# Phase 1: Secure Foundation - Research

**Researched:** 2026-03-06
**Domain:** Flutter encrypted local storage (Drift + SQLCipher), biometric auth (local_auth), profile CRUD UI, freemium cap (Riverpod-gated), photo/avatar handling
**Confidence:** HIGH (stack fully verified; encryption path confirmed against official Drift docs; local_auth v3 confirmed; patterns cross-referenced with production apps)

---

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| SEC-04 | All profile data encrypted at rest using SQLCipher with key in Android Keystore | Drift 2.32+ SQLite3MultipleCiphers + flutter_secure_storage v10 pattern documented in Architecture Patterns section |
| PROF-01 | Create family member profile with built-in fields: name, DOB, address, phone, allergies, emergency contacts | Drift table schema with typed columns; freezed for domain models |
| PROF-02 | Edit any field on an existing profile | Drift `update` API; Riverpod AsyncNotifier mutation pattern |
| PROF-03 | Delete a profile with confirmation | Soft-delete pattern (`deletedAt`) on all entities; UI confirmation dialog before write |
| PROF-04 | Add a photo or avatar to a profile | `image_picker` + compress to JPEG + store file path in profile row; avatar not embedded in DB row |
| PROF-05 | Assign relationship tag to each profile (Parent, Child, Guardian) | Enum column on Profiles table with Drift TypeConverter |
| PROF-06 | Free tier max 2 profiles; third creation shows paywall prompt | Riverpod `profileCountProvider` gated in `ProfileUseCase.createProfile()`; stub entitlement provider returns `free` in Phase 1 |
| PROF-07 | Add custom fields to any profile with user-defined label and type (text, number, date) | Separate `custom_fields` Drift table with FK to profiles; label + type + value columns |
| PROF-08 | Edit and delete custom fields on a profile | Drift `update`/`delete` on `custom_fields` table; cascade delete on profile deletion |
| PROF-09 | Custom fields included in autofill fill responses alongside built-in fields | Custom fields readable from same DB; Phase 2 AutofillService will query them via same repository |
</phase_requirements>

---

## Summary

Phase 1 builds the encrypted data layer and profile management UI that every subsequent phase depends on. The core technical work is: (1) initializing a Drift database with SQLite3MultipleCiphers encryption, with the key derived from flutter_secure_storage backed by Android Keystore; (2) defining the Profiles and CustomFields Drift tables with sync-ready fields (UUID PKs, `updatedAt`, `deletedAt`, `synchronized`); (3) wiring profile CRUD through a Riverpod provider + use-case layer; (4) gating profile creation against a 2-profile free-tier cap; and (5) placing a biometric auth gate at app launch using local_auth v3.

The most consequential decision in this phase is the database schema. Every entity written now is read in Phase 2 by the AutofillService and in Phase 4 by the sync layer. UUID v4 TEXT primary keys, soft deletes, and `synchronized: bool` must be present from the first migration — retrofitting them later requires a destructive schema migration against real user data.

The second most consequential decision is the encryption initialization order: the encryption key must be read from flutter_secure_storage and passed to Drift's `NativeDatabase` setup callback before any table access occurs. If the app is killed between key generation and first DB open, the key must be idempotently regenerated or the open must fail gracefully with a recovery path.

**Primary recommendation:** Build in this order: (1) encrypted DB init + key management, (2) schema + migrations, (3) profile repository + use cases, (4) profile list/edit UI, (5) custom fields UI, (6) biometric auth gate, (7) freemium cap wiring. Each step is testable in isolation before the next begins.

---

## Standard Stack

### Core

| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| drift | ^2.32.0 | Type-safe SQLite ORM with built-in encryption | Built-in SQLite3MultipleCiphers since 2.32; replaces sqlcipher_flutter_libs; code-gen type safety; reactive streams |
| drift_flutter | ^0.3.0 | Drift SQLite bindings for Flutter mobile | Bundles sqlite3 native libs correctly for Android/iOS; required companion to drift on mobile |
| flutter_secure_storage | ^10.0.0 | Stores encryption key in Android Keystore | v10 rewrote Android to use hardware-backed Keystore directly; min SDK 23; gold standard for small secrets |
| local_auth | ^3.0.1 | Biometric + PIN authentication at app launch | Official Flutter team package; wraps Android BiometricPrompt; v3 released Feb 2026 |
| flutter_riverpod | ^3.2.1 | State management; provider-gated freemium cap | Riverpod 3.0 adds compile-time safety; `AsyncNotifier` pattern for CRUD; providers override cleanly in tests |
| riverpod_annotation | ^3.2.1 | Code generation for Riverpod providers | Eliminates hand-written provider boilerplate; pairs with build_runner |
| freezed_annotation | ^3.0.0 | Immutable domain models | Structural equality, copyWith, sealed unions for Result types; critical for sync-ready models |
| uuid | ^4.5.0 | UUID v4 generation for all entity PKs | Required for sync-ready schema from day one; TEXT PKs survive multi-device migration |
| image_picker | ^1.1.0 | Pick photo from gallery or camera for profile avatar | Official Flutter team plugin; standard for media selection |

### Supporting

| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| go_router | ^17.1.0 | Navigation with auth guard for locked screen | Route guard checks biometric session state before allowing profile list access |
| drift_dev | ^2.32.0 (dev) | Drift code generation | Required; generates type-safe query classes and table row types |
| build_runner | ^2.4.0 (dev) | Runs code generation (drift, riverpod, freezed) | Required whenever any annotated file changes |
| riverpod_generator | ^3.2.1 (dev) | Generates Riverpod provider boilerplate | Pairs with riverpod_annotation |
| freezed | ^3.0.0 (dev) | Generates immutable class implementations | Pairs with freezed_annotation |
| mocktail | ^1.0.0 (dev) | Mock repositories in unit tests | Preferred over mockito for null-safe Dart; no codegen needed |
| flutter_test (bundled) | - | Unit + widget tests | Profile model logic, use-case tests, widget tests for profile form |
| integration_test (bundled) | - | On-device DB + auth flow tests | End-to-end: create profile → persists encrypted → visible after auth |

### Alternatives Considered

| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| drift | sqflite | sqflite has no encryption, no type safety, no code gen — inferior in every dimension for this schema |
| drift | isar_community | isar has no encryption (GitHub Discussion #176 open since 2022, never shipped); abandoned original author |
| flutter_secure_storage | Manual EncryptedSharedPreferences | flutter_secure_storage v10 already uses Android Keystore directly; no advantage to manual approach |
| image_picker | camera (platform-level) | image_picker wraps both gallery and camera in one API; camera package is lower level and unnecessary here |

### Installation

```yaml
# pubspec.yaml — core Phase 1 dependencies
dependencies:
  flutter:
    sdk: flutter
  drift: ^2.32.0
  drift_flutter: ^0.3.0
  flutter_secure_storage: ^10.0.0
  local_auth: ^3.0.1
  flutter_riverpod: ^3.2.1
  riverpod_annotation: ^3.2.1
  freezed_annotation: ^3.0.0
  go_router: ^17.1.0
  uuid: ^4.5.0
  image_picker: ^1.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  drift_dev: ^2.32.0
  build_runner: ^2.4.0
  riverpod_generator: ^3.2.1
  freezed: ^3.0.0
  mocktail: ^1.0.0
```

For encryption, the workspace-level `pubspec.yaml` hooks must enable SQLite3MultipleCiphers:

```yaml
# In the workspace root pubspec.yaml (or app pubspec.yaml hooks section)
hooks:
  user_defines:
    sqlite3:
      source: sqlite3mc
```

---

## Architecture Patterns

### Recommended Project Structure (Phase 1 scope)

```
lib/
├── main.dart                          # ProviderScope wrap, app entry
├── app.dart                           # MaterialApp.router, go_router config, auth guard
│
├── domain/
│   ├── models/
│   │   ├── profile.dart               # FamilyProfile freezed model (UUID, sync fields)
│   │   ├── custom_field.dart          # CustomField freezed model
│   │   └── relationship_tag.dart      # Enum: parent, child, guardian
│   ├── use_cases/
│   │   └── profile_use_case.dart      # CRUD + 2-profile cap enforcement
│   └── repositories/
│       ├── profile_repository.dart    # Abstract interface
│       └── custom_field_repository.dart
│
├── data/
│   ├── database/
│   │   ├── app_database.dart          # Drift @DriftDatabase; table list; migrations
│   │   ├── tables/
│   │   │   ├── profiles_table.dart    # Drift Table class for profiles
│   │   │   └── custom_fields_table.dart
│   │   └── daos/
│   │       ├── profiles_dao.dart      # @DriftAccessor; queries for profiles
│   │       └── custom_fields_dao.dart
│   ├── repositories/
│   │   ├── profile_repository_impl.dart
│   │   └── custom_field_repository_impl.dart
│   └── security/
│       └── key_manager.dart           # flutter_secure_storage key gen + retrieval
│
├── presentation/
│   ├── auth_gate/
│   │   └── auth_gate_screen.dart      # Biometric prompt + PIN fallback
│   ├── profiles/
│   │   ├── profile_list_screen.dart
│   │   ├── profile_edit_screen.dart
│   │   ├── profile_card_widget.dart
│   │   └── custom_field_editor_widget.dart
│   └── paywall/
│       └── paywall_stub_screen.dart   # Phase 1: stub paywall (real IAP in Phase 4)
│
└── providers/
    ├── database_provider.dart         # keepAlive FutureProvider<AppDatabase>
    ├── profile_providers.dart         # profileListProvider, profileUseCase
    └── auth_providers.dart            # authStateProvider, biometric session state

android/
└── app/src/main/
    ├── AndroidManifest.xml            # allowBackup=false; USE_BIOMETRIC; FlutterFragmentActivity
    └── kotlin/.../
        └── MainActivity.kt            # extends FlutterFragmentActivity (NOT FlutterActivity)
```

### Pattern 1: Encrypted Database Initialization

**What:** On first launch, generate a cryptographically random 32-byte key, store it in flutter_secure_storage, then pass it to Drift's `NativeDatabase` setup callback via `PRAGMA key`. On subsequent launches, read the stored key. If the key is absent (reinstall scenario), treat it as a fresh install.

**When to use:** Every app cold start. The setup callback runs synchronously before any Drift table access.

```dart
// lib/data/security/key_manager.dart
// Source: drift.simonbinder.eu/platforms/encryption/ + flutter_secure_storage pub.dev
import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeyManager {
  static const _keyAlias = 'autofill_db_key_v1';
  final FlutterSecureStorage _storage;

  KeyManager(this._storage);

  Future<String> getOrCreateKey() async {
    final existing = await _storage.read(key: _keyAlias);
    if (existing != null) return existing;

    // Generate a random 32-byte key, base64-encode for PRAGMA
    final random = Random.secure();
    final keyBytes = List<int>.generate(32, (_) => random.nextInt(256));
    final key = base64UrlEncode(keyBytes);
    await _storage.write(key: _keyAlias, value: key);
    return key;
  }

  Future<bool> hasKey() async {
    return (await _storage.read(key: _keyAlias)) != null;
  }
}
```

```dart
// lib/data/database/app_database.dart (initialization excerpt)
// Source: drift.simonbinder.eu/platforms/encryption/
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:sqlite3/sqlite3.dart';

QueryExecutor _openDatabase(String passphrase, File dbFile) {
  return NativeDatabase.createInBackground(
    dbFile,
    setup: (rawDb) {
      // Verify SQLite3MultipleCiphers is loaded, not plain sqlite3
      assert(
        rawDb.select('PRAGMA cipher;').isNotEmpty,
        'SQLite3MultipleCiphers not loaded — encryption unavailable',
      );
      // Escape single quotes in the passphrase
      final escaped = passphrase.replaceAll("'", "''");
      rawDb.execute("PRAGMA key = '$escaped';");
    },
  );
}
```

```dart
// lib/providers/database_provider.dart
// Pattern: keepAlive FutureProvider so DB is initialized once per app session
@Riverpod(keepAlive: true)
Future<AppDatabase> appDatabase(Ref ref) async {
  final secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: false),
  );
  final keyManager = KeyManager(secureStorage);
  final passphrase = await keyManager.getOrCreateKey();

  final dbFolder = await getApplicationDocumentsDirectory();
  final dbFile = File(p.join(dbFolder.path, 'autofill.db'));

  final db = AppDatabase(_openDatabase(passphrase, dbFile));
  ref.onDispose(db.close);
  return db;
}
```

### Pattern 2: Sync-Ready Drift Table Schema

**What:** Every entity table carries UUID v4 TEXT PK, `createdAt`, `updatedAt`, `deletedAt` (soft delete), and `synchronized` (dirty tracking). Never use `INTEGER PRIMARY KEY AUTOINCREMENT`.

**When to use:** All tables in Phase 1. The sync worker in a future premium tier reads `synchronized == false`; the autofill service in Phase 2 reads these tables via the same repository.

```dart
// lib/data/database/tables/profiles_table.dart
// Source: drift.simonbinder.eu/dart_api/tables/
import 'package:drift/drift.dart';

class Profiles extends Table {
  // UUID v4 TEXT primary key — never auto-increment
  TextColumn get id => text().withLength(min: 36, max: 36)();
  TextColumn get displayName => text()();
  TextColumn get dateOfBirth => text().nullable()(); // ISO-8601 string
  TextColumn get addressLine1 => text().nullable()();
  TextColumn get addressLine2 => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get stateProvince => text().nullable()();
  TextColumn get postalCode => text().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get allergies => text().nullable()(); // free-text
  TextColumn get emergencyContactName => text().nullable()();
  TextColumn get emergencyContactPhone => text().nullable()();
  TextColumn get relationshipTag => textEnum<RelationshipTag>()();
  TextColumn get avatarPath => text().nullable()(); // local file path
  // Sync-ready fields
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synchronized => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class CustomFields extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  TextColumn get profileId => text().references(Profiles, #id)();
  TextColumn get label => text()();
  TextColumn get fieldType => textEnum<CustomFieldType>()(); // text | number | date
  TextColumn get value => text().nullable()();
  // Sync-ready fields
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synchronized => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

enum RelationshipTag { parent, child, guardian }
enum CustomFieldType { text, number, date }
```

### Pattern 3: Profile Use Case with Freemium Cap

**What:** All profile creation flows through `ProfileUseCase.createProfile()`. The use case checks profile count (excluding soft-deleted) against the free-tier cap before writing to the DB. In Phase 1, the entitlement provider is a stub that always returns `free`. Phase 4 replaces the stub with a real RevenueCat provider via Riverpod overrides.

**When to use:** All profile creation. This is the enforcement point for PROF-06.

```dart
// lib/domain/use_cases/profile_use_case.dart
class ProfileUseCase {
  final ProfileRepository _repo;
  final EntitlementService _entitlement;
  static const int freeTierLimit = 2;

  ProfileUseCase(this._repo, this._entitlement);

  Future<Result<Profile>> createProfile(ProfileCreateRequest request) async {
    final isPaid = await _entitlement.isPaidTier();
    if (!isPaid) {
      final count = await _repo.countActive(); // excludes deletedAt != null
      if (count >= freeTierLimit) {
        return Result.failure(ProfileLimitReached());
      }
    }
    final profile = Profile(
      id: const Uuid().v4(),
      createdAt: DateTime.now().toUtc(),
      updatedAt: DateTime.now().toUtc(),
      synchronized: false,
      // ...map request fields
    );
    await _repo.upsert(profile);
    return Result.success(profile);
  }
}
```

UI catches `ProfileLimitReached` and navigates to the paywall stub screen.

### Pattern 4: Biometric Auth Gate with PIN Fallback

**What:** A `go_router` redirect guard checks a Riverpod `authStateProvider`. On app start, auth state is `locked`. The auth gate screen invokes `local_auth.authenticate()` with `biometricOnly: false` so PIN/pattern is accepted if biometrics fail or are unavailable. On success, state transitions to `unlocked` for the session.

**When to use:** Every cold start and app foreground event (SEC-01 is Phase 2; for Phase 1, only the at-launch gate is required).

```dart
// lib/presentation/auth_gate/auth_gate_screen.dart
// Source: pub.dev/packages/local_auth
import 'package:local_auth/local_auth.dart';

class AuthGateScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _authenticate(context, ref),
          child: const Text('Unlock'),
        ),
      ),
    );
  }

  Future<void> _authenticate(BuildContext context, WidgetRef ref) async {
    final auth = LocalAuthentication();
    final canCheck = await auth.canCheckBiometrics;
    final isSupported = await auth.isDeviceSupported();

    try {
      final authenticated = await auth.authenticate(
        localizedReason: 'Unlock your family profiles',
        options: const AuthenticationOptions(
          biometricOnly: false,  // Allow PIN/pattern fallback
          stickyAuth: true,
        ),
      );
      if (authenticated) {
        ref.read(authStateProvider.notifier).unlock();
      }
    } on PlatformException catch (e) {
      // Handle: NotEnrolled, LockedOut, PermanentlyLockedOut
      _handleAuthError(e, context);
    }
  }
}
```

```dart
// AndroidManifest.xml additions required:
// <uses-permission android:name="android.permission.USE_BIOMETRIC" />
// <uses-permission android:name="android.permission.USE_FINGERPRINT" />
// MainActivity must extend FlutterFragmentActivity (NOT FlutterActivity)
```

### Pattern 5: Avatar Photo Handling

**What:** Profile photos are stored as JPEG files in the app's documents directory, not embedded in the SQLite database. The profile row stores only the file path. This prevents large binary data in the encrypted DB and keeps photo loading fast.

**When to use:** Always for PROF-04.

```dart
// Picking + storing avatar
final picker = ImagePicker();
final XFile? image = await picker.pickImage(
  source: ImageSource.gallery,
  maxWidth: 512,
  maxHeight: 512,
  imageQuality: 85,  // Compress to ~50-100KB
);
if (image != null) {
  final dir = await getApplicationDocumentsDirectory();
  final dest = File('${dir.path}/avatars/${profileId}.jpg');
  await dest.parent.create(recursive: true);
  await File(image.path).copy(dest.path);
  // Store dest.path in profile.avatarPath column
}
```

### Anti-Patterns to Avoid

- **Using `INTEGER PRIMARY KEY AUTOINCREMENT`:** Produces keys that collide across devices when sync is added. Use UUID v4 TEXT from day one.
- **Hard-deleting profiles:** The autofill service in Phase 2 caches profile IDs. A hard delete leaves orphaned references. Always soft-delete via `deletedAt = DateTime.now().toUtc()`.
- **Opening the DB without verifying cipher:** If the hooks configuration for sqlite3mc is missing, the database opens unencrypted silently. The `assert(rawDb.select('PRAGMA cipher;').isNotEmpty)` check in the setup callback catches this in debug builds.
- **Storing avatar bytes in the DB row:** Large BLOBs slow Drift queries and inflate the encrypted file size. Store the file path only.
- **Catching `PlatformException` from local_auth with a single generic handler:** The `LockedOut` and `PermanentlyLockedOut` codes require routing the user to device Settings, not just showing a retry button.
- **`android:allowBackup` absent or true:** Android's default is `true`. This allows backup of the encrypted DB file without the Keystore key, making it unreadable on restore. Must be explicitly `false`.

---

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Encrypted SQLite | Custom AES-256 wrapper around sqflite | Drift 2.32+ with sqlite3mc hooks | sqlcipher_flutter_libs is deprecated; sqlite3mc is maintained in-tree; Drift handles cipher initialization correctly |
| Key storage in Android Keystore | Manual KeyStore Java API calls | flutter_secure_storage v10 | v10 uses hardware-backed Keystore on API 23+; manual KeyStore usage has many subtle failure modes (biometric binding, key invalidation) |
| Immutable domain models | Hand-written copyWith and equality | freezed | freezed handles ==, hashCode, copyWith, and union types; hand-rolling these for sync models is error-prone and verbose |
| UUID generation | Random string | uuid ^4.5.0 | RFC 4122 v4 compliance; collision probability proven safe; already in the stack |
| Biometric + PIN auth | Direct BiometricPrompt Kotlin calls | local_auth ^3.0.1 | Handles FragmentActivity requirement, all PlatformException codes, and iOS parity automatically |
| Profile count gating | Shared pref boolean | Riverpod provider checking active profile count via DB query | Count from DB is the source of truth; avoids stale booleans; easily overridden in tests |

**Key insight:** The encryption stack (Drift + sqlite3mc + flutter_secure_storage) is a validated production pattern used by AuthPass and KeePass for Android. Rolling a custom solution means reimplementing cipher initialization, key derivation, and key rotation — all well-solved problems.

---

## Common Pitfalls

### Pitfall 1: sqlcipher_flutter_libs Still in Dependencies

**What goes wrong:** Build fails or creates an unencrypted database. `sqlcipher_flutter_libs` was the pre-2.32 approach. If both `sqlcipher_flutter_libs` and the sqlite3mc hooks are present, they conflict.

**Why it happens:** Old tutorials and Stack Overflow answers reference `sqlcipher_flutter_libs`. Developers copy-paste without checking the Drift changelog.

**How to avoid:** Do not add `sqlcipher_flutter_libs` to pubspec.yaml. Use `drift_flutter` + sqlite3mc hooks only. Verify via `PRAGMA cipher;` at DB open time.

**Warning signs:** `sqlcipher_flutter_libs` appears in pubspec.yaml; DB opens without cipher assertion passing.

### Pitfall 2: Keystore Key Lost on Reinstall

**What goes wrong:** App reinstall deletes the Android Keystore entry. If `android:allowBackup="true"` (the Android default), the encrypted DB file survives in backup but the key is gone. The DB is permanently unreadable. App opens to blank state or crashes on decrypt.

**How to avoid:** Set `android:allowBackup="false"` explicitly in AndroidManifest.xml. On reinstall, `KeyManager.hasKey()` returns false — treat as fresh install, regenerate key, new empty DB. This is correct behavior. Display a clear warning during onboarding.

**Warning signs:** `android:allowBackup` absent from manifest (defaults to `true`); no onboarding screen about local-only data.

### Pitfall 3: MainActivity Extends FlutterActivity (Not FlutterFragmentActivity)

**What goes wrong:** local_auth crashes with a `PlatformException` or `NoSuchMethodError` at runtime on Android. Biometric authentication never works.

**How to avoid:** Set `MainActivity.kt` to `extends FlutterFragmentActivity`. This is a one-line change but easy to miss when generating a new Flutter project (the default template uses `FlutterActivity`).

**Warning signs:** `local_auth` exceptions on authenticate call; works in emulator but crashes on physical device.

### Pitfall 4: Biometric Lockout with No Fallback

**What goes wrong:** 5 failed biometric attempts trigger `LockedOut`. Additional failures trigger `PermanentlyLockedOut`. App becomes permanently inaccessible to the user.

**How to avoid:** Handle all three PlatformException codes: `NotEnrolled` (show settings prompt), `LockedOut` (show message + device-unlock deeplink), `PermanentlyLockedOut` (show device Settings deeplink). Use `biometricOnly: false` so PIN/pattern is always available as fallback.

**Warning signs:** Single catch block for all PlatformExceptions; no visible fallback path in auth gate UI.

### Pitfall 5: Drift Code Generation Not Re-Run After Schema Change

**What goes wrong:** Drift tables are updated (add a column, rename a field) but `build_runner` is not re-run. The generated `.g.dart` files are stale. Runtime errors are cryptic — type mismatches in generated DAO methods, not obvious column errors.

**How to avoid:** Always run `flutter pub run build_runner build --delete-conflicting-outputs` after any change to `tables/`, `daos/`, or `@DriftDatabase` class. Add this to a `Makefile` or task runner. Check generated files into version control so CI fails if they are stale.

**Warning signs:** `build_runner` not in dev_dependencies; `.g.dart` files not in source control; runtime "no such column" errors.

### Pitfall 6: Custom Fields Stored as JSON Blob Instead of Normalized Table

**What goes wrong:** Custom fields are stored as a JSON string in a single TEXT column on the profiles table. This is fast to implement but prevents querying custom fields by type, makes migrations difficult when field types change, and breaks the Phase 2 autofill service which needs to iterate fields by type.

**How to avoid:** Use a separate `custom_fields` Drift table with FK to `profiles`. Each custom field is a row with `label`, `fieldType`, and `value` columns. This is normalized, queryable, and the Phase 2 service can select `SELECT * FROM custom_fields WHERE profile_id = ?` directly.

**Warning signs:** Single `customFieldsJson TEXT` column on profiles table; no CustomFields Drift table.

---

## Code Examples

### Drift Database Class

```dart
// lib/data/database/app_database.dart
// Source: drift.simonbinder.eu/dart_api/ and drift.simonbinder.eu/platforms/encryption/
import 'package:drift/drift.dart';
import 'tables/profiles_table.dart';
import 'tables/custom_fields_table.dart';
import 'daos/profiles_dao.dart';
import 'daos/custom_fields_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Profiles, CustomFields],
  daos: [ProfilesDao, CustomFieldsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
  );
}
```

### Profiles DAO

```dart
// lib/data/database/daos/profiles_dao.dart
// Source: drift.simonbinder.eu/dart_api/
@DriftAccessor(tables: [Profiles, CustomFields])
class ProfilesDao extends DatabaseAccessor<AppDatabase>
    with _$ProfilesDaoMixin {
  ProfilesDao(super.db);

  Stream<List<Profile>> watchActiveProfiles() {
    return (select(profiles)
      ..where((p) => p.deletedAt.isNull())
      ..orderBy([(p) => OrderingTerm.asc(p.displayName)]))
    .watch();
  }

  Future<int> countActive() async {
    final count = countAll(filter: profiles.deletedAt.isNull());
    final result = await (selectOnly(profiles)..addColumns([count])).getSingle();
    return result.read(count) ?? 0;
  }

  Future<void> upsertProfile(ProfilesCompanion companion) {
    return into(profiles).insertOnConflictUpdate(companion);
  }

  Future<void> softDelete(String profileId) {
    return (update(profiles)..where((p) => p.id.equals(profileId))).write(
      ProfilesCompanion(deletedAt: Value(DateTime.now().toUtc())),
    );
  }
}
```

### Riverpod Auth State Provider

```dart
// lib/providers/auth_providers.dart
// Source: pub.dev/packages/flutter_riverpod, codewithandrea.com Riverpod patterns
enum AuthState { locked, unlocked }

@Riverpod(keepAlive: true)
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  AuthState build() => AuthState.locked;

  void unlock() => state = AuthState.unlocked;
  void lock() => state = AuthState.locked;
}

// go_router redirect guard
String? authGuard(BuildContext context, GoRouterState state) {
  final auth = providerContainer.read(authStateNotifierProvider);
  if (auth == AuthState.locked && state.matchedLocation != '/auth') {
    return '/auth';
  }
  return null;
}
```

### Freemium Cap Stub (Phase 1)

```dart
// lib/providers/entitlement_providers.dart
// Phase 1 stub — Phase 4 replaces this with RevenueCat
@Riverpod(keepAlive: true)
EntitlementTier entitlementTier(Ref ref) {
  return EntitlementTier.free; // Always free in Phase 1
}
```

---

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| `sqlcipher_flutter_libs` + Drift | Drift 2.32+ with sqlite3mc hooks (no extra package) | Drift 2.32.0, late 2024 | Remove sqlcipher_flutter_libs; simpler build; maintained in Drift core |
| `StateProvider` / `StateNotifierProvider` | `AsyncNotifier` + `@riverpod` annotation | Riverpod 3.0, Oct 2025 | Old providers moved to `legacy.dart`; do not use in new code |
| `FlutterActivity` | `FlutterFragmentActivity` | Required since local_auth v2+; reinforced in v3 (Feb 2026) | MainActivity must be updated; crashes if not |
| Hard delete + integer PKs | Soft delete (`deletedAt`) + UUID v4 TEXT PKs | Established pattern; critical before Phase 2 | No migration needed when sync ships |
| Hive for local storage | Drift (SQLite-based, encrypted) | Hive abandoned by original author 2023–2024 | Drift is the current standard; isar also abandoned |

**Deprecated / do not use:**
- `sqlcipher_flutter_libs`: Explicitly deprecated since Drift 2.32; remove if present
- `isar` (pub.dev v3.1.0+1): No encryption; original author abandoned; do not use
- `Hive` (v2): Original maintainer abandoned; community fork has limited momentum
- `StateProvider` / `StateNotifierProvider`: Moved to Riverpod legacy namespace in v3.0

---

## Open Questions

1. **sqlite3mc hooks: workspace vs. app pubspec.yaml**
   - What we know: The Drift encryption docs reference a `hooks > user_defines > sqlite3 > source: sqlite3mc` config, but it is unclear whether this goes in a workspace-level `pubspec.yaml` or the app's own `pubspec.yaml`.
   - What's unclear: This project does not currently use a Dart workspace. The sqlite3mc hooks feature may require `dart pub workspaces` to be configured, or it may be an app-level setting.
   - Recommendation: During Wave 0 (environment setup), verify the hooks config against the current `drift_flutter` README on pub.dev. Fallback: use `sqlite3_flutter_libs` with a custom build configuration if hooks are not straightforward.

2. **Photo storage on first install: avatars directory creation**
   - What we know: The avatar is stored as `${documentsDir}/avatars/${profileId}.jpg`.
   - What's unclear: Whether `getApplicationDocumentsDirectory()` is available before the first DB open, or if order of initialization matters.
   - Recommendation: Create the avatars directory lazily on first photo save, not at DB init time.

3. **Biometric availability on emulator for CI**
   - What we know: `local_auth` requires a physical device for real biometric testing; emulators have limited support.
   - What's unclear: Whether the biometric auth gate widget test can be mocked in `flutter_test` (unit) vs. requiring integration_test on a device.
   - Recommendation: Mock `LocalAuthentication` behind an interface for unit/widget tests; add a physical-device integration test as a manual verification step, not a CI gate.

---

## Validation Architecture

`nyquist_validation` is enabled in `.planning/config.json`.

### Test Framework

| Property | Value |
|----------|-------|
| Framework | flutter_test (bundled with Flutter 3.41) + integration_test (bundled) |
| Config file | None — `flutter test` discovers tests in `test/` automatically |
| Quick run command | `flutter test test/unit/` |
| Full suite command | `flutter test` |
| Integration test command | `flutter test integration_test/` (requires connected device/emulator) |

### Phase Requirements → Test Map

| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| SEC-04 | DB file is encrypted: opening with wrong key fails | unit | `flutter test test/unit/database/encryption_test.dart -x` | Wave 0 |
| SEC-04 | `PRAGMA key` is set before any table access | unit | `flutter test test/unit/database/key_manager_test.dart -x` | Wave 0 |
| PROF-01 | `ProfileUseCase.createProfile()` writes all built-in fields | unit | `flutter test test/unit/use_cases/profile_use_case_test.dart -x` | Wave 0 |
| PROF-01 | Profile list screen shows created profile | widget | `flutter test test/widget/profile_list_screen_test.dart -x` | Wave 0 |
| PROF-02 | `ProfileUseCase.updateProfile()` persists changes; `updatedAt` increments | unit | `flutter test test/unit/use_cases/profile_use_case_test.dart -x` | Wave 0 |
| PROF-03 | `ProfileUseCase.deleteProfile()` sets `deletedAt`; profile absent from `countActive()` | unit | `flutter test test/unit/use_cases/profile_use_case_test.dart -x` | Wave 0 |
| PROF-04 | Avatar path stored in profile row; file exists at path | unit | `flutter test test/unit/use_cases/avatar_service_test.dart -x` | Wave 0 |
| PROF-05 | `relationshipTag` persisted and retrieved correctly for all three enum values | unit | `flutter test test/unit/database/profiles_dao_test.dart -x` | Wave 0 |
| PROF-06 | Creating 3rd profile with free entitlement returns `ProfileLimitReached` | unit | `flutter test test/unit/use_cases/profile_use_case_test.dart -x` | Wave 0 |
| PROF-06 | UI navigates to paywall stub when limit reached | widget | `flutter test test/widget/profile_create_screen_test.dart -x` | Wave 0 |
| PROF-07 | `CustomFieldUseCase.addField()` creates row in `custom_fields` table | unit | `flutter test test/unit/use_cases/custom_field_use_case_test.dart -x` | Wave 0 |
| PROF-08 | Edit custom field updates `label`, `fieldType`, `value`, `updatedAt` | unit | `flutter test test/unit/use_cases/custom_field_use_case_test.dart -x` | Wave 0 |
| PROF-08 | Delete custom field sets `deletedAt` (soft delete) | unit | `flutter test test/unit/use_cases/custom_field_use_case_test.dart -x` | Wave 0 |
| PROF-09 | `ProfileRepository.getProfileWithFields()` returns built-in + custom fields in one result | unit | `flutter test test/unit/repositories/profile_repository_test.dart -x` | Wave 0 |
| Schema | All PKs are UUID TEXT; zero AUTOINCREMENT in DDL | unit | `flutter test test/unit/database/schema_test.dart -x` | Wave 0 |
| Schema | `synchronized`, `deletedAt`, `updatedAt` present on all tables | unit | `flutter test test/unit/database/schema_test.dart -x` | Wave 0 |
| Biometric | Auth gate shows after fresh app start; profile list hidden | integration | `flutter test integration_test/auth_gate_test.dart` (physical device) | Wave 0 |
| Reinstall | After reinstall, `KeyManager.hasKey()` is false; app starts fresh | integration | manual only — requires device reinstall scenario | manual |

### Sampling Rate

- **Per task commit:** `flutter test test/unit/` (unit tests only, no device required, < 15 seconds)
- **Per wave merge:** `flutter test` (all unit + widget tests)
- **Phase gate:** Full suite + `flutter test integration_test/` on physical device green before `/gsd:verify-work`

### Wave 0 Gaps

All test files are new — none exist yet (no `.dart` files in the project).

- [ ] `test/unit/database/key_manager_test.dart` — covers SEC-04 key generation + retrieval
- [ ] `test/unit/database/encryption_test.dart` — covers SEC-04 DB encryption verification
- [ ] `test/unit/database/profiles_dao_test.dart` — covers PROF-01, PROF-02, PROF-03, PROF-05 at DAO layer
- [ ] `test/unit/database/schema_test.dart` — verifies UUID PKs, sync fields present in DDL
- [ ] `test/unit/use_cases/profile_use_case_test.dart` — covers PROF-01 through PROF-06
- [ ] `test/unit/use_cases/custom_field_use_case_test.dart` — covers PROF-07, PROF-08
- [ ] `test/unit/use_cases/avatar_service_test.dart` — covers PROF-04
- [ ] `test/unit/repositories/profile_repository_test.dart` — covers PROF-09
- [ ] `test/widget/profile_list_screen_test.dart` — covers PROF-01 UI
- [ ] `test/widget/profile_create_screen_test.dart` — covers PROF-06 paywall navigation
- [ ] `test/helpers/in_memory_database.dart` — shared fixture: in-memory Drift DB for tests
- [ ] `integration_test/auth_gate_test.dart` — covers biometric gate (physical device)
- [ ] Framework install: already bundled; `flutter test` works immediately

---

## Sources

### Primary (HIGH confidence)
- [Drift Encryption docs — drift.simonbinder.eu/platforms/encryption/](https://drift.simonbinder.eu/platforms/encryption/) — SQLite3MultipleCiphers setup, NativeDatabase setup callback, sqlcipher deprecation confirmed
- [Drift Setup docs — drift.simonbinder.eu/setup/](https://drift.simonbinder.eu/setup/) — drift_flutter dependency versions confirmed
- [Drift Tables docs — drift.simonbinder.eu/dart_api/tables/](https://drift.simonbinder.eu/dart_api/tables/) — Table class patterns, TypeConverter, column definitions
- [flutter_secure_storage pub.dev](https://pub.dev/packages/flutter_secure_storage) — v10.0.0 confirmed, Android Keystore backend confirmed
- [local_auth pub.dev](https://pub.dev/packages/local_auth) — v3.0.1 confirmed, FlutterFragmentActivity requirement confirmed
- [local_auth GitHub issue #108945](https://github.com/flutter/flutter/issues/108945) — biometricOnly: false PIN fallback bug on Android 10 confirmed
- [STACK.md — .planning/research/STACK.md] — All package versions cross-referenced from prior research
- [ARCHITECTURE.md — .planning/research/ARCHITECTURE.md] — Layer structure and data flow patterns
- [PITFALLS.md — .planning/research/PITFALLS.md] — Encryption key loss, allowBackup, FlutterFragmentActivity pitfalls

### Secondary (MEDIUM confidence)
- [Riverpod + Drift initialization pattern — dinkomarinac.dev](https://dinkomarinac.dev/blog/building-local-first-flutter-apps-with-riverpod-drift-and-powersync/) — `keepAlive FutureProvider` + `DatabaseConnection.delayed()` pattern verified
- [Riverpod testing — riverpod.dev/docs/how_to/testing](https://riverpod.dev/docs/how_to/testing) — `ProviderContainer` + `overrideWith` pattern for unit tests
- [Riverpod 3.0 changes — riverpod.dev/docs/whats_new](https://riverpod.dev/docs/whats_new) — `AsyncNotifier`, `@riverpod` annotation, legacy.dart deprecations

### Tertiary (LOW confidence — needs validation)
- sqlite3mc `hooks` configuration in `pubspec.yaml` — documented in Drift encryption page but exact YAML path requires verification against current `drift_flutter` README during Wave 0

---

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH — all package versions confirmed via prior research + pub.dev; Drift encryption path confirmed against official docs
- Architecture: HIGH — Drift + flutter_secure_storage encryption pattern is production-proven (AuthPass, KeePass for Android use this stack); layer structure is standard Flutter architecture
- Pitfalls: HIGH — FlutterFragmentActivity, allowBackup, LockedOut handling all confirmed from official sources and known Flutter issues
- sqlite3mc hooks YAML path: LOW — needs Wave 0 verification; fallback approach documented

**Research date:** 2026-03-06
**Valid until:** 2026-04-06 (30 days; packages are stable; check local_auth v3 changelog for breaking changes if delayed)

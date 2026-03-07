# Stack Research

**Domain:** Flutter mobile app — Android autofill service, encrypted local storage, biometric auth, freemium IAP
**Researched:** 2026-03-06
**Confidence:** MEDIUM-HIGH (core Flutter packages verified via pub.dev; autofill plugin has low star count but active maintenance confirmed)

---

## Recommended Stack

### Core Technologies

| Technology | Version | Purpose | Why Recommended |
|------------|---------|---------|-----------------|
| Flutter | 3.41.x (Dart 3.11) | Cross-platform mobile framework | Current stable as of Feb 2026; Android-first with iOS additive later; no rewrite needed |
| flutter_riverpod | ^3.2.1 | State management | Riverpod 3.0 (Oct 2025) adds compile-time safety, built-in offline caching mutations, minimal boilerplate; surpassed BLoC for most greenfield apps in 2025 |
| go_router | ^17.1.0 | Navigation / routing | Official Flutter team package; declarative routing with guards (needed for biometric lock screen); deep link support for future iOS |
| drift | ^2.32.0 | Relational local database (SQLite) | Actively maintained by Simon Binder; type-safe SQL with code gen; built-in SQLite3MultipleCiphers encryption since v2.32.0; relational model supports sync-ready schema design better than NoSQL alternatives |
| flutter_secure_storage | ^10.0.0 | Secure key storage | Platform keychain/keystore for encryption keys and tokens; v10.0.0 (Dec 2025) rewrote Android to drop deprecated Jetpack Security; min SDK 23 (Android 6.0); gold standard for small secrets |
| local_auth | ^3.0.1 | Biometric authentication | Official Flutter team package; wraps Android BiometricPrompt and iOS LocalAuthentication; v3.x released Feb 2026 |
| flutter_autofill_service | ^0.21.0 | Android AutofillService OS integration | Implements Android AutofillService with auth-gated access — user must explicitly tap before data is revealed; supports saving new data back; Android 12+ IME integration; actively maintained (v0.21.0 published Jan 2026) |
| purchases_flutter | ^9.13.1 | In-app purchases / subscriptions | RevenueCat SDK; handles receipt validation, entitlement management, webhook-free status tracking; far less boilerplate than raw in_app_purchase; both iOS and Android; worth the RevenueCat backend dependency for a freemium model |

### Supporting Libraries

| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| riverpod_generator | ^3.x | Code generation for Riverpod | Always — eliminates hand-written provider boilerplate; pairs with build_runner |
| drift_flutter | ^0.2.x | Drift SQLite bindings for Flutter | Always with drift on mobile; bundles sqlite3 native libs correctly |
| freezed | ^3.x | Immutable data classes + unions | Use for domain models (Profile, FieldMapping, FormHistory) — critical for sync-ready models |
| json_serializable | ^6.x | JSON serialization | Use alongside freezed for cloud sync serialization layer; generates toJson/fromJson |
| uuid | ^4.x | UUID generation | Required for sync-ready data model — every entity needs a stable UUID as primary key |
| build_runner | ^2.x | Code generation runner | Required by drift, riverpod_generator, freezed, json_serializable |
| package_info_plus | ^8.x | App version / build metadata | IAP receipt validation often needs build context; useful for analytics |
| permission_handler | ^11.x | Android/iOS permission management | Needed for biometric permission check on some Android devices |
| flutter_local_notifications | ^18.x | Local push notifications | If adding reminders or "unlock to fill" prompts in a later phase |

### Development Tools

| Tool | Purpose | Notes |
|------|---------|-------|
| flutter_test (bundled) | Unit + widget testing | Use for profile model logic and field heuristic mapping tests |
| integration_test (bundled) | End-to-end on-device testing | Required for autofill service flow — cannot mock system-level interactions |
| drift_devtools / Drift inspector | Database inspection during dev | Drift has a DevTools extension for viewing live DB contents |
| RevenueCat Dashboard | IAP product / entitlement management | Configure free vs paid entitlements in RevenueCat before writing any Dart code |
| Android Studio / Device Manager | Autofill service testing | Must test on a real Android device or full emulator with autofill enabled in Settings |

---

## Installation

```yaml
# pubspec.yaml — dependencies
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^3.2.1
  riverpod_annotation: ^3.2.1
  go_router: ^17.1.0
  drift: ^2.32.0
  drift_flutter: ^0.2.0
  flutter_secure_storage: ^10.0.0
  local_auth: ^3.0.1
  flutter_autofill_service: ^0.21.0
  purchases_flutter: ^9.13.1
  freezed_annotation: ^3.0.0
  json_annotation: ^4.9.0
  uuid: ^4.5.0
  package_info_plus: ^8.0.0
  permission_handler: ^11.3.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  build_runner: ^2.4.0
  riverpod_generator: ^3.2.1
  drift_dev: ^2.32.0
  freezed: ^3.0.0
  json_serializable: ^6.9.0
```

```bash
# Android manifest additions required:
# 1. AutofillService declaration with BIND_AUTOFILL_SERVICE permission
# 2. BILLING permission for IAP
# 3. USE_BIOMETRIC + USE_FINGERPRINT permissions
# 4. MainActivity must extend FlutterFragmentActivity (not FlutterActivity) for local_auth
```

---

## Alternatives Considered

| Recommended | Alternative | When to Use Alternative |
|-------------|-------------|-------------------------|
| drift | isar_community | If you need pure NoSQL object storage with no relational requirements and don't need web support. Isar core was abandoned by original author; community fork (isar_community 3.3.0) exists but Rust core makes contributing hard. Drift is the safer long-term bet. |
| drift | Hive | Only for simple key-value caching of non-sensitive config. Hive has built-in AES-256 encryption but is also community-maintained and not suitable for the relational schema this app needs. |
| purchases_flutter (RevenueCat) | in_app_purchase (official) | If you want zero backend dependency and are willing to write your own receipt validation server. in_app_purchase gives lower-level access. For a solo/small-team freemium app, RevenueCat's backend value far outweighs its dependency cost. |
| flutter_riverpod | flutter_bloc | If your team has existing BLoC expertise or if you need strict event-driven audit trails for regulated compliance. BLoC 9.0 is still excellent; just more boilerplate for a greenfield app. |
| flutter_autofill_service (kee-org) | autofill_service (authpass) | The authpass plugin is simpler but last updated Feb 2024 and has minimal active maintenance. kee-org's plugin supports auth-gated access (required for security), Android 12+ IME, and had a release in Jan 2026. |
| go_router | auto_route | If you need very advanced nested navigation with strongly-typed route parameters. go_router covers 95% of use cases and has Flutter team backing. |
| flutter_secure_storage | encrypt package (manual) | If you need to encrypt arbitrary large data (profile payloads). flutter_secure_storage is for small secrets (keys, tokens). For the DB encryption key itself, use flutter_secure_storage; let Drift handle the rest. |

---

## What NOT to Use

| Avoid | Why | Use Instead |
|-------|-----|-------------|
| sqflite (direct) | No built-in encryption, no type safety, raw SQL strings everywhere, no code generation; significantly worse DX than Drift | drift with SQLite3MultipleCiphers |
| hive (original, v2) | Original maintainer abandoned project; community fork has limited momentum; no relational queries; AES encryption requires manual key management | drift for structured data; flutter_secure_storage for secrets |
| isar (original, pub.dev v3.1.0+1) | Original author abandoned; v4 dev build stalled for 2 years; Rust core is a significant barrier to community fixes; encryption support is absent (open GitHub Discussion #176 since 2022, never shipped) | drift or isar_community if NoSQL is truly required |
| SharedPreferences | No encryption whatsoever; stores plaintext; inappropriate for any PII (names, DOB, addresses, health data) | flutter_secure_storage for secrets; drift for structured profile data |
| Provider (flutter_provider) | Superseded by Riverpod; lacks compile-time safety; Riverpod's author built it specifically to fix Provider's limitations | flutter_riverpod ^3.2.1 |
| GetX | Monolithic — routing + state + DI in one opinionated package; mixes concerns; poor testability; community reputation for magic bugs | go_router for routing, flutter_riverpod for state |
| in_app_purchase_android / in_app_purchase_storekit (platform-specific) | Using platform-specific IAP packages means writing and maintaining two IAP code paths; RevenueCat normalizes them | purchases_flutter |
| flutter_inapp_purchase (dooboolab) | Less maintained than official plugin or RevenueCat; more setup work; less official support | purchases_flutter |

---

## Stack Patterns by Variant

**If implementing the Android AutofillService (v1 core feature):**
- Implement `flutter_autofill_service` — it handles the native `AutofillService` lifecycle via Kotlin platform channel
- The Dart side receives `FillRequestEvent` with a list of `AutofillMetadata` (field hints, package name, activity)
- Your heuristic mapping logic lives entirely in Dart and returns `AutofillValue` results
- Test ONLY on physical device or full Android emulator — autofill service cannot be exercised in unit tests
- The service must be registered in AndroidManifest.xml and the user must enable it in Settings > Passwords > Autofill Service

**If adding biometric auth gate at app launch:**
- Use `local_auth ^3.0.1`
- Call `canCheckBiometrics` + `isDeviceSupported()` on startup; gracefully degrade to PIN if unavailable
- MainActivity MUST extend `FlutterFragmentActivity` — if it extends `FlutterActivity`, local_auth crashes on Android
- Store the session-unlocked boolean in Riverpod state, NOT in secure storage (it's ephemeral per-session)

**If designing for future cloud sync (v1 data model):**
- Every profile entity needs: a stable `uuid` (UUID v4), `createdAt`, `updatedAt` (ISO8601 UTC), `deletedAt` (soft delete), `syncVersion` (integer counter)
- Drift's type-safe column definitions make this easy to enforce; add these to all `@DataClassName` tables
- Never use auto-increment integer PKs as the sync ID — use UUIDs so records survive migration across devices/backends

**If implementing freemium profile cap (free tier = 2 profiles):**
- Gate profile creation in a Riverpod provider that checks `purchases_flutter` entitlement state
- Cache entitlement status locally (RevenueCat caches it automatically)
- Show upgrade prompt when user hits the cap — do NOT silently fail
- RevenueCat's `Purchases.getCustomerInfo()` is the single source of truth for entitlement state

**If encryption key management with Drift:**
- Generate a random 32-byte key once on first app launch using `dart:math` or `dart:typed_data`
- Store the key in `flutter_secure_storage` under a stable key name
- Pass key as the PRAGMA passphrase to the `NativeDatabase` setup callback
- The key is protected by the Android Keystore (hardware-backed on Android 6+); biometric unlock wraps the keystore entry

---

## Version Compatibility

| Package | Compatible With | Notes |
|---------|-----------------|-------|
| flutter_secure_storage ^10.0.0 | Flutter 3.19+, Dart 3.3+, Android SDK 23+ | v10 rewrote Android implementation; min SDK raised from 19 to 23 (Android 6.0+). This is fine for 2026 target devices. |
| local_auth ^3.0.1 | Flutter 3.41.x | v3.0.1 published 9 days before research date (Feb 2026). Requires FlutterFragmentActivity. |
| drift ^2.32.0 | sqlite3 ^3.1.6 | SQLite3MultipleCiphers encryption built in since 2.32.0; sqlcipher_flutter_libs no longer needed |
| flutter_autofill_service ^0.21.0 | Android only | iOS autofill is explicitly unsupported by the plugin author (iOS requires a native App Extension, not possible from Dart); aligns with project's Android-first constraint |
| purchases_flutter ^9.13.1 | Android SDK 21+, iOS 13+ | RevenueCat requires network; offline entitlement cache is automatic |
| flutter_riverpod ^3.2.1 | Dart 3.x, Flutter 3.x | Riverpod 3.0 moved StateProvider/StateNotifierProvider to legacy.dart — don't use them in new code |

---

## Sources

- pub.dev/packages/flutter_autofill_service — version 0.21.0 confirmed, published Jan 19, 2026 (HIGH confidence)
- pub.dev/packages/flutter_secure_storage — version 10.0.0 confirmed, changelog verified (HIGH confidence)
- pub.dev/packages/local_auth — version 3.0.1 confirmed (HIGH confidence)
- pub.dev/packages/drift — version 2.32.0 confirmed (HIGH confidence)
- pub.dev/packages/flutter_riverpod — version 3.2.1 confirmed, published Feb 3, 2026 (HIGH confidence)
- pub.dev/packages/go_router — version 17.1.0 confirmed (HIGH confidence)
- pub.dev/packages/purchases_flutter — version 9.13.1 confirmed (HIGH confidence)
- drift.simonbinder.eu/platforms/encryption/ — SQLite3MultipleCiphers recommended, sqlcipher deprecated since drift 2.32.0 (HIGH confidence)
- github.com/kee-org/flutter_autofill_service — maintenance status confirmed: last release May 2025 + v0.21.0 Jan 2026, auth-gated access requirement (MEDIUM confidence — 9 stars, small but active project)
- WebSearch: "Hive vs Drift vs Floor vs Isar: Best Flutter Databases 2025" (quashbugs.com) — Isar abandonment status cross-referenced (MEDIUM confidence)
- WebSearch: Riverpod 3.0 release and features (MEDIUM confidence — multiple sources agree)
- blog.flutter.dev/whats-new-in-flutter-3-41 — Flutter 3.41 / Dart 3.11 current stable (HIGH confidence)

---

*Stack research for: Flutter family autofill app — Android autofill service, encrypted local storage, biometric auth, freemium IAP*
*Researched: 2026-03-06*

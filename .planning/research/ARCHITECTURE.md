# Architecture Research

**Domain:** Flutter Android autofill service app (family profile manager)
**Researched:** 2026-03-06
**Confidence:** HIGH (Android AutofillService lifecycle from official docs; Flutter patterns from verified community sources)

## Standard Architecture

### System Overview

```
┌──────────────────────────────────────────────────────────────────────┐
│                         PRESENTATION LAYER                           │
│  ┌─────────────┐  ┌──────────────┐  ┌─────────────┐  ┌───────────┐  │
│  │ Profile UI  │  │  Auth Gate   │  │ IAP/Paywall │  │ Settings  │  │
│  │ (Screens,   │  │  (Biometric  │  │  (RevenueCat│  │  Screen   │  │
│  │  Widgets)   │  │   Prompt)    │  │   overlay)  │  │           │  │
│  └──────┬──────┘  └──────┬───────┘  └──────┬──────┘  └─────┬─────┘  │
├─────────┴────────────────┴─────────────────┴────────────────┴────────┤
│                         DOMAIN LAYER                                 │
│  ┌──────────────────┐  ┌──────────────────┐  ┌─────────────────────┐ │
│  │  ProfileUseCase  │  │  AuthUseCase     │  │  EntitlementUseCase │ │
│  │  (CRUD profiles, │  │  (biometric lock,│  │  (free vs paid tier │ │
│  │   family mgmt)   │  │   app unlock)    │  │   enforcement)      │ │
│  └────────┬─────────┘  └────────┬─────────┘  └──────────┬──────────┘ │
│           │                     │                        │            │
│  ┌────────┴────────────────────┬┘                        │            │
│  │  HeuristicsEngine           │           ┌─────────────┴──────────┐ │
│  │  (field matching,           │           │  IAPService            │ │
│  │   manual override store)    │           │  (RevenueCat SDK)      │ │
│  └────────┬────────────────────┘           └────────────────────────┘ │
├───────────┴──────────────────────────────────────────────────────────┤
│                         DATA LAYER                                   │
│  ┌────────────────┐  ┌─────────────────┐  ┌──────────────────────┐   │
│  │ ProfileStore   │  │  MappingStore   │  │  SyncQueue           │   │
│  │ (Hive AES-256, │  │  (site→field→   │  │  (pending ops,       │   │
│  │  key via       │  │   profile map,  │  │   dirty flag,        │   │
│  │  secure_storage│  │   manual fixes) │  │   future cloud sync) │   │
│  └────────────────┘  └─────────────────┘  └──────────────────────┘   │
├──────────────────────────────────────────────────────────────────────┤
│                    PLATFORM BRIDGE LAYER                             │
│  ┌────────────────────────────────────────────────────────────────┐  │
│  │  AutofillPlatformChannel (MethodChannel)                       │  │
│  │  Dart side: sends profile list + field mappings to Kotlin      │  │
│  │  Kotlin side: receives data, builds FillResponse for OS        │  │
│  └────────────────────────────────────────────────────────────────┘  │
├──────────────────────────────────────────────────────────────────────┤
│                    ANDROID NATIVE LAYER (Kotlin)                     │
│  ┌───────────────────────┐  ┌───────────────────────────────────┐    │
│  │  FamilyAutofillService│  │  AuthActivity                     │    │
│  │  extends              │  │  (biometric prompt gate before    │    │
│  │  AutofillService      │  │   data is passed to FillResponse) │    │
│  │  (onFillRequest,      │  └───────────────────────────────────┘    │
│  │   onSaveRequest)      │                                           │
│  └───────────────────────┘                                           │
└──────────────────────────────────────────────────────────────────────┘
         ↑ OS binds / unbinds per request
┌──────────────────────────────────────────────────────────────────────┐
│                    ANDROID OS AUTOFILL FRAMEWORK                     │
│  User focuses form field → OS sends FillRequest → service responds  │
│  User selects dataset → OS injects values into views                │
└──────────────────────────────────────────────────────────────────────┘
```

### Component Responsibilities

| Component | Responsibility | Typical Implementation |
|-----------|----------------|------------------------|
| **FamilyAutofillService** | Implements Android `AutofillService`; receives OS fill/save requests; parses `AssistStructure`; returns `FillResponse` with datasets | Kotlin class in `android/` extending `AutofillService` |
| **AutofillPlatformChannel** | Bridge between Kotlin autofill service and Dart app state; Dart sends profile summaries, Kotlin builds native UI (RemoteViews) and datasets | Flutter `MethodChannel` — Dart sends JSON, Kotlin deserializes |
| **HeuristicsEngine** | Given a list of `ViewNode` hints/text/ids from `AssistStructure`, determines which `ProfileField` to fill; stores manual overrides keyed by site package name + field id | Pure Dart; rules-based regex/keyword matching; correction map persisted in `MappingStore` |
| **ProfileStore** | CRUD for family member profiles; AES-256 encrypted via Hive + encryption key held in `flutter_secure_storage` | Hive `Box<ProfileEntity>` with `HiveCipher` |
| **MappingStore** | Stores learned field mappings: `{packageName}.{fieldHintKey} → ProfileField`; stores manual corrections so they survive restarts | Separate Hive box; lightweight, not sensitive |
| **SyncQueue** | Tracks mutations that have not been synced to cloud; `synchronized: bool`, `updatedAt: DateTime`, `entityId: UUID` on every entity | Hive field annotations on every entity; sync worker reads `synchronized == false` |
| **AuthGate** | Intercepts app launch and AutofillService authentication flow; invokes `local_auth` biometric prompt | Dart widget + `local_auth` plugin |
| **IAPService** | Wraps RevenueCat SDK; exposes current entitlement state (`Entitlement.free` / `Entitlement.pro`); all feature gating checks here | `purchases_flutter` plugin; Riverpod provider exposes `EntitlementState` |
| **ProfileUseCase** | Business logic: enforce free-tier 2-profile cap; validate required fields; handle profile ordering | Pure Dart; depends on `ProfileStore` + `IAPService` |
| **AuthUseCase** | Checks biometric availability; initiates lock/unlock; stores lock state in session (not persisted) | Dart; calls `local_auth` |

---

## Recommended Project Structure

```
lib/
├── main.dart                     # App entry, Riverpod ProviderScope
├── app.dart                      # MaterialApp, router, auth gate wrap
│
├── domain/
│   ├── models/
│   │   ├── profile.dart          # FamilyProfile (with sync fields)
│   │   ├── profile_field.dart    # Enum: name, dob, address, phone, allergy, ...
│   │   └── field_mapping.dart    # FieldMapping: package+hint → ProfileField
│   ├── use_cases/
│   │   ├── profile_use_case.dart
│   │   ├── auth_use_case.dart
│   │   └── entitlement_use_case.dart
│   └── repositories/             # Abstract interfaces
│       ├── profile_repository.dart
│       └── mapping_repository.dart
│
├── data/
│   ├── storage/
│   │   ├── profile_store.dart    # Hive encrypted box implementation
│   │   ├── mapping_store.dart    # Hive unencrypted box
│   │   └── sync_queue.dart       # Pending sync tracker
│   ├── iap/
│   │   └── iap_service.dart      # RevenueCat wrapper
│   └── platform/
│       └── autofill_channel.dart # MethodChannel Dart side
│
├── heuristics/
│   ├── heuristics_engine.dart    # Field matching logic
│   ├── hint_rules.dart           # autofillHints → ProfileField map
│   └── text_rules.dart           # hint/label text → ProfileField heuristics
│
├── presentation/
│   ├── auth_gate/
│   │   └── auth_gate_screen.dart
│   ├── profiles/
│   │   ├── profile_list_screen.dart
│   │   ├── profile_edit_screen.dart
│   │   └── profile_card_widget.dart
│   ├── settings/
│   │   └── settings_screen.dart
│   └── paywall/
│       └── paywall_screen.dart
│
└── providers/                    # Riverpod providers
    ├── profile_providers.dart
    ├── auth_providers.dart
    └── entitlement_providers.dart

android/
├── app/src/main/
│   ├── AndroidManifest.xml       # AutofillService declaration
│   └── kotlin/.../
│       ├── FamilyAutofillService.kt  # extends AutofillService
│       ├── StructureParser.kt        # AssistStructure traversal
│       ├── DatasetBuilder.kt         # Builds FillResponse datasets
│       ├── AuthActivity.kt           # Auth gate for autofill flow
│       └── AutofillPlugin.kt         # MethodChannel registration
└── res/
    └── xml/
        └── autofill_service.xml      # Service capabilities declaration
```

### Structure Rationale

- **`domain/`:** Pure Dart, no Flutter/platform dependencies — independently testable; models own the sync-ready fields
- **`heuristics/`:** Isolated as a first-class module because it will grow (LLM integration is a future premium feature); keeping it separate now avoids a messy extraction later
- **`data/platform/`:** The MethodChannel boundary is explicit and co-located with the Android native code conceptually
- **`android/`:** Kotlin-heavy because `AutofillService` is a native Android class — the Dart layer cannot extend it; Flutter Dart communicates with it via channel only

---

## Architectural Patterns

### Pattern 1: Native Service + Platform Channel Bridge

**What:** The Android `AutofillService` lifecycle is owned entirely by the OS and runs in a Kotlin class. It cannot be a Dart class. The Kotlin service receives the `FillRequest`, communicates over a `MethodChannel` to get profile/mapping data from the Dart/Hive layer, builds `Dataset` objects with `RemoteViews`, and returns a `FillResponse` to the OS.

**When to use:** Required — there is no way to implement `AutofillService` in Dart. This is the only viable architecture for Flutter-based autofill on Android.

**Trade-offs:** The Kotlin service is stateless by design (OS binds, gets response, unbinds). The Dart/Hive layer holds all persistent state. The channel call must complete fast — the OS will unbind if the service takes too long.

**Key concern:** The Flutter engine may not be running when the OS calls `onFillRequest`. A common pattern (used by `authpass/autofill_service`) is to have the Kotlin service read profile data directly from the encrypted store without starting the Flutter engine, or to bring up a lightweight Flutter isolate. Authentication gating is handled in `AuthActivity` (a native Android activity) before data is returned to the OS.

```kotlin
// Kotlin: FamilyAutofillService.kt (simplified)
override fun onFillRequest(
    request: FillRequest,
    cancellationSignal: CancellationSignal,
    callback: FillCallback
) {
    val structure = request.fillContexts.last().structure
    val parsedFields = StructureParser(structure).parse()
    // Get profile data via channel (or read directly from Hive)
    val datasets = DatasetBuilder.build(parsedFields, profileData)
    callback.onSuccess(FillResponse.Builder().apply {
        datasets.forEach { addDataset(it) }
    }.build())
}
```

### Pattern 2: Heuristics-First Field Matching with Override Persistence

**What:** When `onFillRequest` receives an `AssistStructure`, the `StructureParser` traverses each `ViewNode`. For each autofillable field, it checks (in priority order): (1) explicit `autofillHints` attribute on the view, (2) HTML `autocomplete` attribute for web content, (3) `getHint()` / `getText()` matched against a keyword map, (4) field `id`/`resourceId` matched against a pattern library. Matched fields are mapped to `ProfileField` enum values. If the user manually corrects a mapping in the UI, the correction is stored in `MappingStore` keyed by `{packageName}.{viewId}` and used on all future requests to that app.

**When to use:** Always — this is the primary field identification strategy. LLM matching is a future paid-tier layer added on top of this, not a replacement.

**Trade-offs:** Keyword heuristics miss unusual label text and non-English forms. Manual corrections close this gap per-site. LLM matching (premium) closes it globally.

### Pattern 3: Biometric-Gated Autofill Authentication

**What:** The `FillResponse` is configured with `setAuthentication(autofillIds, intentSender, authPresentation)`. This tells the OS to launch `AuthActivity` when the user taps the autofill suggestion. `AuthActivity` invokes Android `BiometricPrompt`. On success, it returns the populated `Dataset` to the OS via `EXTRA_AUTHENTICATION_RESULT`. The actual profile data is never exposed in the initial `FillResponse` — only after authentication succeeds.

**When to use:** Always — required for the security model. Profile data (children's health, home address) must not be accessible without biometric confirmation.

**Trade-offs:** Adds one extra tap to every autofill flow. This is the correct trade-off for sensitive family data.

### Pattern 4: Sync-Ready Entity Model

**What:** Every entity stored in Hive carries three sync fields: `id: String` (UUID v4, assigned at creation), `updatedAt: DateTime`, and `synchronized: bool`. When a profile is created or modified, `synchronized` is set to `false` and `updatedAt` is updated. A background sync worker (future premium feature) reads all entities where `synchronized == false` and pushes them to the cloud API, then sets `synchronized = true` on success.

**When to use:** From day one on all persistent entities. Retrofitting UUIDs and dirty flags after v1 requires a database migration affecting real user data — painful and error-prone.

**Trade-offs:** Adds minor overhead per entity write. Worth it to avoid migration pain when cloud sync ships.

```dart
// Dart: profile.dart
@HiveType(typeId: 0)
class ProfileEntity extends HiveObject {
  @HiveField(0) late String id;           // UUID v4
  @HiveField(1) late String displayName;
  @HiveField(2) late DateTime updatedAt;
  @HiveField(3) late bool synchronized;   // false = dirty, needs sync
  // ... profile fields
}
```

---

## Data Flow

### Primary Flow: Profile Creation → Encrypted Storage

```
User fills profile form (Dart UI)
    ↓
ProfileUseCase.createProfile(data)
    ↓ enforces 2-profile cap for free tier via IAPService
ProfileRepository.save(profileEntity)
    ↓ sets id=UUID, updatedAt=now, synchronized=false
ProfileStore (Hive AES-256 encrypted box)
    ↓ encryption key read from flutter_secure_storage (backed by Android Keystore)
Profile encrypted and written to disk
```

### Primary Flow: Autofill Service → Form Fill

```
User focuses a form field in another app (e.g., camp registration website)
    ↓
Android OS: AutofillManager.notifyViewEntered()
    ↓
OS binds to FamilyAutofillService (Kotlin)
    ↓
onFillRequest(FillRequest) called
    ↓
StructureParser traverses AssistStructure ViewNodes
    ↓ reads autofillHints → maps to ProfileField enum
    ↓ fallback: reads hint/label text → HeuristicsEngine keyword match
    ↓ fallback: checks MappingStore for prior manual correction for this packageName+fieldId
    ↓
FamilyAutofillService fetches profile summaries
    ↓ (via MethodChannel to Dart, or direct Hive read from Kotlin)
    ↓ decrypt with key from Android Keystore
DatasetBuilder constructs Dataset per family member
    ↓ RemoteViews: shows profile name + avatar in OS dropdown
    ↓ AutofillValue set for each matched field
FillResponse built with authentication intent (AuthActivity)
callback.onSuccess(fillResponse)
    ↓
OS displays autofill tray with family member options
    ↓
User taps family member name
    ↓
OS launches AuthActivity
    ↓
BiometricPrompt shown (fingerprint/face)
    ↓ [user authenticates]
AuthActivity returns populated Dataset via EXTRA_AUTHENTICATION_RESULT
    ↓
OS injects AutofillValues into form fields
    ↓
onDisconnected() — OS unbinds from service
```

### Flow: Manual Field Correction

```
User notices wrong field was filled (e.g., "emergency contact" filled with child's name)
    ↓
User opens app → Settings → "Fix field mappings" or inline correction in autofill UI
    ↓
Correction recorded: MappingStore.save(packageName, viewId, correctProfileField)
    ↓
Next onFillRequest for same app: StructureParser checks MappingStore first
    ↓ manual override takes priority over heuristics
Correct field filled automatically going forward
```

### Flow: IAP Purchase → Feature Unlock

```
User has 2 profiles (free tier limit) and tries to add a third
    ↓
ProfileUseCase.createProfile() → IAPService.currentEntitlement() == free
    ↓
ProfileUseCase throws ProfileLimitException
    ↓
UI catches exception → navigates to PaywallScreen
    ↓
User purchases "Family Pro" subscription
    ↓
RevenueCat SDK: CustomerInfo updated → entitlement "pro" active
    ↓
IAPService notifies EntitlementProvider (Riverpod)
    ↓
ProfileUseCase re-executes → cap now = unlimited
Profile created, stored
```

### State Management Flow

```
Riverpod ProviderScope
    ↓ (subscribe)
ProfileListNotifier ←→ ProfileUseCase → ProfileStore (Hive)
EntitlementNotifier ←→ IAPService (RevenueCat)
AuthStateNotifier   ←→ AuthUseCase (local_auth)
    ↓
Screens observe providers, rebuild reactively
```

---

## Android AutofillService Lifecycle (Detailed)

The OS binds to the service on demand and unbinds immediately after the response. The service must be fast.

```
1. App A requests autofill (user taps a field)
   OS → binds → FamilyAutofillService.onConnected()

2. OS → FamilyAutofillService.onFillRequest(request, signal, callback)
   Service must call callback.onSuccess() or callback.onFailure()
   If it takes too long, the OS cancels via CancellationSignal

3. Service → callback.onSuccess(fillResponse)
   OS → unbinds → FamilyAutofillService.onDisconnected()

4. OS displays the autofill dropdown to user

5. User selects a dataset OR taps authenticate
   [If authenticate] OS → launches AuthActivity
   AuthActivity → BiometricPrompt
   On success → setResult(RESULT_OK, intent with dataset)
   OS injects AutofillValues into App A's views

6. [Optional] User submits the form
   OS → binds → onSaveRequest() [only if FillResponse had SaveInfo]
   Service can choose to save/update profile data
   OS → unbinds
```

**Key constraint:** The service process may be killed between requests. Do not hold state in service fields — read from storage on every `onFillRequest`.

**Chrome compatibility note:** Chrome 135 (April 2025) ships native third-party autofill support, ending the "compatibility mode" that caused janky scrolling and duplicate suggestions. This app's autofill will work more reliably in Chrome on Android after that release.

---

## Where Field Heuristics Logic Lives

The heuristics engine has two layers:

**Layer 1 — Kotlin (StructureParser, in Android native):**
- Runs inside `onFillRequest`
- Reads raw `AssistStructure` data: `autofillHints`, `hint`, `text`, `htmlInfo.attributes`, `resourceId`
- Maps to a shared `FieldType` enum (passed via platform channel as JSON)
- Must be fast — runs synchronously in the service call

**Layer 2 — Dart (HeuristicsEngine, in `lib/heuristics/`):**
- Stores and retrieves the rule set (keyword lists, regex patterns)
- Manages learned corrections in `MappingStore`
- In the future: calls LLM API for unmatched fields (premium tier)
- Provides the up-to-date rule set to the Kotlin layer on each fill request (or the rules are compiled into the Kotlin layer and updated via channel only when rules change)

**Why split:** Android requires the actual field-type decision to happen in Kotlin (it runs natively on the service thread). But the rule set and learned corrections live in Dart/Hive. The Kotlin layer is stateless; the Dart layer owns the knowledge.

**Manual correction persistence:**
- Stored in `MappingStore` as `Map<String, String>` where key = `{packageName}::{autofillId or resourceId}`, value = `ProfileField` enum name
- Loaded on app start, passed to Kotlin via channel on each fill request (or queried on demand)

---

## Sync-Ready Data Model vs Naive Local-Only

| Aspect | Naive Local-Only | Sync-Ready (this project) |
|--------|------------------|---------------------------|
| Entity ID | Hive auto-increment int | UUID v4 string (stable across devices) |
| Timestamps | None | `createdAt`, `updatedAt` on every entity |
| Dirty tracking | None | `synchronized: bool` field |
| Deletion | Hard delete | Soft delete: `deletedAt: DateTime?` (tombstoning) |
| Field granularity | Whole object | Individual field `updatedAt` for merge (future) |
| Migration pain | Requires schema migration when sync is added | None — fields exist from day one, sync layer reads them |

Tombstoning (soft delete) is important: if a profile is deleted on device A while device B is offline, the sync layer needs to know it was deleted, not just absent. Without `deletedAt`, sync would re-create deleted profiles.

---

## Recommended Build Order

The following order reflects hard technical dependencies — each phase must exist before the next can be built:

1. **Encrypted Profile Store** — `ProfileEntity` with sync fields, Hive + `flutter_secure_storage` setup. Everything depends on this. No autofill is possible without profile data.

2. **Profile CRUD UI + Biometric Auth Gate** — Users must be able to create and view profiles. The auth gate must work before the autofill service can be trusted with real data.

3. **Android AutofillService (Kotlin skeleton)** — Register the service with the OS; `onFillRequest` returns a static test dataset to prove the plumbing works. Does not need heuristics yet.

4. **StructureParser + HeuristicsEngine** — Field matching logic. Feeds real profile data into the autofill response. Needs the profile store (step 1) and the service skeleton (step 3).

5. **MappingStore + Manual Correction UI** — Builds on heuristics (step 4); allows users to fix wrong mappings. Needs the profile store and a working autofill flow.

6. **IAP / Entitlement Layer** — RevenueCat integration; profile cap enforcement; paywall screen. Can be built in parallel with steps 4-5 but requires the profile store (step 1).

7. **Cloud Sync** (paid tier, future) — Reads `synchronized == false` entities and pushes to API. All groundwork (UUIDs, dirty flags, tombstones) was laid in step 1. No migration required.

8. **LLM Field Matching** (paid tier, future) — Adds a third layer to `HeuristicsEngine` that calls an external API for fields the heuristic rules cannot match. Requires the heuristics architecture (step 4) to be clean and pluggable.

---

## Integration Points

### External Services

| Service | Integration Pattern | Notes |
|---------|---------------------|-------|
| Android OS AutofillFramework | Kotlin `AutofillService` subclass; responds to `onFillRequest` | Bound per-request; service must respond fast; cannot be Dart |
| RevenueCat | `purchases_flutter` SDK; `Purchases.configure()` at app start; observe `CustomerInfo` stream | Single source of truth for entitlement state; handles Android/iOS store differences |
| Android BiometricPrompt | `local_auth` Flutter plugin (Dart) + `BiometricPrompt` in `AuthActivity` (Kotlin) | Two usage contexts: app unlock (Dart) and autofill auth (Kotlin native activity) |
| Future: Cloud Sync API | REST or Firebase; writes from `SyncQueue` worker | Not needed in v1; data model is ready |
| Future: LLM API | HTTP call from `HeuristicsEngine` for unmatched fields | Premium tier only; not in v1 |

### Internal Boundaries

| Boundary | Communication | Notes |
|----------|---------------|-------|
| Kotlin AutofillService ↔ Dart Domain Layer | `MethodChannel` (`autofill/main`) | Kotlin calls Dart to get profile summaries; Dart returns JSON list; keep payload small — Binder transaction limit |
| Dart Presentation ↔ Domain | Riverpod providers / `UseCase` calls | Screens never touch `Store` directly |
| Domain ↔ Data | Repository interface (abstract class) | `ProfileRepository` interface in domain; `ProfileStore` implements it in data layer |
| Heuristics Engine ↔ MappingStore | Direct repository call | `HeuristicsEngine` reads from `MappingRepository`; writes corrections back |
| IAPService ↔ EntitlementUseCase | `IAPService` is injected into use case; use case gates profile cap | Entitlement check must be synchronous for UX; RevenueCat caches state locally |

---

## Anti-Patterns

### Anti-Pattern 1: Implementing AutofillService Logic in Dart

**What people do:** Attempt to write the `onFillRequest` handler in Dart and call native platform code from there.

**Why it's wrong:** `AutofillService` is an Android system service bound by the OS. It runs in a Kotlin/Java process. Flutter's Dart isolate may not be running when the OS calls it. The OS will not wait for a Flutter engine to spin up. The service will time out.

**Do this instead:** Implement `FamilyAutofillService.kt` in Kotlin. Keep the Kotlin service responsible for parsing `AssistStructure` and building `FillResponse`. Use the `MethodChannel` to pull profile data from the Dart/Hive layer, or have the Kotlin service read the Hive database directly (the Hive files are on-disk; the Kotlin layer can read them if the encryption key is accessible via Android Keystore without going through Dart).

### Anti-Pattern 2: Storing Profile Data Without Sync Fields

**What people do:** Store profiles as plain Hive objects with auto-increment IDs and no timestamps, planning to add sync later.

**Why it's wrong:** When cloud sync is added, all existing entities need migration: add UUID, add timestamps, add dirty flags. This migration runs against real user data (children's health records, emergency contacts) and must be correct. If it fails or is skipped by existing installs, sync will produce duplicate records or data loss.

**Do this instead:** Add `id: String` (UUID), `updatedAt: DateTime`, `synchronized: bool`, and `deletedAt: DateTime?` to every entity on day one. The sync worker is a future feature; the data model is not.

### Anti-Pattern 3: Returning Plaintext Profile Data in the Initial FillResponse

**What people do:** Build `Dataset` objects with actual `AutofillValue` data in `onFillRequest` and return them directly without authentication.

**Why it's wrong:** Any app that can trigger a fill request can receive the plaintext values in the response before the user authenticates. The OS populates the form without any user confirmation.

**Do this instead:** Use `FillResponse.Builder().setAuthentication(autofillIds, intentSender, authPresentation)` so the OS must launch `AuthActivity` and the user must authenticate before the dataset is returned. Only return populated `Dataset` objects from `AuthActivity` via `EXTRA_AUTHENTICATION_RESULT`.

### Anti-Pattern 4: Monolithic Heuristics Function

**What people do:** Write field matching as a single large function with nested if/else chains, interleaved with database calls and logging.

**Why it's wrong:** The LLM matching feature (premium tier) needs to slot in as a third strategy after heuristics fails. A monolithic function cannot be extended cleanly. It also makes the heuristic rules untestable in isolation.

**Do this instead:** Design `HeuristicsEngine` as a strategy pipeline: `HintStrategy → TextStrategy → ManualOverrideStrategy → (future) LlmStrategy`. Each strategy returns `ProfileField?` — the engine tries them in order and returns the first non-null result. Adding LLM matching is then a new strategy class, not a change to existing code.

---

## Scaling Considerations

This is a local-first mobile app. "Scale" means device count, not server load. The considerations are different:

| Scale | Architecture Adjustments |
|-------|--------------------------|
| 1-3 family members (typical) | Single Hive box, no pagination needed; all in memory |
| 10+ profiles (power user / edge case) | Profile list should be lazy-loaded; no change to core architecture |
| Many saved field mappings | `MappingStore` can grow large for heavy users; index by packageName prefix; acceptable in Hive |
| Cloud sync (premium) | `SyncQueue` worker already designed for this; add a background `WorkManager` job in Kotlin |

The primary scaling concern is the **Binder transaction limit** when passing data through the `MethodChannel` to the `AutofillService`. Each `onFillRequest` passes profile summaries (not full profiles) to keep payload small. Full profile data (including medical fields) should only be retrieved when the user confirms authentication in `AuthActivity`.

---

## Sources

- [Build autofill services — Android Developers](https://developer.android.com/identity/autofill/autofill-services) — HIGH confidence, official documentation
- [AutofillService API reference — Android Developers](https://developer.android.com/reference/android/service/autofill/AutofillService) — HIGH confidence, official
- [Chrome third-party autofill services update (Feb 2025) — Android Developers Blog](https://android-developers.googleblog.com/2025/02/chrome-3p-autofill-services-update.html) — HIGH confidence, official announcement
- [flutter_autofill_service plugin — GitHub (kee-org)](https://github.com/kee-org/flutter_autofill_service) — MEDIUM confidence, production implementation reference
- [autofill_service plugin — GitHub (authpass)](https://github.com/authpass/autofill_service) — MEDIUM confidence, production implementation (used by AuthPass password manager)
- [Offline-first support — Flutter official docs](https://docs.flutter.dev/app-architecture/design-patterns/offline-first) — HIGH confidence, official
- [Flutter app architecture with Riverpod — codewithandrea.com](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/) — MEDIUM confidence, well-regarded community source
- [RevenueCat Flutter docs](https://www.revenuecat.com/docs/getting-started/installation/flutter) — HIGH confidence, official SDK docs
- [Writing custom platform-specific code — Flutter docs](https://docs.flutter.dev/platform-integration/platform-channels) — HIGH confidence, official

---

*Architecture research for: Flutter family autofill app (Android AutofillService)*
*Researched: 2026-03-06*

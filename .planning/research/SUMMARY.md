# Project Research Summary

**Project:** Autofill — Family Profile Manager
**Domain:** Flutter Android AutofillService app with encrypted local storage, biometric auth, freemium IAP
**Researched:** 2026-03-06
**Confidence:** HIGH

## Executive Summary

This product is a purpose-built family profile autofill app for Android, targeting the unserved gap between credential managers (1Password, Bitwarden) and the actual form-filling needs of parents. Existing password managers model an "Identity" as a single adult with name, address, phone, and email — they have no concept of a child's allergy list, emergency contacts, insurance policy, or school name. Camp, school, and medical registration forms require 15-25 fields that no existing autofill product fills reliably. The core value proposition is: store each family member's profile once, then fill any registration form with one tap and a biometric confirmation.

The recommended implementation uses Flutter 3.41 with Riverpod 3.x for state management, Drift 2.32 (encrypted SQLite with SQLite3MultipleCiphers) for local storage, `flutter_autofill_service` (kee-org) for the Android AutofillService integration, `local_auth` for biometric gating, and RevenueCat (`purchases_flutter`) for freemium IAP. The Android AutofillService itself must be implemented in Kotlin — it cannot be a Dart class — and communicates with the Dart layer via a MethodChannel. This native/Dart split is not optional; it is the only viable architecture for this product category on Android.

The three highest risks are: (1) the AutofillService manifest declaration has three required elements that are commonly missed, causing the service to silently never activate; (2) the data model must include UUID primary keys and sync-ready timestamps from day one — retrofitting them after users have data requires a high-risk migration; and (3) field detection heuristics routinely fail on the non-standard field names used by real camp and school registration forms. All three risks are fully mitigatable with the design decisions documented in research and must be addressed in the first phase of development before any user-facing features are built.

---

## Key Findings

### Recommended Stack

The stack is well-defined with high source confidence. Flutter 3.41 / Dart 3.11 is current stable. The most important non-obvious choices are: **Drift over Hive** (Hive's original author abandoned the project; Drift provides type-safe relational queries, code generation, and built-in SQLite3MultipleCiphers encryption since v2.32.0); **RevenueCat over raw in_app_purchase** (RevenueCat handles receipt validation, entitlement caching, and cross-platform normalization — worth the backend dependency for a solo/small-team freemium app); and **kee-org's `flutter_autofill_service`** over the authpass fork (kee-org is actively maintained with a Jan 2026 release and supports auth-gated access, which is required for the security model).

**Core technologies:**
- Flutter 3.41 / Dart 3.11: Cross-platform mobile framework — Android-first with iOS additive later; no rewrite needed
- flutter_riverpod ^3.2.1: State management — Riverpod 3.0 adds compile-time safety; surpassed BLoC for greenfield apps in 2025
- drift ^2.32.0: Encrypted local database — type-safe SQL, built-in SQLite3MultipleCiphers, relational model supports sync-ready schema
- flutter_secure_storage ^10.0.0: Encryption key storage — hardware-backed Android Keystore; v10 rewrote Android impl for API 23+
- local_auth ^3.0.1: Biometric authentication — official Flutter team package; requires FlutterFragmentActivity (not FlutterActivity)
- flutter_autofill_service ^0.21.0: Android OS autofill integration — auth-gated access, Android 12+ IME, actively maintained
- purchases_flutter ^9.13.1: RevenueCat IAP/subscriptions — handles receipt validation and entitlement state; far less boilerplate than raw IAP

**Critical version constraint:** `local_auth ^3.0.1` requires `MainActivity` to extend `FlutterFragmentActivity` — apps using `FlutterActivity` will crash on Android.

**What not to use:** Hive (abandoned), Isar (abandoned, no encryption), SharedPreferences (no encryption), GetX (monolithic, poor testability), AccessibilityService for autofill (Play Store policy violation as of October 2025).

### Expected Features

The market gap is clear: no competitor offers child-specific data fields (allergies, medications, emergency contacts, insurance, school), full-form fill for 15-25 field registration forms, or per-app field mapping corrections. The free tier cap of 2 profiles is both the monetization mechanism and a natural upgrade trigger (adding a third child).

**Must have (table stakes — v1):**
- Biometric unlock with PIN fallback — security gate; absence signals negligence
- Encryption at rest (AES-256, biometric-protected key) — table stakes for children's health data
- Create/edit family member profiles with child-specific fields (allergies, emergency contacts, insurance, medications, school name) — the data the autofill actually needs
- Android Autofill Service with onboarding walkthrough (deep-link to Settings) — without OS integration, there is no product
- Profile selection picker in autofill UI (one Dataset per profile) — the "one tap" moment
- Full-form fill on profile selection (heuristic field mapping) — fills all recognized fields, not just the focused one
- Manual field correction with per-package persistence — heuristics will fail; fallback is required for user trust
- Freemium cap at 2 profiles with upgrade CTA — monetization from day one

**Should have (differentiators — v1.x after validation):**
- Contact import for profile setup — reduces setup friction
- In-app profile reference view with copy-to-clipboard — secondary daily utility
- Form fill history (paid tier) — meaningful once fill events accumulate

**Defer (v2+):**
- LLM-powered field matching (paid) — architecture must support it, but API cost is premature until paid user base exists
- Cloud backup and sync (paid) — data model is sync-ready from day one; defer the UI and backend
- iOS autofill — Flutter foundation makes it additive; validate Android demand first

**Anti-features to reject:** Password/credential storage (scope bloat, security liability), real-time collaborative editing (sync conflict complexity), unlimited free profiles (eliminates upgrade motivation), social login in v1 (no server account to link).

**Dependency order enforced by research:** Biometric auth must exist before profile viewing. Encryption must exist before profile storage. AutofillService registration must exist before any autofill feature. Sync-ready data model must exist before any paid tier feature.

### Architecture Approach

The architecture has two distinct execution environments that must be designed as a bridge from the start, not integrated later. The Android `AutofillService` lifecycle is owned by the OS and runs in a Kotlin class — the Dart/Flutter engine may not be running when `onFillRequest` is called. The Kotlin service parses `AssistStructure`, fetches profile summaries via a `MethodChannel` (or reads Drift's SQLite file directly), builds `Dataset` objects with `RemoteViews`, and returns a `FillResponse` with an authentication intent. The user's biometric confirmation happens in a native `AuthActivity` (Kotlin), not in the Flutter UI. Only after biometric success does the OS inject `AutofillValue` objects into the target app's form fields.

**Major components:**
1. **FamilyAutofillService (Kotlin)** — extends `AutofillService`; receives OS fill/save requests; parses `AssistStructure`; returns `FillResponse`
2. **AutofillPlatformChannel** — `MethodChannel` bridge between Kotlin service and Dart domain layer; Dart sends profile JSON, Kotlin builds native datasets
3. **HeuristicsEngine (Dart)** — layered field matching pipeline: `HintStrategy → TextStrategy → ManualOverrideStrategy → (future) LlmStrategy`; returns `ProfileField?` at each layer; isolated module for future LLM extension
4. **ProfileStore (Drift)** — encrypted SQLite via SQLite3MultipleCiphers; all entities carry UUID PK, `updatedAt`, `synchronized`, `deletedAt` from day one
5. **AuthGate** — biometric prompt via `local_auth` at app launch; separate `AuthActivity` in Kotlin for autofill flow
6. **IAPService** — RevenueCat wrapper; exposes `EntitlementState` via Riverpod; all feature gating goes through here
7. **MappingStore** — per-package field override corrections; keyed by `{packageName}::{autofillId}`; loaded on app start and passed to Kotlin on each fill request

**Key pattern — Biometric-gated autofill:** `FillResponse` is configured with `setAuthentication()` so the OS must launch `AuthActivity` before profile data is returned. Profile data is never exposed in the initial `FillResponse`. This is non-negotiable for a product storing children's health and location data.

**Key pattern — Sync-ready entity model:** Every entity has `id: String` (UUID v4), `updatedAt: DateTime`, `synchronized: bool`, `deletedAt: DateTime?`. The sync worker is a v2 feature; the data model is a v1 requirement.

### Critical Pitfalls

1. **Missing manifest service declaration** — AutofillService requires three simultaneous manifest elements: `android:permission="android.permission.BIND_AUTOFILL_SERVICE"` on the `<service>` tag, the `<action android:name="android.service.autofill.AutofillService" />` intent filter, and a `<meta-data>` pointing to a service configuration XML. Any one missing causes silent failure — the service never appears in Settings. Verify on a physical device before writing any field matching code.

2. **Auto-increment integer primary keys** — Using SQLite's `AUTOINCREMENT` means two devices can create a "Profile" with `id = 1`. When cloud sync ships, ID collision makes merge impossible without a full schema migration against real user data. Use UUID v4 TEXT PKs on every entity table from schema creation. This costs nothing now and prevents a catastrophic migration later.

3. **Encryption key lost on reinstall** — Android Keystore keys are hardware-bound and are deleted on app uninstall. The encrypted Drift database file may survive in backup, but without the key it is permanently unreadable. Set `android:allowBackup="false"` explicitly, document the data-loss-on-reinstall behavior prominently in onboarding, and position paid cloud sync as the migration path.

4. **Field heuristics brittle on real forms** — Camp, school, and medical registration forms use non-standard field names (`student_fname`, `child-first`, `enrollee_given_name`). Testing only against synthetic forms will produce a heuristic pass rate that looks good in development and fails in production. Test against at least 10 real camp/school registration form fixtures before v1. Design the engine as a replaceable strategy pipeline, not a flat if/else chain.

5. **Biometric lockout with no fallback** — After 5 failed attempts, Android returns `LockedOut`; after more failures, `PermanentlyLockedOut`. Without a PIN/device-credential fallback path, users are locked out of their family's emergency contacts. Implement device credential fallback (`biometricOnly: false`) as the default, not an afterthought. Known Flutter issue #112519 affects Android 10 and below.

---

## Implications for Roadmap

Based on the dependency graph in FEATURES.md and the build order in ARCHITECTURE.md, a 4-phase structure is recommended. Every subsequent phase depends on the foundation phase being complete and correct — attempting to build autofill features before the data layer and auth gate are proven will require rework.

### Phase 1: Secure Foundation

**Rationale:** Everything depends on this. No profile data can be written without encryption. No autofill can be trusted without biometric gating. No sync can ever be added without UUID primary keys. These must be done right before any user-facing features exist — there is no safe way to retrofit them.

**Delivers:** Encrypted local database with sync-ready schema, biometric auth gate, profile CRUD with child-specific fields, freemium cap enforcement, onboarding skeleton.

**Addresses:** Profile creation with required fields (name, DOB, allergies, emergency contacts, insurance, school), biometric unlock with PIN fallback, encryption at rest, freemium profile cap with upgrade CTA.

**Avoids:**
- Pitfall: Missing sync fields / auto-increment PKs (must use UUID PKs from first entity written)
- Pitfall: Encryption key lost on reinstall (set `android:allowBackup="false"`, add onboarding warning)
- Pitfall: Biometric lockout with no fallback (handle `LockedOut` / `PermanentlyLockedOut` error codes)

**Stack used:** Drift ^2.32.0, flutter_secure_storage ^10.0.0, local_auth ^3.0.1, flutter_riverpod ^3.2.1, go_router ^17.1.0, freezed, uuid.

### Phase 2: Android Autofill Service Integration

**Rationale:** The AutofillService Kotlin scaffold must be built and proven before heuristics can be added. A static test dataset ("Hello World" fill) validates the manifest, platform channel, and authentication flow before any real profile data is wired in. Getting the plumbing right before the intelligence is the correct order.

**Delivers:** Working AutofillService that appears in Android Settings, presents family member profiles in the autofill tray, requires biometric confirmation, and fills all recognized fields on selection. Onboarding walkthrough that deep-links to Settings and confirms activation.

**Addresses:** Android Autofill Service registration, onboarding walkthrough (deep-link to Settings, verify activation), profile selection picker in autofill UI, full-form fill (heuristic-based), Chrome 131+ native autofill compatibility.

**Avoids:**
- Pitfall: Wrong/incomplete manifest declaration (verify on physical device before heuristics phase)
- Pitfall: Using AccessibilityService (confirm `AutofillService` API 26+ throughout)
- Pitfall: Chrome compatibility mode dependency (implement standard API; do not use compatibility mode entries)
- Pitfall: Returning plaintext data in initial FillResponse (use `setAuthentication()` with `AuthActivity`)
- Pitfall: FillResponse dataset limit crash (20-dataset cap; pagination logic required)

**Stack used:** flutter_autofill_service ^0.21.0, Kotlin AutofillService, MethodChannel, RemoteViews, BiometricPrompt (Kotlin).

**Research flag:** Phase needs deeper implementation research — the Kotlin `StructureParser` + `DatasetBuilder` pattern has few Flutter-specific tutorials. Reference authpass/autofill_service and kee-org/flutter_autofill_service source code directly. `InlinePresentation` for Android 11+ IME integration needs a discrete implementation spike.

### Phase 3: Field Detection Engine and Mapping Corrections

**Rationale:** The heuristics engine requires a working autofill service (Phase 2) and a populated profile store (Phase 1). Separating this as its own phase allows focused testing against real-world form fixtures before v1 launch. The correction persistence layer must be built alongside heuristics — it is not an enhancement, it is the safety net for heuristic failures.

**Delivers:** Layered heuristics engine (hint attributes → HTML autocomplete → text tokenization → resource ID matching), per-package manual field correction UI and persistence, heuristic pass rate validated against real camp/school/medical registration forms.

**Addresses:** Field heuristics for camp/school/medical forms, automatic full-form fill on profile selection, manual field correction with per-package persistence.

**Avoids:**
- Pitfall: Brittle monolithic heuristics (implement as `HintStrategy → TextStrategy → ManualOverrideStrategy` pipeline; LLM slot-in is a future strategy class)
- Pitfall: Field detection fails on real forms (test against 10+ real-world form fixtures, target 70%+ pass rate)
- Pitfall: `onSaveRequest` never called (attach `SaveInfo` to every `FillResponse` where fields are detected; test save callback explicitly)

**Stack used:** Dart HeuristicsEngine, MappingStore (Drift), StructureParser (Kotlin).

**Research flag:** The keyword/regex rule set for child-specific fields (allergy, emergency contact, insurance, school name) needs real-world form analysis. No existing library covers this domain — it must be built from scratch using actual form fixtures. Budget extra time here.

### Phase 4: Freemium and IAP

**Rationale:** RevenueCat integration can be partially parallelized with Phase 3, but the paywall screen and entitlement enforcement must be complete before any public release. IAP is last because it requires App Store / Play Console product configuration that can't be tested until the build is installable.

**Delivers:** RevenueCat integration, profile creation blocked at 2-profile cap with upgrade CTA, paywall screen, purchase restoration on reinstall, entitlement state persisted in secure storage (not SharedPreferences).

**Addresses:** Freemium 2-profile cap enforcement, upgrade CTA with clear value proposition, IAP receipt handling.

**Avoids:**
- Pitfall: IAP entitlement enforced only client-side (use RevenueCat as single source of truth; for paid sync tier, server-side receipt validation is mandatory)
- Security mistake: Storing entitlement state in plain SharedPreferences (use flutter_secure_storage; validate against RevenueCat on each cold start)

**Stack used:** purchases_flutter ^9.13.1, RevenueCat Dashboard (configure products before writing Dart code).

### Phase Ordering Rationale

- **Foundation before everything else:** The database schema and encryption key setup cannot be migrated safely after real user data exists. UUID PKs, sync fields, and `allowBackup=false` are Phase 1 requirements, not Phase 4 cleanup.
- **Service scaffold before heuristics:** Proving the Kotlin ↔ Dart bridge works with a static dataset is faster than debugging manifest issues while simultaneously debugging field matching failures.
- **Heuristics as a dedicated phase:** The heuristics pass rate against real-world forms is the single most important quality metric for the product's core value. It deserves focused testing time, not a sprint backlog item.
- **IAP last in v1:** Can be built in parallel with Phase 2-3 but must not delay them. RevenueCat configuration (products, entitlements) must happen before integration testing.

### Research Flags

**Needs deeper research during planning:**
- **Phase 2:** Kotlin `StructureParser` + `DatasetBuilder` implementation patterns for Flutter-based autofill. `InlinePresentation` construction for Android 11+ IME. Reference kee-org and authpass plugin source code directly. Official Android docs are authoritative but Flutter-specific implementation details are sparse.
- **Phase 3:** Real-world field name coverage for camp/school/medical forms. Collect 10+ actual form fixtures before writing the keyword rule set. This is domain knowledge that cannot be researched generically.

**Standard patterns (skip research-phase):**
- **Phase 1:** Drift encrypted database setup, flutter_secure_storage key management, local_auth biometric flow, Riverpod 3.x provider patterns — all well-documented with official sources and high-confidence examples.
- **Phase 4:** RevenueCat Flutter integration — official SDK documentation is comprehensive; this is a standard integration.

---

## Confidence Assessment

| Area | Confidence | Notes |
|------|------------|-------|
| Stack | HIGH | Core packages verified via pub.dev with changelog confirmation; version compatibility cross-referenced; only uncertainty is flutter_autofill_service (9 GitHub stars, but Jan 2026 release confirms active maintenance) |
| Features | MEDIUM-HIGH | Competitor analysis from live sources (1Password support docs, Bitwarden comparison, Android developer docs); camp form fields validated against Jotform and CircleTree templates; no user interviews yet |
| Architecture | HIGH | Android AutofillService lifecycle from official docs; Kotlin platform channel pattern from production plugin source (authpass, kee-org); Flutter offline-first patterns from official Flutter docs |
| Pitfalls | HIGH | Most pitfalls verified against official Android docs, Flutter issue tracker, and production plugin implementations; Chrome compatibility mode deprecation confirmed via official Android Developers Blog |

**Overall confidence:** HIGH

### Gaps to Address

- **User interviews not yet conducted:** Feature priorities reflect competitor analysis and domain knowledge, not direct parent feedback. The assumption that "camp/school/medical forms" is the primary pain point should be validated in the first 2-4 weeks post-launch.
- **Real-world heuristics pass rate unknown:** The heuristics keyword set has not been tested against actual form fixtures. Phase 3 must include a form fixture collection step before writing the rule set.
- **LLM matching API costs unquantified:** The paid-tier LLM matching feature is architecturally supported but the API cost per fill request has not been analyzed. This needs a cost model before the paid tier is priced.
- **iOS autofill scope:** `flutter_autofill_service` explicitly does not support iOS (iOS requires a native App Extension). The Flutter foundation means iOS is additive, but the iOS autofill implementation will require native Swift code — it is not a Flutter port.

---

## Sources

### Primary (HIGH confidence)
- [Android AutofillService documentation](https://developer.android.com/identity/autofill/autofill-services) — service lifecycle, FillRequest/FillResponse/SaveInfo, manifest requirements
- [Android AutofillService API reference](https://developer.android.com/reference/android/service/autofill/AutofillService) — onFillRequest, onSaveRequest, CancellationSignal
- [Chrome third-party autofill update — Android Developers Blog, Feb 2025](https://android-developers.googleblog.com/2025/02/chrome-3p-autofill-services-update.html) — compatibility mode deprecation confirmed
- [Flutter offline-first architecture](https://docs.flutter.dev/app-architecture/design-patterns/offline-first) — sync-ready patterns
- [Flutter platform channels](https://docs.flutter.dev/platform-integration/platform-channels) — MethodChannel usage
- [RevenueCat Flutter docs](https://www.revenuecat.com/docs/getting-started/installation/flutter) — SDK configuration
- pub.dev package pages (drift, flutter_secure_storage, local_auth, flutter_riverpod, go_router, purchases_flutter) — version and changelog verification
- [drift encryption documentation](https://drift.simonbinder.eu/platforms/encryption/) — SQLite3MultipleCiphers, sqlcipher deprecation
- [blog.flutter.dev — Flutter 3.41 release notes](https://blog.flutter.dev/whats-new-in-flutter-3-41) — current stable version confirmation

### Secondary (MEDIUM confidence)
- [kee-org/flutter_autofill_service GitHub](https://github.com/kee-org/flutter_autofill_service) — production implementation reference; auth-gated access pattern
- [authpass/autofill_service GitHub](https://github.com/authpass/autofill_service) — production implementation reference; used by AuthPass password manager
- [codewithandrea.com — Flutter app architecture with Riverpod](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/) — well-regarded community source
- [1Password item categories](https://support.1password.com/item-categories/) — competitor Identity field analysis; no allergy/emergency fields confirmed
- [Bitwarden vs 1Password comparison — CyberNews 2026](https://cybernews.com/best-password-managers/bitwarden-vs-1password/) — family plan feature parity
- [Jotform camp registration form templates](https://www.jotform.com/form-templates/camp-registration-form) — ground truth for camp form field requirements
- [CircleTree summer camp registration tips](https://blog.circuitree.com/summer-camp-registration-forms) — emergency contact field requirements
- [Flutter local_auth issues #112519, #108945](https://github.com/flutter/flutter/issues/112519) — Android 10 PIN fallback bug confirmed

### Tertiary (MEDIUM-LOW confidence)
- WebSearch: "Hive vs Drift vs Floor vs Isar 2025" (quashbugs.com) — Isar abandonment cross-referenced with GitHub activity
- WebSearch: Riverpod 3.0 release features — multiple community sources agree; no single authoritative changelog
- [OnSecurity: Bypassing freemium with client-side controls](https://www.onsecurity.io/blog/pentest-findings-bypassing-freemium-through-client-side-security-controls/) — IAP bypass risk analysis

---

*Research completed: 2026-03-06*
*Ready for roadmap: yes*

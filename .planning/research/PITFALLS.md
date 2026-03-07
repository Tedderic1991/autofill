# Pitfalls Research

**Domain:** Flutter Android AutofillService app with encrypted local storage, biometric auth, freemium IAP, sync-ready architecture
**Researched:** 2026-03-06
**Confidence:** HIGH (most pitfalls verified against official Android docs and active Flutter issue tracker)

---

## Critical Pitfalls

### Pitfall 1: Missing or Incomplete Manifest Service Declaration

**What goes wrong:**
The AutofillService never activates — it won't appear in Android Settings > Autofill Service, the OS won't bind to it, and users cannot enable it. The app installs fine but the autofill integration is silently dead.

**Why it happens:**
Developers copy service declarations from accessibility service examples, which have a different structure. The AutofillService requires three simultaneous elements in the manifest: the `android:permission="android.permission.BIND_AUTOFILL_SERVICE"` attribute (not a uses-permission — the service must *require* it), the `<action android:name="android.service.autofill.AutofillService" />` intent filter, and a `<meta-data android:name="android.autofill" android:resource="@xml/service_configuration" />` pointing to a settings XML resource. Any one of these missing causes silent failure.

**How to avoid:**
Declare all three required elements from day one. The service_configuration XML must exist and reference a valid settings activity (even if it's a placeholder screen). Verify the service appears in device Settings > Apps & notifications > Default apps > Autofill service before testing any fill behavior.

**Warning signs:**
- Autofill dropdown never appears on any app or form
- Service is absent from Android Settings autofill selector
- No `onFillRequest()` calls in logs despite focusing form fields

**Phase to address:** Autofill Service scaffold (Phase 1 / foundation)

---

### Pitfall 2: AutofillService Confused with AccessibilityService

**What goes wrong:**
Developers implement using `AccessibilityService` instead of `AutofillService`, or mix the two APIs. Apps using `AccessibilityService` for autofill-like behavior face Google Play rejection and policy violation, plus severely limited fill capabilities (no structured dataset, no UI presentation control).

**Why it happens:**
Before Android 8.0, the only way to auto-fill forms was via `AccessibilityService`. Many tutorials, Stack Overflow answers, and GitHub repos from pre-2017 use this pattern. The two service names look similar. Some password managers (pre-2018) used AccessibilityService, and this history pollutes search results.

**How to avoid:**
Use only `AutofillService` (introduced Android API 26). Never request `BIND_ACCESSIBILITY_SERVICE` for autofill purposes. As of Google's October 2025 policy update, apps that use AccessibilityService to autonomously execute actions face rejection. The correct API is `android.service.autofill.AutofillService`.

**Warning signs:**
- Codebase has `AccessibilityService` anywhere near autofill logic
- Play Store review rejection mentioning AccessibilityService policy
- Service requires `BIND_ACCESSIBILITY_SERVICE` permission

**Phase to address:** Autofill Service scaffold (Phase 1 / foundation)

---

### Pitfall 3: Chrome Compatibility Mode Dependency (Deprecated as of Early 2025)

**What goes wrong:**
The autofill service works in native apps but fails silently in Chrome on Android. Historically this was "solved" by compatibility mode — allowlisting Chrome packages and using `FLAG_COMPAT_MODE_REQUEST`. As of Chrome 131 (November 2024), compatibility mode is deprecated, and Chrome now uses native autofill service APIs directly.

**Why it happens:**
All pre-2025 documentation and tutorials describe compatibility mode as the solution for Chrome autofill. Developers follow this outdated guidance, build their service around compatibility mode behaviors (e.g., relying on `FLAG_SAVE_ON_ALL_VIEWS_INVISIBLE`, which is the compatibility mode default), and the service breaks silently on Chrome 131+.

**How to avoid:**
Do not build compatibility mode as the primary Chrome strategy. Implement the standard AutofillService API correctly and it will work natively with Chrome 131+. Explicitly document in code that compatibility mode `<compatibility-package>` entries are legacy only. Test against Chrome 131+ with native autofill enabled via Chrome Settings > Autofill using another service.

**Warning signs:**
- Service works in Firefox/other browsers but not Chrome
- Codebase has `<compatibility-package android:name="com.android.chrome" .../>` as the primary Chrome strategy
- `onFillRequest()` not called when focusing fields in Chrome

**Phase to address:** Autofill Service scaffold + integration testing (Phase 1-2)

---

### Pitfall 4: Field Detection Heuristics That Break on Real-World Forms

**What goes wrong:**
Heuristics work on simple test forms but fail on the forms that matter most — camp registration sites, school enrollment, and medical intake forms. These forms use non-standard field names, unlabeled inputs, dynamic JS-rendered fields, or unconventional HTML structures. The service matches nothing and presents no suggestions, which is the app's entire value proposition.

**Why it happens:**
Developers test heuristics against synthetic forms they control. Real-world educational/medical forms are built by non-specialist developers with inconsistent naming (e.g., `student_fname`, `child-first`, `enrollee_given_name` for a child's first name). The Android `ViewNode` may provide `getHint()`, `getText()`, `getClassName()`, or HTML attributes — but no single signal is reliable. Developers also fail to handle the case where `autofillHints` is absent (most third-party apps don't set it).

**How to avoid:**
Build heuristics as a layered cascade: (1) explicit `autofillHints`, (2) HTML autocomplete attributes, (3) field hint/label text tokenization, (4) field name/id patterns, (5) positional context (e.g., field after a label containing "child"). Test against at least 10 real camp/school registration forms before v1. Store per-domain manual override corrections (required in the spec) as the safety net. Design the field classifier as a replaceable module so LLM matching slots in cleanly later.

**Warning signs:**
- Pass rate on a diverse test form suite below 70%
- Heuristic code has a flat `if/else` chain rather than layered fallback
- No test fixtures representing real-world forms

**Phase to address:** Field detection / heuristics engine (Phase 2)

---

### Pitfall 5: onSaveRequest Never Called

**What goes wrong:**
The autofill service never receives a save callback after form submission. No form data is persisted. Developers assume the OS will call `onSaveRequest()` automatically after any form submission.

**Why it happens:**
`onSaveRequest()` is only called when (a) a `SaveInfo` object was included in the `FillResponse` for that fill request, AND (b) the autofill context is properly committed — either by the client activity finishing or by an explicit `AutofillManager.commit()` call. Single-activity apps using fragment navigation never finish the activity, so the context is never committed. Additionally, if the service returns a null/empty `FillResponse`, no save callback is possible.

**How to avoid:**
Always attach a `SaveInfo` to `FillResponse` when form fields are detected. For form submission flows that don't navigate away (SPAs, WebView apps), use `FLAG_SAVE_ON_ALL_VIEWS_INVISIBLE`. For multi-screen form flows, use client state bundles to accumulate field data across `FillRequest` calls. Test `onSaveRequest()` firing explicitly in the integration test suite.

**Warning signs:**
- Form data never appears in save prompt after submission
- `onSaveRequest()` has no log output in any test scenario
- `FillResponse.Builder()` calls missing `.setSaveInfo(...)` chain

**Phase to address:** Field detection + autofill service fill/save lifecycle (Phase 2)

---

### Pitfall 6: Encryption Key Lost on App Reinstall or Backup Restore

**What goes wrong:**
All user profile data becomes permanently inaccessible after app reinstall, device migration, or Android backup restore. The app opens but decryption fails silently or crashes. This is catastrophic for a local-first app storing irreplaceable family data (children's medical info, emergency contacts).

**Why it happens:**
Android Keystore keys are hardware-bound and not included in standard Android backups. If the app stores data with an AES key that lives in Keystore, and the user reinstalls (or restores from backup), the Keystore key is gone but the encrypted data remains — unrecoverable. `flutter_secure_storage` uses Keystore under the hood. Developers test on a single device and never notice because they never reinstall.

**How to avoid:**
Set `android:allowBackup="false"` and `android:fullBackupContent="@xml/backup_rules"` with explicit Keystore key exclusion so users understand data is device-local. Display a clear first-run warning: "Data is stored only on this device. Reinstalling will delete all profiles." For the paid sync tier, design the export/backup format as the migration path, not Android backup. Never rely on `BackupAgent` to back up Keystore-derived keys — it won't work.

**Warning signs:**
- No documented data-loss-on-reinstall behavior in onboarding
- Backup rules file absent or not explicitly excluding encrypted data
- No integration test for fresh install with existing encrypted store

**Phase to address:** Encrypted storage setup (Phase 1 / foundation)

---

### Pitfall 7: Biometric Auth Lockout Breaks App Access

**What goes wrong:**
After 5 failed biometric attempts, Android returns a `LockedOut` error. After another threshold of failures it returns `PermanentlyLockedOut`. If the app's only auth path is biometric, users are completely locked out of their own family data — potentially for medical emergency contacts or time-sensitive form fills.

**Why it happens:**
Flutter's `local_auth` package exposes these error codes but many implementations just show a generic "authentication failed" message with a retry button. There is no fallback to device PIN/password. Additionally, known Flutter bugs (issue #112519) cause Android 10 and below devices to prompt for biometric enrollment instead of accepting PIN as a fallback when `biometricOnly: false` is set.

**How to avoid:**
Handle all three PlatformException codes explicitly: `NotEnrolled` (prompt settings), `LockedOut` (prompt device unlock), `PermanentlyLockedOut` (prompt device unlock with message). Implement device credential fallback (`biometricOnly: false`) as the default path, not an afterthought. Test on physical devices — emulators do not correctly simulate biometric states. Test specifically on Android 10 (API 29) for the PIN fallback bug.

**Warning signs:**
- Auth implementation catches generic `PlatformException` with a single handler
- No fallback visible in UI for biometric failure
- Only tested on emulator or a single physical device

**Phase to address:** Biometric auth + vault unlock (Phase 1 / foundation)

---

### Pitfall 8: FillResponse Dataset Limit Causing Binder Transaction Crash

**What goes wrong:**
When a family has many profiles, or when the service constructs verbose `RemoteViews` for each dataset, the `FillResponse` object exceeds the Android Binder transaction size limit (1MB). This causes a `TransactionTooLargeException` and the service crashes silently — no autofill suggestions appear and no error is surfaced to the user.

**Why it happens:**
`RemoteViews` objects are serialized through Binder IPC. Large presentation layouts, high-resolution icons, or constructing more than ~20 datasets at once pushes the payload over the limit. Android's official docs say no more than 20 `Dataset` objects per response, but developers don't read this constraint until after a crash report from a user with 30+ profiles.

**How to avoid:**
Keep presentation layouts minimal — a `TextView` with a name is sufficient. Limit datasets to 20 per `FillResponse`; implement a "Show more" dataset that triggers a second fill request for pagination. Never embed full-resolution images in `RemoteViews`. For this app, with a practical max of 2-5 family profiles in most use cases, this limit is rarely hit, but the architecture must handle it from day one.

**Warning signs:**
- Logcat shows `TransactionTooLargeException` near autofill lifecycle
- RemoteViews layout references large drawables or complex hierarchies
- No pagination logic for dataset responses

**Phase to address:** Autofill service dataset construction (Phase 2)

---

### Pitfall 9: Inline Suggestion Support Not Implemented (Android 11+)

**What goes wrong:**
On Android 11+ devices with compatible keyboards (Gboard, Samsung Keyboard), the autofill suggestions appear as a dropdown below the field rather than inline in the keyboard suggestion strip. This looks broken/unprofessional compared to 1Password, Bitwarden, and Google Password Manager, which show suggestions inline. Users on modern devices complain the app "doesn't work right."

**Why it happens:**
Android 11 (API 30) introduced `InlineSuggestionsRequest` as part of `FillRequest`. If the service ignores it and returns only dropdown-style datasets, Android falls back to dropdown mode. Most Flutter autofill service tutorials predate Android 11 and don't cover inline suggestions. The `flutter_autofill_service` plugin (kee-org) has partial inline suggestion support, but it is not automatic.

**How to avoid:**
Check for `FillRequest.getInlineSuggestionsRequest()` in `onFillRequest()`. When present, construct `InlinePresentation` in addition to standard `RemoteViews` presentation. This is additional code in the Kotlin platform channel, not configurable from Dart. Plan this as a discrete implementation task rather than discovering it in user feedback post-launch.

**Warning signs:**
- No `InlinePresentation` construction anywhere in Kotlin service code
- Testing only on Android 10 or lower
- No inline suggestion test on Gboard + Android 11+

**Phase to address:** Autofill service polish / presentation layer (Phase 2-3)

---

### Pitfall 10: IAP Entitlement Enforced Only Client-Side

**What goes wrong:**
The 2-profile free tier limit and "unlimited profiles" paid tier can be bypassed with trivial APK patching or Dart VM manipulation. Any user who decompiles the app and patches the profile count check gets all paid features for free. This is confirmed exploitable in Flutter apps via repack-and-sideload attacks.

**Why it happens:**
Local-first apps with no backend naturally put all business logic on the client. The profile count check is a simple integer comparison in Dart code — easily identified and patched. This is tempting to rationalize: "our users are parents, not hackers." But family data apps attract sideloaded modified APKs circulated in parenting forums.

**How to avoid:**
For the free tier limit specifically, consider whether enforcement matters more than friction: a parent managing 2 kids who wants a 3rd profile is your highest-value upgrade target, not a piracy risk. If enforcement is required, use Google Play Integrity API to attest the app binary hasn't been tampered with. For the paid cloud sync feature, server-side receipt validation is mandatory (the server won't serve sync without a valid subscription token). Use RevenueCat or equivalent to centralize entitlement state rather than rolling a custom IAP implementation.

**Warning signs:**
- Profile limit is enforced only via a Dart boolean/integer check with no server verification
- IAP receipt never sent to a backend for validation
- No Play Integrity API integration for sensitive paywall enforcement

**Phase to address:** Freemium + IAP implementation (Phase 3-4)

---

### Pitfall 11: Sync-Ready Data Model Retrofitted Instead of Designed In

**What goes wrong:**
When cloud sync is added as a paid feature, the local SQLite schema uses auto-incrementing integer primary keys. Two devices create a "Profile" with `id = 1` — the same key, different data. Merging is impossible without a painful migration that reassigns all IDs and breaks all foreign key references across the schema.

**Why it happens:**
SQLite's `INTEGER PRIMARY KEY AUTOINCREMENT` is the default for beginners and most tutorials. It works perfectly on a single device. The sync-readiness requirement in the spec is noted but deferred: "we'll add UUIDs later." Later arrives with 10K users and a multi-table schema with FK chains.

**How to avoid:**
Use UUID v4 (TEXT) primary keys for all entities from day one. Add `created_at`, `updated_at`, and `deleted_at` (soft-delete) timestamp columns to every entity table. Add a `device_id` source column for conflict context. Do not use any auto-incrementing sequence that cannot be globally unique. This costs nothing at schema design time and prevents a full migration later.

**Warning signs:**
- Schema uses `INTEGER PRIMARY KEY AUTOINCREMENT` for any entity table
- No `updated_at` or `deleted_at` timestamp columns
- "We'll fix primary keys when we add sync" in a code comment

**Phase to address:** Data model design (Phase 1 / foundation) — must be done before any data is written to the schema

---

### Pitfall 12: flutter_secure_storage Key Wiped by App Uninstall on Android

**What goes wrong:**
`flutter_secure_storage` stores its wrapped AES key in Android Keystore. On app uninstall, Android deletes all Keystore entries scoped to that app. On reinstall, a new encryption key is generated, and all previously stored data (if the encrypted database file survived via backup or external storage) is permanently unreadable.

**Why it happens:**
Developers understand that Keystore keys are "secure" but don't think through the uninstall/reinstall lifecycle. The encrypted SQLCipher database file may survive in app data backup (if `allowBackup` is true), but the Keystore key that decrypted it is gone. The result: the database file exists, decryption fails, the app either crashes or silently returns empty data.

**How to avoid:**
Set `android:allowBackup="false"` explicitly. Treat every reinstall as a fresh start — communicate this to users prominently during onboarding. Do not try to back up Keystore keys; it cannot be done securely. For users who need data persistence across devices, direct them to the paid cloud sync feature as the sanctioned path.

**Warning signs:**
- `android:allowBackup` not explicitly set in AndroidManifest.xml
- No onboarding screen explaining local-only data policy
- No test for reinstall scenario in integration test suite

**Phase to address:** Encrypted storage + onboarding (Phase 1 / foundation)

---

## Technical Debt Patterns

| Shortcut | Immediate Benefit | Long-term Cost | When Acceptable |
|----------|-------------------|----------------|-----------------|
| Auto-increment integer PKs | Simpler queries, familiar pattern | Full schema migration to UUIDs when sync ships; FK chain reassignment across all tables | Never — UUID PKs cost nothing at design time |
| Client-side-only profile limit enforcement | No backend needed | Bypassable with APK patch; resets to free tier on cache clear | Acceptable for MVP if server validation is planned for sync tier |
| Skip inline suggestion support (Android 11+) | Faster initial build | Users report autofill "looks broken" vs. competitors on modern devices | Acceptable as Phase 2 follow-up, not permanent deferral |
| SharedPreferences for entitlement state | No Keystore overhead | Trivially writable by rooted device | Never for paid feature state — use secure storage |
| Hard-coded heuristic strings | Quick to write | Brittle; breaks on form redesigns; untestable | Acceptable in Phase 2 if extracted to a data file (not embedded in logic) |
| No pagination in FillResponse | Simpler code path | Crashes on TransactionTooLargeException if dataset count grows | Never — 20-dataset cap is a hard system limit |
| Compatibility mode as Chrome strategy | Works on older Chrome | Broken on Chrome 131+ (released Nov 2024); compatibility mode is deprecated | Never for new implementations |

---

## Integration Gotchas

| Integration | Common Mistake | Correct Approach |
|-------------|----------------|------------------|
| Android AutofillService manifest | Missing `android:permission="android.permission.BIND_AUTOFILL_SERVICE"` on `<service>` tag | Attribute goes on the `<service>` element, not `<uses-permission>` — the service *requires* callers to hold this permission |
| flutter_secure_storage | Using `encryptedSharedPreferences` option on Android without testing on API < 23 | Requires API 23+; app silently uses unencrypted fallback on older devices unless explicitly blocked |
| Google Play Billing (in_app_purchase) | Not handling `purchaseUpdatedStream` subscription being dropped on app restart | Restore purchases on every cold start; re-attach the stream listener in `initState` |
| local_auth biometric | Calling `authenticate()` without checking `isDeviceSupported()` and `canCheckBiometrics()` first | Always check capabilities before prompting; show appropriate setup guidance when biometrics unavailable |
| Chrome native autofill (131+) | Testing autofill against Chrome with only compatibility mode enabled | Disable compatibility mode; test with Chrome Settings > Autofill using another service set to your service |
| SQLCipher (sqflite_sqlcipher) | Opening a SQLCipher v3 database with the v4 plugin without running PRAGMA cipher_migrate | Plugin auto-migrates, but this can fail silently; verify migration success in first-open logic |

---

## Performance Traps

| Trap | Symptoms | Prevention | When It Breaks |
|------|----------|------------|----------------|
| Heuristic scan runs on every `onFillRequest()` without caching | Perceptible 200-500ms delay before autofill dropdown appears | Cache field classification results keyed by package name + activity name; invalidate on app update | From first user on a slow device |
| `RemoteViews` constructed with large drawables | `TransactionTooLargeException` crash; no autofill suggestions | Use text-only or small icon presentations; profile photo thumbnails not in RemoteViews | With any dataset response, or when many profiles exist |
| Decrypting entire profile database on every `onFillRequest()` | High latency on fill, battery drain, service ANR | Decrypt profile data once on vault unlock and hold in memory; re-lock on screen-off or configurable timeout | From the first fill request on a large dataset |
| SQLite queries without indices on `updated_at` for sync delta fetch | Slow full-table scans when building sync payloads | Index `updated_at` on all entity tables from schema creation | At ~1,000+ profile history / form history rows |

---

## Security Mistakes

| Mistake | Risk | Prevention |
|---------|------|------------|
| Logging profile data (name, DOB, address) in debug builds | Sensitive family data in Android logcat readable by other apps | Use a logging wrapper that strips PII; ensure `BuildConfig.DEBUG` gates all profile-data logging |
| Storing IAP entitlement state in plain SharedPreferences | Rooted users can set `is_premium = true`; free riders | Store entitlement in flutter_secure_storage; validate against Play Billing receipt on each cold start |
| Autofill dataset `RemoteViews` presentation shows full child name + DOB | Sensitive data visible on autofill overlay without device unlock | Require biometric/PIN unlock before service is enabled; show only first name + masked data in presentation until unlocked |
| `android:allowBackup="true"` (Android default) with encrypted local database | Backup restores database without Keystore key; crash on decrypt; data permanently lost | Explicitly set `android:allowBackup="false"` and document data-loss-on-reinstall in onboarding |
| No certificate pinning for sync API (if added) | MITM attack intercepts children's health/emergency data in transit | Pin public key for sync endpoint; use HSTS; plan this for the sync feature phase, not retroactively |

---

## UX Pitfalls

| Pitfall | User Impact | Better Approach |
|---------|-------------|-----------------|
| No guidance on how to enable the autofill service in device Settings | Users install, see no autofill, uninstall — the core feature is invisible | Prominent onboarding flow with step-by-step screenshots for enabling autofill in Settings; deep-link to the autofill settings screen |
| Biometric prompt appears with no context about what is being unlocked | Parents confused why a fingerprint is needed inside an app they just opened | Explain in the prompt: "Unlock your family profiles to enable autofill" |
| "Autofill failed" shown when field mapping produces no match | Looks like a bug, not a fixable mapping issue | Show "We couldn't match this form — tap to set up fields manually" with the manual correction flow |
| Profile limit hit with no upgrade path visible | User with 3 kids cannot add a third child; error with no explanation | When profile limit is reached, show upgrade prompt with specific value proposition: "Add [child's name] and all future kids" |
| Manual field correction UX is buried or missing | Power users cannot fix bad mappings; mappings stay wrong per-site forever | Surface "fix this mapping" affordance directly on the autofill dropdown; persist corrections keyed by package + activity |

---

## "Looks Done But Isn't" Checklist

- [ ] **Autofill service registration:** Service appears in Android Settings > Default apps > Autofill service — verify on a physical device, not emulator
- [ ] **Chrome autofill:** Service fills forms in Chrome 131+ with native autofill (not compatibility mode) — test with a real Chrome session
- [ ] **Biometric lockout:** App handles `LockedOut` and `PermanentlyLockedOut` errors with a PIN fallback path — test by deliberately triggering lockout
- [ ] **onSaveRequest:** Service receives save callback after real form submission in a third-party app — not just in the service's own test form
- [ ] **Reinstall data loss:** Documented user-visible warning about data loss on reinstall shown during onboarding — not just in privacy policy
- [ ] **Field heuristics tested on real forms:** Heuristic pass rate measured against real camp/school registration forms, not only synthetic test forms
- [ ] **Dataset presentation limits:** Service does not crash with `TransactionTooLargeException` when presenting dataset list — test with 20+ datasets
- [ ] **IAP purchase restoration:** Paid entitlement is correctly restored after app reinstall without re-purchasing — test with a real test purchase
- [ ] **UUID primary keys:** All entity tables use UUID TEXT PKs — no `AUTOINCREMENT` in schema DDL
- [ ] **Inline suggestions:** Service renders inline suggestions on Android 11+ with Gboard — test on physical Android 11+ device

---

## Recovery Strategies

| Pitfall | Recovery Cost | Recovery Steps |
|---------|---------------|----------------|
| Wrong manifest service declaration discovered post-publish | LOW | Fix manifest, resubmit — no data migration needed |
| Auto-increment PKs discovered after sync feature starts | HIGH | Write migration that generates UUIDs for all existing rows, updates all FK references, tests referential integrity — plan for a forced app update |
| Chrome compatibility mode dependency discovered after Chrome 131 rollout | MEDIUM | Remove compatibility-mode allowlist, verify standard fill API works with Chrome 131+ — likely no code change needed if standard API is properly implemented |
| Users hit `LockedOut` with no fallback | MEDIUM | Ship hotfix adding PIN fallback path; affected users must use Android Settings to reset biometric attempts in the interim |
| Keystore key lost on reinstall reported by users | LOW (per-user) | Data is unrecoverable — direct users to restore from sync backup (if paid) or re-enter profiles; add clearer onboarding warning in next release |
| Client-side profile limit bypassed at scale | MEDIUM | Add server-side entitlement validation for sync API; implement Play Integrity attestation for paywall; client-side check cannot be fully hardened |

---

## Pitfall-to-Phase Mapping

| Pitfall | Prevention Phase | Verification |
|---------|------------------|--------------|
| Missing/wrong manifest service declaration | Phase 1: Autofill service scaffold | Service visible in Android Settings autofill selector on physical device |
| AutofillService vs. AccessibilityService confusion | Phase 1: Autofill service scaffold | No AccessibilityService references in codebase |
| Chrome compatibility mode dependency | Phase 1: Autofill service scaffold | Integration test against Chrome 131+ without compatibility mode entries |
| Field detection heuristics too brittle | Phase 2: Field detection engine | Pass-rate test against 10 real-world form fixtures ≥ 70% |
| onSaveRequest never called | Phase 2: Fill/save lifecycle | Integration test confirms save callback fires after third-party form submission |
| Encryption key lost on reinstall | Phase 1: Encrypted storage | Test: uninstall + reinstall shows "data cleared" state, not crash |
| Biometric lockout with no fallback | Phase 1: Biometric auth | Test: trigger 5 failed attempts, verify PIN fallback path appears |
| FillResponse dataset limit crash | Phase 2: Dataset construction | Load test: construct 21+ datasets, verify no TransactionTooLargeException |
| Inline suggestions missing on Android 11+ | Phase 2-3: Presentation polish | Test: inline chip appears in Gboard on Android 11+ physical device |
| IAP entitlement client-side only | Phase 3-4: Freemium + IAP | Server validates receipt before granting sync access; Play Integrity attests binary for paywall |
| Non-UUID primary keys | Phase 1: Data model | Schema DDL review: zero AUTOINCREMENT, all PKs are TEXT UUID |
| flutter_secure_storage key wiped on reinstall | Phase 1: Encrypted storage | Reinstall scenario documented in onboarding; test confirms clean state |

---

## Sources

- [Build autofill services — Android Developers](https://developer.android.com/identity/autofill/autofill-services) (official, current)
- [AutofillService API reference — Android Developers](https://developer.android.com/reference/android/service/autofill/AutofillService) (official)
- [Optimize your app for autofill — Android Developers](https://developer.android.com/identity/autofill/autofill-optimize) (official)
- [Chrome on Android to support third-party autofill services natively — Android Developers Blog, October 2024](https://android-developers.googleblog.com/2024/10/chrome-3p-autofill-services.html)
- [Timeline update: third-party autofill services support on Chrome on Android — Android Developers Blog, February 2025](https://android-developers.googleblog.com/2025/02/chrome-3p-autofill-services-update.html)
- [Integrate autofill with IMEs — Android Developers](https://developer.android.com/identity/autofill/ime-autofill)
- [flutter_secure_storage — pub.dev](https://pub.dev/packages/flutter_secure_storage)
- [local_auth — pub.dev](https://pub.dev/packages/local_auth)
- [local_auth issue #112519: Non-biometrics auth on Android 10 and below — flutter/flutter GitHub](https://github.com/flutter/flutter/issues/112519)
- [local_auth issue #108945: Requires biometric instead of PIN on some devices — flutter/flutter GitHub](https://github.com/flutter/flutter/issues/108945)
- [autofill_service plugin — authpass/autofill_service GitHub](https://github.com/authpass/autofill_service)
- [flutter_autofill_service plugin — kee-org/flutter_autofill_service GitHub](https://github.com/kee-org/flutter_autofill_service)
- [Android platform view autofill doesn't work — flutter/flutter issue #154495](https://github.com/flutter/flutter/issues/154495)
- [Use of AccessibilityService API — Google Play Console Help](https://support.google.com/googleplay/android-developer/answer/10964491)
- [Bypassing Freemium with client-side security controls — OnSecurity](https://www.onsecurity.io/blog/pentest-findings-bypassing-freemium-through-client-side-security-controls/)
- [In-App Purchases Without Backend Validation in Flutter — Medium](https://medium.com/@s0larm00n/in-app-purchases-without-backend-validation-in-flutter-aa9d976c7797)
- [sqflite_sqlcipher — pub.dev](https://pub.dev/packages/sqflite_sqlcipher)
- [Offline-First Architecture in Flutter: SQLite and Conflict Resolution — DEV Community](https://dev.to/anurag_dev/implementing-offline-first-architecture-in-flutter-part-1-local-storage-with-conflict-resolution-4mdl)
- [onSaveRequest never called — android-AutofillFramework issue #2 — googlearchive GitHub](https://github.com/googlearchive/android-AutofillFramework/issues/2)

---
*Pitfalls research for: Flutter Android AutofillService + encrypted local storage + freemium IAP + sync-ready data model*
*Researched: 2026-03-06*

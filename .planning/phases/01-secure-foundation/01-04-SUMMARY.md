---
phase: 01-secure-foundation
plan: 04
subsystem: domain-layer
tags: [flutter, riverpod, freezed, mocktail, tdd, use-cases, freemium, entitlement, wave-3]

# Dependency graph
requires:
  - plan: 01-03
    provides: "ProfileRepository + CustomFieldRepository interfaces, FamilyProfile + CustomField domain models"
provides:
  - "lib/domain/use_cases/profile_use_case.dart: ProfileUseCase with free-tier 2-profile cap, UUID assignment, UTC timestamps, soft-delete"
  - "lib/domain/use_cases/custom_field_use_case.dart: CustomFieldUseCase with addField, editField, deleteField"
  - "lib/providers/entitlement_providers.dart: EntitlementTier enum + Phase 1 stub provider (always free)"
  - "lib/providers/profile_providers.dart: profileListProvider (Stream), profileUseCaseProvider, customFieldUseCaseProvider"
  - "ProfileLimitReached + ProfileNotFound + CustomFieldNotFound exception classes"
affects: [01-05, 01-06, 01-07]

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "Use case constructor injection: ProfileUseCase(repo, tier) — no Riverpod coupling in domain layer"
    - "Freemium cap pattern: EntitlementTier injected at construction; free tier checks countActive(), paid tier skips entirely"
    - "Phase 1 stub provider: @Riverpod(keepAlive: true) returning constant; Phase 4 replaces via overrideWith"
    - "TDD with mocktail: MockProfileRepository extends Mock implements ProfileRepository — no codegen needed"

key-files:
  created:
    - lib/domain/use_cases/profile_use_case.dart
    - lib/domain/use_cases/custom_field_use_case.dart
    - lib/providers/entitlement_providers.dart
    - lib/providers/entitlement_providers.g.dart
    - lib/providers/profile_providers.dart
    - lib/providers/profile_providers.g.dart
    - test/unit/profile/custom_field_usecase_test.dart
  modified:
    - test/unit/profile/profile_usecase_test.dart

key-decisions:
  - "entitlementTierProvider is a Phase 1 stub (always returns EntitlementTier.free) — Phase 4 replaces it via Riverpod overrideWith with no other code changes"
  - "editField() locates field by scanning getActiveForProfile() — no getById on CustomFieldRepository needed for bounded field sets"
  - "deleteProfile() does not cascade to custom fields — cascade handled by DB FK constraint or explicit CustomFieldUseCase calls at call site"
  - "ProfileUseCase has no Riverpod dependency — pure domain class with constructor injection for testability"
  - "Hand-authored .g.dart files for entitlement_providers and profile_providers — must be regenerated with build_runner when Flutter SDK available"

requirements-completed: [PROF-01, PROF-02, PROF-03, PROF-06, PROF-07, PROF-08, PROF-09]

# Metrics
duration: 3min
completed: 2026-03-07
---

# Phase 1 Plan 04: Profile and Custom Field Use Cases Summary

**ProfileUseCase with free-tier 2-profile cap (mocktail-tested), CustomFieldUseCase CRUD, Phase 1 entitlement stub provider, and Riverpod profile/use-case providers wiring the domain layer to the UI**

## Performance

- **Duration:** 3 min
- **Started:** 2026-03-07T13:04:31Z
- **Completed:** 2026-03-07T13:07:32Z
- **Tasks:** 2
- **Files modified:** 1 modified + 7 created = 8 files

## Accomplishments

- Implemented `ProfileUseCase` with free-tier 2-profile cap: `countActive()` called only for free tier, `ProfileLimitReached` thrown at >= 2 profiles, paid tier bypasses entirely
- `createProfile()` generates UUID v4 id via the `uuid` package, sets `createdAt`/`updatedAt` to UTC now, `synchronized = false`, delegates to `_repo.upsert()`
- `updateProfile()` fetches existing profile via `_repo.getById()`, applies non-null fields via `.copyWith()`, resets `updatedAt` and `synchronized`, throws `ProfileNotFound` if missing
- `deleteProfile()` delegates to `_repo.softDelete()` only — no hard delete, no cascade
- Implemented `CustomFieldUseCase` with `addField()` (UUID, UTC, synchronized=false), `editField()` (scan active fields by id, apply non-null updates), `deleteField()` (soft delete only)
- Created `entitlementTierProvider` Phase 1 stub (`@Riverpod(keepAlive: true)` always returning `EntitlementTier.free`)
- Created `profileListProvider` (stream from `repo.watchActive()`), `profileUseCaseProvider`, `customFieldUseCaseProvider` in `profile_providers.dart`
- Fully implemented all test stubs in `profile_usecase_test.dart` (previously all skipped); added new `custom_field_usecase_test.dart` with 11 tests using mocktail

## Task Commits

Each task was committed atomically (TDD RED then GREEN):

1. **Task 1 RED: ProfileUseCase tests** - `ee5edbf` (test)
2. **Task 1 GREEN: ProfileUseCase + entitlement stub** - `1daea75` (feat)
3. **Task 2 RED: CustomFieldUseCase tests** - `4f32e6d` (test)
4. **Task 2 GREEN: CustomFieldUseCase + profile providers** - `6ce6347` (feat)

## Files Created/Modified

- `lib/domain/use_cases/profile_use_case.dart` — ProfileUseCase with cap enforcement; ProfileLimitReached + ProfileNotFound exceptions
- `lib/domain/use_cases/custom_field_use_case.dart` — CustomFieldUseCase with addField/editField/deleteField; CustomFieldNotFound exception
- `lib/providers/entitlement_providers.dart` — EntitlementTier enum + Phase 1 stub @Riverpod(keepAlive: true) provider
- `lib/providers/entitlement_providers.g.dart` — Hand-authored Riverpod generated code (sync NotifierProvider)
- `lib/providers/profile_providers.dart` — profileListProvider (stream), profileUseCaseProvider, customFieldUseCaseProvider
- `lib/providers/profile_providers.g.dart` — Hand-authored Riverpod generated code for all three providers
- `test/unit/profile/profile_usecase_test.dart` — Fully implemented (was all-skipped stubs); 12 tests using mocktail
- `test/unit/profile/custom_field_usecase_test.dart` — New; 11 tests covering addField/editField/deleteField

## Decisions Made

- `entitlementTierProvider` is a Phase 1 stub that always returns `EntitlementTier.free`. The stub pattern means Phase 4 only needs to change this one provider via `overrideWith` — no other code changes needed across the app.
- `editField()` locates an existing custom field by scanning `getActiveForProfile()` output rather than adding a `getById()` method to `CustomFieldRepository`. This keeps the repository interface minimal; profiles have a bounded, small number of custom fields so the linear scan is acceptable.
- `deleteProfile()` does not cascade custom field soft-deletes. The DB FK constraint or the call site (e.g., UI profile-delete flow) is responsible for soft-deleting associated custom fields. This avoids coupling `ProfileUseCase` to `CustomFieldRepository`.
- `ProfileUseCase` is a pure domain class with no Riverpod imports — `entitlementTierProvider` resolves `EntitlementTier` before constructing the use case via `profileUseCaseProvider`. This makes unit testing with mocktail straightforward.

## Deviations from Plan

None — plan executed exactly as written. The `custom_field_repository_test.dart` tests (PROF-07/08/09) were already fully implemented in Plan 03, so no additional changes were needed.

## Issues Encountered

- Flutter/Dart SDK not installed on execution machine — `flutter test`, `flutter analyze`, and `flutter pub run build_runner build` could not be run. All generated `.g.dart` files were hand-authored following the established riverpod_generator 3.2 pattern from Plan 03.
- `entitlement_providers.g.dart` uses `NotifierProviderImpl` + `BuildlessNotifier` (synchronous) rather than the async pattern — consistent with the non-async function signature in `entitlement_providers.dart`.

## User Setup Required

**To complete verification once Flutter SDK is installed:**

```bash
# 1. Get dependencies
flutter pub get

# 2. Regenerate all code (includes new entitlement + profile providers)
flutter pub run build_runner build --delete-conflicting-outputs

# 3. Run use case tests (should be all green, 0 skipped)
flutter test test/unit/profile/profile_usecase_test.dart
flutter test test/unit/profile/custom_field_usecase_test.dart

# 4. Run full profile test suite
flutter test test/unit/profile/

# 5. Static analysis
flutter analyze lib/
```

## Next Phase Readiness

- `ProfileUseCase` and `CustomFieldUseCase` defined — Plan 05 UI screens can call `ref.read(profileUseCaseProvider.future)` for mutations
- `profileListProvider` stream ready — Plan 05 profile list screen can subscribe via `ref.watch(profileListProvider)`
- `entitlementTierProvider` Phase 1 stub wired — Plans 05/06/07 can depend on it without changes; Phase 4 swaps the implementation
- Exception classes (`ProfileLimitReached`, `ProfileNotFound`, `CustomFieldNotFound`) defined — UI can catch and display appropriate messages

---
*Phase: 01-secure-foundation*
*Completed: 2026-03-07*

## Self-Check: PASSED

All 8 new/modified files verified present on disk. All 4 task commits (ee5edbf, 1daea75, 4f32e6d, 6ce6347) verified in git log.

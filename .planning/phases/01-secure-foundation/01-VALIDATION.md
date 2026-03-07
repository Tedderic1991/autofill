---
phase: 1
slug: secure-foundation
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-06
---

# Phase 1 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | flutter_test (unit + widget) + integration_test (on-device) |
| **Config file** | pubspec.yaml (dev_dependencies) — Wave 0 installs |
| **Quick run command** | `flutter test test/unit/ test/widget/` |
| **Full suite command** | `flutter test` |
| **Estimated runtime** | ~30 seconds (unit + widget); integration tests require device |

---

## Sampling Rate

- **After every task commit:** Run `flutter test test/unit/ test/widget/`
- **After every plan wave:** Run `flutter test`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 30 seconds

---

## Per-Task Verification Map

| Task ID | Requirement | Test Type | Automated Command | File | Status |
|---------|-------------|-----------|-------------------|------|--------|
| DB encryption init | SEC-04 | unit | `flutter test test/unit/database/encryption_test.dart` | ❌ W0 | ⬜ pending |
| Schema migration | SEC-04, PROF-01 | unit | `flutter test test/unit/database/schema_test.dart` | ❌ W0 | ⬜ pending |
| Profile create | PROF-01 | unit | `flutter test test/unit/profile/profile_repository_test.dart` | ❌ W0 | ⬜ pending |
| Profile edit | PROF-02 | unit | `flutter test test/unit/profile/profile_repository_test.dart` | ❌ W0 | ⬜ pending |
| Profile soft-delete | PROF-03 | unit | `flutter test test/unit/profile/profile_repository_test.dart` | ❌ W0 | ⬜ pending |
| Avatar photo pick | PROF-04 | widget | `flutter test test/widget/profile/profile_form_test.dart` | ❌ W0 | ⬜ pending |
| Relationship tag | PROF-05 | unit | `flutter test test/unit/profile/profile_repository_test.dart` | ❌ W0 | ⬜ pending |
| Free tier cap | PROF-06 | unit | `flutter test test/unit/profile/profile_usecase_test.dart` | ❌ W0 | ⬜ pending |
| Custom field create | PROF-07 | unit | `flutter test test/unit/profile/custom_field_repository_test.dart` | ❌ W0 | ⬜ pending |
| Custom field edit/delete | PROF-08 | unit | `flutter test test/unit/profile/custom_field_repository_test.dart` | ❌ W0 | ⬜ pending |
| Custom fields in DB | PROF-09 | unit | `flutter test test/unit/profile/custom_field_repository_test.dart` | ❌ W0 | ⬜ pending |
| Biometric gate | SEC-01 (Phase 2) | manual | N/A — requires physical device | N/A | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `test/helpers/in_memory_database.dart` — shared Drift in-memory DB fixture for all unit tests
- [ ] `test/unit/database/encryption_test.dart` — stubs for SEC-04 (key generation, DB open with key, missing key recovery)
- [ ] `test/unit/database/schema_test.dart` — stubs for schema shape (UUID PKs, sync fields, soft delete columns present)
- [ ] `test/unit/profile/profile_repository_test.dart` — stubs for PROF-01/02/03/05 (CRUD operations)
- [ ] `test/unit/profile/profile_usecase_test.dart` — stubs for PROF-06 (2-profile cap logic)
- [ ] `test/unit/profile/custom_field_repository_test.dart` — stubs for PROF-07/08/09 (custom field CRUD)
- [ ] `test/widget/profile/profile_form_test.dart` — stubs for PROF-04 (avatar picker widget interaction)

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Biometric unlock at app open | SEC-01 | local_auth.authenticate() cannot be mocked at platform level in unit tests | Open app on physical Android device; verify biometric prompt appears; authenticate; verify profile list is accessible |
| PIN fallback when biometric locked out | SEC-03 | Requires device biometric lockout state | Trigger biometric lockout (5 failed attempts); verify PIN fallback screen appears; enter correct PIN; verify access |
| Raw DB file unreadable without key | SEC-04 | Requires adb shell access to verify | Use `adb shell` to pull DB file; attempt to open with sqlite3 CLI without key; verify gibberish output |
| Data loss on reinstall | SEC-04 | Requires actual uninstall/reinstall cycle | Create profiles; uninstall app; reinstall; verify data is gone and app starts fresh |
| Upgrade prompt on 3rd profile | PROF-06 | Requires UI interaction flow | Create 2 profiles; tap "Add profile"; verify upgrade prompt appears instead of profile form |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 30s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending

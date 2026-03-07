# Roadmap: Family Autofill App

## Overview

Four phases, each delivering a complete capability that the next phase depends on. Phase 1 establishes the encrypted data foundation and profile management — nothing can be built safely without it. Phase 2 integrates the Android AutofillService so the OS can prompt profile selection in any form. Phase 3 adds the heuristics intelligence that makes the fill accurate and correctable. Phase 4 wires in the freemium paywall so the product can monetize from launch.

## Phases

**Phase Numbering:**
- Integer phases (1, 2, 3): Planned milestone work
- Decimal phases (2.1, 2.2): Urgent insertions (marked with INSERTED)

Decimal phases appear between their surrounding integers in numeric order.

- [ ] **Phase 1: Secure Foundation** - Encrypted database, profile CRUD with custom fields, freemium cap, biometric auth at app launch
- [ ] **Phase 2: Android Autofill Integration** - AutofillService registration, biometric-gated fill flow, OS profile picker, onboarding walkthrough
- [ ] **Phase 3: Field Detection Engine** - Heuristics pipeline, confidence indicators, manual correction with per-site persistence
- [ ] **Phase 4: Freemium and IAP** - RevenueCat integration, paywall screen, purchase restoration, entitlement enforcement
- [ ] **Phase 5: Telemetry** - Anonymous analytics SDK, field usage tracking, autofill event tracking, conversion funnel, opt-out toggle

## Phase Details

### Phase 1: Secure Foundation
**Goal**: Family profiles are stored securely on-device and fully manageable, with biometric protection at app open and a freemium cap that gates upgrade
**Depends on**: Nothing (first phase)
**Requirements**: SEC-04, PROF-01, PROF-02, PROF-03, PROF-04, PROF-05, PROF-06, PROF-07, PROF-08, PROF-09
**Success Criteria** (what must be TRUE):
  1. User can create, edit, and delete family member profiles with all built-in fields (name, DOB, address, phone, allergies, emergency contacts) and a photo/avatar
  2. User can add, edit, and delete custom fields on any profile, and those fields are stored alongside built-in fields
  3. App requires biometric authentication (or PIN fallback) to open — profile data is never visible without it
  4. Profile data is encrypted at rest using SQLCipher with a key in Android Keystore — the raw database file is unreadable without the key
  5. Attempting to create a third profile on the free tier shows an upgrade prompt instead of creating the profile
**Plans**: 7 plans

Plans:
- [ ] 01-01-PLAN.md — Wave 0 test scaffolds for all requirements
- [ ] 01-02-PLAN.md — Project bootstrap: pubspec, manifest, KeyManager, Drift tables, code gen
- [ ] 01-03-PLAN.md — Domain models (freezed), DAOs, repository interfaces + implementations, DB provider
- [ ] 01-04-PLAN.md — ProfileUseCase (CRUD + freemium cap), CustomFieldUseCase, Riverpod providers
- [ ] 01-05-PLAN.md — Profile CRUD UI: list screen, edit form, avatar picker, custom field editor, paywall stub
- [ ] 01-06-PLAN.md — App entry point, go_router with auth guard, biometric auth gate screen
- [ ] 01-07-PLAN.md — Full automated test suite + human verification checkpoint

### Phase 2: Android Autofill Integration
**Goal**: The app appears as an Android autofill service, presents family member profiles in the OS autofill tray, and fills an entire form after biometric confirmation
**Depends on**: Phase 1
**Requirements**: SEC-01, SEC-02, SEC-03, SEC-05, AUTO-01, AUTO-02, AUTO-03, AUTO-04
**Success Criteria** (what must be TRUE):
  1. The app appears in Android Settings > Autofill service and can be selected as the active autofill provider
  2. Focusing a form field in any Android app or browser shows a list of family member profile names in the OS autofill tray
  3. Tapping a profile in the tray triggers biometric auth — profile data is only injected into form fields after the user successfully authenticates
  4. Onboarding walks the user through enabling the app as their autofill service, with a direct deep-link to the Android Settings screen and a confirmation step once activation is detected
  5. User can set a PIN fallback so they are never permanently locked out when biometric authentication fails
**Plans**: TBD

### Phase 3: Field Detection Engine
**Goal**: The autofill fill response accurately maps profile fields to form fields using heuristics, shows the user which matches are confident vs. guessed, and persists any manual corrections the user makes
**Depends on**: Phase 2
**Requirements**: FDET-01, FDET-02, FDET-03, FDET-04
**Success Criteria** (what must be TRUE):
  1. When a fill occurs, the app automatically maps profile fields (including custom fields) to form fields using layered heuristics — autofillHints, hint text, resource IDs, and label text are all checked in order
  2. The fill response distinguishes confidently matched fields from guessed fields so the user can see where accuracy is uncertain
  3. After a fill, the user can open a correction view, reassign any wrong field mapping, and save the correction
  4. On a subsequent fill of the same app or site, the saved manual correction is applied automatically without prompting the user again
**Plans**: TBD

### Phase 4: Freemium and IAP
**Goal**: Users can upgrade to the paid tier via in-app purchase, the paywall communicates the value of upgrading, and the entitlement state is preserved across reinstalls
**Depends on**: Phase 3
**Requirements**: IAP-01, IAP-02, IAP-03, IAP-04
**Success Criteria** (what must be TRUE):
  1. User can complete an in-app purchase through RevenueCat and the paid entitlement is immediately reflected in the app without a restart
  2. After purchasing, the 2-profile creation cap is removed and the user can create as many profiles as they want
  3. The paywall screen clearly lists what the paid tier unlocks before asking for payment
  4. After reinstalling the app or switching to a new device, the user can restore their previous purchase and regain the paid entitlement
**Plans**: TBD

### Phase 5: Telemetry
**Goal**: Anonymous usage analytics give you signal on which fields matter most, how often autofill succeeds, and where users drop off in the conversion funnel — with no personal data ever leaving the device
**Depends on**: Phase 4
**Requirements**: TELE-01, TELE-02, TELE-03, TELE-04, TELE-05, TELE-06, TELE-07
**Success Criteria** (what must be TRUE):
  1. Analytics SDK is integrated and events are visible in the analytics dashboard with no profile field values or personally identifiable data present in any event payload
  2. Dashboard shows which field types (built-in and custom) appear most frequently in fill responses
  3. Dashboard shows autofill session completion rate (fill triggered → fill completed vs. abandoned)
  4. Dashboard shows full conversion funnel: profile cap hit → paywall shown → purchase completed
  5. Dashboard shows manual correction rate per session, giving a signal on heuristic accuracy
  6. Onboarding screen discloses analytics collection; app settings contains a toggle to disable it
**Plans**: TBD

## Progress

**Execution Order:**
Phases execute in numeric order: 1 → 2 → 3 → 4 → 5

| Phase | Plans Complete | Status | Completed |
|-------|----------------|--------|-----------|
| 1. Secure Foundation | 6/7 | In Progress|  |
| 2. Android Autofill Integration | 0/TBD | Not started | - |
| 3. Field Detection Engine | 0/TBD | Not started | - |
| 4. Freemium and IAP | 0/TBD | Not started | - |
| 5. Telemetry | 0/TBD | Not started | - |

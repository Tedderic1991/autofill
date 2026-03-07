# Requirements: Family Autofill App

**Defined:** 2026-03-06
**Core Value:** Parents can fill any family form in seconds — one tap selects a child's profile and the whole form is done.

## v1 Requirements

### Profiles

- [x] **PROF-01**: User can create a family member profile with built-in fields: name, date of birth, address, phone number, allergies, and emergency contacts
- [x] **PROF-02**: User can edit any field on an existing profile
- [x] **PROF-03**: User can delete a profile (with confirmation)
- [x] **PROF-04**: User can add a photo or avatar to a profile
- [x] **PROF-05**: User can assign a relationship tag to each profile (Parent, Child, Guardian)
- [x] **PROF-06**: Free tier allows a maximum of 2 profiles; attempting to create a third prompts the upgrade paywall
- [x] **PROF-07**: User can add custom fields to any profile with a user-defined label and a type (text, number, or date)
- [x] **PROF-08**: User can edit and delete custom fields on a profile
- [x] **PROF-09**: Custom fields are per-profile and included in autofill fill responses alongside built-in fields

### Security

- [ ] **SEC-01**: App requires biometric authentication (fingerprint or face) to open
- [ ] **SEC-02**: Autofill fill request is gated behind biometric auth via native AuthActivity before any profile data is returned to the OS
- [ ] **SEC-03**: User can set a PIN as a fallback when biometric authentication fails or is unavailable
- [x] **SEC-04**: All profile data is encrypted at rest using SQLCipher with a key stored in Android Keystore
- [ ] **SEC-05**: Onboarding displays a clear warning that uninstalling the app permanently destroys profile data (Keystore key is app-scoped)

### Autofill Integration

- [ ] **AUTO-01**: App registers as an Android AutofillService and appears in Android Settings > Autofill service
- [ ] **AUTO-02**: When a user focuses a form field in any app or browser, the OS autofill prompt shows a list of family member profile names
- [ ] **AUTO-03**: Tapping a profile name in the OS prompt triggers biometric auth and then fills all detected form fields with the selected profile's data in a single action
- [ ] **AUTO-04**: Onboarding includes a step-by-step walkthrough guiding the user to enable the app as their autofill service in Android Settings

### Field Detection

- [ ] **FDET-01**: App uses heuristic rules (autofillHints, hint text, resource IDs, label text) to automatically map form fields to profile data fields, including user-defined custom fields
- [ ] **FDET-02**: Fill response shows a confidence indicator for each field (confidently matched vs. guessed)
- [ ] **FDET-03**: User can manually correct a wrong field mapping after a fill
- [ ] **FDET-04**: Manual corrections are saved per app/site and applied automatically on future fills

### Freemium & IAP

- [ ] **IAP-01**: User can upgrade to the paid tier via an in-app purchase using RevenueCat
- [ ] **IAP-02**: Paid tier removes the 2-profile cap (unlimited profiles)
- [ ] **IAP-03**: Paywall screen clearly communicates what is unlocked by upgrading
- [ ] **IAP-04**: User can restore a previous purchase on reinstall or new device

### Telemetry

- [ ] **TELE-01**: App integrates an analytics SDK (PostHog or Firebase Analytics) that sends no personal or profile data — only anonymous behavioral events
- [ ] **TELE-02**: App tracks which profile field types (built-in and custom field labels) are most frequently included in autofill fill responses
- [ ] **TELE-03**: App tracks autofill session events: fill triggered, fill completed, fill abandoned
- [ ] **TELE-04**: App tracks conversion funnel events: profile cap reached, paywall shown, purchase initiated, purchase completed
- [ ] **TELE-05**: App tracks manual field correction events to signal heuristic accuracy over time
- [ ] **TELE-06**: Onboarding discloses that anonymous usage analytics are collected and enabled by default
- [ ] **TELE-07**: User can disable analytics collection in app settings (opt-out)

## v2 Requirements

### Security

- **SEC-V2-01**: App auto-locks when sent to background, requiring re-authentication on return

### Profiles

- **PROF-V2-01**: User can import profile data from a vCard or CSV file

### Premium Features (paid tier expansions)

- **PREM-01**: LLM-powered field matching for forms where heuristics fail — cloud API call, paid tier only
- **PREM-02**: Encrypted cloud backup of profile data (user-controlled, opt-in)
- **PREM-03**: Profile sync across multiple devices via cloud backend
- **PREM-04**: Form history — view previously filled forms and reuse them

## Out of Scope

| Feature | Reason |
|---------|--------|
| iOS autofill integration | Android first; iOS requires a native Swift App Extension — separate milestone |
| Browser extension / PC autofill | Explored during planning, deferred to future milestone |
| On-device LLM matching (Gemini Nano) | Device availability too fragmented in v1; cloud LLM is v2 paid tier |
| Real-time sync | Requires backend infrastructure; deferred to premium v2 |
| Social / sharing features | Out of product scope; data is private family data |
| Web app | Explored during planning, deferred |

## Traceability

Which phases cover which requirements. Updated during roadmap creation.

| Requirement | Phase | Status |
|-------------|-------|--------|
| SEC-04 | Phase 1 | Complete |
| PROF-01 | Phase 1 | Complete |
| PROF-02 | Phase 1 | Complete |
| PROF-03 | Phase 1 | Complete |
| PROF-04 | Phase 1 | Complete |
| PROF-05 | Phase 1 | Complete |
| PROF-06 | Phase 1 | Complete |
| PROF-07 | Phase 1 | Complete |
| PROF-08 | Phase 1 | Complete |
| PROF-09 | Phase 1 | Complete |
| SEC-01 | Phase 2 | Pending |
| SEC-02 | Phase 2 | Pending |
| SEC-03 | Phase 2 | Pending |
| SEC-05 | Phase 2 | Pending |
| AUTO-01 | Phase 2 | Pending |
| AUTO-02 | Phase 2 | Pending |
| AUTO-03 | Phase 2 | Pending |
| AUTO-04 | Phase 2 | Pending |
| FDET-01 | Phase 3 | Pending |
| FDET-02 | Phase 3 | Pending |
| FDET-03 | Phase 3 | Pending |
| FDET-04 | Phase 3 | Pending |
| IAP-01 | Phase 4 | Pending |
| IAP-02 | Phase 4 | Pending |
| IAP-03 | Phase 4 | Pending |
| IAP-04 | Phase 4 | Pending |
| TELE-01 | Phase 5 | Pending |
| TELE-02 | Phase 5 | Pending |
| TELE-03 | Phase 5 | Pending |
| TELE-04 | Phase 5 | Pending |
| TELE-05 | Phase 5 | Pending |
| TELE-06 | Phase 5 | Pending |
| TELE-07 | Phase 5 | Pending |

**Coverage:**
- v1 requirements: 33 total
- Mapped to phases: 33
- Unmapped: 0 ✓

---
*Requirements defined: 2026-03-06*
*Last updated: 2026-03-06 after adding telemetry requirements — all 33 v1 requirements mapped*

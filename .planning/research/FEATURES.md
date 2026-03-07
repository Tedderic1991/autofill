# Feature Research

**Domain:** Family profile autofill / digital wallet for parents
**Researched:** 2026-03-06
**Confidence:** MEDIUM-HIGH (competitor analysis from live sources; UX patterns from official docs and reviews)

---

## Feature Landscape

### Table Stakes (Users Expect These)

Features users assume exist. Missing these = product feels incomplete.

| Feature | Why Expected | Complexity | Notes |
|---------|--------------|------------|-------|
| Create / edit family member profiles | Core value: store data once, reuse everywhere. Without this, nothing else works. | LOW | Fields: first/last name, DOB, gender, address, phone, email. Must support 2+ members from day one. |
| Biometric unlock (fingerprint / face) | Every serious credential or personal-data app uses biometric auth. Absence signals security negligence to users. | LOW | Flutter `local_auth` package; always offer PIN fallback — some users have injuries/prosthetics that prevent biometric use. |
| Encryption at rest | Users storing children's health data and addresses will not tolerate plaintext storage. Competing apps (1Password, Bitwarden) all encrypt at rest. | MEDIUM | AES-256 on SQLite or Hive/Isar; key derived from biometric-protected master secret. |
| Android Autofill Service integration | The entire product value is delivered through the autofill trigger. Without OS-level integration, the app is just a contacts app. | HIGH | Must register as an `AutofillService`, handle `onFillRequest()` / `onSaveRequest()`. Requires system permission grant — onboarding must walk user through Settings. |
| Profile selection picker in autofill UI | When a form field is focused, users expect to see a list of family members and choose one. This is the "one tap" moment. | MEDIUM | Android `Dataset` objects with `RemoteViews` presentation; each profile = one Dataset. Label should show name + avatar/icon to differentiate at a glance. |
| Automatic full-form fill on profile selection | Selecting a family member should fill all recognizable fields — not just the focused field. | HIGH | Map AssistStructure fields to profile attributes heuristically. Google's own autofill spec recommends filling the entire partition, not just one field. |
| Field heuristics for common form types | Camp, school, and medical forms are not password forms — they have `first_name`, `last_name`, `dob`, `allergy`, `emergency_contact` labels. Heuristics must go beyond username/password. | HIGH | Parse `ViewNode` hint attributes, `htmlInfo`, and visible labels. Build a mapping dictionary for common field name patterns (e.g. "child name", "student name", "camper name" all map to `child.firstName + child.lastName`). |
| Required child profile fields | Parents filling camp/school/medical forms are repeatedly asked for: name, DOB, gender, address, parent/guardian name, parent phone, emergency contact name + phone, allergies, medications, insurance info, school name. Missing any of these means the form still needs manual entry. | LOW | Validate against Jotform/CircleTree camp registration templates — all require these fields. |
| Manual field correction and save | Heuristics will misfire on unusual or poorly-labeled forms. Users need to correct mappings manually and have those corrections persist for that site/app. | MEDIUM | Store per-package (Android) or per-domain overrides. Corrections feed back into local heuristic improvement. |
| Onboarding walkthrough — autofill service setup | Enabling a third-party autofill service requires users to navigate to Android Settings > Languages & input > Autofill service. Without explicit in-app guidance, adoption rate craters. | LOW | Step-by-step deep-link to settings. Show visual cues; verify activation and celebrate on return. |
| Freemium profile cap enforcement | Free tier = 2 profiles. Reaching the cap must be graceful, explain the upgrade path clearly, and not corrupt existing data. | LOW | Cap check on profile creation; show upgrade CTA with clear value proposition ("Add more family members"). |
| Data stays on device (privacy promise) | Parents are storing children's health and location data. The local-first privacy guarantee is table stakes for this trust relationship — not a differentiator, an expectation. | LOW | No network calls in free tier. Privacy policy must be explicit. |

---

### Differentiators (Competitive Advantage)

Features that set the product apart. Not required, but valued. Focus: things competing apps do badly or ignore entirely for the family use case.

| Feature | Value Proposition | Complexity | Notes |
|---------|-------------------|------------|-------|
| Child-specific data fields (allergies, medications, emergency contacts, insurance, school name) | 1Password's Identity item has name/address/phone/email — it does not have allergies, emergency contacts, or insurance. RoboForm's Identity has "AOL Name" and "Pager". Neither is built for camp/school/medical forms. Purpose-built fields eliminate the manual-entry residue. | MEDIUM | First-class fields: `allergies[]`, `medications[]`, `emergencyContacts[]` (name + phone + relationship), `insurancePolicyNumber`, `physicianName`, `schoolName`, `grade`. Treat these as typed lists, not free text. |
| "Fill entire form" vs. "fill one field" interaction model | Password managers fill credentials (2 fields). This app fills entire registration forms (15-20 fields). The UX contract is different — users expect completeness, not just the focused field. | HIGH | After profile selection from autofill picker, traverse all fields in the current AssistStructure partition and fill all recognized ones simultaneously. Unrecognized fields stay empty (don't corrupt them). |
| Per-site / per-app field mapping corrections with learning | RoboForm occasionally fills wrong fields; 1Password is password-centric and doesn't persist form layout corrections. A correction UI that saves per-package overrides gives the app a compounding accuracy advantage over time. | MEDIUM | Expose a "correct this fill" flow post-autofill. Store corrections as a per-package overlay on top of base heuristics. These corrections are part of user data that should sync in paid tier. |
| LLM-powered field matching (paid tier) | When heuristics fail on unusual or custom-labeled forms, LLM matching can resolve edge cases that rule-based systems can't. Competing apps have no equivalent for non-credential forms. | HIGH | Architecture must allow plugging in LLM matcher without restructuring the fill pipeline. Free tier uses heuristics; paid tier sends field context to LLM API and receives mapping suggestions. On-device LLM (Gemini Nano) is a future option to explore. |
| Family profile switcher in app (beyond autofill) | Parents often need to reference a child's insurance number, allergy list, or emergency contact quickly — outside of form filling context. A clean in-app profile viewer with copy-to-clipboard is a secondary use case that increases daily utility. | LOW | Simple read-only profile detail screen. Copy icons next to every field. Not a form filler — just a reference card. |
| Onboarding profile import from contacts | The most painful part of setup is typing all family data in. If parents can pull first name, last name, phone, and address from their phone's contacts and then supplement with child-specific fields, setup time drops dramatically. | MEDIUM | `contacts` permission request with clear rationale. Map contact fields to profile fields; surface unmatched fields for manual entry. Do not auto-import — always show preview before saving. |
| Cloud backup & sync (paid tier, sync-ready model from day one) | Neither Apple Keychain nor Google Autofill offer multi-device family sync for custom personal data. The privacy-respecting local-first default + optional encrypted cloud backup is a meaningful combination that has no good free equivalent. | HIGH | Data model must carry vector clocks or `updatedAt` timestamps from v1. Conflict resolution strategy needed before implementing sync. E2E encrypted backup — server sees only ciphertext. |
| Form fill history / audit log (paid tier) | Knowing which forms were filled for which family member, when, is useful for health records and tracking (e.g., "did I already fill the allergy form for camp Maple?"). No competing app provides this for non-credential forms. | MEDIUM | Store fill events (timestamp, app package, profile used, fields filled count). Display in a timeline per profile. Exclude sensitive field values from log for privacy. |

---

### Anti-Features (Commonly Requested, Often Problematic)

Features that seem good but create problems.

| Feature | Why Requested | Why Problematic | Alternative |
|---------|---------------|-----------------|-------------|
| Password / credential storage | Users will ask "can I also store my passwords here?" since the app already stores sensitive data. | Credential management is a solved, competitive, and security-audited space (1Password, Bitwarden). Adding it creates security liability, user confusion about the app's identity, and scope bloat. The app's edge is family profile autofill — not credential management. | Explicitly decline. In onboarding, position the app as complementary to their existing password manager, not a replacement. |
| Auto-save forms on submit | Capturing form data automatically after submission sounds convenient. | Silently capturing user input from third-party apps raises serious privacy concerns and potential malware flagging by Google Play. The `onSaveRequest()` API is available but opt-in should be explicit and narrow. | Only offer save prompts for fields the user has explicitly mapped, not blanket form capture. Prompt the user after fill, not after submit. |
| Real-time family sharing / collaborative editing | Multiple family members editing profiles simultaneously sounds useful. | Sync conflicts in real-time systems are complex and expensive. The v1 use case is a single parent managing profiles; collaborative editing is a future paid feature, not v1. | Design data model for sync-readiness from day one; defer the UI and conflict resolution to a later milestone after core value is validated. |
| Unlimited profiles on free tier | Users will request removing the profile cap. | The profile cap IS the monetization mechanism. Removing it eliminates upgrade motivation for the primary paid feature. | Keep the 2-profile free cap. Make the upgrade path clear and friction-low. The natural moment is adding a third family member — a genuine, felt need. |
| Browser extension / desktop autofill | Some parents use camp and school websites on desktop. | Separate codebase, separate security surface, separate distribution (Chrome Web Store). This is explicitly deferred to a future milestone in PROJECT.md. Building it early fractures focus and engineering capacity. | Android first, validate demand, then scope desktop as a separate milestone. |
| Social login / account creation at launch | Users may expect "sign in with Google" to avoid creating yet another account. | Local-first architecture means there is no server account to link. Cloud sync (paid) will need an auth layer — but that's a later milestone. Adding social login in v1 creates a dependency that doesn't serve the core product. | PIN + biometric local auth in v1. When cloud sync ships, add email/OAuth as part of that milestone. |
| Offline-first messaging or notes between family members | Co-parenting apps (OurFamilyWizard, AppClose) include messaging. Users who discover the app for family data may request this. | Messaging is a fundamentally different product with different privacy, moderation, and infrastructure requirements. It would distract from the form-fill core loop entirely. | Clearly scope the app as profile data + autofill. Recommend existing co-parenting apps for communication needs. |

---

## Feature Dependencies

```
[Biometric unlock]
    └──required by──> [Profile viewing]
    └──required by──> [Autofill service activation]

[Encryption at rest]
    └──required by──> [Profile creation/storage]
                          └──required by──> [Autofill fill pipeline]
                                                └──enhances──> [Field heuristics]
                                                └──requires──> [Profile selection picker]

[Android Autofill Service registration]
    └──required by──> [Profile selection picker (autofill UI)]
    └──required by──> [Full-form fill]
    └──required by──> [Manual field correction & save]

[Onboarding walkthrough]
    └──enables──> [Autofill service activation]
    └──enables──> [Profile creation]

[Field heuristics]
    └──enhanced by──> [Manual field correction & save]
    └──enhanced by──> [LLM-powered matching (paid)]

[Sync-ready data model]
    └──required by──> [Cloud backup & sync (paid)]
    └──required by──> [Form fill history (paid)]
    └──required by──> [Manual field corrections persisting across devices]

[Freemium cap enforcement]
    └──requires──> [Profile count check]
    └──requires──> [Upgrade CTA / paywall]
```

### Dependency Notes

- **Biometric unlock required by everything else:** The app must not be usable without unlocking. Biometric is the entry gate — implement before any profile or autofill feature.
- **Encryption required by profile storage:** Write no profile data to disk without AES encryption. This is a constraint that must be designed into the storage layer in Phase 1, not retrofitted.
- **Autofill service registration required by all autofill features:** The OS-level integration is a prerequisite. Onboarding must drive the user to complete this before demonstrating autofill.
- **Sync-ready data model required by all paid tier features:** Cloud sync, fill history, and cross-device corrections all require a data model with timestamps and identifier stability. Design this in the profile schema before any data is written to production devices.
- **Field heuristics enhanced by corrections:** Manual corrections are not independent — they are an improvement layer on top of heuristics. Heuristics must exist before corrections can supplement them.

---

## MVP Definition

### Launch With (v1)

Minimum viable product — validates the core loop: store profile once, fill any form with one tap.

- [ ] Biometric unlock with PIN fallback — security gate; non-negotiable given sensitivity of data stored
- [ ] Create / edit family member profiles with required fields (name, DOB, address, phone, allergies, emergency contacts, insurance) — the data the autofill actually needs
- [ ] Encryption at rest (AES-256, biometric-protected key) — trust requirement; privacy-first positioning
- [ ] Android Autofill Service with onboarding walkthrough — without OS integration, there is no product
- [ ] Profile picker in autofill UI (Dataset presentation with name labels) — the "one tap" moment
- [ ] Full-form fill on profile selection (heuristic-based field mapping) — the core value delivery
- [ ] Manual field correction with per-package persistence — heuristics will fail; fallback is required for user trust
- [ ] Freemium cap at 2 profiles with upgrade CTA — monetization mechanism from day one

### Add After Validation (v1.x)

Add once the core fill loop is proven working and used.

- [ ] Contact import for profile setup — reduces onboarding friction; add when user interviews confirm setup time as a drop-off point
- [ ] In-app profile reference view (copy-to-clipboard) — secondary utility; add when users ask "can I just look up the insurance number quickly?"
- [ ] Form fill history (paid) — add when users have enough fill events for the history to be meaningful; requires paid tier infrastructure

### Future Consideration (v2+)

Defer until product-market fit is established.

- [ ] LLM-powered field matching (paid) — architecture must support it from day one, but the API cost and latency make it premature until the paid user base justifies it
- [ ] Cloud backup & sync (paid) — the most requested premium feature; defer until local-first is fully validated and a sync backend can be designed properly
- [ ] iOS autofill integration — explicitly out of scope for v1; Flutter foundation makes it additive not a rewrite
- [ ] On-device LLM matching (Gemini Nano) — interesting future option for offline premium matching; too experimental for v1

---

## Feature Prioritization Matrix

| Feature | User Value | Implementation Cost | Priority |
|---------|------------|---------------------|----------|
| Biometric unlock | HIGH | LOW | P1 |
| Encryption at rest | HIGH | MEDIUM | P1 |
| Profile creation with child-specific fields | HIGH | LOW | P1 |
| Android Autofill Service registration | HIGH | HIGH | P1 |
| Onboarding walkthrough (settings deep-link) | HIGH | LOW | P1 |
| Profile picker in autofill UI | HIGH | MEDIUM | P1 |
| Full-form fill (heuristic mapping) | HIGH | HIGH | P1 |
| Manual field correction + per-package save | HIGH | MEDIUM | P1 |
| Freemium cap + upgrade CTA | MEDIUM | LOW | P1 |
| Contact import for profile setup | MEDIUM | MEDIUM | P2 |
| In-app profile reference / copy-to-clipboard | MEDIUM | LOW | P2 |
| Form fill history (paid tier) | MEDIUM | MEDIUM | P2 |
| LLM-powered field matching (paid tier) | HIGH | HIGH | P3 |
| Cloud backup & sync (paid tier) | HIGH | HIGH | P3 |
| iOS autofill integration | HIGH | HIGH | P3 |

**Priority key:**
- P1: Must have for launch
- P2: Should have, add when possible
- P3: Nice to have, future consideration

---

## Competitor Feature Analysis

| Feature | 1Password Families | Bitwarden Families | Google Autofill | Apple Keychain | Our Approach |
|---------|-------------------|-------------------|-----------------|----------------|--------------|
| Multi-person profiles | Yes — separate vault per member, shared vaults | Yes — organizations with collections | No — single Google account only | No — single Apple ID only | First-class family profiles, each a full data record |
| Child-specific fields (allergies, emergency contacts, insurance) | No — Identity item has name/address/phone; no medical or emergency fields | No — Identity fields are generic | No | No | Yes — purpose-built for the actual fields camp/school/medical forms ask for |
| Non-credential form autofill | Partial — fills identity/address fields on web; limited on native Android apps | Partial — similar to 1Password | No — credential-focused | No — credential-focused | Yes — primary use case; entire form filled for a selected profile |
| Field heuristics for unusual forms | Low — relies heavily on HTML autocomplete attributes | Low — similar | Low | Low | Core differentiator — heuristics + correction layer + future LLM |
| Manual field correction persistence | No | No | No | No | Yes — per-package overrides saved locally |
| Android autofill service | Yes — primary delivery mechanism | Yes | Built-in | No (iOS only) | Yes — required for the product to function |
| Family sharing model | Vault-based sharing — all-or-nothing vault access | Collection-based sharing | No sharing | No sharing | Profile-level: parent controls all profiles; designed for single-device parent use initially |
| Local-first / offline-first | No — cloud required | Self-host option exists | No | No | Yes — local-first is the default; cloud is paid opt-in |
| Biometric unlock | Yes | Yes | Yes | Yes | Yes — required at launch |
| Free tier | No (14-day trial only) | Yes (single device, no sharing) | Yes (limited) | Yes | Yes — 2 profiles free |
| LLM field matching | No | No | No | No | Planned for paid tier |

---

## Key Gaps in Competitor Landscape (Opportunity Summary)

**What no existing app does well for the parent use case:**

1. **Child-specific data types.** All password managers model an "Identity" as a single person — name, address, phone, email. They do not model a child who has an allergy list, an emergency contact who is not a parent, an insurance policy number, and a pediatrician. The data model gap is the core opportunity.

2. **Full-form fill for registration forms.** The entire category is optimized for username + password fill (2 fields). Camp and school registration forms have 15-25 fields. Competing products degrade to partial fill or no fill.

3. **Per-app mapping corrections.** No competing product lets users correct a wrong mapping and have that correction persist for future fills of the same app or website.

4. **Local-first with privacy guarantee for children's data.** Parents storing a child's medical and location data are a natural fit for a privacy-first, no-cloud-required model. No mainstream competitor offers this.

---

## Sources

- [1Password item categories and families support](https://support.1password.com/item-categories/) — confirmed Identity item fields; no allergy/emergency fields
- [1Password back-to-school family guide](https://blog.1password.com/back-to-school-onboarding-checklist/) — how 1Password positions for family use; vault-based model
- [Bitwarden vs 1Password comparison — CyberNews 2026](https://cybernews.com/best-password-managers/bitwarden-vs-1password/) — family plan feature parity analysis
- [Android Autofill Framework — Android Developers](https://developer.android.com/identity/autofill) — Dataset/FillResponse/AssistStructure architecture; confirmed picker UI behavior
- [Build autofill services — Android Developers](https://developer.android.com/identity/autofill/autofill-services) — onFillRequest / onSaveRequest lifecycle; vault-as-dataset pattern for multiple profiles
- [Chrome 3P autofill services — Android Developers Blog 2025](https://android-developers.googleblog.com/2025/02/chrome-3p-autofill-services-update.html) — Chrome on Android moving to native third-party autofill support (compat mode deprecated summer 2025)
- [Jetpack Compose 1.8 autofill — Medium 2025](https://medium.com/@mustafayanik/whats-new-in-jetpack-compose-autofill-visibility-tracking-smarter-text-822909c02477) — Modifier.autofill() annotation support in Compose
- [Jotform camp registration form templates](https://www.jotform.com/form-templates/camp-registration-form) — ground truth for which fields camp forms actually contain
- [CircleTree summer camp registration tips](https://blog.circuitree.com/summer-camp-registration-forms) — parent and emergency contact field requirements confirmed
- [RoboForm review — PasswordManager.com 2025](https://www.passwordmanager.com/roboform-review/) — best form filler among password managers; still has outdated Identity fields (AOL Name, Pager)
- [RoboForm custom fields — RoboForm Blog](https://blog.roboform.com/2020/05/19/roboform-custom-fields/) — custom field support exists but requires manual setup; no child-specific defaults
- [Biometric authentication UX best practices — Orbix Studio](https://www.orbix.studio/blogs/biometric-authentication-app-design) — fallback options, accessibility, speed expectations
- [Benefits and Limitations of Apple AutoFill — Minimalist Support](https://minimalistpassword.com/help/benefits-and-limitations-of-apple-auto-fill-system) — Apple allows only 2 autofill providers simultaneously; confirmed single-account limitation

---

*Feature research for: Family profile autofill app (Flutter / Android)*
*Researched: 2026-03-06*

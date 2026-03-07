# Family Autofill App

## What This Is

A Flutter mobile app that stores family profile data locally on the device and integrates with the Android Autofill Framework (iOS later) so parents can fill repetitive forms — camp registrations, medical appointments, school enrollment — by selecting a family member from a prompt and having the entire form fill automatically. All sensitive data stays on-device, encrypted at rest.

## Core Value

Parents can fill any family form in seconds instead of minutes — one tap selects a child's profile and the whole form is done.

## Requirements

### Validated

(None yet — ship to validate)

### Active

- [ ] User can create and edit family profiles (name, DOB, address, phone, allergies, emergency contacts)
- [ ] App integrates with Android Autofill Framework so OS prompts profile selection when a form field is focused
- [ ] Tapping a profile fills the entire form automatically
- [ ] App uses heuristics to map form fields to profile data automatically
- [ ] User can manually correct field mappings and corrections are saved per site
- [ ] All profile data is encrypted at rest on device
- [ ] App requires biometric authentication (fingerprint/face) to unlock
- [ ] Free tier supports up to 2 profiles
- [ ] Paid tier unlocks unlimited profiles, LLM-powered field matching, cloud backup & sync, and form history

### Out of Scope

- Browser extension / PC autofill — explored, deferred to future milestone
- iOS autofill integration — Android first, iOS in a later milestone
- LLM field matching in v1 — planned for paid tier, architecture must support it
- Cloud backup & sync in v1 — planned for paid tier, data model must be sync-ready

## Context

- Target users: parents managing forms for 2-4 family members (themselves + 1-3 kids)
- Pain: retyping the same child information into every camp, school, and medical form — nothing today handles this well (browser autofill doesn't understand family data structures)
- Android Autofill Framework is the primary integration point for v1; it requires the app to act as an Autofill Service registered with the OS
- Field mapping must handle diverse form implementations — heuristics first, manual fallback, LLM matching as future premium feature
- Monetization is freemium: core autofill is free (2 profiles), power features are paid (more profiles, LLM matching, cloud sync, form history)
- Cloud sync is a premium feature but the local data model must be designed sync-ready from day one to avoid a painful migration later

## Constraints

- **Platform**: Android first — deepest autofill framework support, ship iOS in a later milestone
- **Tech stack**: Flutter — cross-platform foundation so iOS is additive, not a rewrite
- **Storage**: Local-first — all profile data stays on device; cloud is opt-in and paid
- **Security**: Biometric auth + AES encryption at rest required — non-negotiable given sensitivity of stored data (children's health, address, emergency contacts)
- **Autofill API**: Must implement Android AutofillService — this is a system-level integration with specific lifecycle requirements

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Flutter over native Kotlin | Single codebase enables iOS without a rewrite when the time comes | — Pending |
| Local-first storage | Privacy positioning and no backend costs in v1; sync added as paid premium | — Pending |
| Freemium over one-time purchase | Profile cap (2 free) creates natural upgrade moment for families with 3+ members | — Pending |
| Heuristics + manual fallback before LLM | LLM has API costs unsuitable for free tier; heuristics cover most common forms | — Pending |
| Sync-ready data model from day one | Retrofitting sync onto a non-sync data model is painful; design it in early | — Pending |

---
*Last updated: 2026-03-06 after initialization*

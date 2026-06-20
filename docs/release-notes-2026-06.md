---
title: Release notes — June 2026
type: release-notes
period: 2026-06-13 → 2026-06-18
status: current
---

# Release notes — June 2026

A heavy build week on the DTA site and the composable-bank prototype:
**96 commits (13–18 June)**, ~3,560 lines of new site/docs/tooling (excluding
synced demo assets), **10 new insight papers**, several new pages, a corrected
prototype positioning, and a working performance harness.

The throughline: the story moved from *"here is an agentic-banking
architecture"* to *"here is a working, standards-based proving ground that turns
a proposition into a tested, evidenced, vendor-neutral specification before a
bank builds it"* — with Consumer Duty and agentic customer outcomes as the
commercial wedge, and a performance harness to back the robustness claim.

## Platform (composable-bank prototype)

Platform code lives in `ultim8-prototype` and is **synced** into this repo. This week:

- **3-actor "command centre" model** rolled out across the demonstrated propositions — the agent vs human-in-the-loop split made explicit, with agent steps that **auto-advance** and a clear advance/Run control.
- **Family Wealth** promoted to its own page; **Platform**, **Data Products** and **Resilience** microsite pages built.
- **Governance proof always-visible** — authority, consent and evidence shown at every step.
- Design-review cleanup, contrast/legibility fixes, and removal of a protected codename from the public showcase (boundary-hardening).

## Site — insight series

Ten new papers building the agentic-banking thesis:

- Owned Autonomy; **C3** (Capability · Context · Consent); Consent; Context; Domain Building Blocks; **Data Products for Agentic Banking**; Cross-Border Payments; the **Self-Diagnosing Bank** (operational resilience as architecture).
- **Consumer Duty pair (18 June):** "Proving the Change Worked" (the outcome-evidence gap) and "Test, Learn, Evidence" (Consumer Duty when agents act and money moves in tokens).

## Site — new pages, voice, infrastructure

- **New pages:** `/customer-outcomes/`, `/capability-intelligence/`, `/operating-model/`, `/success/`.
- **Voice rewrite** of the core pages (home, approach, operating-model, capability-intelligence, platform/data-products/resilience) and a locked house style (no em-dashes; banned-word voice-lint in `scripts/voice-lint.sh`).
- **Infrastructure & governance:** Netlify deploy path documented; the **public-showcase boundary check** (`scripts/check-public-showcase.sh`); shared copy de-duplicated into `_data/copy.yml` + the `cta-calendly` include; a **messaging map**, **claim register** (honesty discipline) and **lexicon** established; homepage bio updated to lead with the TSB CTO / Payments role.

## Customer Outcomes workstream (18 June)

- **`/customer-outcomes/`** repositioned from a generic "outcomes matter" page to an **agentic pre-launch proving ground**: use the prototype to test whether a proposition is likely to deliver good customer outcomes before a bank commits to build. The differentiator — testing the consumer-outcome impact of **agentic (and soon tokenised)** journeys, which a focus group cannot reach. Plus a **control-plane band** on Approach and a competitor-agnostic **"Why this is different"** band.
- **`docs/competitive-landscape.md`** — the four-segment market map (conduct consulting / consumer testing / RegTech / agentic tooling) and the upstream-of-implementation position.
- **`docs/distribution/linkedin-customer-outcomes.md`** + **`docs/demo-script-customer-outcomes-lab.md`** — distribution and a 5-minute demo script.

## Prototype positioning corrected

Retired the *"not yet product-ready"* framing across the site and the canonical
sources. The prototype is now described consistently as:

> A **working proving-ground platform**, **non-production by design** (test
> consumers, never real customers), and a **standards-based working
> specification** (ISO 20022 messaging, BIAN domain boundaries, recognised
> control frameworks) that is portable, reusable and vendor-neutral.

Canonical brief: **`docs/prototype.md`**. Claim altitude held in
`docs/claim-register.md`: "expressed in / structured around / aligned to" — never
"certified / conformant"; non-production is the design, not a deficiency.

## Performance & robustness harness

- **`perf/`** — Layer A (Playwright, client-side) and Layer B (k6, a build of the spec), tuned for the current reality (a few concurrent users → robustness and a stable baseline), framed as a measure → improve → re-measure loop. Rationale in **`docs/performance-testing.md`**.
- **Layer A run (18 June):** LCP < 0.5 s even at 6× CPU throttle, TBT ≤ 0.25 s, heap ~5 MB and flat over a soak (no leak). Read: the client side is not the constraint; performance effort belongs at the engine (Layer B).

## Discipline

Every change went through the same gates: **voice-lint** (no em-dashes),
**Jekyll build**, and the **public-showcase boundary check**. Claims are governed
in `docs/claim-register.md`; Consumer Duty and tokenisation are attributed to the
FCA/BoE as external/developing, never as DTA certifying compliance.

## Open / next

- Sync the control-plane / pluggability copy for Platform / Resilience / Cross-Border (lives in `ultim8-prototype`).
- Wire real Family Wealth journey selectors into the Layer-A harness for precise event-volume numbers.
- Run Layer B against the engine on desktop.
- **Site launch LinkedIn post — held until Phase 9 complete** (draft in `docs/distribution/linkedin-site-launch.md`).

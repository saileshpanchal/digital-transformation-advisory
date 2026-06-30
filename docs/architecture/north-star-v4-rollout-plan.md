# North Star V4 Rollout Plan — Transformation Intelligence and the Observatory Method

> **Status:** draft for owner approval (2026-06-30). No public-site changes have
> been made. This plan sequences the adoption of
> [`north-star-v4.md`](north-star-v4.md) across the canon and the site, on the
> launch-gated branch `plans/dta-architecture-2026-06-21`.

## Goal

Adopt North Star V4 (DTA as a **Transformation Intelligence** firm running the
**Observatory Analysis Model**) across the canon and the public site, with the
**Eight Intelligences** preserved unchanged as the executive decision lenses
inside the new frame, and all operational governance carried forward.

## What does not change

- The Eight Intelligences and their pages (Experience, Capability, Cognitive,
  Value, Trust, Platform, Control, Financial). V4 states they are unchanged.
- The Accountable Bank as the synthetic, production-grade demonstration
  environment.
- The evidence-led, vendor-neutral, board-ready, customer-centric positioning.
- The operational governance: provenance (public/internal), stability,
  claim status, the honesty model (link, do not litter), terminology locks, the
  public versus protected boundary, and the claim register.

## Constraints

- Quality and evidence determine launch; no calendar deadline. Launch stays
  gated on the master fold.
- Every change passes the gates: Jekyll build, `voice-lint.sh` (no em-dashes,
  no codenames), `check-public-showcase.sh`, and the dead-link check.
- Preserve files and history. Reuse the existing visual kit and brand palette
  for any new diagrams (inline SVG, no JS).

## Terminology map (V4 to current site)

| V4 term | Current site term | Proposed action | Owner decision |
| --- | --- | --- | --- |
| Transformation Intelligence | (none; site leads with the mission line) | Add as the market category and firm identity; keep the mission line beneath it | Replace or sit above the mission? |
| Observatory Analysis Model / Future Banking Observatory | Insights | Add the Observatory as the reasoning engine and publication home; reframe Insights as Observatory publications | Rename Insights, or add Observatory and keep Insights? |
| Executable Journeys | Experience Journeys | Position Experience Journeys as the human-facing application of an Executable Journey; introduce the Executable Journey as the proof | Rename sitewide, or keep Experience Journeys as a subtype? |
| Executable Architecture Repository | Architecture Library | Evolve the Architecture Library into the Repository (knowledge-graph framing: relationships over documents) | Rename now, or keep Library label for launch? |
| Reference Architecture / Prototype | Reference Architectures / Prototype Specifications | Keep; align labels to the V4 publication structure | None expected |
| Decision Gate (five gates) | (none) | Introduce as a recurring device on journeys and publications | None expected |
| Reference Runtime (Ultim8 internal) | Reference Runtime | Unchanged; Ultim8 stays internal | None |
| Owned Autonomy, C3, DBBs | same | Position within V4: doctrine and reference architectures beneath the Intelligences | None expected |

## Stage 0: Reconcile the canon into one North Star

- Decide the canon shape: either fold the operational governance sections of
  `north-star.md` into V4 to make a single canonical file, or keep V4 as the
  strategic head with `north-star.md` as a governance annex, cross-linked. (Owner
  decision.)
- Add the new V4 terms to `conflict-register.yml` with provenance, stability and
  status, marking P0 any term that gates public navigation or copy
  (Transformation Intelligence, Observatory, Executable Journeys, Executable
  Architecture Repository, Decision Gate).
- Add canonical strings and the terminology map to `docs/lexicon.md` and, where
  they appear in public copy, to `_data/copy.yml`.
- Acceptance: one unambiguous canon; every new public term defined before use.

## Stage A: Positioning (homepage, navigation, metadata)

- Homepage leads with Transformation Intelligence and the signature propositions
  ("Most consultancies describe the future; DTA explains why it emerges"), with
  the mission line retained, the Eight Intelligences as the decision lenses, and
  the DTA Stack as the spine.
- Navigation and footer updated for the V4 vocabulary (Observatory, Executable
  Architecture Repository, Executable Journeys) per the owner decisions above.
- Site title and description lead with Transformation Intelligence.
- Acceptance: build and gates green; nav routes resolve; positioning reads as V4.

## Stage B: The Observatory

- New Observatory page or section: the Observatory Analysis Model (the reasoning
  engine, the connected System/Behaviour/Incentives to Emergence to Future
  Journey to Architecture/Evidence/Decision flow), the nine-step publication
  structure, and "living operating models under observation".
- Reframe existing Insights posts as Observatory publications.
- Acceptance: a reader understands the Observatory as the method, not a blog.

## Stage C: The Five Observatory Diagrams (the visual language)

- Build five reusable inline-SVG diagram includes in the existing chart kit:
  Systems Evolution, Strategic Interaction, Future Narrative Journey, Executable
  Journey, Decision Gate.
- These become the standard analytical language across publications and journeys.
- Acceptance: each diagram renders cleanly, themes to brand, no JS.

## Stage D: The DTA Stack and the Decision Gate

- The DTA Stack (eight layers, Transformation Intelligence down to Investment
  Decision) as a homepage and architecture centrepiece.
- The Decision Gate (five gates: capital, regulation, customer trust, operability,
  technology, provability) as a recurring close on journeys and publications.
- Acceptance: the Stack and Gate appear and link to their layers.

## Stage E: Executable Journeys and the Repository

- Reframe Experience Journeys as Executable Journeys: proofs that connect
  customer outcomes, executive decisions, human judgement, AI agents,
  capabilities, data products, architecture, controls and evidence, each layer
  traceable and measurable.
- Evolve the Architecture Library into the Executable Architecture Repository,
  with the knowledge-graph framing.
- Acceptance: journeys read as proofs; the Repository reads as a connected graph.

## Stage F: Reconcile claims and run the quality review

- Claim register: every new claim (Observatory, Repository, Decision Gate,
  Executable Journeys) carries a status (Demonstrated, Specified, Blueprint or
  Illustrative).
- Run the full build, boundary, voice, route and provenance checks, plus a
  six-perspective editorial pass.
- Acceptance: all P0 rows resolved; gates green; launch decision unchanged.

## Open decisions for the owner

1. **Mission vs category on the homepage:** does "Transformation Intelligence"
   replace the mission line as the lead, or sit above it?
2. **Insights vs Observatory:** rename Insights to the Observatory, or add the
   Observatory and keep Insights?
3. **Experience vs Executable Journeys:** rename sitewide, or keep Experience
   Journeys as a named subtype of Executable Journey?
4. **Architecture Library vs Executable Architecture Repository:** rename for
   launch, or defer the rename and keep the Library label?
5. **Canon shape:** one folded North Star file, or V4 head plus governance annex?
6. **Future Banking Observatory:** public brand now, or internal until the first
   publication ships?

## Sequencing note

Stage 0 (canon) should complete before Stages A to F, because the public copy
derives from the canon. Stages C (the five diagrams) and D (Stack and Gate) can
run in parallel once the canon is set, since they are self-contained visual
components. Everything stays on the launch-gated branch; the master fold remains
the separate launch decision.

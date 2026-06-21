# DTA Architecture Review Design

**Status:** Revised for user review

**Date:** 21 June 2026

**Scope:** DTA North Star, Architecture Room, public website, clean-room demonstration, propositions, prototypes, insights, and supporting governance documents

## Decision

DTA will use a layered architecture model:

1. The **North Star** is the internal canonical source.
2. The **Architecture Room** holds gated evidence, mappings, decisions, and working views.
3. The **public site** derives its mission, thesis, offers, journeys, and selected architecture from approved North Star content.
4. The **clean-room layer** remains separately fenced. It contains synthetic, non-production demonstrations and their executable specifications.

The programme will preserve every existing artefact, record conflicts before rewriting pages, and migrate only content whose provenance and stability permit publication. It will run as two related lanes: a quality-gated site launch and a durable internal canon. The site will be fully updated, then checked against the locked Phase 9 platform plan and design. Phase 9 implementation does not block launch; it controls later promotion from Blueprint to demonstrated status. The launch has no calendar deadline that overrides quality.

## Architectural model under review

The review will test and refine this hierarchy:

```text
Mission
  -> Principles
  -> Seven Intelligences
  -> Experience Journeys
  -> Reference Architectures
  -> Prototype Specifications
  -> Ultim8
  -> Executable Systems
```

Three themes run across the hierarchy:

- **Preservation:** retain knowledge, evidence, capability, and institutional memory.
- **Evolution:** operate old and new worlds together and migrate safely.
- **Augmentation:** enable humans and machines to think and act together.

The Seven Intelligences provide lenses across DTA's work. They are soft tags, not mandatory filing categories. An artefact may span several Intelligences without having one primary parent. They do not replace every existing term. **Owned Autonomy** remains a doctrine. **C3** remains a reusable reference architecture. **Domain Building Blocks** remain capability units. The register must define how these concepts fit before the site presents the hierarchy as settled.

## Governance artefacts

The review creates two immediate governance artefacts:

- `docs/architecture/conflict-register.yml`: machine-readable conflicts, recommendations, provenance, stability, dependencies, and status.
- `docs/architecture/change-plan.md`: a four-stage programme that separates the launch lane from the longer-lived canon lane.

Later canon work may add deeper mappings, reference architecture views, and automation when they earn their maintenance cost.

## Conflict-register rules

Every row must contain a stable ID and one value from each governed enumeration.

### Disposition

`define`, `preserve`, `adopt`, `merge`, `deprecate`, `redirect`, `quarantine`, or `open`.

`define` comes first. DTA must lock a coined term's meaning before adopting it, merging alternatives into it, or redirecting older language.

### Provenance

- `public`: safe and intended for unrestricted publication.
- `gated`: evidence or architecture available under controlled access.
- `internal`: DTA method, working material, or protected IP.
- `clean-room`: synthetic, non-production demonstration and specification material.

An artefact gets one primary provenance. If one concept needs different public and internal treatments, the register splits it into separate rows.

### Stability

- `locked`: approved canonical content; change requires an explicit architecture decision.
- `stable`: publishable and evidence-backed; normal governance may revise it.
- `developing`: suitable for drafting, but publication is held.
- `provisional`: exploratory; dependent content must not ship.

Public pages may use only `public` content that is `locked` or `stable`. Clean-room pages may use `clean-room` content that is `locked` or `stable`, with synthetic and non-production boundaries visible. Gated and internal content must not be copied into public output.

## Change strategy

The programme has four stages:

1. **Author the canon:** lock the mission, principles, Intelligence definitions, hierarchy, and coined terms needed to write the full site coherently.
2. **Map and fence:** apply soft Intelligence tags where useful and enforce provenance, claim, and clean-room boundaries.
3. **Build the site:** finalise navigation, rewrite shared components, and then rewrite pages in dependency order.
4. **Review once:** check the fully updated site against the locked Phase 9 platform plan and design, then run one manual persona, claim, provenance, link, and redirect pass before launch.

The launch lane stops when the public site is complete, coherent, safe, and consistent with the locked platform design. The Phase 9 proposition remains Blueprint and synthetic until implementation evidence supports promotion. The canon lane may continue after launch with deeper client-reuse material that is not required to explain the public architecture.

## Quality model

Architecture quality requires human review. For the first launch, use the register and one disciplined manual review. Keep the existing Jekyll, link, claim, and public-showcase checks. Defer new schema enforcement, mapping coverage automation, and fresh-reader panels until a second contributor makes enforcement valuable.

## Source boundary

This design uses repository evidence and the architecture programme and improvement notes supplied in the conversation on 21 June 2026. The cited `DTA_Deep_Strategy_Notes.md` source could not be retrieved because the required gstack browser daemon failed to start after three attempts. No unverified material from that file has been imported beyond the excerpt supplied directly by the user.

## Non-goals

- No public page rewrite occurs during register creation.
- No existing page, post, document, prototype, or asset is deleted.
- No internal or gated IP is promoted to public provenance by implication.
- No developing or provisional term becomes a public navigation promise.
- No historical insight is rewritten merely because its terminology reflects an earlier architecture stage.

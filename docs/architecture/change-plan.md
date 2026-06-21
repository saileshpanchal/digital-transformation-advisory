# DTA Architecture Change Plan

**Status:** Revised for review

**Date:** 21 June 2026

**Origin:** `docs/superpowers/specs/2026-06-21-dta-architecture-review-design.md`

**Register:** `docs/architecture/conflict-register.yml`

## Decision

DTA needs both a complete public site and a durable internal canon. They will run as separate lanes:

- **Launch lane:** establish the stable canon required to update the full site, then check the result against the locked Phase 9 platform plan and design.
- **Canon lane:** continue the North Star, deeper mappings, reference architectures, Prototype Specifications, and Ultim8 work after launch.

The launch has no calendar deadline that overrides quality. The public site does not need every internal canon section to close, but every public surface must be updated and its Phase 9 claims must match the locked design. Implementation evidence is a later promotion gate.

## Controls that remain mandatory

- Keep provenance, stability, and claim status as separate decisions.
- Keep synthetic, non-production, and claim labels visible on clean-room content.
- Define coined terms before adopting, merging, or redirecting older language.
- Preserve historical posts rather than rewriting DTA's intellectual history.
- Do not modify the two untracked insight drafts during this work.
- Edit generated demonstration content through its source repository.

## Priority rule

- **P0:** blocks launch, risks protected IP, or risks a false or misleading claim.
- **P1:** needed for a coherent launch but safe to resolve during the build.
- **P2:** canon depth or post-launch refinement.

The register should contain about ten P0 items. A P0 must meet the rule above, not merely be important.

## Target model

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

Preservation, Evolution, and Augmentation cut across this model. Owned Autonomy remains a doctrine. C3 remains a reference architecture. DBBs remain capability units.

The Seven Intelligences are lenses, not folders. Artefacts may carry several Intelligence tags and need no single primary parent.

## Launch navigation hypothesis

Test this grouped model during the site build:

1. Home
2. Intelligences
3. Experience Journeys
4. Architecture
   - Architecture Library
   - Prototype Specifications
5. Ultim8, held until its definition is stable
6. Insights
7. Discuss a challenge

Mission and Principles should lead the homepage and remain directly linkable. Keep them out of the top-level navigation unless the editorial review shows that readers cannot find them.

## Stage A: Author the public canon

### Objective

Write the North Star content required to make the full public site coherent without forcing completion of protected, client-reuse material that the site does not expose.

### Launch work

1. Lock the mission and a shorter public expression.
2. Lock the role of the principles.
3. Define Preservation, Evolution, and Augmentation as cross-cutting themes.
4. Write one clear paragraph for each of the Seven Intelligences.
5. State how Owned Autonomy, C3, DBBs, governed data products, and the control plane fit without giving each a competing architectural level.
6. Lock the public definitions needed for launch:
   - Experience Journey and proposition;
   - Capability Intelligence;
   - Consumer Outcomes;
   - Clean-Room Demonstration and its Standard;
   - Proposition Blueprint, Capability Blueprint, Glass Tube, working prototype, working specification, and Prototype Specification.
7. Decide which terms remain held:
   - The Accountable Bank pending trademark review;
   - Ultim8 pending a stable public definition;
   - detailed Judgment Intelligence methods pending canon work.
8. Preserve the 20 June controlled-evolution design as an origin document and carry forward its approved commercial and claim decisions.

### Launch output

- A concise `docs/architecture/north-star.md` containing the sections above.
- Approved updates to the P0 and launch-critical P1 register rows.
- A short canonical terminology section in `docs/lexicon.md`.

### Canon work after launch

- Full inclusion and exclusion rules for every Intelligence.
- Deeper Skills, Knowledge, and Judgment models.
- Complete reference architecture definitions.
- Detailed Ultim8 and executable-system boundaries.

## Stage B: Map and fence for IP

### Objective

Protect credibility and IP while using the Seven Intelligences to reveal relationships rather than force ownership.

### Launch work

1. List the two untracked drafts and leave them unchanged. Git provides the baseline for tracked files.
2. Assign provenance to each page and document touched by the launch:
   - `public`;
   - `gated`;
   - `internal`;
   - `clean-room`.
3. Confirm stability and claim status for each public statement changed during the launch.
4. Split public summaries from protected source material where a page draws on internal IP.
5. Apply zero or more soft Intelligence tags to each changed page or proposition. Use `lead`, `material`, or `supporting` strength only when it helps editorial decisions. More than one `lead` tag is valid.
6. Fence SFIA levels, role libraries, DBB catalogues, methods, schemas, and implementation mechanics as gated or internal.
7. Keep generated demonstrations fenced as clean-room content with synthetic, non-production, and claim labels.

### Launch output

- Updated conflict register for changed content.
- A lightweight launch mapping in the North Star or messaging map.
- A manual public-safe checklist for each changed page.

### Deferred canon work

- A complete artefact inventory.
- Mapping every historical post, tool, image, and asset.
- Heat-map coverage reports.
- Checksums, snapshot manifests, and immutable-baseline machinery beyond Git.

## Stage C: Build the full site

### Objective

Update every public surface from the approved public canon.

### Shared change order

1. `_config.yml`: title, description, and canonical metadata.
2. `_data/copy.yml`: approved mission, term definitions, status labels, and calls to action.
3. `_layouts/corporate.html`: navigation, footer, and route families.
4. Shared CTA and header includes.
5. `index.html`: mission, principles, Intelligences, journeys, proof, and commercial routes.

Read the shared frame once as six audiences: board leader, CIO or CTO, architect, regulator or control leader, capability buyer, and informed public reader. This is one editorial pass, not six approval panels.

### Page order

| Order | Surface | Launch treatment |
|---|---|---|
| 1 | `index.html` | Establish mission, principles, Intelligences, proof, and commercial routes. |
| 2 | Intelligences hub | Publish concise definitions and links; defer deep domain pages where content remains developing. |
| 3 | `capability-intelligence.html` | Broaden the domain definition and keep squads and SFIA as an application. |
| 4 | `customer-outcomes.html` | Rename to Consumer Outcomes and preserve the old route with a permanent redirect. |
| 5 | Experience Journeys hub | Reframe current propositions as journeys and commercial concepts. |
| 6 | `composable-bank/*` | Preserve demonstrations; update the shell, labels, and generated source copy. |
| 7 | Architecture landing page | Curate the stable C3, platform, data, resilience, value, trust, and control material already available. |
| 8 | `approach.html` | Reframe as the advisory and evolution method. |
| 9 | `operating-model.html` | Connect leadership and continuous control to Capability and Control Intelligence. |
| 10 | `insights.html` | Preserve posts and improve canonical cross-links only. |
| 11 | About, contact, and policies | Align the corporate story; give policies a separate factual and legal review. |

Prototype Specifications and Ultim8 pages may be drafted, but remain held while their definitions are developing or provisional.

### URL work

Create one small redirect list for routes that actually change. Test old and new routes during the final review. Do not build a general URL-governance system for this launch.

## Stage D: Check against locked Phase 9 design, review once, and launch

### Objective

Check the full site against the locked Phase 9 plan and design, then run one disciplined review against the controls that protect DTA's credibility.

### Phase 9 design check

1. Confirm the Phase 9 plan and design are locked and cover feedback, reconciliation, the migration decision record, exception reporting, and the vendor-neutral specification.
2. Compare every site statement about the Synthetic Bank Migration Twin with the locked design.
3. Label planned behaviour as Blueprint or Specified, not Demonstrated.
4. Keep *synthetic* attached to *digital twin* and use *synthetic migration model* until implementation evidence supports promotion.
5. Check the platform's planned proposition, architecture, and runtime terminology against the site's canonical definitions.
6. Record discrepancies in the conflict register and resolve them before launch.

### Manual review

For every changed public page, check:

1. **Purpose:** Does the page support the mission and make its next action clear?
2. **Terminology:** Is every coined term defined before use and used for one architectural job?
3. **Provenance:** Has gated, internal, or clean-room detail leaked into ordinary public copy?
4. **Stability:** Does the page depend only on locked or stable public statements?
5. **Claims:** Is each material assertion permitted by `docs/claim-register.md`?
6. **Clean room:** Are synthetic, non-production, and claim-status boundaries explicit?
7. **Personas:** Can the six audience types understand the shared navigation and page purpose?
8. **History:** Have old posts and the untracked drafts remained intact?

### Existing technical checks

1. Run the Jekyll build.
2. Run existing public-showcase and voice checks.
3. Check internal links and metadata.
4. Test changed redirects.
5. Review the rendered site at mobile and desktop widths.

### Launch criteria

- All P0 register rows are approved or resolved.
- The full public site has been updated, not merely the homepage and shared shell.
- The Phase 9 plan and design are locked.
- Site claims and status labels match the locked Phase 9 design and retain Blueprint boundaries.
- The mission and seven concise Intelligence definitions are stable.
- Public copy passes provenance, stability, and claim review.
- Clean-room boundaries remain explicit.
- Navigation and changed routes work.
- No historical post or untracked draft was lost or silently rewritten.

## Deferred until a second contributor exists

- Build-time enum and dependency enforcement.
- CI checks for Intelligence mapping coverage.
- Automated provenance and stability gates.
- Full fresh-reader persona panels.
- Complete artefact IDs and machine-generated inventories.
- Snapshot and checksum infrastructure beyond normal Git history.

The register remains machine-readable so these controls can be automated later without redesigning the governance model.

## Canon completion after launch

The canon lane continues independently. Its completion criteria are:

- every canonical term has one definition, owner, provenance, stability, and architectural job;
- reference architectures connect the Seven Intelligences without forcing single-parent classification;
- public, gated, internal, and clean-room views are distinct;
- Prototype Specifications and Ultim8 have stable boundaries;
- DTA can reuse the North Star structure in client architecture work without exposing protected methods.

## Next decision

Approve the revised register and begin Stage A. Launch remains state-based: full site update, locked Phase 9 plan and design, claim reconciliation, and final quality review.

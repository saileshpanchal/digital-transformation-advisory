# DTA Architecture Launch Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Update the full DTA site from a stable public North Star, then reconcile every platform claim against the locked Synthetic Bank Migration Twin Phase 9 plan and design before launch.

**Architecture:** The North Star is the internal canonical source. Public pages derive from public, locked or stable statements; protected method remains gated or internal; generated demonstration content remains clean-room. The Seven Intelligences are soft lenses rather than single-parent categories.

**Tech Stack:** Jekyll 4.3, Liquid, HTML, YAML, Bash, Netlify redirects, generated Ultim8 clean-room assets

## Global Constraints

- Quality and evidence state determine launch; there is no calendar deadline.
- Preserve all existing files and history. Do not modify the two untracked insight drafts.
- Keep provenance, stability, and claim status independent.
- Keep synthetic, non-production, and claim labels visible on clean-room content.
- Define coined terms before using them in navigation or public copy.
- Do not edit generated files under `composable-bank/assets/` by hand.
- Keep *synthetic* attached to *digital twin* and retain Blueprint status until Phase 9 implementation evidence and the claim register permit promotion.
- Complete the full public site before the final comparison with the locked platform design.

---

### Task 0: Commit the approved architecture governance

**Files:**
- Create: `docs/superpowers/specs/2026-06-21-dta-architecture-review-design.md`
- Create: `docs/architecture/conflict-register.yml`
- Create: `docs/architecture/change-plan.md`
- Create: `docs/superpowers/plans/2026-06-21-dta-architecture-launch.md`

**Interfaces:**
- Consumes: approved architecture review and user revisions
- Produces: versioned origin, register, change strategy, and executable plan

- [ ] **Step 1: Validate the register**

Run:

```bash
ruby -ryaml -rdate -e 'd=YAML.safe_load(File.read("docs/architecture/conflict-register.yml"), permitted_classes:[Date], aliases:false); rows=d.fetch("conflicts"); abort "duplicate ids" unless rows.map{|r|r.fetch("id")}.uniq.size==rows.size; abort "wrong P0 count" unless rows.count{|r|r["priority"]=="P0"}==10; puts "register ok"'
```

Expected: `register ok`.

- [ ] **Step 2: Confirm the user drafts remain excluded**

Run:

```bash
git status --short
```

Expected: the two untracked `_posts/2026-06-17-*.md` drafts remain untracked and are not staged.

- [ ] **Step 3: Commit only the governance files**

```bash
git add docs/superpowers/specs/2026-06-21-dta-architecture-review-design.md docs/architecture/conflict-register.yml docs/architecture/change-plan.md docs/superpowers/plans/2026-06-21-dta-architecture-launch.md
git commit -m "docs: define DTA architecture launch programme"
```

### Task 1: Author and approve the public North Star

**Files:**
- Create: `docs/architecture/north-star.md`
- Modify: `docs/lexicon.md`
- Modify: `docs/architecture/conflict-register.yml`
- Modify: `_data/copy.yml`

**Interfaces:**
- Consumes: `docs/superpowers/specs/2026-06-21-dta-architecture-review-design.md`, `docs/architecture/change-plan.md`, existing lexicon and claim register
- Produces: stable public definitions and protected-detail boundaries consumed by every later task

- [ ] **Step 1: Record the pre-change validation result**

Run:

```bash
test -f docs/architecture/north-star.md
```

Expected: exit 1 because the canonical North Star does not exist yet.

- [ ] **Step 2: Write the North Star**

Create `docs/architecture/north-star.md` with these sections and decisions:

1. Mission: helping institutions evolve customers, colleagues, and technology together through multiple forms of intelligence, creating trustworthy, inclusive, and resilient financial systems.
2. Principles: Human-centred; Evolution over replacement; Capability before technology; Human-in-the-loop; Consumer outcomes; Preservation before optimisation; Continuous control; Standards and interoperability.
3. Cross-cutting themes: Preservation, Evolution, Augmentation.
4. Seven Intelligences, each with one concise public definition: Experience, Capability, Cognitive, Value, Trust, Platform, Control.
5. Capability subdomains: Skills, Knowledge, Judgment.
6. Hierarchy: Mission -> Principles -> Intelligences -> Experience Journeys -> Reference Architectures -> Prototype Specifications -> Ultim8 -> Executable Systems.
7. Existing concepts: Owned Autonomy is a doctrine; C3 is a reference architecture; DBBs are capability units; the clean room is proof infrastructure.
8. Provenance and stability rules.
9. Public versus protected content boundary.

- [ ] **Step 3: Reconcile the lexicon**

Update `docs/lexicon.md` so its concept hierarchy does not compete with the North Star. Preserve existing approved definitions of Owned Autonomy, C3, DBB, Glass Tube, Proposition Blueprint, Capability Blueprint, and the Clean-Room Demonstration Standard. Add cross-references to the North Star and mark protected details explicitly.

- [ ] **Step 4: Add canonical public strings**

Add approved mission, principle, Intelligence, and clean-room summary strings to `_data/copy.yml`. Keep page-specific prose out of this file.

- [ ] **Step 5: Approve launch-critical register rows**

Update the status and recommendations only after the North Star wording is accepted. Resolve or approve the ten P0 rows: `PUR-001`, `HIER-001`, `TERM-008`, `COM-001`, `COM-003`, `PROV-001`, `PROV-002`, `PROV-003`, `CLAIM-001`, and `BUILD-004`.

- [ ] **Step 6: Validate the canon**

Run:

```bash
ruby -ryaml -rdate -e 'YAML.safe_load(File.read("docs/architecture/conflict-register.yml"), permitted_classes:[Date], aliases:false); YAML.safe_load(File.read("_data/copy.yml"), permitted_classes:[Date], aliases:false); puts "yaml ok"'
rg -n '^## (Mission|Principles|Cross-cutting themes|Seven Intelligences|Architecture hierarchy|Provenance)' docs/architecture/north-star.md
```

Expected: `yaml ok` and one heading match for every required North Star section.

- [ ] **Step 7: Commit**

```bash
git add docs/architecture/north-star.md docs/lexicon.md docs/architecture/conflict-register.yml _data/copy.yml
git commit -m "docs: establish DTA architecture North Star"
```

### Task 2: Replace the shared site frame

**Files:**
- Modify: `_config.yml`
- Modify: `_layouts/corporate.html`
- Modify: `_includes/cta.html`
- Modify: `_includes/cta-calendly.html`
- Modify: `index.html`
- Modify: `assets/css/corporate.css`

**Interfaces:**
- Consumes: canonical public strings from Task 1
- Produces: navigation, footer, homepage, and shared language used by all public routes

- [ ] **Step 1: Capture the current navigation assertion**

Run:

```bash
rg -n 'Customer Outcomes|Capability Intelligence|Propositions' _layouts/corporate.html
```

Expected: current navigation labels are found.

- [ ] **Step 2: Update site metadata**

Change `_config.yml` so the title and description lead with DTA's mission and strategic advisory position. Keep Owned Autonomy as doctrine rather than the site category.

- [ ] **Step 3: Implement the grouped navigation**

Update `_layouts/corporate.html` to route to:

- Home
- Intelligences
- Experience Journeys
- Architecture, with Architecture Library and Prototype Specifications
- Ultim8 only when its register stability is `stable`
- Insights
- Discuss a challenge

Put Mission and Principles on the homepage and make their anchors directly linkable. Update the footer to mirror the new hierarchy and retain Contact and Policies.

- [ ] **Step 4: Rewrite the homepage**

Order `index.html` as:

1. Mission-led strategic advisory hero.
2. Mission and principles.
3. Preservation, Evolution, Augmentation.
4. Seven Intelligences overview.
5. Experience Journeys.
6. Architecture and Prototype Specifications.
7. Clean-room proof with explicit synthetic and non-production boundary.
8. Advisory, Talent, and Squads routes.
9. Leadership and Insights.

Do not present Ultim8 as stable if `TERM-010` remains developing or provisional.

- [ ] **Step 5: Update shared styling**

Add only the grid, navigation, status-label, and responsive styles required by the new shared sections. Reuse the existing design language and breakpoints.

- [ ] **Step 6: Build and lint**

Run:

```bash
bundle exec jekyll build
./scripts/voice-lint.sh index.html _layouts/corporate.html _includes/cta.html _includes/cta-calendly.html
./scripts/check-public-showcase.sh
```

Expected: Jekyll exits 0; voice lint reports no em dashes or codenames; public-showcase boundary passes.

- [ ] **Step 7: Commit**

```bash
git add _config.yml _layouts/corporate.html _includes/cta.html _includes/cta-calendly.html index.html assets/css/corporate.css
git commit -m "site: establish DTA architecture navigation"
```

### Task 3: Publish the Seven Intelligences and Experience Journeys

**Files:**
- Create: `intelligences.html`
- Create: `experience-intelligence.html`
- Modify: `capability-intelligence.html`
- Create: `cognitive-intelligence.html`
- Create: `value-intelligence.html`
- Create: `trust-intelligence.html`
- Create: `platform-intelligence.html`
- Create: `control-intelligence.html`
- Create: `experience-journeys.html`
- Modify: `assets/css/corporate.css`

**Interfaces:**
- Consumes: Seven Intelligence definitions and hierarchy from Task 1
- Produces: stable public domain routes and the journey lens used by proposition and architecture pages

- [ ] **Step 1: Verify the routes do not yet exist**

Run:

```bash
test -f intelligences.html || test -f experience-journeys.html
```

Expected: exit 1.

- [ ] **Step 2: Create the Intelligences hub**

Create `intelligences.html` with permalink `/intelligences/`. Explain that Intelligences are overlapping lenses, not filing categories. Link all seven domain pages and show Preservation, Evolution, and Augmentation across the set.

- [ ] **Step 3: Create or revise the seven domain pages**

Use these canonical routes:

- `experience-intelligence.html` -> `/experience-intelligence/`
- `capability-intelligence.html` -> `/capability-intelligence/`
- `cognitive-intelligence.html` -> `/cognitive-intelligence/`
- `value-intelligence.html` -> `/value-intelligence/`
- `trust-intelligence.html` -> `/trust-intelligence/`
- `platform-intelligence.html` -> `/platform-intelligence/`
- `control-intelligence.html` -> `/control-intelligence/`

Each page must contain:

1. The Intelligence's primary question.
2. Its concise definition.
3. Outcomes it governs.
4. Existing DTA evidence and propositions.
5. Related Intelligences without claiming exclusive ownership.
6. One next action.

Expand `capability-intelligence.html` so Skills, Knowledge, and Judgment sit above its current SFIA and squad application. Keep protected levels and detailed methods off the public page.

- [ ] **Step 4: Create the Experience Journeys hub**

Create `experience-journeys.html` with permalink `/experience-journeys/`. Distinguish a customer or institutional journey from a commercial proposition. Link Family Wealth, Premium Yacht, International Student, Cross-Border Payments, Franchise Network, Consumer Outcomes, and the Synthetic Bank Migration Twin with their current evidence labels.

- [ ] **Step 5: Build and lint the new routes**

Run:

```bash
bundle exec jekyll build
for route in intelligences experience-intelligence capability-intelligence cognitive-intelligence value-intelligence trust-intelligence platform-intelligence control-intelligence experience-journeys; do test -f "_site/$route/index.html" || exit 1; done
./scripts/voice-lint.sh intelligences.html experience-intelligence.html capability-intelligence.html cognitive-intelligence.html value-intelligence.html trust-intelligence.html platform-intelligence.html control-intelligence.html experience-journeys.html
```

Expected: all route files exist; lint exits 0.

- [ ] **Step 6: Commit**

```bash
git add intelligences.html experience-intelligence.html capability-intelligence.html cognitive-intelligence.html value-intelligence.html trust-intelligence.html platform-intelligence.html control-intelligence.html experience-journeys.html assets/css/corporate.css
git commit -m "site: publish the Seven Intelligences"
```

### Task 4: Reconcile Consumer Outcomes, advisory, and operating-model pages

**Files:**
- Create: `consumer-outcomes.html`
- Replace: `customer-outcomes.html`
- Modify: `approach.html`
- Modify: `operating-model.html`
- Modify: `netlify.toml`
- Modify: `docs/messaging-map.md`
- Modify: `docs/claim-register.md`

**Interfaces:**
- Consumes: Experience, Trust, Capability, and Control definitions
- Produces: canonical Consumer Outcomes route, advisory method, operating-model narrative, and permanent legacy route

- [ ] **Step 1: Record the current terminology**

Run:

```bash
rg -n 'Customer Outcomes|customer outcomes|/customer-outcomes/' customer-outcomes.html _layouts/corporate.html docs/messaging-map.md
```

Expected: current terminology and links are found.

- [ ] **Step 2: Create the canonical Consumer Outcomes page**

Move the substantive page to `consumer-outcomes.html` with permalink `/consumer-outcomes/`. Lead with DTA's advocacy position, then explain advisory, journey testing, evidence, and clean-room proof. Use *customer* only for a specific bank-customer relationship or quoted source.

- [ ] **Step 3: Preserve the old route**

Replace `customer-outcomes.html` with a minimal redirect document at `/customer-outcomes/` containing a canonical link and immediate redirect to `/consumer-outcomes/`. Add a Netlify 301 rule before the catch-all rule.

- [ ] **Step 4: Reframe advisory and operating model**

Update `approach.html` so it explains how DTA applies the Intelligences, reference architectures, proof, and evolution method. Update `operating-model.html` so Capability and Control Intelligence frame leadership, decision rights, squads, and continuous control. Preserve Owned Autonomy, C3, Glass Tube, and DBB definitions.

- [ ] **Step 5: Update governance references**

Update `docs/messaging-map.md` and `docs/claim-register.md` for the canonical route and wording. Do not upgrade any evidence status without supporting evidence.

- [ ] **Step 6: Build and verify redirects**

Run:

```bash
bundle exec jekyll build
test -f _site/consumer-outcomes/index.html
test -f _site/customer-outcomes/index.html
rg -n '/consumer-outcomes/' _site/customer-outcomes/index.html netlify.toml
./scripts/voice-lint.sh consumer-outcomes.html approach.html operating-model.html
```

Expected: both routes exist; the old route points to the new route; lint exits 0.

- [ ] **Step 7: Commit**

```bash
git add consumer-outcomes.html customer-outcomes.html approach.html operating-model.html netlify.toml docs/messaging-map.md docs/claim-register.md
git commit -m "site: establish Consumer Outcomes architecture"
```

### Task 5: Build the Architecture and Prototype Specification routes

**Files:**
- Create: `architecture-library.html`
- Create: `prototype-specifications.html`
- Create: `ultim8.html`
- Modify: `docs/c3-architecture.md`
- Modify: `docs/prototype.md`
- Modify: `docs/messaging-map.md`
- Modify: `assets/css/corporate.css`

**Interfaces:**
- Consumes: architecture hierarchy, provenance rules, and stable terms
- Produces: public architecture index, specification boundary, and a held or publishable Ultim8 route based on evidence

- [ ] **Step 1: Create the Architecture Library**

Create `architecture-library.html` with permalink `/architecture-library/`. Curate stable public views for C3, DBBs, governed data products, value exchange, trust, platform evolution, resilience, and continuous control. Link to existing public papers and demonstration pages. Do not expose internal schemas or methods.

- [ ] **Step 2: Create Prototype Specifications**

Create `prototype-specifications.html` with permalink `/prototype-specifications/`. Define the difference among Reference Architecture, Prototype Specification, working prototype, working specification, and executable system. Show status and provenance for each published example.

- [ ] **Step 3: Create the Ultim8 page with a stability hold**

Create `ultim8.html` with permalink `/ultim8/`. If `TERM-010` is not `stable`, set `published: false` in frontmatter and omit it from navigation. If it is stable, explain only its approved runtime role and relationship to Prototype Specifications and executable systems.

- [ ] **Step 4: Align architecture source documents**

Update `docs/c3-architecture.md` to position C3 as a reference architecture within the Seven Intelligences. Update `docs/prototype.md` to use the canonical clean-room and specification terms. Update the messaging map.

- [ ] **Step 5: Build and lint**

Run:

```bash
bundle exec jekyll build
test -f _site/architecture-library/index.html
test -f _site/prototype-specifications/index.html
./scripts/voice-lint.sh architecture-library.html prototype-specifications.html ultim8.html
./scripts/check-public-showcase.sh
```

Expected: public architecture and specification routes exist; Ultim8 follows its stability state; checks exit 0.

- [ ] **Step 6: Commit**

```bash
git add architecture-library.html prototype-specifications.html ultim8.html docs/c3-architecture.md docs/prototype.md docs/messaging-map.md assets/css/corporate.css
git commit -m "site: publish DTA architecture library"
```

### Task 6: Complete the remaining public-site update

**Files:**
- Modify: `insights.html`
- Modify: `connect.html`
- Modify: `policy-documentation.html`
- Modify: `about.md`
- Modify: `_config.yml`
- Modify: `_includes/post-footer.html`
- Modify: `_layouts/corporate-post.html`

**Interfaces:**
- Consumes: final navigation and canonical terminology
- Produces: complete public-site coverage without rewriting historical posts

- [ ] **Step 1: Update Insights discovery**

Add soft Intelligence filters or grouped links to `insights.html` without reclassifying every historical post as a launch requirement. Update post footers to link readers back to the relevant Intelligences, journeys, or architecture routes.

- [ ] **Step 2: Align contact and About**

Update `connect.html` to accept strategic, architecture, proposition, and capability enquiries. Rewrite `about.md` as a corporate About page using the mission and leadership evidence already approved on the homepage. Remove `about.md` from `_config.yml` exclusions when ready.

- [ ] **Step 3: Review policy content separately**

Correct only verified dates, facts, grammar, and current positioning in `policy-documentation.html`. Do not treat architecture review as legal approval.

- [ ] **Step 4: Preserve historical content**

Confirm that no `_posts/*.md` file was rewritten merely to match the new terminology and that the two untracked drafts remain byte-for-byte untouched.

- [ ] **Step 5: Build and lint**

Run:

```bash
bundle exec jekyll build
./scripts/voice-lint.sh insights.html connect.html about.md policy-documentation.html _includes/post-footer.html
git status --short
```

Expected: build and lint exit 0; the two original untracked drafts remain listed and unmodified.

- [ ] **Step 6: Commit**

```bash
git add insights.html connect.html policy-documentation.html about.md _config.yml _includes/post-footer.html _layouts/corporate-post.html
git commit -m "site: complete DTA architecture migration"
```

### Task 7: Lock Phase 9 design and reconcile launch claims

**Files:**
- Modify: `docs/claim-register.md`
- Modify: `docs/messaging-map.md`
- Modify: `docs/architecture/conflict-register.yml`
- Modify as design requires: `index.html`
- Modify as design requires: `experience-journeys.html`
- Modify as design requires: `architecture-library.html`
- Modify as design requires: `prototype-specifications.html`

**Interfaces:**
- Consumes: versioned and approved Ultim8 Synthetic Bank Migration Twin Phase 9 plan and design
- Produces: launch copy and status labels aligned to planned behaviour without claiming implementation

- [ ] **Step 1: Verify that Phase 9 planning and design are locked**

Require a versioned, approved Phase 9 design covering:

1. feedback and reconciliation behaviour;
2. migration decision record;
3. exception report;
4. vendor-neutral specification;
5. Demonstrated, Simulated, Specified, or Blueprint labels for each step and output.

Do not resolve `BUILD-004` if any design item remains open.

- [ ] **Step 2: Compare the site with the locked design**

Compare every Synthetic Bank Migration Twin, clean-room, runtime, reconciliation, and specification statement with the locked design. Record the platform design version or commit in the claim register.

- [ ] **Step 3: Preserve the launch claim boundary**

Keep the proposition labelled Blueprint. Use *synthetic migration model* and apply Specified or Blueprint labels to Phase 9 behaviour. Do not label planned behaviour Demonstrated.

- [ ] **Step 4: Update status and conflicts**

Update the claim register, messaging map, and relevant conflict rows. Resolve `BUILD-004` only when the full site agrees with the locked design.

- [ ] **Step 5: Build and run boundaries**

Run:

```bash
bundle exec jekyll build
./scripts/check-public-showcase.sh
./scripts/voice-lint.sh index.html experience-journeys.html architecture-library.html prototype-specifications.html
```

Expected: build, boundary check, and lint exit 0.

- [ ] **Step 6: Commit**

```bash
git add docs/claim-register.md docs/messaging-map.md docs/architecture/conflict-register.yml index.html experience-journeys.html architecture-library.html prototype-specifications.html
git commit -m "site: align DTA claims with locked phase 9 design"
```

### Task 8: Run the final quality review

**Files:**
- Review: every public `.html` and `.md` route
- Modify only if defects are found: affected source files
- Modify: `docs/architecture/conflict-register.yml`

**Interfaces:**
- Consumes: complete site and locked Phase 9 platform design
- Produces: launch-ready site with every P0 conflict resolved

- [ ] **Step 1: Run the full build and existing checks**

```bash
JEKYLL_ENV=production bundle exec jekyll build
./scripts/check-public-showcase.sh
./scripts/voice-lint.sh index.html intelligences.html experience-intelligence.html capability-intelligence.html cognitive-intelligence.html value-intelligence.html trust-intelligence.html platform-intelligence.html control-intelligence.html experience-journeys.html consumer-outcomes.html approach.html operating-model.html architecture-library.html prototype-specifications.html ultim8.html insights.html connect.html about.md policy-documentation.html
```

Expected: every command exits 0.

- [ ] **Step 2: Check links, routes, and redirects**

Verify all navigation links in `_site`, the `/customer-outcomes/` redirect, legacy `/composable-bank/` links, canonical metadata, and sitemap entries. Fix any broken route before continuing.

- [ ] **Step 3: Run one six-perspective editorial pass**

Read the full rendered site once as: board leader, CIO or CTO, architect, regulator or control leader, capability buyer, and informed public reader. Record only concrete comprehension, claim, provenance, or routing defects and correct them.

- [ ] **Step 4: Confirm launch state**

Run:

```bash
ruby -ryaml -rdate -e 'd=YAML.safe_load(File.read("docs/architecture/conflict-register.yml"), permitted_classes:[Date]); p0=d.fetch("conflicts").select{|r| r["priority"]=="P0" && !%w[approved implemented verified].include?(r["status"])}; abort p0.map{|r|r["id"]}.join(" ") unless p0.empty?; puts "all P0 rows resolved"'
```

Expected: `all P0 rows resolved`.

- [ ] **Step 5: Confirm preservation**

Verify the two untracked drafts still exist and review `git diff --name-status` for unintended deletions or historical-post rewrites.

- [ ] **Step 6: Commit final corrections**

```bash
git add _config.yml _data/copy.yml _layouts/corporate.html _layouts/corporate-post.html _includes/cta.html _includes/cta-calendly.html _includes/post-footer.html index.html intelligences.html experience-intelligence.html capability-intelligence.html cognitive-intelligence.html value-intelligence.html trust-intelligence.html platform-intelligence.html control-intelligence.html experience-journeys.html consumer-outcomes.html customer-outcomes.html approach.html operating-model.html architecture-library.html prototype-specifications.html ultim8.html insights.html connect.html about.md policy-documentation.html netlify.toml assets/css/corporate.css docs/architecture/conflict-register.yml docs/architecture/north-star.md docs/lexicon.md docs/c3-architecture.md docs/prototype.md docs/messaging-map.md docs/claim-register.md
git commit -m "site: complete DTA launch quality review"
```

## Post-launch Phase 9 promotion

Phase 9 implementation may continue after launch. When it is solid and verified:

1. export the platform from its verified implementation commit;
2. replace `composable-bank/` only through the platform's documented export process;
3. compare actual outputs with the locked design;
4. update claim statuses from Blueprint or Specified only where evidence supports promotion;
5. rerun the build, boundary, voice, route, and provenance checks;
6. publish the status update as a separate, evidence-led change.

# DTA Messaging Map

> One screen of the site's words — the review/comment surface for messaging tweaks. **Not the build source** (pages stay as HTML). Comment inline here or in chat referencing `page · section`.
>
> **Tags:** **[web]** = edit the Jekyll file directly · **[proto]** = copy lives in the prototype `packages/ui-showcase/src/propositions.ts` → edit there, rebuild, republish `/composable-bank/` · **[data]** = centralised in `_data/copy.yml` (edit once, propagates).
>
> **Consistency backstops:** vocabulary → `docs/lexicon.md`; claims → `docs/claim-register.md`; repeated strings → `_data/copy.yml`. Cross-cutting edits: change `_data`/lexicon once, then I grep-verify before deploy.

## Shared / cross-cutting [data]
- **Calendly CTAs** — `_data/copy.yml › calendly` + `_includes/cta-calendly.html`. Strategy-call slug `…/30min`; capability slug `…/capability-blueprint`. Labels in `cta_labels`.
- **Canonical lines** — `_data/copy.yml › canonical`: offer (`Six-week Proposition Blueprint → optional 90-day Proof`), spine (`You cannot be accountable for what you do not control.`), Owned Autonomy, Clean-Room.
- **Nav / footer** [web] `_layouts/corporate.html` — items: Home · Approach · Propositions · Capability Intelligence · Customer Outcomes · Insights · [Book a strategy call]. Footer adds Contact + Policies + (LinkedIn/Medium when configured).

## Home — `index.html` [web]
- **Hero strapline:** "Owned Autonomy · Agentic Squads · Capable Organisations." · **H1:** "Deploy agentic talent now. Own the autonomy that follows." · **sub:** build the squads, organisational capability and operating model to adopt agentic ways of working, then turn that capability into better propositions and new business models. · CTAs: [Book a strategy call] + [See the demonstration].
- **Mission:** "Agents are crossing from advice to action. The real question is whether you can answer for it." → accountable banking.
- **Offer ladder (3):** 1 Agentic Talent & Squads (standalone, simple to consume) · 2 Build & Run Propositions · 3 Owned Autonomy Transformation. Each stands alone.
- **How we work:** Standalone squad can start immediately. Wider change follows Discover (founder-led senior advisory) · Pilot / Glass Tube (light PO+FPE sandbox proof with selected enterprise services, or full-depth organisational slice) · Scale (multiple DBB squads + coaches + Finance/HR/Procurement/Risk/Audit).
- **Operating-model teaser:** "Grow the delivery model with the work" + core scale squad roster (PO · FPE · 2 Engineers · Data Engineer). CTAs: full approach · Capability Intelligence.
- **Showcase band:** "Our Clean-Room Demonstration" + 4-demonstrated/1-blueprint wording + proposition list (links to /composable-bank/*).
- **Insights teaser** (auto from posts) · **Leadership** (bio — sign-off-governed) · closing CTA (`_includes/cta.html`).

## Approach — `approach.html` [web]
- **Hero H1:** "Build the organisation of the future — on purpose." + Owned Autonomy / accountability-sovereignty intro.
- Sections: Architecture-first (5 lenses) · Frameworks (BIAN/SAFe/TOGAF/SFIA/DBB) · **Operating-model diagram** (Discover → Glass Tube pilot, light or full-depth → DBB squads + enablers) · Squad (standalone buying motion; old delivery factory vs small AI-amplified squad; roster + named SFIA skills; fixed-capacity) · Whole-business reorg ("what's really important"; From→To) · Two journeys (incumbent + founder) · Where DTA helps (squad / Glass Tube / transformation) · **Delivery lifecycle** · **Glass Tube** · Proposition→spike.

## Operating Model — `operating-model.html` [web]
- **Hero H1:** "What it really takes to run Owned Autonomy." · Sections: delivery sequence (Discover → Pilot → Scale) · Glass Tube thin slice + SM&CR · PO/FPE readiness ("bring your own road") · transformation backbone (not-a-PMO) · coaching (lean/agentic) · leadership (From→To).

## Capability Intelligence — `capability-intelligence.html` [web]
- **Hero H1:** "Capability intelligence for high-performance squads." · CTA [Discuss a Capability Blueprint] + [See how it works].
- Sections: Why now (WEF 2025, attributed) · Unsolved problem (4) · Two better conversations (demand/evidence) · Lifecycle (Capability Blueprint → Best-fit Squad → Managed Capability Cycle) · Two applications · **Worked example** (synthetic; provenance labels Generated/Derived/Future) · Trusted structure (SFIA; SFIA-10) · AI-assisted (privacy line) · Expansion · CTA ("what to bring").

## Customer Outcomes — `customer-outcomes.html` [web]
- **Hero H1:** "Test agentic journeys before you build them." · Repositioned from a principles page to a **pre-delivery proving ground**: use the prototype to test whether a proposition is likely to deliver good outcomes before the bank commits to build.
- **The differentiator (lead):** the prototype already runs **agents under C3 controls with evidence recorded**, so it tests the part no focus group can reach — what agentic action does to consumer outcomes (agent-action comprehension, consent and control, intervention and override). Generic consumer testing only sees screens; this sees the agent.
- Sections: problem (outcomes evidenced too late) · **the new question agents create** · proving ground (not a principles page) · what a run would look like (5 stages) · what a run measures (6 general lenses + 3 agentic lenses + misunderstanding heatmap) · outputs (focus-group evidence, risk log, design changes, board pack) · CTA "Bring a proposition you are about to build".
- **Honesty (critical):** the prototype is a **working platform, in use on this site** (Family Wealth, agent actions + approval gates + recorded evidence, synthetic data). It is a **proving ground by design: test consumers only, never real customers, not production** — "non-production" is the intent, so do NOT under-sell it as vapour/blueprint either. Outcome-capture/heatmap is **configured & extended per engagement** (no off-the-shelf "Lab"). **Output = vendor-neutral working specification** for the client's chosen vendor/build (DTA upstream of implementation). Demo script: `docs/demo-script-customer-outcomes-lab.md`.
- **Governance:** Consumer Duty = FCA external, attribute only, **never imply DTA certifies compliance** — `claim-register.md` §D + material-claims table.

## Post — "Test, Learn, Evidence: Consumer Duty When Agents Act and Money Moves in Tokens" [blog]
- `_posts/2026-06-18-consumer-duty-test-learn-evidence-agents-tokens.md`. Thesis: the Duty is a test→learn→evidence **loop**; banks run it as 3 disconnected, late activities; **agents** change *what* you test (the agent's action, not the screen) and **tokens** change *what's at stake* (speed, finality, programmability). FCA now supervises for outcomes → needs now.
- Drives to `/customer-outcomes/` proving ground. Honesty: platform **working/in-use** (synthetic, **test consumers, non-production by design**); outcome-capture configured/extended per engagement; tokenised rail added per engagement; **output = vendor-neutral working spec** for client's chosen vendor. Tokenisation = FCA/BoE proposed regime, attributed, **not settled law, no limit numbers**. No compliance certification. Governance: `claim-register.md`.

## Connect — `connect.html` [web]
- H1 "Book a strategy call" + Calendly + secondary contact form (→ `/success/`).

## Propositions — `/composable-bank/*` [proto]
> Copy lives in `propositions.ts` (prototype). Edits → rebuild showcase → republish. Each: title · audience · trigger · commercialOutcome · 4 outcomes · 5 proof steps · bankChanges · platformCapabilities · buildingBlocks · blueprintStart.
- **Showcase nav** (`ui-showcase/src/App.tsx › SiteHeader`): Propositions · Platform · **Data Products** · **Resilience** · Engagement · [Discuss a blueprint]. Content pages (Platform, Data Products, Resilience) are React components in `App.tsx`, routed via `site.ts` + `scripts/build-routes.mjs`. Diagrams are **Mermaid** (DTA-themed, CDN-lazy, via `src/Mermaid.tsx`).
- Family Wealth Hub (live) · Premium Yacht Portfolio (live) · International Student Banking (live) · **Cross-Border Real-Time Payments** (live; claim = "real-time cross-border payment *experience*") · Franchise Network Operations (**blueprint**) · Platform · Resilience.
- **Platform** (`/composable-bank/platform/`) — "One governed operating architecture you can interrogate." CTO/Head-of-Eng audience. **Product-first inversion centerpiece** (engines are plug-ins on governed products; governed operational data mesh) · C3 + reference-architecture + core-bank-sync **Mermaid diagrams** · BDAT + engines · money model made vivid (4 concepts open, not collapsed) · Live/Substantiated/Blueprint honesty band · architecture-briefing CTA (validation dimensions, not the stack). **Control-plane pluggability wedge (NEW):** name the bank-owned **sovereign control plane** as the stable core, and make plug-in/swap/revoke explicit — rails (FPS/SEPA Inst/RTGS/ISO 20022/future CBDC), identity/credential schemes (ARC), liquidity proofs and engines all **plug in as versioned ABBs**. This is where C3 currently lands but pluggability does *not* read. Claims in `claim-register.md` §I (control-plane row).
- **Resilience** (`/composable-bank/resilience/`) — "Resilience you can prove. Sovereignty you keep." CISO/COO/CTO audience. Op-resilience frame (PS21/3, SS1/21, DORA) · zero-trust (NIST 800-207) + gateway **Mermaid** · mandate/authority registry · **self-monitoring/self-diagnosing platform (BLUEPRINT)** + blast-radius **Mermaid** · sovereignty · honesty band · CTA. **Control-plane operator wedge (NEW):** the page already ships "the bank, not a vendor's control plane" — promote it to a named section: *who operates the control plane* = protocol sovereignty (no operator) vs organisational sovereignty (the bank operates it; authorise/evidence/revoke). Claims in `claim-register.md` §I (control-plane row).
- **Data Products** (`/composable-bank/data-products/`) — "Data Products for Agentic Banking." CDO / data-office audience. **Concrete-first:** Hero (no product name) · **worked example** (one Family Wealth contribution: microdata vs governed trace + 6-step trace) · **Authority-facet zoom** (composition) · why it's a data product (3) · TFM drill-in (infer-vs-record, generic — NVIDIA name-drop removed) · **CDO + DCAM + 4 data-office roles** (CDO/Data Owner/Steward/Custodian; CISO dropped) · **illustrative catalogue (6, labelled)** · DBB/ABB/BIAN · engines (6) · see-it-in-motion → Family Wealth · closing CTA. Claims governed in `claim-register.md` §H. **Shape, never schema.**

## Insights — `insights.html` + `_posts/*.md` [web]
- Listing page intro + per-post (title/excerpt/body). Flagship: DBB paper; Cross-border ("the real prize is the deposit"); **Data Products for Agentic Banking** (2026-06-16 — TFM as external anchor; the governed data product is the missing unit; links to `/composable-bank/data-products/`); **The Self-Diagnosing Bank** (2026-06-16 — operational resilience as architecture; PS21/3/DORA; blast-radius; links to `/composable-bank/resilience/`).

## Policy — `policy-documentation.html` [web]
- Modern Slavery · Privacy.

---
### How to comment
- Page-specific: e.g. *"Approach · Hero H1: change to …"*.
- Cross-cutting: e.g. *"Everywhere 'strategy call' → 'discovery call'"* → I update `_data/copy.yml`/lexicon once + grep-verify.
- Proposition copy: mark **[proto]** — routes through the prototype build.

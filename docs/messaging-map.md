# DTA Messaging Map

> One screen of the site's words — the review/comment surface for messaging tweaks. **Not the build source** (pages stay as HTML). Comment inline here or in chat referencing `page · section`.
>
> **Tags:** **[web]** = edit the Jekyll file directly · **[proto]** = copy lives in the prototype `packages/ui-showcase/src/propositions.ts` → edit there, rebuild, republish `/composable-bank/` · **[data]** = centralised in `_data/copy.yml` (edit once, propagates).
>
> **Consistency backstops:** vocabulary → `docs/lexicon.md`; claims → `docs/claim-register.md`; repeated strings → `_data/copy.yml`. Cross-cutting edits: change `_data`/lexicon once, then I grep-verify before deploy.

## Shared / cross-cutting [data]
- **Calendly CTAs** — `_data/copy.yml › calendly` + `_includes/cta-calendly.html`. Strategy-call slug `…/30min`; capability slug `…/capability-blueprint`. Labels in `cta_labels`.
- **Canonical lines** — `_data/copy.yml › canonical`: offer (`Six-week Proposition Blueprint → optional 90-day Proof`), spine (`You cannot be accountable for what you do not control.`), Owned Autonomy, Clean-Room.
- **Nav / footer** [web] `_layouts/corporate.html` — items: Home · Approach · Propositions · Capability Intelligence · Insights · [Book a strategy call]. Footer adds Policies + (LinkedIn/Medium when configured).

## Home — `index.html` [web]
- **Hero strapline:** "Owned Autonomy · Agentic Squads · Capable Organisations." · **H1:** "Deploy agentic talent now. Own the autonomy that follows." · **sub:** build the squads, organisational capability and operating model to adopt agentic ways of working, then turn that capability into better propositions and new business models. · CTAs: [Book a strategy call] + [See the demonstration].
- **Mission:** "Agents are crossing from advice to action. The real question is whether you can answer for it." → accountable banking.
- **Offer ladder (3):** 1 Agentic Talent & Squads (standalone, simple to consume) · 2 Build & Run Propositions · 3 Owned Autonomy Transformation. Each stands alone.
- **How we work:** Standalone squad can start immediately. Wider change follows Discover (founder-led senior advisory) · Pilot / Glass Tube (light PO+FPE sandbox proof with selected enterprise services, or full-depth organisational slice) · Scale (multiple DBB squads + coaches + Finance/HR/Procurement/Risk/Audit).
- **Operating-model teaser:** "Grow the delivery model with the work" + core scale squad roster (PO · FPE · 2 Engineers · Data Engineer). CTAs: full approach · Capability Intelligence.
- **Showcase band:** "Our Clean-Room Demonstration" + 4-live/1-blueprint wording + proposition list (links to /composable-bank/*).
- **Insights teaser** (auto from posts) · **Leadership** (bio — sign-off-governed) · closing CTA (`_includes/cta.html`).

## Approach — `approach.html` [web]
- **Hero H1:** "Build the organisation of the future — on purpose." + Owned Autonomy / accountability-sovereignty intro.
- Sections: Architecture-first (5 lenses) · Frameworks (BIAN/SAFe/TOGAF/SFIA/DBB) · **Operating-model diagram** (Discover → Glass Tube pilot, light or full-depth → DBB squads + enablers) · Squad (standalone buying motion; old delivery factory vs small AI-amplified squad; roster + named SFIA skills; fixed-capacity) · Whole-business reorg ("what's really important"; From→To) · Two journeys (incumbent + founder) · Where DTA helps (squad / Glass Tube / transformation) · **Delivery lifecycle** · **Glass Tube** · Proposition→spike.

## Operating Model — `operating-model.html` [web]
- **Hero H1:** "What it really takes to run Owned Autonomy." · Sections: delivery sequence (Discover → Pilot → Scale) · Glass Tube thin slice + SM&CR · PO/FPE readiness ("bring your own road") · transformation backbone (not-a-PMO) · coaching (lean/agentic) · leadership (From→To).

## Capability Intelligence — `capability-intelligence.html` [web]
- **Hero H1:** "Capability intelligence for high-performance squads." · CTA [Discuss a Capability Blueprint] + [See how it works].
- Sections: Why now (WEF 2025, attributed) · Unsolved problem (4) · Two better conversations (demand/evidence) · Lifecycle (Capability Blueprint → Best-fit Squad → Managed Capability Cycle) · Two applications · **Worked example** (synthetic; provenance labels Generated/Derived/Future) · Trusted structure (SFIA; SFIA-10) · AI-assisted (privacy line) · Expansion · CTA ("what to bring").

## Connect — `connect.html` [web]
- H1 "Book a strategy call" + Calendly + secondary contact form (→ `/success/`).

## Propositions — `/composable-bank/*` [proto]
> Copy lives in `propositions.ts` (prototype). Edits → rebuild showcase → republish. Each: title · audience · trigger · commercialOutcome · 4 outcomes · 5 proof steps · bankChanges · platformCapabilities · buildingBlocks · blueprintStart.
- **Showcase nav** (`ui-showcase/src/App.tsx › SiteHeader`): Propositions · Platform · **Data Products** · Engagement · [Discuss a blueprint]. Content pages (Platform, Data Products) are React components in `App.tsx`, routed via `site.ts` + `scripts/build-routes.mjs`.
- Family Wealth Hub (live) · Premium Yacht Portfolio (live) · International Student Banking (live) · **Cross-Border Real-Time Payments** (live; claim = "real-time cross-border payment *experience*") · Franchise Network Operations (**blueprint**) · Platform ("One platform, many propositions").
- **Data Products** (`/composable-bank/data-products/`) — "Data Products for Agentic Banking." CDO/CISO audience. Hero · audience strip · the shift · CDO/CISO · operational test (6) · **illustrative catalogue (6, labelled)** · DBB/ABB/BIAN · engines (6) · see-it-in-motion → Family Wealth · closing CTA. Claims governed in `claim-register.md` §H.

## Insights — `insights.html` + `_posts/*.md` [web]
- Listing page intro + per-post (title/excerpt/body). Flagship: DBB paper; Cross-border ("the real prize is the deposit"); **Data Products for Agentic Banking** (2026-06-16 — TFM as external anchor; the governed data product is the missing unit; links to `/composable-bank/data-products/`).

## Policy — `policy-documentation.html` [web]
- Modern Slavery · Privacy.

---
### How to comment
- Page-specific: e.g. *"Approach · Hero H1: change to …"*.
- Cross-cutting: e.g. *"Everywhere 'strategy call' → 'discovery call'"* → I update `_data/copy.yml`/lexicon once + grep-verify.
- Proposition copy: mark **[proto]** — routes through the prototype build.

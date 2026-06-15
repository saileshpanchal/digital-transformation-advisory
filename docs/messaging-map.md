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
- **Hero H1:** "Deploy agentic talent now. Own the autonomy that follows." · **sub:** accountable + sovereign = Owned Autonomy; deploy squads now or transform the bank. · CTAs: [Book a strategy call] + [See the demonstration].
- **Mission:** "Agents are crossing from advice to action. The real question is whether you can answer for it." → accountable banking.
- **Offer ladder (3):** 1 Agentic Talent & Squads · 2 Build & Run Propositions · 3 Owned Autonomy Transformation. (each: blurb + 3 bullets + engagement note + CTA)
- **How we work:** Discover · Pilot · Scale.
- **Operating-model teaser:** "Built by squads, not committees" + squad roster (PO · FPE · 2 Engineers · Data Engineer) + SFIA/SFIA-10 line. CTAs: full approach · Capability Intelligence.
- **Showcase band:** "Our Clean-Room Demonstration" + 3-live/1-blueprint wording + proposition list (links to /composable-bank/*).
- **Insights teaser** (auto from posts) · **Leadership** (bio — sign-off-governed) · closing CTA (`_includes/cta.html`).

## Approach — `approach.html` [web]
- **Hero H1:** "Build the organisation of the future — on purpose." + Owned Autonomy / accountability-sovereignty intro.
- Sections: Architecture-first (5 lenses) · Frameworks (BIAN/SAFe/TOGAF/SFIA/DBB) · **Operating-model diagram** (Mermaid) · Squad (roster + named SFIA skills, no levels; FPE; forward-deployed unit; fixed-capacity) · Whole-business reorg ("what's really important"; From→To) · Two journeys (incumbent + founder) · Where DTA helps · **Delivery lifecycle** (Proposition → Capability Blueprint → Squad formation → Glass Tube proof → Evidence-led growth) · **Glass Tube** (proving method) · Proposition→spike (Clean-Room; CTAs).

## Operating Model — `operating-model.html` [web]
- **Hero H1:** "What it really takes to run Owned Autonomy." · Sections: thin-slice + SM&CR · readiness ("bring your own road") · transformation backbone (not-a-PMO) · coaching (lean/agentic) · leadership (From→To).

## Capability Intelligence — `capability-intelligence.html` [web]
- **Hero H1:** "Capability intelligence for high-performance squads." · CTA [Discuss a Capability Blueprint] + [See how it works].
- Sections: Why now (WEF 2025, attributed) · Unsolved problem (4) · Two better conversations (demand/evidence) · Lifecycle (Capability Blueprint → Best-fit Squad → Managed Capability Cycle) · Two applications · **Worked example** (synthetic; provenance labels Generated/Derived/Future) · Trusted structure (SFIA; SFIA-10) · AI-assisted (privacy line) · Expansion · CTA ("what to bring").

## Connect — `connect.html` [web]
- H1 "Book a strategy call" + Calendly + secondary contact form (→ `/success/`).

## Propositions — `/composable-bank/*` [proto]
> Copy lives in `propositions.ts` (prototype). Edits → rebuild showcase → republish. Each: title · audience · trigger · commercialOutcome · 4 outcomes · 5 proof steps · bankChanges · platformCapabilities · buildingBlocks · blueprintStart.
- Family Wealth Hub (live) · Premium Yacht Portfolio (live) · International Student Banking (live) · **Cross-Border Real-Time Payments** (live; claim = "real-time cross-border payment *experience*") · Franchise Network Operations (**blueprint**) · Platform ("One platform, many propositions").

## Insights — `insights.html` + `_posts/*.md` [web]
- Listing page intro + per-post (title/excerpt/body). Flagship: DBB paper; Cross-border ("the real prize is the deposit").

## Policy — `policy-documentation.html` [web]
- Modern Slavery · Privacy.

---
### How to comment
- Page-specific: e.g. *"Approach · Hero H1: change to …"*.
- Cross-cutting: e.g. *"Everywhere 'strategy call' → 'discovery call'"* → I update `_data/copy.yml`/lexicon once + grep-verify.
- Proposition copy: mark **[proto]** — routes through the prototype build.

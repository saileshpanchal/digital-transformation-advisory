# DTA Website — Claim Register

**Purpose.** Every material claim the public website makes must be honest. This register is the single source of permitted wording for **website copy** (Home, Approach, Showcase links, Insights). No copy ships a claim that is not listed here with an approved status and wording.

**Authority split.** The authoritative audit of *what the demonstrator actually does* is the prototype's own **`docs/marketing-claim-audit.md`** (maintained alongside the demonstration). This register does **not** duplicate it — for any demo-capability claim, defer to that audit and the **"Interactive demo" / "Blueprint" badges** in the showcase. This register governs the **website-specific** claims the audit doesn't cover: the spine vocabulary, market/macro facts, industry-context citations, track record, and boundary rules.

**Metadata.** Verification date: **2026-06-14** · Register owner: DTA (Sailesh) · Demo-audit owner: the demonstrator/marketing stream.

**Status taxonomy.** *Substantiated* (backed by code that runs in tests or the demonstration) · *Partial* (mechanism narrower than the words) · *Aspirational/Blueprint* (described, not implemented — must be labelled) · *External* (third-party fact — attribute, never imply as DTA's) · *Needs-source* / *Needs-sign-off* / *Needs-trademark-check* (cannot ship until resolved here).

**Framing principle (avoid "live").** DTA produces consulting and architecture prototypes, not production solutions. Public copy says we **demonstrate** four propositions (interactive demonstrations) and present one **blueprint** (Franchise Network). Never "live engine", "runs live", or wording that implies production. Use "interactive demonstration", "demonstrated", "prototype", and the "Interactive demo" badge.

---

## Material-claims tracking (v5 schema)

Each material claim is tracked by: **source** (repo + commit/file, or external URL) · **owner** · **approval status** · **expiry** (re-verify by) · **pages using it** · **status**. Default expiry is quarterly; demo-capability rows expire whenever the prototype `marketing-claim-audit.md` changes.

| Claim | Source (repo + commit / file) | Owner | Approval | Expiry | Pages using | Status |
|---|---|---|---|---|---|---|
| 4 propositions as interactive demonstrations (Family Wealth, Int. Student, Premium Yacht, Cross-Border); Franchise = blueprint | prototype `marketing-claim-audit.md` (feat/live-marketing-demos) | demo/marketing stream | Approved | on audit change | index, approach, /composable-bank/ | Substantiated (interactive demonstration) |
| Cross-Border Real-Time Payments — interactive demonstration proposition (EUR→GBP inbound; B2B SME lead, multinational variation; **public-safe copy only** — no FXC/$27tn/proposed-stablecoin/"few banks" claims). **Claim softened (fact-check 2026-06-15):** promise is a "real-time cross-border payment *experience*" (pre-funded local accounts + domestic instant rails + API initiation), not universal end-to-end instant settlement — OCT Inst governs the euro leg only; FPS is a pre-funded settlement model. | prototype `dbb-crossborder-payment` + `runtime-crossborder` (tests green); `marketing-claim-audit.md` #7/#8/#10; EPC/BoE/FCA per the proposition doc | demo stream | Approved | on audit change | composable-bank/cross-border-payments, index, approach | Substantiated — interactive demonstration (prototype) (simulated FX/settlement feeds) |
| "Clean-Room Demonstration" — a **working proving-ground platform**: production-grade in design, on synthetic data, **deliberately non-production / never real customers** (test consumers only); purpose = prove propositions → **vendor-neutral working specification**. **Retire "not yet product-ready"** (mis-frames a working tool for a non-production purpose as an unfinished product chasing production). | this repo `index.html`, `approach.html`, `consumer-outcomes.html`, `_data/copy.yml` | DTA | Approved | 2026-09-18 | index, approach, consumer-outcomes | Substantiated (wording) |
| Agents prepare; humans approve material actions; evidence per step | prototype `agentic-gateway` tests | demo stream | Approved | on audit change | index, approach | Substantiated |
| Owned Autonomy / C3 / Accountability–Sovereignty / Clean-Room Standard / Glass Tube / DBB | `docs/lexicon.md` | DTA | Approved (DTA-original) | 2026-09-14 | index, approach, operating-model, posts | Coin & own |
| SFIA-defined, FPE-led squad (skill *names*, no levels) | `docs/squad-operating-model.md` (sanitised) | DTA | Approved | 2026-09-14 | index, approach | Substantiated (sanitised) |
| SFIA 10 contributor; SFIA use properly licensed; SFIA® trademark | SFIA Foundation relationship | Sailesh | Approved | 2026-12-31 | approach, capability-intelligence | External — sourced |
| Capability Intelligence — outcome positioning ("high-performance squads"; brief→evidence→squad→growth); SFIA codes invisible | spec 2026-06-14; SFiA-AI engine | DTA | Approved | 2026-09-14 | capability-intelligence | Substantiated (capability + wording) |
| Capability Intelligence worked example | synthetic; SFiA-AI engine (extraction/evidence/gaps/collaborators Generated/Derived; collaboration-optimised composition + Managed Cycle = Illustrative future) | DTA | Approved (labelled synthetic + provenance) | 2026-09-14 | capability-intelligence | Substantiated with provenance labels |
| WEF Future of Jobs 2025 (63% skill gaps / 85% upskilling) | weforum.org | Sailesh | Attribute only | 2026-09-14 | capability-intelligence | External — sourced |
| Privacy — "sensitive client, candidate and employee information can be processed on device or within a controlled environment" | DTA delivery capability (governed AI; on-device/controlled-env) | DTA | Approved (capability statement; no infra/security-tier detail) | 2026-09-14 | capability-intelligence | Substantiated (capability statement) |
| Two Blueprints distinct (Proposition Blueprint = offer; Capability Blueprint = work-product) | `docs/lexicon.md` | DTA | Approved | 2026-09-14 | approach, capability-intelligence, index | Coin & own |
| SFIA tools (SFiA-AI / jobfinder / recruitment) status | repos; jobfinder app "coming soon", recruitment pitch-stage | Sailesh | **No public product links yet** | 2026-09-14 | (none) | Not linked |
| ~~"none are built on SFIA" market claim~~ | — | — | **Removed** (unsubstantiable) | — | (none) | Deleted v6 |
| Track record + **TSB role** (CTO & Payments/Economic Crime Director; MRT 5 IBS; Evolve: £20m+ savings, ~25% IT-change-cost cut, quarterly→monthly, £6.8m fraud reduction, +30% intl-payments revenue) + Metro/Lloyds/JPM/Travelex/Orwell | **CV + NED cover letter (2026-06-15)** | Sailesh | **Approved (from CV/cover letter)** | 2026-12-31 | index | Approved |
| ipagoo (Orwell) — first cloud-first FCA/ACPR-regulated EMI on AWS/Azure; 2018 FIA Award | CV (2026-06-15) | Sailesh | **Approved (from CV)** — public-safe wording; no failure history | 2026-12-31 | index | Approved |
| "The Accountable Bank" as a brand | — | Sailesh | **Needs-trademark-check** | — | (none; use "Clean-Room Demonstration") | Needs-TM |
| Market/macro facts (2028 repricing, FXC sizing, FCA/BoE) | external + prototype thesis (marked external) | Sailesh | Attribute only; FXC needs licence | 2026-09-14 | (posts, attributed) | External |
| Consumer Outcomes page (was Customer Outcomes; `/customer-outcomes/` 301s to `/consumer-outcomes/`) — **advocacy-led** (banking should work for the people it is easiest to exclude; outcomes designed in, not evidenced after harm), then advisory + the **proving ground**; differentiator = testing **agentic** impact on consumer outcomes (agent under C3 controls + evidence). **Platform is WORKING and in use on this site** (Family Wealth, agent-propose/human-approve, recorded evidence on synthetic data). **Proving ground by design: test consumers only, never real customers, not a production system** (so "non-production" is the design, not a gap — do not under-sell as vapour). Outcome-capture/heatmap **configured & extended per engagement**. **Output = vendor-neutral working specification** the client takes to their chosen vendor/build (DTA sits upstream of implementation, not competing with it). A Place to Start = **Blueprint**. *consumer* for advocacy/market-wide, *customer* only for a specific bank-customer relationship or quoted FCA source. FCA Consumer Duty = external/attribute. | FCA (external) + working demonstration platform (substantiated) | DTA | Approved — platform live-for-purpose (non-production, test consumers); capture configured/extended per engagement; agentic claims anchored on FW demo; **no compliance certification** | 2026-09-18 | consumer-outcomes; `docs/demo-script-customer-outcomes-lab.md` | Substantiated platform + external Duty |

---

## A. Demonstrator capability — DEFER to `marketing-claim-audit.md`

As of 2026-06-14 the demonstration backs more than it used to. **Do not restate demo capability from memory** — pull current status from the prototype audit and the on-page badges. Summary the website may rely on:

| Proposition | Status | Website may say | Review |
|---|---|---|---|
| Family Wealth Hub | **Substantiated — interactive demonstration (prototype)** (mock external feeds) | "an interactive demonstration" | 2026-06-14 |
| International Student Banking | **Substantiated — interactive demonstration (prototype)** (mock external feeds) | "an interactive demonstration" | 2026-06-14 |
| Premium Yacht Portfolio | **Substantiated — interactive demonstration (prototype)** (mock external feeds) | "an interactive demonstration" | 2026-06-14 |
| Cross-Border Real-Time Payments | **Substantiated — demonstrated with labelled mocks** (EUR→GBP inbound; claims #7/#8/#10 in the prototype audit revised) | "demonstrated, with simulated external feeds" | 2026-06-14 |
| Franchise Network Operations | **Blueprint** (honestly labelled) | "a design blueprint" | 2026-06-14 |

Rule: external feeds are **simulated** (FX, settlement, valuation, card) — say "simulated/mock external feeds," and "a recorded entitlement, not a card processor." Cards = recorded entitlement only.

---

## B. Platform & architecture claims (website wording)

| Claim | Status | Permitted website wording | Review |
|---|---|---|---|
| Agents prepare; humans approve material actions; everything leaves evidence | **Substantiated** (agentic-gateway HITL gate, tested) | "Agents prepare; a human approves every material action; each step leaves evidence — demonstrated in our prototype." | 2026-06-14 |
| Common-platform architecture (one engine, many propositions) | **Substantiated (narrowed)** — several propositions now run on one engine | "One governed engine carrying multiple propositions — four are interactive demonstrations, with one as a blueprint." | 2026-06-14 |
| Tokenised deposit with 1:1 backing | **Substantiated** | State plainly. | 2026-06-14 |
| ISO 20022 / Faster Payments on the same engine | **Substantiated** (standalone + cross-border inbound) | "ISO 20022 messaging on the same engine." | 2026-06-14 |
| Prototype as a **standards-based working specification** (portable / reusable) | **DTA framing on a standards base** — ISO 20022 Substantiated; BIAN "structured around"; control frameworks (NIST 800-207, OWASP LLM, BCBS 239, DCAM) **External, attribute only** | "expressed in open standards… portable and reusable, vendor-neutral". Reuse argument = standards are the shared vendor language. **Never claim certification/conformance** to any framework; "expressed in / structured around / aligned to" only. | 2026-09-18 |
| Demonstrations use simulated services, no live customer money | **Substantiated** | Keep this disclaimer visible (the Clean-Room Demonstration Standard). | 2026-06-14 |
| **Performance envelope / robustness** — where the prototype breaks; "useful level for a few concurrent users" | **Measured evidence (when run), not a live-platform claim** — harness in `perf/` | Layer A = the demonstration (render/memory/jank); Layer B = a build of the spec (latency/concurrency), NOT the demo or marketing site. Report numbers as session limits / achievable-shape NFRs for the working spec. **No production-SLA or scale claims.** Scope today = a few concurrent users (robustness, not scale). | 2026-09-18 |

---

## C. The offer (reused site-wide)

| Claim | Status | Permitted wording | Review |
|---|---|---|---|
| Offer ladder: Talent & Squads → Build & Run Propositions → Owned Autonomy Transformation | **Engagement model** | Describe as engagement shapes; lead with talent for the fast path. Hold the premium ("control-grade, not body-shop"); do not read as staff-aug. | 2026-06-14 |
| Six-week Proposition Blueprint → optional 90-day Proof | **Substantiated as advisory offer** (self-qualified) | Keep the qualifier: advisory and decision-oriented; not a claim a production platform is built in six/ninety days. | 2026-06-14 |
| Advisory IP model — client builds their own blueprint; DTA model/method/reference architecture stay DTA IP | **Engagement model** (per `squad-operating-model.md`) | "You keep the capability; our opinionated model stays our IP." | 2026-06-14 |

---

## D. Market / macro claims (EXTERNAL — attribute, never imply as DTA's own)

| Claim | Status | Permitted wording | Review |
|---|---|---|---|
| 2028 profit-pool repricing; 9% / $170bn at risk; Lloyds/NatWest/JPMorgan/HSBC facts | **External** (the thesis note marks these as external, not prototype outputs) | Always attributed ("McKinsey estimates…", "Lloyds settled…"). | 2026-06-14 |
| Cross-border market sizing (FXC: $208tn flows / $625bn revenue) | **External — licence required** | Do not reproduce FXC figures/chart without an FXC licence; paraphrase-with-attribution only. See the cross-border proposition's claims table. | 2026-06-14 |
| "feedback window closed 3 July 2026" | **DATE DEFECT** | ❌ Future date written as past. Use "closes 3 July 2026" or omit. | 2026-06-14 |
| FCA/BoE tokenisation vision (20 May 2026); UK stablecoin limits (£20k/£10m, 40/60 backing) | **Needs-source / proposed-not-law** | Cite primary FCA/BoE source; never state proposed numbers as settled. | 2026-06-14 |
| Post "Test, Learn, Evidence" — FCA 2026 supervision-led posture; consumer-understanding + board-report findings; FCA/BoE tokenisation vision (May 2026); FCA stablecoin sandbox (4 firms); tokenised-deposit pilots; finality/programmability | **External — attribute + proposed-not-law** (FCA/BoE) | Primary FCA/BoE links only. Stablecoin/tokenisation regime = **proposed/developing, not settled retail law**; **no backing-ratio or limit numbers** in copy. Agentic claims anchored on Family Wealth demo (synthetic); outcome-capture + tokenised rail = blueprint. **No compliance certification.** | 2026-09-18 |
| **FCA Consumer Duty** — deliver good outcomes for retail customers; monitor and evidence outcomes; the four outcomes (products & services, price & value, consumer understanding, consumer support); vulnerable customers | **External — attribute only** (FCA) | "an FCA framework"; the four outcomes are the FCA's. **Never imply DTA certifies/guarantees compliance** — DTA helps deliver and evidence outcomes. Avoid precise rule numbers / in-force dates in copy unless primary-sourced. | 2026-09-18 |

---

## E. Approach-page industry-context claims

| Claim | Status | Permitted wording | Review |
|---|---|---|---|
| Forward Deployed Engineer (FDE), Palantir-origin | **External — sourced** ([Palantir blog](https://blog.palantir.com/a-day-in-the-life-of-a-palantir-forward-deployed-software-engineer-45ef2de257b1); [Wikipedia](https://en.wikipedia.org/wiki/Forward_Deployed_Engineer)) | Cite as industry context, not a DTA brand. | 2026-06-14 |
| IBM Forward Deployed Unit (FDU): humans at the edges, agents in the middle, under human direction | **External — sourced** ([IBM Newsroom, 14 May 2026](https://newsroom.ibm.com/2026-05-14-A-New-Way-to-Make-AI-Actually-Work-in-the-Real-World); [IBM Think](https://www.ibm.com/think/insights/conversation-forward-deployed-engineers-incomplete)) | Attribute to IBM; never as a DTA capability. | 2026-06-14 |

---

## F. Spine & lexicon terms (see `docs/lexicon.md`)

| Term | Status | Permitted wording / rule | Review |
|---|---|---|---|
| **Owned Autonomy** | **DTA original — coin & own** | Lead term: "agentic capability a bank owns rather than rents — accountable and sovereign." | 2026-06-14 |
| **C3 (Capability · Context · Consent)** | **DTA original — coin & own** | Reference architecture; DBB = the Capability plane. | 2026-06-14 |
| **The Accountability–Sovereignty Principle** | **DTA original — coin & own** | "You cannot be accountable for what you do not control." | 2026-06-14 |
| **Clean-Room Demonstration Standard** | **DTA original — coin & own** | The honesty discipline: isolated, synthetic data, production-grade controls, explicitly non-production. Always "a demonstration, not production." Frame non-production as **by design / purpose** (a working proving ground), NOT as an unfinished product — **never "not yet product-ready".** Purpose: prove propositions with test consumers → a vendor-neutral working specification. | 2026-06-14 |
| **DBB (Domain Building Block)** | **DTA original** | A reusable banking capability (journey + policy + controls + evidence + execution); sits alongside TOGAF's ABB. | 2026-06-14 |
| **"accountable banking"** | **Catch-phrase — pre-trademark** | Use freely (lowercase) across posts and site to build mindshare; trademark later. | 2026-06-14 |
| "agentic banking" / "agent-ready banking" (Zafin) / "autonomous finance" etc. | **Descriptor-only** | Use to be understood; never claim as DTA coinage. | 2026-06-14 |
| **"control plane"** (Ping/SDN/K8s/identity lineage) | **Descriptor — borrow, do not coin** | Never trademark or claim the bare noun. Own the *operator* claim only: "the bank operates its own control plane." DTA's **sovereign / operational control plane** = the bank-operated Consent plane of C3. Pluggability is the wedge (see §I). No "first/only". | 2026-06-18 |
| **"The Accountable Bank"** (proper-noun product name) | **Needs-trademark-check** | ❌ Do not launch as a brand until cleared. The visible demo label is "**our Clean-Room Demonstration**"; keep the `/composable-bank/` slug. | 2026-06-14 |
| Internal architecture codenames | **Off public site** | Kept in private notes / the book only. Banned in this public repo by `scripts/check-public-showcase.sh`. | 2026-06-14 |

---

## G. Credibility / track-record claims

| Claim | Status | Permitted wording | Review |
|---|---|---|---|
| ipagoo (Orwell) — first cloud-first FCA/ACPR EMI on AWS/Azure; 2018 FIA Award | **Approved (from CV, 2026-06-15)** | Public-safe wording on the homepage bio; do not reference the company's wind-down/funding history. | 2026-12-15 |
| TSB role + senior roles (Metro, Lloyds, JPM, Travelex) | **Approved (from CV + NED cover letter, 2026-06-15)** | Homepage bio wording; figures (£20m+, £6.8m, +30%, ~25%) are from Sailesh's own CV. | 2026-12-15 |

---

## H. Data Products page + insights paper (2026-06-16)

Governs `/composable-bank/data-products/` (prototype `ui-showcase`, **[proto]**) and the post `_posts/2026-06-16-data-products-for-agentic-banking.md` (**[web]**).

| Claim | Status | Permitted wording / rule | Review |
|---|---|---|---|
| Ultim8 is a **transaction-based platform** (events/states/permissions/relationships/evidence native) | **Substantiated (narrowed)** — tie to what the demonstration visibly does (event-driven flow, evidence per step) | "a transaction-based platform" / "our reference engine"; do not over-state beyond the demonstrated event-driven behaviour | 2026-09-16 |
| The **governed data product** is the missing unit for agentic banking (ontology + governance of banking data); a transaction-based platform is structurally advantaged at producing it | **DTA original — coin & own** (the argument of the paper) | DTA's own thesis; present as our argument, not industry consensus | 2026-09-16 |
| We have **already built the engine** as proof — Family Wealth runs end-to-end | **Substantiated — interactive demonstration (prototype)** (see §A; defer to `marketing-claim-audit.md`) | "one proposition runs on it end to end"; Family Wealth and three more are interactive demonstrations; Franchise = blueprint | on audit change |
| The six-item **data-product catalogue** (Party & Relationship, Authority & Consent, Transaction Context, Case & Evidence, Intent & Proposition, Exposure & Eligibility) | **Illustrative operating model — LABELLED** | Must carry the on-page disclaimer: "illustrative operating model, not a claim that every product is already live." Show product **shape**, never schema. | 2026-09-16 |
| **Transaction Foundation Models** — a bank's event history becomes one reusable intelligence layer | **External — attribute only** ([NVIDIA](https://blogs.nvidia.com/blog/financial-institutions-transaction-foundation-models/); [Thoughtworks](https://www.thoughtworks.com/en-gb/insights/articles/power-of-transaction-foundation-models-building-the-unified-intelligence-layer-for-payments)) | Always attributed; paraphrase-with-link; **no proprietary figures** (no PRAGMA/Mastercard/Stripe/JPMorgan numbers); never imply NVIDIA/Thoughtworks endorse DTA's approach | 2026-09-16 |
| Data products **structured around DBB / ABB / BIAN** | **DTA original (softened)** | "structured around / designed to align with" — not a finished formal mapping | 2026-09-16 |
| **Event log as source of truth, ledger as projection** (UK payments platform we architected) | **Substantiated — own build (from CV/ipagoo, public-safe)** | Public-safe wording; no company name, no wind-down/funding history; "years ago we architected a UK payments platform…" | 2026-12-16 |
| **Yacht multi-currency vault** (owner sees funds; captain/crew spend under policy) — provenance for proposition-native, policy-bounded actor authority | **Substantiated — own build, ANONYMISED** | Do **not** name the client. "a multi-currency vault we built for a yacht." Maps to the live Premium Yacht demo. | 2026-12-16 |
| New coinages: **Governed Event Spine · Transaction Ontology · Evidence-grade Data Products · Consent-bearing Data · Proposition-native Intelligence** | **DTA original — coin & own** (see `docs/lexicon.md`) | Use sparingly; defined inline on first use | 2026-09-16 |
| **Two data products from one interaction** — the interaction microdata (behavioural signal) + the governed decision trace (intent/authority/proposal/gate/approval/evidence) | **DTA original argument** | Present as our argument. The governed trace is a *higher-supervision, more proprietary* substrate **complementary to** transaction history — **not** "strictly richer" / not a replacement (raw streams still win on volume). | 2026-09-16 |
| **Worked example — shape of one governed object** (a Family Wealth contribution: intent · authority · proposal · gate · approval · evidence, + microdata vs trace) | **Substantiated — SHAPE only** (drawn from the live Family Wealth journey) | Show the **shape and facet names**; illustrative values (e.g. "£250 to Mum's care fund") are synthetic. **Never** the canonical schema, field types, ontology internals or PII mechanics. | 2026-09-16 |
| **Authority facet — composition shown** (an authority assertion = principal · mandate · scope · constraints · provenance · verified-state; contrast with a permission boolean) | **Substantiated — SHAPE only** (illustrative values; conceptual element names, not canonical fields) | Show the **structural point** — authority is an evidenced object carried on the event, not a lookup beside it. Element names are conceptual (generic access-control vocabulary), values synthetic. **Never** canonical field names/types, the gate's evaluation logic (control internals), or how state is verified mechanically. | 2026-09-16 |
| NVIDIA "interprets behavior in context" + midnight-payment example; "language of money movement" (Thoughtworks) | **External — attribute only** (verbatim quotes verified against source) | Quote with link; frame as the argument we drill into, never as endorsement. **Now PAPER-ONLY** (name-drop + midnight example removed from the page 2026-06-16; the page keeps a generic, unattributed infer-vs-record framing). | 2026-09-16 |
| **BCBS 239** Principle 3 — risk data "aggregated on a largely automated basis so as to minimise the probability of errors" | **External — attribute only** ([BIS BCBS d239](https://www.bis.org/publ/bcbs239.htm)) | Quote as the regulatory expectation lineage-by-construction answers; do not imply DTA certifies BCBS 239 compliance | 2026-09-16 |
| **DCAM (Data Management Capability Assessment Model)** — scores data-management maturity on process **and evidence**; banks benchmark against it; maps to BCBS 239 | **External — attribute only** (Enterprise Data Management Council; [DCAM framework](https://edmcouncil.org/frameworks/dcam/)) | "scores process and evidence" / "the model banks benchmark against" — verified claims only. **Do NOT** list v3 component names (member-gated, unverified). Page + paper. | 2026-09-16 |
| **Data-governance role model** — CDO · Data Owner (RDO) · Data Steward · Data Custodian | **External concept (standard governance practice) + DTA framing** | Standard Owner/Steward/Custodian split; the "object each role can hold" framing is ours. Page + paper. | 2026-09-16 |
| **OWASP Top 10 for LLM Applications (2025)** — "excessive agency" (LLM06); "sensitive information disclosure" (LLM02) | **External — attribute only** (OWASP GenAI Security Project) | Name the list and the item; framing is industry context. **Now PAPER-ONLY** (CISO section removed from the page 2026-06-16). | 2026-09-16 |
| **Models can leak training data** — verbatim PII extracted from trained models (Carlini et al., USENIX Security 2021) | **External — attribute only** | "researchers have extracted verbatim personal data from trained models"; no figures, no over-claim. **Now PAPER-ONLY.** | 2026-09-16 |
| **UK GDPR purpose limitation + data minimisation; ICO AI guidance** | **External — attribute only** (ICO) | "UK GDPR requires processing only what's relevant to a declared purpose"; do not give legal advice. **Now PAPER-ONLY.** | 2026-09-16 |
| **Data mesh — operational vs analytical plane; "an agent can't act on a dashboard"** | **External concept (Dehghani/Thoughtworks) + DTA framing** | Attribute the operational/analytical split to data mesh; the "act on, not read" framing is our positioning | 2026-09-16 |
| Data-prep / feature-engineering cost ("much of a data team's time") | **External — handle with care** | ✅ "much of a data team's time"; ❌ **do NOT publish a bare "80%"** (debunked 2016 vendor stat). If a number is ever needed, use Anaconda 2020 ~45%, sourced. | 2026-09-16 |

**Hold back (post-MOU, never in the page or paper):** canonical schemas / field types / canonical objects, ontology internals and diagrams, control maps and control internals (incl. how a gate evaluates and how state is verified), PII-handling mechanics, platform/deploy/engine-composition detail. **Now public (deliberately):** the *shape* of a governed object and its facet names (intent · authority · proposal · gate · approval · evidence); the *composition* of one facet — authority (principal · mandate · scope · constraints · provenance · verified-state), illustrative values, conceptual element names; the two-data-products framing; and the DBB/ABB/BIAN alignment — shape, never schema.

---

## I. Platform + Resilience pages + paper (2026-06-16)

Governs `/composable-bank/platform/` (reworked) and the new `/composable-bank/resilience/` (both
**[proto]**, `ui-showcase`), and the post `_posts/2026-06-16-the-self-diagnosing-bank-...md` (**[web]**).
Audience: CTO / Chief Architect / CISO / COO. All architecture on these pages is **shape, never schema**.

| Claim | Status | Permitted wording / rule | Review |
|---|---|---|---|
| **Product-first inversion** — "engines are built on the products, not the other way round"; engines as thin reasoning layers over governed products | **DTA argument / Design** | The inversion is our architecture. Gateway + one-engine-many-propositions = Substantiated; the full engine set = Blueprint. | 2026-09-16 |
| **"Governed operational data mesh for agentic banking"** (category framing) | **DTA framing extending Dehghani** ([data mesh](https://martinfowler.com/articles/data-mesh-principles.html)) | Attribute the data-mesh concept to Dehghani; frame DTA's extension to operational+governed as ours. **No "first"/"only" superlatives.** | 2026-09-16 |
| Feature-store duplication eliminated (one Party product, all engines query it) | **Design argument** | Present as the architectural consequence; not a measured benchmark | 2026-09-16 |
| **BDAT** views (Business/Data/Application/Technology) + BIAN as the **product boundary contract** | **DTA framing** (TOGAF/BIAN external, standard) | Shape only; engines' "consumes X → focuses on Y" is illustrative | 2026-09-16 |
| **Core-bank sync** — event spine alongside the authoritative core, ISO 20022, shadow-ledger projection, incremental displacement (strangler-fig) | **Blueprint** (ISO 20022 itself Substantiated) | "we do not rip out your core"; pattern name "strangler-fig" only in the diagram caption with a gloss | 2026-09-16 |
| Money concepts — **Programmable payment · Programmable money · Tokenised bank deposit · Shadow ledger** | **Definitions** (tokenised deposit = Blueprint) | Boundaries at conceptual/regulatory level only (e.g. "a regulated liability of the issuing bank, not a bearer instrument") — **never implementation** (no settlement-model leak) | 2026-09-16 |
| **Self-monitoring / self-diagnosing platform** — components/agents self-register to CMDB/ServiceNow (discovery, service mapping, event management, AIOps, self-healing); **service-impact / blast-radius** report (which transactions failed, which customers missed a notification) | **BLUEPRINT** | Phrase as design intent ("designed to…"), never present-tense. Blast-radius figures **illustrative**, label **baked into the Mermaid source**. | 2026-09-16 |
| **Zero-trust** — NIST SP 800-207 (PDP/PEP, least privilege, assume breach); agents as non-human identities; **authority per-action and per-context, not per-role** | **External (NIST) — attribute** + DTA gateway framing | [NIST SP 800-207](https://csrc.nist.gov/pubs/sp/800/207/final); gateway pattern Substantiated, at-scale Blueprint | 2026-09-16 |
| **Mandate / authority registry as a governed product** — lifecycle: issuance · revocation · expiry · delegation | **Design** | "authority on the event is only as trustworthy as the registry behind it"; cross-link Data Products Authority & Consent | 2026-09-16 |
| **Operational resilience** — FCA PS21/3 + PRA SS1/21 (important business services, impact tolerances, mapping, scenario testing; **in force since 31 Mar 2025**); EU **DORA** (**applies since 17 Jan 2025**, incl. critical third-party ICT) | **External — attribute only** ([FCA PS21/3](https://www.fca.org.uk/publications/policy-statements/ps21-3-building-operational-resilience); [DORA](https://www.eba.europa.eu/legal-framework/digital-operational-resilience-act-dora)) | Dates "in force since" (past); **do not imply DTA certifies compliance** | 2026-09-16 |
| **Sovereignty** — residency ≠ data sovereignty ≠ operational sovereignty; key/custody; exit/portability; model sovereignty | **External concepts + DTA framing** | Ties to Accountability–Sovereignty Principle; no specific vendor/jurisdiction legal advice | 2026-09-16 |
| **Sovereign / operational control plane** — the bank operates its own agentic control plane (authorise · evidence · revoke per action); **rails (FPS / SEPA Inst / RTGS / ISO 20022 / future CBDC), identity & credential schemes (e.g. ARC) and liquidity proofs plug in as versioned ABBs**; engines are thin layers over governed products; contrast a *rented vendor/protocol* control plane (= protocol sovereignty, no operator) | **DTA framing** extending an external term-of-art (Ping/SDN/K8s/identity); the **operator claim + pluggability** are DTA's positioning | Borrow "control plane" to be understood; frame the **bank-operated + pluggable** extension as ours. Gateway/HITL + ISO 20022 = **Substantiated**; authority registry, multi-rail and future-rail pluggability = **Design/Blueprint** (say "designed to / plugs in as", never present-tense production). **No "first/only"; demonstrator, not production.** ARC/liquidity proofs are Canon's — attribute, never imply DTA built them. Maps to C3 Consent plane (lexicon §B). | 2026-09-18 |

**Hold back (post-MOU / Architecture Room only — NOT public, via `ARCHITECTURE_URL` email flow):** the
named stream/storage stack (e.g. Kafka/Flink/Iceberg), partition/state/compaction strategy,
schema-registry governance, the **engine build-pattern code**, the **latency/throughput SLA numbers**,
deploy topology, control internals, PII mechanics, canonical schemas, internal codenames. The pages
state the validation **dimensions** (latency budgets, contract versioning, throughput headroom, mandate
write-path, sensitivity inheritance) — **never the values or the stack**.

---

## Pre-publish checklist (gates every copy PR)

1. Every claim maps to a row here (or, for demo capability, to the prototype's `marketing-claim-audit.md`) with a resolved status.
2. Demonstrated propositions carry an "Interactive demo" badge; Franchise carries "Blueprint." (Owned by the showcase build.)
3. No future date is written as past (re-check the 3 July 2026 line).
4. Market facts attributed; FXC figures not reproduced without licence.
5. Run `scripts/check-public-showcase.sh` — zero forbidden-codename hits in the repo and built site; no "for sale" / "production platform" overclaim.

---

## Internal positioning notes (NOT public) — cross-border (fact-check 2026-06-15)

- **PMF (corridor-based, not universal):** High fit = cross-border SMEs with repeat payables/receivables · mid-market multi-entity corporates · **banks/PSPs embedding it** (they monetise the deposits). Medium = large global corporates (incumbents already have local clearing). **Low = retail remittance** (over-built; price/simplicity matter more). Believable promise = "predictable execution on key corridors, with auditability, API control and liquidity I control," not "send money anywhere instantly."
- **Revenue spine (durability order):** NII/float on pre-funded balances → FX spread → platform/SaaS fees (API, treasury controls, reconciliation) → liquidity services (sweeps) → per-txn/corridor fees → compliance value-adds. **Deposit economics is the core, not payment fees.**
- **Differentiator:** the pre-funded-local-rails model is **commoditised** (Banking Circle, Nium, Thunes, Airwallex, Currencycloud). DTA's edge is the **owned, accountable, agentic, deposit-economics** integration — not being first or fastest. The **agentic layer is an enhancer/differentiator, not the primary revenue engine.**
- **Claim discipline:** "real-time cross-border" → "real-time cross-border *experience*"; OCT Inst = euro-leg only; FPS = pre-funded settlement model; FCA CP25/14 = consultation (proposed, not law). (Sources: EPC, BoE, Pay.UK, FCA — per the proposition doc's research.)

---

## Positioning (DTA internal) — what the artifacts substantiate

The demonstrations and this claim register substantiate one positioning: DTA produces an
**independent, vendor-agnostic, executable target architecture** for UK banking, proven on the
hard primitives before any platform commitment. The category claim is sequenced, not adversarial:
*the platform decision comes second*. The aim is at the **bank's pain** (vendor-led architecture,
committing before the hard parts are proven, regulators wanting evidence over assertions), never at
any advisor's deliverable.

The three-legs synthesis is DTA's transferable capability and runs as a quiet connecting thread,
one line per page (Platform / Approach / Capability Intelligence), each cross-linking the others:

> Three parts of one capability: the target architecture (what good looks like, proven), the
> operating model to build it, and the capability intelligence to staff it.

**Claim status:** *substantiated* by the four interactive demonstrations + one blueprint, the claim
register, decision records and the demonstrated-vs-blueprint discipline. It is positioning, not a
product-availability claim; nothing here implies a production platform for sale.

**Discipline (gates public copy):** no superlatives, no pricing, no "top 1%" or "best/leading";
internal codenames never appear in public copy or the built site; "demonstrated, not production"
holds for DTA's own work; the rigour is shown in the artifacts, not asserted. Public surfaces for
the positioning: the Platform page category line + evidence band, and the essay
*Independent Architecture, Proven Primitives: the Platform Decision Comes Second*
(`_posts/2026-06-17-independent-architecture-proven-primitives.md`).

# DTA Lexicon & Spine (source of truth)

The single vocabulary the website, posts and book all draw from. Authority comes from owning the **deeper** terms, not the category umbrella (which others already own). Pairs with the [claim register](claim-register.md) — anything here marked *trademark-check* or *descriptor-only* is governed there before it ships publicly.

## The spine (one line)

> **You cannot be accountable for what you do not control.** Accountability is the obligation; sovereignty is the precondition. The proposition is **Owned Autonomy** — agentic capability a bank *owns* rather than rents, accountable and sovereign by construction.

## Concept hierarchy — each coined term has exactly one job

| Layer | Term | Job |
|---|---|---|
| Thesis | **Owned Autonomy** | Why — accountable + sovereign |
| Commercial offer | **Proposition Blueprint → Proof** | Six-week Proposition Blueprint → optional 90-day Proof (the engagement) |
| People work-product | **Capability Blueprint** | The human + AI capability a proposition/brief needs — a squad work-product *within* the Proposition Blueprint, also available standalone |
| Pilot and proving method | **Glass Tube** | A transparent vertical slice, light or full-depth, that proves the solution and as much of the operating model as the decision requires |
| Architecture | **C3 (Capability · Context · Consent)** | How it fits; DBB = the Capability plane |
| Delivery mechanism | **Capability-Intelligence-informed, SFIA-grounded, FPE-led squads** | A standalone buying motion or the delivery unit for wider change: small, senior and AI-amplified |

**Two Blueprints, never blurred:** *Proposition Blueprint* = the commercial offer/engagement. *Capability Blueprint* = the people/capability work-product inside it (or standalone). Copy must distinguish them.

**Working specification** = what the prototype *is and produces*: a standards-based, executable specification of a proposition (expressed in ISO 20022, BIAN, recognised control frameworks) that a client takes to whatever vendor and build they choose. Distinct from the two Blueprints; it is the artefact, not the engagement. Its value is **portability/reuse** (standards are the shared vendor language) and **vendor-neutrality** (no lock-in). Never claim framework *certification* — "expressed in / structured around / aligned to" only.

## A. Coin and own (DTA-original)

| Term | Names | Published definition |
|---|---|---|
| **Owned Autonomy** *(flagship)* | the thesis | Agentic capability a bank **owns** rather than rents — accountable and sovereign by construction. Lead with this. No existing finance/AI collision found. |
| **Capability · Context · Consent (C3)** | the reference architecture | The three planes of an agentic-ready bank: **Capability** (governed banking capabilities — the DBB), **Context** (a shared semantic layer of meaning), **Consent** (the authority layer — every agent action authorised, evidenced, revocable). |
| **The Accountability–Sovereignty Principle** | the governing law | *You cannot be accountable for what you do not control.* A named principle others cite back to you. |
| **Clean-Room Demonstration Standard** | the proof method | A demonstration that is isolated, runs on synthetic data, is engineered to production-grade controls, and is explicitly non-production. The honesty discipline, named and ownable. |
| **Glass Tube** | the pilot and proving method | A transparent vertical slice sized to the decision: from a PO/FPE-led sandbox prototype to a full domain run end-to-end with the required organisational functions. |
| **Domain Building Block (DBB)** | existing IP | Composable capability unit = the **Capability plane of C3**. Keep; now positioned inside the architecture. |
| **Governed data product** | the data-layer unit | A governed, reusable view of a banking concept, packaged with meaning, authority/consent, lineage/evidence and sensitivity boundaries. The **data-layer twin of the DBB**: DBB governs a capability; the data product governs the data it runs on. Structured around DBB/ABB/BIAN. |
| **Governed Event Spine** | the substrate | The event log as source of truth (ledger as projection) from which every reusable data product is a governed projection. Why a transaction-based platform produces evidence-grade data cheaply. |
| **Transaction Ontology** | the meaning layer | Governed meaning for business events, tied to accountable owners — "not a folder of tables." The Context-plane counterpart for transaction data. |
| **Evidence-grade Data Products** | the quality bar | Data products traceable from customer action to control outcome — usable in a regulated decision, not just available. |
| **Consent-bearing Data** | the authority property | Data that carries its mandates, permissions and approval states as first-class fields, not a separate lookup bolted on later. |
| **Proposition-native Intelligence** | the reuse property | One governed product serving many engines and propositions, so each team stops rebuilding its own private view of the bank. |
| **Governed Decision Trace** | the labelled-data half | The record a governed agentic process emits as it runs — stated intent, authority, the agent's proposal, the policy gate, the human approval, the evidence. The already-labelled supervision a transaction model would otherwise have to infer. Pairs with **Interaction Microdata**. |
| **Interaction Microdata** | the behavioural-signal half | The fine-grained behavioural signal of a customer interaction (screen sequence, timing, device, hesitation) — how intent formed. The high-volume raw material a transaction model feeds on. The two together = two data products from one interaction. |
| **Product-first architecture** | the platform thesis | "Engines are built on the products, not the other way round." Governed data products are the platform; engines (fraud/AML/KYC/risk/reporting/servicing) are thin reasoning layers that consume them. Framed publicly as a **governed operational data mesh for agentic banking** — extends Dehghani's data mesh from analytical to operational + governed (attribute Dehghani; no "first"/"only"). |
| **Self-monitoring / self-diagnosing platform** | the resilience capability | The platform watches itself: components/agents register to the CMDB, incidents self-assemble, and the platform produces a **service-impact / blast-radius** report (which transactions failed, which customers missed a notification). **Blueprint-scoped.** Avoid the noun "self-declaring" (echoes regulatory self-certification) — use "self-registering components" for the mechanism, "self-monitoring estate" for the whole. |
| **Mandate & Authority Registry** | the governed product behind authority | The registry that issues, revokes, expires and delegates mandates — modelled as its own governed product, because "authority on the event" is only as trustworthy as the registry behind it. Pairs with the data-products **Authority & Consent** product. |
| **Forward Platform Engineer (FPE)** | the squad's technical lead | The forward-deployed role that leads technical delivery and integrates into the client estate. Not an in-house tech lead. |

## B. Descriptors only — already owned, never claim as ours

"agentic banking" (universal); "agent-ready / agentic-ready banking" (Zafin); "autonomous finance" (Forrester); "AI-native Banking OS / Unified Frontline / Sentinel / Nexus" (Backbase); "agentOS" (Fiserv); "composable / coreless banking" (Mambu / BIAN); "control plane" (Ping et al.); "Trust Score / runtime trust" (Trustwise). Use to be understood; never present as DTA coinage.

### On "control plane" specifically — borrow the term, own the *operator* claim

"Control plane" is a 30-year term of art (telecom/SDN → Kubernetes → service mesh → identity: Ping, Strata). It is generic and **not coinable** — never trademark or claim the bare noun. What DTA owns is the question the market is now circling: *who operates it?*

- **Protocol sovereignty** (e.g. Canon's verifiable-credential / proof model) — the protocol *is* the control plane; there is no operator.
- **Organisational sovereignty** (DTA) — the **bank operates its own control plane**: authorise, evidence and revoke every agent action in real time, examinable by a regulator.

DTA's **sovereign / operational control plane** *(framing, not a coinage)* is simply the **bank-operated Consent plane of C3** — the agentic decision gateway, the Mandate & Authority Registry and the evidence store — expressed in language the audience already uses. The differentiator to make explicit everywhere is **pluggability you control**: settlement rails (FPS, SEPA Instant, RTGS, ISO 20022, future CBDC), identity / credential schemes (e.g. ARC) and liquidity proofs **plug into it as versioned, testable ABBs**, and engines (fraud/AML/KYC/risk) are thin layers over governed products. Because the bank operates the plane, it decides what plugs in and can swap or revoke it — *you cannot plug into, or revoke on, a control plane you do not operate.* That is the Accountability–Sovereignty Principle made operational. Rule: borrow the term, attribute the lineage, frame the bank-operated + pluggable extension as ours; **no "first/only"; demonstrator, not production**. Governed in [claim register](claim-register.md) §F and §I.

## C. Internal architecture mythos — ownable, keep OFF the public site

A coherent internal naming system covers the capability substrate / payments engine, the governed bridge that carries an agent's intent to settlement, and the zero-trust authority plane. **The codenames themselves are deliberately kept off this public repo and the public site** — they live in the book and private architecture notes only; plain-English on the board-facing layer. (Enforced by `scripts/check-public-showcase.sh`.)

## D. Trademark-check before any public use

- **"The Accountable Bank"** (the demonstration name) — loose ESG/ethical-banking usage exists; run a formal TM/category check per jurisdiction before public launch. Until cleared, keep the `/composable-bank/` slug.
- **"Agentic-Ready Banking"** — usable umbrella descriptor, not ownable.

## E. The offer ladder (commercial spine)

Each rung is buyable alone; together they're land-and-expand. **Lead with talent (fast revenue); the strategic frame premium-prices it.** Caution: lead too hard on "talent" and premium buyers file you as staff-aug — the blended H1 and "control-grade, not body-shop" language hold the premium.

1. **Agentic Talent & Squads** *(lead; standalone or underpinning)* — the simplest buying motion: senior agentic engineers, embedded or as a managed squad, productive week one and accountable for a bounded outcome. Engagements: embedded engineer (day rate) · managed squad (managed service) · fractional lead/architect (retainer).
2. **Build & Run Propositions** *(the project)* — a fixed, shippable agentic product/journey to the same control standards as the demonstration; on-device models where data must not leave. Engagement: fixed-scope build (SOW). The **six-week Proposition Blueprint → optional 90-day Proof** lives here / at the rung 2→3 boundary.
3. **Owned Autonomy Transformation** *(the expand; strategic)* — making the bank agentic-ready on C3, with the agent wired to regulated settlement (ISO 20022, tokenised deposits, agentic payments), led from inside the bank. Engagement: transformation programme.

## F. Frameworks — established vs ours

Public framing: **proven frameworks — BIAN, SAFe, TOGAF, SFIA — assembled into an opinionated model, customised per client.** **SFIA** (Skills Framework for the Information Age) is the *people-capability* standard, defining every role as a skills profile — the people-layer twin of DBB (the banking-capability unit beside TOGAF's ABB). DTA's SFIA use is properly licensed; **Sailesh is a SFIA 10 contributor** — a credential, not a constraint. Public role copy shows concept + role names + skill *names* only; **levels of responsibility and the DBB catalogue are DTA IP**.

## Through-line in every artefact

**Owned Autonomy** (accountable + sovereign) · the **C3** architecture · the **Accountability–Sovereignty Principle** · the **Glass Tube** proving method · the **SFIA-defined, FPE-led** squad · a **clean-room demonstration** that is a working proving ground, deliberately non-production (test consumers, never real customers).

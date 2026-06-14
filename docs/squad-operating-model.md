# The Squad Operating Model for Agentic-Ready Banking

**DTA's master delivery operating model for the new world**

**A DTA working document**
**Status:** Draft for discussion · **Owner:** Sailesh Panchal · **Last updated:** 2026-06-14

---

## What changed in this revision (2026-06-14)

This revision does three things the previous draft did not:

1. **Re-anchors the language to the current DTA spine.** The model is now expressed
   as **Agentic-Ready Banking**, built on the **Accountable** and **Sovereign**
   pillars, with **Capability · Context · Consent (C3)** as the architecture spine
   and **Owned Autonomy** as the thesis the squad makes real. The demonstration
   platform is **The Accountable Bank** (the name **Composable Bank** is retired).
2. **Adds the operating-model depth that site copy was hiding.** A squad cannot
   "own a DBB" until something exists for it to own one *on*. New sections cover the
   special first squad, the enabling platform, the paved-road control library and
   the agentic harness (§6); how the rest of the bank is pulled in by a thin
   vertical slice rather than a horizontal re-org (§8); the transformation backbone
   that is *not* a PMO (§9); a lean, time-boxed, agentic-aware coaching model (§10);
   and the leadership operating-model change that has to happen alongside (§11).
3. **Defines every role through SFIA 9.** Capability is now explicit, assessable
   and not personality-dependent. Each role is a small set of named SFIA skills,
   each pinned to a level of responsibility, with a consolidated capability index
   in §15.

The locked decisions from 2026-06-13 are preserved. The only substantive change to
a prior decision is the platform-naming update (Composable Bank → The Accountable
Bank), which follows the agreed positioning spine.

**Same-day refinements (commercial & deployment reality):** adds the **fixed-capacity
funding** / cost-control model that also owns the client's cloud + AI run-rate (§7);
the **critical-mass** rule for a minimum viable number of squads (§4); the
**forward-deployed-unit** external framing and the **environment-readiness gaps** —
SDLC/CISO, ITIL v4, procurement and supplier resistance (§8); renames the squad
technical lead to **Forward Platform Engineer (FPE)**; and records that SFIA use is a
**credential** (Sailesh is an SFIA 10 contributor), not a licence constraint (§15).

---

## How to use this document

This is a shared working document, not site copy yet. We use it to think the model
through in a structured way; once a section feels right, we lift it into the public
site (`/approach/`, the homepage operating-model section, and the **Accountable
Bank** showcase).

Two reader types must recognise themselves in everything below:

- **Audience A — the incumbent (PRIMARY).** An established organisation — bank or
  larger FinTech — that already runs real operations and now needs a whole-
  organisation transformation: adopt the model and migrate towards it without
  breaking what works. This is our lead audience.
- **Audience B — the new-venture builder (SECONDARY, signposted).** Someone standing
  up a **new sub-division inside a bank**, or a **startup founder** creating a new
  bank for the first time. Addressed through signposts woven into the incumbent
  narrative, not a separate path.

Wherever the advice diverges, the document calls it out explicitly:
> **Incumbent:** … **Founder:** …

Sections marked **🗨️ To discuss** are open questions; **RESOLVED** markers record
decisions taken.

---

## Decisions log

**Carried forward (2026-06-13) — unchanged:**

1. **Thesis — LOCKED.** Strategy-led *construction* of the organisation of the
   future: a whole-org transformation with a high-level vision + roadmap, ~2 years
   out, changing people, process and technology together. (§1)
2. **Site structure.** One narrative, **incumbent-led**, with **founder signposts**
   woven in. (§12, §16)
3. **Frameworks.** Proven industry models — **BIAN, SAFe, TOGAF (ABBs)** — assembled
   into DTA's opinionated view. **DBB is our own coined term**, mirroring TOGAF's
   ABB. (§1, §5)
4. **Squad boundaries.** No single right shape; AI is blurring role boundaries. DTA
   advises the choice rather than prescribing one. (§4)
5. **Engagement model — RESOLVED.** DTA is an **advisory**. The client builds *their
   own* blueprint; DTA's model, method and reference architecture are **our IP**.
   (§13)
6. **Tone.** Credible to a bank CRO, never intimidating to a founder. (§1)
7. **Reality-check framing — RESOLVED.** Show **what is really important** — what to
   protect and invest in, not just what to cut. Positive framing. (§2)
8. **Audiences — EXTENDED.** Existing bank, new sub-division, startup founder share
   the model; site leads incumbent. (§12)

**Added (2026-06-14):**

9. **Lexicon re-anchor — RESOLVED.** Express the model in the current spine:
   Agentic-Ready Banking · Accountable + Sovereign · C3 · Owned Autonomy. The
   showcase is **The Accountable Bank** (clean-room demonstration). "Composable
   Bank" is retired. (§1, §3, §14)
10. **SFIA as the capability framework — RESOLVED.** Every role is defined as a SFIA
    9 skills profile at explicit levels of responsibility. SFIA sits alongside
    BIAN/SAFe/TOGAF as the *people-capability* standard, the way DBB sits alongside
    ABB as the *banking-capability* unit. (§1, §4, §15)
11. **The first squad is special — RESOLVED.** Squads are not interchangeable. The
    enabling platform, paved-road controls and agentic harness must exist before a
    DBB squad can be productive. The first engagement stands up that foundation. (§6)
12. **Engage the bank by thin slice — RESOLVED.** The beachhead proposition pulls one
    vertical thread through every function (risk, finance, ops, compliance) rather
    than transforming each function horizontally up front. (§8)
13. **Coaching is lean, time-boxed, agentic-aware — RESOLVED.** Coaches build the
    muscle and leave; they are never permanent overhead. A distinct *agentic
    delivery* coach profile is part of the model. (§10)
14. **Squad engagement split — RESOLVED.** The **Product Owner** is the single
    engagement point to the business, operations and governance teams and is
    accountable for **scope decisions**. The **Forward Platform Engineer (FPE)**
    leads technical delivery and integration with the client environment. There is no
    separate squad-level operations role; operations transforms as a client function
    and is engaged through the PO. (§4, §8)
15. **Public vs IP detail — RESOLVED.** A **sanitised** version of the operating
    model and role architecture is the public credibility artefact; the **full SFIA
    role library, the levels of responsibility and the DBB catalogue are DTA IP** that
    a client pays for. Sanitised = concept, roles and skill names; no levels, no
    catalogue, no protected detail. (§15, §16)
16. **FPE naming — RESOLVED.** The squad's technical lead is the **Forward Platform
    Engineer (FPE)** — chosen to fit the platform/substrate model. The role is still
    forward-deployed in nature (embedded, integrating into the client estate). (§4)
17. **Critical mass — RESOLVED.** The model needs a minimum viable number of squads to
    prove reuse and amortise the foundation: a working floor of **1 foundation + 2–3
    delivery squads**, tailored per client. (§4)
18. **External framing & readiness — RESOLVED.** Squads are framed as **forward-deployed
    units** that bring their own paved road and land in a not-yet-ready environment; a
    **parallel readiness workstream** closes the SDLC/CISO, ITIL v4, procurement and
    supplier gaps, cleared by SM&CR sponsorship. (§8)
19. **Fixed-capacity funding — RESOLVED.** DBB delivery is a **fixed-capacity** model:
    funding agreed in advance, work prioritised into capacity, scope flexes not cost — a
    strong cost-control mechanism that **also owns the client's cloud and AI run-rate**.
    (§7)
20. **SFIA licence — RESOLVED (non-issue).** DTA's SFIA use is properly licensed;
    Sailesh contributes to **SFIA 10** development. The framework grounding is a
    credential, not a constraint. (§15)

---

## 1. The thesis — RESOLVED

**The bank — and the organisation — of the future has to be *constructed*, not
assembled.** It needs a strategic approach to construction: a whole-organisation
transformation, expressed as a high-level vision and a roadmap pitched roughly two
years out, that changes **people, process and technology** together.

One-sentence form (candidate for the site):

> The organisation of the future is built on purpose — a two-year vision and roadmap
> that transforms people, process and technology together, not a technology project
> bolted onto today's org.

What the transformation is *for* is **Owned Autonomy**: autonomy the bank owns rather
than rents — **accountable and sovereign by construction**. Every autonomous action
is authorised against policy, evidenced and revocable (**accountable**); the bank
owns and governs its agents, data, models and infrastructure, standards-aligned but
not locked inside a vendor's operating system (**sovereign**). The bridge principle:
**you cannot be accountable for what you do not control** — accountability is the
obligation, sovereignty the precondition.

**The squad is where Owned Autonomy stops being a slogan.** A squad that builds and
runs a DBB is the smallest unit that has to *live* accountable-and-sovereign: it
authors the policy its agents act under, it owns the evidence its work produces, and
it owns the building block rather than renting a black box. If the squad does not
understand and embody that, the bank has bought a deck, not a transformation.

Supporting points:

- It is **strategy-led construction**, not disconnected initiatives.
- It is a **whole-organisation transformation**, not an engineering re-org.
- It is governed by a **high-level vision and roadmap**, ~2-year horizon.
- It moves **people, process and technology** in step.
- The pay-off is **composability** — one coherent platform and operating model
  carrying many propositions, countries, currencies and brands, because variation
  lives in configuration and reusable building blocks, not duplicated stacks or org
  charts.

### Frameworks we build on — and what's ours

An **opinionated model built on industry-proven foundations**, customised per client.
We are explicit about what is established and what is DTA's own:

- **BIAN** — the banking industry's reference architecture for capabilities and
  service domains. Established standard.
- **SAFe** — value streams and coordinated delivery at scale. Established standard.
- **TOGAF** — the enterprise-architecture method; gives us **Architecture Building
  Blocks (ABBs)**. Established standard.
- **SFIA 9** — the Skills Framework for the Information Age; the global standard for
  defining professional capability as skills at seven levels of responsibility. We
  use it to define *every* role in this model, so capability is explicit, assessable
  and portable rather than personality-dependent. Established standard.
- **Domain Building Blocks (DBBs)** — *our term.* DTA coined it, mirroring TOGAF's
  ABBs: where an ABB is a reusable *technical/architecture* capability, a **DBB is a
  reusable *banking* capability** (journey + policy + controls + evidence +
  execution). Our opinionated contribution, not an industry standard.

Honest framing for the site: **proven frameworks — BIAN, SAFe, TOGAF, SFIA —
assembled into an opinionated model, customised per client**, with DBB as our named
idea sitting alongside TOGAF's ABB and SFIA grounding the people layer.

---

## 2. Banking context — why a bank is bigger than its app

The most common mistake, especially for founders, is to mistake the customer app for
the bank. The proposition is the visible 10%. Underneath sits identity, consent,
entitlements, mandates, a ledger, evidence, reconciliation, payment rails, financial
crime, complaints, treasury, capital, and a named human accountable to a regulator
for each of them.

That weight multiplies with ambition: **multi-currency** (FX, settlement,
reconciliation, accounting per currency), **multi-country** (a different regulator,
licence, language, tax and consumer-protection regime per market), **multi-regulator**
(overlapping obligations that rarely compose cleanly).

### The "zero-ops" myth

"Zero-ops" is a useful design ambition, not an organisational reality. Automation and
agents reduce *effort*; they do not remove the *obligation*. A bank still needs
accountable owners for risk, capital, conduct, financial crime and resilience —
whether or not a human touches each transaction. This is the **Accountable** pillar
stated as an operational fact: the model's job is to make the obligation cheaper and
more observable, not to pretend it away.

> **Incumbent:** you already carry this weight — the risk is it's *fragmented* across
> silos and duplicated per product.
> **Founder:** the risk is the opposite — discovering the weight in production, after
> a licence condition or an incident forces the issue.

> **RESOLVED:** Reframe positively as **"what's really important."** In a cost-cutting
> climate our value is showing what to *protect and invest in*, not just what to cut.

---

## 3. The C3 architecture spine — Capability · Context · Consent

The operating model has one architecture spine, and every other section maps to it.

- **Capability** — *what the bank can do.* The **Domain Building Blocks (DBB)**
  substrate. Squads own capability (§4, §5).
- **Context** — *what the bank knows.* The shared semantic layer — the common
  meaning of party, product, mandate, money and event — that lets DBBs compose
  instead of fork. The data, evidence and measurement spine (§4 data role, §6
  substrate).
- **Consent** — *what the bank is allowed to do, and can prove it did.* The
  authority and evidence layer: identity, consent, entitlements, policy, the agentic
  decision gateway, and the evidence store that makes every action authorised and
  revocable. This is where **Accountable** is enforced (§6, §8).

The squad lives C3 directly: it builds **Capability** (its DBBs), draws on shared
**Context** (the semantic layer), and operates against **Consent** (authority +
evidence). "Living the Accountable Bank" means a squad never ships a capability whose
authority boundary and evidence trail are an afterthought — Consent is part of the
definition of done, not a gate at the end.

> *Internal (not for the site):* C3 maps onto the internal architecture naming —
> a Capability/Context substrate, a governed bridge to settlement, and a zero-trust
> authority (Consent) plane. The codenames are kept in private notes only; public
> copy uses C3 and plain-language plane names. (Enforced by `scripts/check-public-showcase.sh`.)

---

## 4. The squad — the unit that lives The Accountable Bank

The unit of delivery is a small, senior, cross-functional squad. Deliberately small:
large enough to own a capability end-to-end, small enough to stay fast and
accountable.

**Default shape — five people. One squad. Accountable for the DBBs it owns.**

| Role | Count | Owns | C3 plane |
|---|---|---|---|
| Product Owner | 1 | Proposition value and priorities; **scope decisions**; **primary engagement to the business, operations and governance teams** | Capability + Consent |
| Forward Platform Engineer (FPE) | 1 | **Lead of technical delivery and integration with the client environment**; architectural fit, reuse-vs-fork, accountable-by-construction | Capability |
| Engineer | 2 | Build, test, ship — with evidence | Capability + Consent |
| Data Engineer | 1 | Data, evidence, reconciliation, measurement | Context + Consent |

The squad spans the client boundary along two axes. The **Product Owner** faces the
business — the single, accountable engagement point to the business, operations and
governance teams, and the owner of scope decisions. The **Forward Platform Engineer**
faces the technology — the lead of technical delivery and the integration into the
client's existing estate, working to the enterprise architect's catalogue and fitness
functions (§9, §11). Between them they own the two hard boundaries an embedded squad
has to cross.

### SFIA profiles (levels of responsibility in brackets; **primary skill** in bold)

- **Product Owner** — **Product management PROD (5)**; Requirements definition and
  management REQM (5); Business situation analysis BUSA (4); Stakeholder relationship
  management RLMT (5); Governance GOVN (4); Customer experience CEXP (4). *Single
  engagement point to business, operations and governance; accountable for scope.*
- **Forward Platform Engineer (FPE)** — **Solution architecture ARCH (5)**; Systems
  integration and build SINT (5); Software design SWDN (4–5); Consultancy CNSL (4–5);
  Governance GOVN (4); Methods and tools METL (4). *Leads technical delivery and
  client-environment integration; the SINT + CNSL pairing is what makes this a
  forward-deployed role rather than an in-house tech lead.*
- **Engineer** — **Programming/software development PROG (4)**; Functional testing
  TEST (4); Non-functional testing NFTS (3–4); Systems integration and build SINT (4);
  Deployment DEPL (3–4); Systems and software lifecycle engineering SLEN (3–4).
- **Data Engineer** — **Data engineering DENG (4–5)**; Data management DATM (4); Data
  modelling and design DTAN (4); Measurement MEAS (4); Data analytics DAAN (3–4).

Principles:

- A squad owns **one or more** DBBs (§5); it is **durable**, aligned to capability,
  not a temporary project team.
- **Seniority over headcount.** Agentic tooling lets a small senior squad do what
  used to take a much larger team — but only once the foundation (§6) exists.

### What "living The Accountable Bank" means for a squad

Three behavioural commitments, one per C3 plane, that distinguish an Owned-Autonomy
squad from an ordinary agile team:

1. **Sovereign over its capability (Capability).** The squad owns its DBBs — the
   journey, policy, controls, evidence and execution — not a vendor black box. It can
   explain and change every part. Reuse-vs-fork is a deliberate, governed decision.
2. **Authored authority (Consent).** Agents in the squad's DBBs act under policy the
   squad authors and the bank approves. Every agent action is authorised against that
   policy and is revocable. "The agent did it" is never an answer to "who is
   accountable?"
3. **Evidence over status (Context/Consent).** The squad's work produces evidence as
   a by-product, not a report afterwards. Governance reads the evidence, not a slide.

> **RESOLVED — DTA's position:** There is no single right answer on squad boundaries,
> and we have run it both ways. Whether design, QA, risk/compliance, SRE and data sit
> *inside* each squad, in a shared enabling team, or as cross-cutting chapters depends
> on the client's existing people and on how far AI has absorbed the role boundaries.
> The five-person squad above is DTA's sensible default, not a mandate — and the SFIA
> profiles make the trade explicit: when AI absorbs a skill, you can see *which*
> SFIA skill and at *what* level, rather than arguing about job titles.

### Critical mass — the minimum viable number of squads

A single squad proves a *capability*; it does not prove the *operating model*. The
model only pays back above a minimum critical mass, because the expensive shared parts
— the foundation substrate, the agentic harness and the paved-road control library
(§6) — are fixed costs that amortise across squads, and because reuse and composition
(the whole point of DBBs) cannot be demonstrated with one squad building one block.

DTA's working floor, to be tailored per client:

- **1 foundation capability** (shared substrate, harness, paved-road controls), plus
- **2–3 delivery squads** inside the first value stream.

Below that you have a promising spike but no evidence that capabilities reuse, that
controls compose, or that a second proposition is cheaper than the first — which is the
claim the whole transformation rests on. Above it, each additional squad gets *faster*,
not slower, because it inherits the foundation rather than rebuilding it.

> **Incumbent:** fund the foundation plus the first 2–3 squads as one commitment, not a
> single pilot that can never prove the reuse thesis.
> **Founder:** the same floor applies — one squad ships an app; the operating model
> needs enough squads to show the second proposition composing from the first.

---

## 5. Domain Building Blocks (DBBs) — the Capability plane

A **Domain Building Block** packages a meaningful banking capability as a reusable
unit combining the customer/colleague **journey**, the **policy** and controls, the
**evidence** it produces, and the **execution** it performs.

Examples (from the showcase): onboarding, party & relationship graph, pooled goals,
tokenised deposit, Faster Payments / ISO 20022 messaging, consent & entitlements,
agentic decision gateway.

Why DBBs matter:

- **Unit of ownership** — squads own DBBs, not screens or services.
- **Unit of reuse** — a proposition is *composed* from DBBs, not copied. Family Wealth
  and International Student share onboarding, party graph, consent and payments; they
  differ only where they should.
- **Unit of sovereignty** — because the bank owns the DBB end-to-end, it owns the
  capability. Variation lives in composition and configuration, not forked tech.

> **RESOLVED (with default):** DBB is **our coined term** (mirroring TOGAF's ABB) — we
> name the *concept* and ~6–8 illustrative DBBs publicly; the full catalogue, contracts
> and implementation status stay in the protected Architecture Room.

---

## 6. The foundation — why the first squad is special (NEW)

The previous draft treated squads as interchangeable. They are not. **A squad cannot
own a DBB until there is a substrate to own one on, a control library to compose, and
a harness to build with.** Standing those up is the work of the *first* engagement and
the *first* squad — which is really a foundation squad, or a beachhead squad doing
double duty.

Four things make a DBB squad genuinely fast from day one. None of them should be
reinvented per squad; they are shared enabling capability.

**6.1 The substrate (Capability + Context).** The shadow-ledger projection, the shared
semantic layer, the consent/entitlements service, the agentic decision gateway and the
evidence store. Until these exist, "seniority over headcount" is aspirational.

**6.2 The reference DBB (Capability).** A template plus eval harness plus
architectural fitness functions, so *"is this a real DBB?"* is testable, not argued.
Definition of done includes the Consent boundary and the evidence trail.

**6.3 The agentic harness (Capability + Consent).** The custom skills library, the
guardrails and the eval/grading suite that let a squad ship agentic work safely. This
is the operational meaning of "agentic tooling, custom skills and evals" — owned as an
enabling capability, maintained centrally, consumed by every squad.

**6.4 The paved-road control library (Consent).** Pre-approved control patterns mapped
to DBBs, so a squad *composes* pre-cleared controls instead of re-litigating compliance
per capability. **This is the single biggest determinant of squad pace.** Without it,
even the most senior squad stalls at the first risk gate. It is the concrete,
buildable meaning of "risk & controls align to value."

### Foundation roles (shared, not per-squad) — SFIA profiles

- **Platform / Substrate Engineer** — **Systems and software lifecycle engineering
  SLEN (5)**; Infrastructure design IFDN (4–5); Data engineering DENG (4); Information
  security SCTY (4); Systems integration and build SINT (4); Methods and tools METL (5).
  *Owns the substrate, the golden path and the agentic harness.*
- **Control / Risk Engineer (paved road)** — **Risk management BURM (5)**; Governance
  GOVN (4–5); Information security SCTY (4); Audit AUDT (4); AI and data ethics AIDE (4).
  *Owns the pre-approved control library; the bridge between the risk function and the
  squads — the role that unblocks pace.*

> **Incumbent:** the foundation is built once and reused — it is how a second, third
> and tenth squad get faster, not slower.
> **Founder:** the foundation *is* the minimum credible bank underneath the app —
> build it on purpose before the first proposition, not after the first incident.

> 🗨️ **To discuss:** how thin can the v1 foundation be and still be honest? Define the
> minimum substrate + harness + control library that lets one beachhead DBB ship.

---

## 7. Value streams — the SAFe model

Squads group into **value streams** aligned to a proposition and its P&L. SAFe applied
to banking: coordination *across* squads without re-centralising delivery into a
programme office.

- A value stream owns a proposition (or a coherent family) end-to-end.
- It aligns funding, priorities and outcomes to value, not to projects.
- It gives leadership a small number of accountable lines, instead of hundreds of
  features.

> **Incumbent:** value streams are how you retire the project-and-programme machine
> without losing control.
> **Founder:** value streams are how your first 2–3 squads stay coherent past the
> "everyone in one room" stage.

> **RESOLVED:** Name **SAFe explicitly** as the proven foundation, use its core
> concepts, present our application as an opinionated view (e.g. DBBs on top). Keep
> heavy SAFe jargon (ART, PI planning) light in founder-facing passages.

### Fixed-capacity funding — the cost-control mechanism

DBB delivery runs as a **fixed-capacity model**: a value stream is funded for a fixed
squad capacity agreed *in advance*, and work is **prioritised into that capacity**
rather than capacity expanding to meet the work. Cost is the constant; scope is the
variable the Product Owner manages (§4). This is the direct answer to the first
question a CRO or CFO asks of any transformation — *"how do I stop this running
away?"*

How it controls cost:

- **Funding is capped and known.** The bill for a period is the agreed capacity, not an
  open-ended estimate that grows with discovery.
- **Prioritisation, not expansion.** New work competes for the next slot in a fixed
  backlog; it does not silently enlarge the team or the budget. The PO owns that
  trade-off transparently.
- **Cloud and AI costs sit inside the envelope.** The squad is accountable for its own
  **cloud and AI (inference / token) spend** as part of its capacity — a FinOps line it
  owns, meters and optimises, not an uncontrolled tail that arrives later. The agentic
  harness (§6) is where that metering lives.

The effect is a transformation with a **predictable run-rate** and a built-in brake:
leadership commits capacity, sees the evidence, and decides whether to renew, expand or
stop at the next boundary — the same discipline as DTA's own advisory engagements.

> **Incumbent:** this is how you sponsor ambitious change without writing a blank
> cheque — fixed capacity, visible prioritisation, an owned cloud/AI run-rate.
> **Founder:** it keeps the cost base honest before revenue — you buy capacity you can
> carry, and the AI bill is a managed line from day one.

SFIA grounding: the funding and cost discipline draws on **Financial management FMIT**,
**Budgeting and forecasting BUDF**, **Cost management COMG** and **Investment appraisal
INVA** at the value-stream level (§8 finance partner, §11 leadership), with the PO
owning prioritisation within the cap.

---

## 8. Engaging the whole bank — by thin slice, not horizontal re-org (REWRITTEN)

This is the part that separates a real transformation from a re-org of engineering.
The previous draft *asserted* that the whole business reorganises; this section says
*how*.

**The mechanism is a thin vertical slice, not boiling the ocean.** The beachhead
proposition pulls one thread through every function — a single named risk owner for
that value stream, one finance line for that P&L, one ops exception model for that
proposition — rather than transforming all of risk, finance and HR up front. Each
function transforms the slice the first value stream needs, then the next slice, and
the new ways of working propagate horizontally through chapters and communities of
practice.

What each function does as it joins a value stream:

- **Risk & controls** — embed an accountable risk owner in the value stream; co-own
  the paved-road control library (§6.4); engage continuously, not at gates.
- **Finance** — fund the value stream, not projects; map the P&L to the proposition.
- **Operations** — shift from manual processing to **exception handling and oversight
  of agent-prepared work**, engaged through the squad's Product Owner. The function is
  being actively redefined by agentic work; define it deliberately under its own
  functional leadership rather than porting the old shape or bolting a delivery role
  onto the squad.
- **Regulatory affairs & compliance** — engage continuously with the value stream;
  feed obligations into the control library so they become composable, not bespoke.
- **HR & people** — hire, grow and reward around durable squads and chapters; use the
  SFIA profiles in this document as the job architecture.

If these functions don't move, the squads become a fast engine bolted to a slow
chassis, and the transformation stalls.

### What actually makes the functions move: sponsorship with teeth

Functions move when a **named accountable executive** can change finance's funding
rules, HR's grades and risk's operating model — and when the incentives change with
them. This is where **SM&CR is the sharpest lever you have**: tie transformation
outcomes to a named SMF, and the functions move because someone is *personally*
accountable, not because a deck asked nicely. (Founder equivalent: the licence
perimeter and the regulator's expectations are the forcing function.)

### Cross-functional value-stream roles — SFIA profiles

- **Value Stream Owner** (senior business leader) — **Product management PROD (6)**;
  Strategic planning ITSP (5); Financial management FMIT (5); Benefits management
  BENM (5); Stakeholder relationship management RLMT (6); Governance GOVN (5).
- **Value-stream Risk & Control Owner** (embedded from risk) — **Risk management
  BURM (5–6)**; Governance GOVN (5); Audit AUDT (4–5); Continuity management
  COPL (4); Information assurance INAS (4).
- **Value-stream Finance Partner** — **Financial management FMIT (5)**; Investment
  appraisal INVA (5); Benefits management BENM (5); Budgeting and forecasting
  BUDF (5); Cost management COMG (4).

> Operations is engaged **through the Product Owner**, not through a separate squad
> role. It transforms toward exception handling and oversight of agent-prepared work
> under its own functional leadership — treat its evolving profile as a client-side
> design question, not a fixed DTA delivery role.

> **RESOLVED (default):** One simple before/after (silos → value streams), naming the
> cultural shift explicitly: **accountable autonomy** and **evidence over status
> reporting**. One diagram, not a treatise.

### Landing in a not-yet-ready environment — external framing & readiness

Everything above assumes the bank can *receive* a squad. Often it cannot — yet. The
squads are ready before the environment is, so two things have to be true: the squads
need an **external framing** that lets them operate semi-independently, and someone has
to close the **environment-readiness gaps** in parallel.

**External framing — the squad as a forward-deployed unit.** A DTA squad is presented
to the host bank not as contractors plugged into the bank's existing machine, but as a
**forward-deployed unit**: a small, self-sufficient team that lands in the client,
brings its own paved road, harness and controls (§6), and integrates outward into the
estate through the **Forward Platform Engineer** (§4). The unit is designed to be
productive *before* the bank has finished modernising around it — and the FPE's job is
precisely to make that landing work. It is a unit, not a person: humans at the edges,
agentic capability in the middle.

**The readiness gaps that block an unprepared environment.** Expect some or all of:

- **SDLC / architecture / CISO governance not adapted.** The secure SDLC, architecture
  review and CISO sign-off still assume the old delivery shape; the agentic,
  evidence-first way of working has no approved path through them yet.
- **ITIL v4 not adopted (or only partially).** Change, release, problem and service
  management may not be in a state that can absorb continuous, agent-assisted delivery.
- **Procurement friction.** Onboarding a new model of delivery through procurement
  designed for staff augmentation or fixed-scope SOWs is slow and ill-fitting.
- **Incumbent supplier resistance.** Existing SIs and vendors have commercial reasons
  to slow a model that reduces seat-count and shifts value to reusable capability.

**How the model copes — bring your own road, then pave theirs.** The forward-deployed
unit ships its *own* controls and golden path so it is not blocked waiting for the
bank's, while a **parallel readiness workstream** upgrades the host environment to adopt
them: an approved agentic SDLC path with the CISO, the architecture fitness functions,
the ITIL v4 alignment, and a procurement/commercial route that fits fixed-capacity
funding (§7). This is exactly where **SM&CR sponsorship** earns its keep — a named
accountable executive is what clears procurement, overrules supplier foot-dragging and
authorises the SDLC/CISO changes. The squad's own paved-road controls (§6.4) are
designed to *become* the bank's once approved.

SFIA grounding for the readiness workstream: **Information security SCTY** and
**Governance GOVN** (CISO / SDLC path), **Methods and tools METL** (delivery method),
**Technology service management ITMG** and **Service level management SLMO** (ITIL v4),
**Supplier management SUPP** and **Sourcing SORC** (procurement and incumbent
suppliers).

> **Incumbent:** assume the environment is *not* ready and plan the readiness workstream
> as a first-class part of the engagement — it is usually the real critical path, not
> the build.
> **Founder:** you have the opposite advantage — no legacy SDLC, ITIL estate or
> incumbent SI to dislodge; design the environment around the unit from the start.

> 🗨️ **To discuss:** how much of the readiness workstream DTA leads vs advises, and how
> we price it separately from delivery capacity.

---

## 9. The transformation backbone — not a PMO (NEW)

Sequencing a whole-bank change while keeping the lights on needs a small backbone that
owns the roadmap, the dependencies and the *operating-model* change itself (the
funding-model redesign, the grade/role change, the control-model change). It is
emphatically **not** a revived programme office that manages features and reads status.

### Backbone roles — SFIA profiles

- **Transformation Lead / Sponsor** (accountable exec, SM&CR-tied) — **Strategic
  planning ITSP (6–7)**; Governance GOVN (6–7); Organisational change management
  CIPM (6); Risk management BURM (6); Stakeholder relationship management RLMT (7);
  Benefits management BENM (6).
- **Transformation / Enterprise Architect** (owns the DBB catalogue, reference
  architecture, fitness functions, reuse arbitration) — **Enterprise and business
  architecture STPL (6)**; Solution architecture ARCH (6); Governance GOVN (5);
  Innovation management INOV (5); Emerging technology monitoring EMRG (5);
  Consultancy CNSL (5).
- **Portfolio / Sequencing Lead** (owns sequencing, dependencies, migration path) —
  **Portfolio management POMG (5–6)**; Programme management PGMG (5); Benefits
  management BENM (5); Demand management DEMM (4); Feasibility assessment FEAS (4).

> The Enterprise Architect seat is the centre of gravity for sovereignty: it owns the
> catalogue and the fitness functions that keep the estate composable rather than
> forked. It is the role DTA most often *advises into* on an incumbent engagement.

---

## 10. Coaches — lean, time-boxed, agentic-aware (NEW)

Coaches were missing from the previous draft. They matter — and coach-bloat is exactly
where transformations lose credibility with a CRO. DTA's position is sharp and
deliberately differentiated.

**What coaches are NOT here:** ceremony-teachers running stand-ups by rote.

**What coaches ARE for:** (a) helping senior people unlearn stage-gate reflexes and
adopt accountable autonomy and evidence-over-status; (b) coaching *leadership* on the
new operating model — how to fund and govern value streams; (c) — the part consistent
with our own thesis — coaching senior squads on the **agentic golden path, the evals
and the DBB harness**. Because AI is absorbing role boundaries, you need *fewer*
classic process coaches and *more* agentic ways-of-working coaches: a genuinely
different profile.

**The discipline that lands with a cost-cutting CRO:** coaching is **lean, time-boxed
and outcome-tied, with a designed exit.** Coaches build the muscle and leave; they
never become permanent overhead. Same discipline as DTA itself — advisory, not a
permanent handover.

### Coach roles — SFIA profiles

- **Ways-of-Working / Agile Coach** — **Organisational change enablement OCEN (5)**;
  Organisational facilitation OFCL (5); Methods and tools METL (5); Professional
  development PDSV (4); Learning delivery ETDL (4).
- **Agentic Delivery Coach** (the new profile) — **Methods and tools METL (5)**;
  Organisational change enablement OCEN (4–5); Emerging technology monitoring
  EMRG (4); AI and data ethics AIDE (4); Programming/software development PROG (4,
  *for credibility with the squad*); Learning delivery ETDL (4).
- **Leadership / Transformation Coach** — **Organisational change enablement
  OCEN (6)**; Organisational change management CIPM (5); Performance management
  PEMT (5); Stakeholder relationship management RLMT (5); Professional development
  PDSV (5).

> SFIA 9 added **Organisational change enablement (OCEN)** and **Organisational
> facilitation (OFCL)** as distinct skills — they map almost exactly onto what good
> transformation coaching actually is, which is useful evidence that the lean-coaching
> position is the mainstream-rigorous one, not a corner-cut.

---

## 11. Leadership — the operating model changes too (NEW / EXPANDED)

The harder truth than "leaders must sponsor": the **leadership operating model changes
as much as the delivery model.** Leaders move from approving projects and reading
status decks to **funding value streams and reading evidence**. That behavioural shift
is as large as the squad shift — and it is the one most likely to silently revert,
because the old reflexes (stage gates, status reporting, project funding) are
comfortable and well-rewarded.

What has to change, concretely:

- **Funding** — from project business cases to value-stream funding tied to outcomes.
- **Governance** — from status review to evidence review (the squad's evidence trail,
  not a RAG slide).
- **Accountability** — from committee diffusion to named SM&CR ownership.
- **Proof** — leaders need an early, visible win to spend political capital on; the
  showcase (§14) exists partly to give them one.

### Leadership roles — SFIA profiles (beyond the backbone in §9)

- **Accountable Transformation Sponsor** — see §9 (ITSP 6–7, GOVN 6–7, CIPM 6,
  RLMT 7).
- **Value Stream Owner** — see §8 (PROD 6, ITSP 5, FMIT 5, RLMT 6).
- **Architecture / Enterprise Architecture Leadership** — **Enterprise and business
  architecture STPL (6–7)**; Governance GOVN (6); Solution architecture ARCH (6);
  Information systems coordination ISCO (5); Innovation management INOV (5). *Owns the
  catalogue, the reference architecture, the reuse-vs-fork arbitration.*
- **Risk & Control Leadership** — **Risk management BURM (6)**; Governance GOVN (6);
  Audit AUDT (5); Information security SCTY (5); Continuity management COPL (5).
  *Co-owns the paved-road control library at the enterprise level.*

> **Incumbent:** name the leaders, tie them to SM&CR, and change what they are funded
> and measured on — otherwise the squads run fast inside an unchanged governance cage.
> **Founder:** these are the few senior hires that actually have to be senior; most of
> the rest can be junior + agentic.

---

## 12. The two journeys

One destination, two very different starting points. **The site leads with the
incumbent journey (12A)**; the founder journey (12B) is woven in as signposts.

### 12A. The incumbent — adopt and migrate

The hard work is sequencing change while keeping the lights on.

1. Start with architecture & strategy: which propositions justify the change, and what
   is the target operating model?
2. **Stand up the foundation** (§6) and the first value stream + squad around the
   beachhead proposition's DBBs.
3. Use **shadow integration** — project consented data and events into a shadow
   ledger/view to prove value alongside the existing estate without re-platforming.
4. Expand DBB by DBB, value stream by value stream; migrate the business functions in
   step by thin slice (§8).
5. Decommission the old path only once the new one is proven.

### 12B. The founder — build it right the first time

The hard work is building *enough* bank without a cost base you can't carry.

1. Start with architecture & strategy: the proposition, the P&L, the licence and
   jurisdiction perimeter.
2. Stand up the first squad around the smallest set of DBBs that makes the proposition
   real (onboarding, accounts, payments, consent) — on top of a deliberately thin
   foundation (§6).
3. Build the **minimum credible bank** underneath — the accountable functions a
   regulator and a customer actually require — designed on purpose.
4. Compose the next proposition from the same building blocks instead of forking.
5. Scale squads into value streams as the business grows.

| | Incumbent | Founder |
|---|---|---|
| Main risk | Fragmentation & duplication | Under-building the real bank |
| First move | Foundation + beachhead + shadow integration | Minimum credible bank + thin foundation + first squad |
| Hardest part | Migration sequencing | Knowing what's genuinely required |
| DTA's biggest lever | Whole-bank transformation | Architecture, strategy & first squads |

---

## 13. Where DTA helps

Three engagement shapes, often in sequence:

1. **Whole-bank transformation, from the CEO down** — proposition & P&L, customer
   experience, operating model, people & culture (SFIA job architecture), risk &
   controls, and the production architecture that ties it together.
2. **Stand up the foundation and specific squads** — build the substrate, harness and
   paved-road controls (§6), then build and embed individual squads around their DBBs
   with the SFIA profiles, agentic tooling, custom skills and evals that let them ship
   safely from day one.
3. **Plan the migration** — the sequencing, shadow integration and change path that
   moves an existing bank or FinTech onto the new model.

It always starts with architecture (business, domain, technology, enterprise) and the
strategy of the proposition and value creation.

> **RESOLVED:** DTA is an **advisory**. The client builds *their own* blueprint; our
> opinionated model, method, reference architecture and SFIA role library are **our
> IP**, not a handover. A focused blueprint engagement is the low-commitment first
> step — advisory and decision-oriented (a go/reshape/stop recommendation) — backed by
> the reference prototype and Sailesh's experience, not productised IP transfer.

---

## 14. From proposition to working spike — The Accountable Bank

The conversion path that ties strategy to proof:

1. The client chooses a proposition (e.g. the Family Wealth Hub).
2. DTA helps build a **spike** for it — either **standalone**, or **shadow-integrated**
   alongside the existing bank.
3. The reference prototype shows the technology is genuinely possible and connects
   directly to business value in an **agentic** way: agents observe, prepare, check and
   recommend, while policy and accountable people keep authority and approve execution
   — Owned Autonomy demonstrated, not asserted.

**The Accountable Bank** is the shop window: a **clean-room demonstration** — isolated,
synthetic data, built to production-grade control standards but explicitly **not**
production. That honesty is the anti-vaporware differentiator. Four propositions, one
governed platform, every journey demonstrable in the browser: Family Wealth Hub,
Premium Yacht Portfolio, Franchise Network Operations, International Student Banking.

> *Disclosure ladder (internal):* public site → NDA (walkthrough + boundary + risk
> register) → MOU (architecture + control mapping) → engagement (IP transfer +
> production roadmap). Public copy is confident; risks and substantiation live in the
> internal annex. TM-check "The Accountable Bank" before public use.

> 🗨️ **To discuss:** the smallest "spike" we'd actually scope, and how we price
> standalone vs shadow-integrated so the next step feels concrete.

---

## 15. Role capability index (SFIA 9) — the people layer

> **This full index is DTA IP.** The public/credibility version is **sanitised** — the
> concept, the role names and the named skills, but **without the levels of
> responsibility** and without the DBB catalogue. The complete index below, with
> levels, is what a client pays for. (Decisions log #15.)

A consolidated reference. Levels are **illustrative starting points to be tailored**
(per SFIA's own guidance — do not deploy unadjusted), and should be confirmed against
the SFIA 9 source and the ForgeML SFIA mapper. SFIA recommends ~5–7 skills per role;
profiles here hold to that.

**SFIA seven levels of responsibility:** 1 Follow · 2 Assist · 3 Apply · 4 Enable ·
5 Ensure/advise · 6 Initiate/influence · 7 Set strategy/inspire/mobilise.

### Delivery squad

| Role | Primary skill | Supporting skills (level) |
|---|---|---|
| Product Owner | PROD (5) | REQM (5), BUSA (4), RLMT (5), GOVN (4), CEXP (4) |
| Forward Platform Engineer (FPE) | ARCH (5) | SINT (5), SWDN (4–5), CNSL (4–5), GOVN (4), METL (4) |
| Engineer | PROG (4) | TEST (4), NFTS (3–4), SINT (4), DEPL (3–4), SLEN (3–4) |
| Data Engineer | DENG (4–5) | DATM (4), DTAN (4), MEAS (4), DAAN (3–4) |

### Foundation (shared enabling)

| Role | Primary skill | Supporting skills (level) |
|---|---|---|
| Platform / Substrate Engineer | SLEN (5) | IFDN (4–5), DENG (4), SCTY (4), SINT (4), METL (5) |
| Control / Risk Engineer (paved road) | BURM (5) | GOVN (4–5), SCTY (4), AUDT (4), AIDE (4) |

### Value stream (cross-functional)

| Role | Primary skill | Supporting skills (level) |
|---|---|---|
| Value Stream Owner | PROD (6) | ITSP (5), FMIT (5), BENM (5), RLMT (6), GOVN (5) |
| Risk & Control Owner | BURM (5–6) | GOVN (5), AUDT (4–5), COPL (4), INAS (4) |
| Finance Partner | FMIT (5) | INVA (5), BENM (5), BUDF (5), COMG (4) |

*Operations is engaged through the Product Owner and transforms under its own
functional leadership; it is not carried as a DTA squad role (see §8).*

### Transformation backbone & leadership

| Role | Primary skill | Supporting skills (level) |
|---|---|---|
| Transformation Lead / Sponsor | ITSP (6–7) | GOVN (6–7), CIPM (6), BURM (6), RLMT (7), BENM (6) |
| Transformation / Enterprise Architect | STPL (6) | ARCH (6), GOVN (5), INOV (5), EMRG (5), CNSL (5) |
| Portfolio / Sequencing Lead | POMG (5–6) | PGMG (5), BENM (5), DEMM (4), FEAS (4) |
| Architecture Leadership | STPL (6–7) | GOVN (6), ARCH (6), ISCO (5), INOV (5) |
| Risk & Control Leadership | BURM (6) | GOVN (6), AUDT (5), SCTY (5), COPL (5) |

### Coaching

| Role | Primary skill | Supporting skills (level) |
|---|---|---|
| Ways-of-Working / Agile Coach | OCEN (5) | OFCL (5), METL (5), PDSV (4), ETDL (4) |
| Agentic Delivery Coach | METL (5) | OCEN (4–5), EMRG (4), AIDE (4), PROG (4), ETDL (4) |
| Leadership / Transformation Coach | OCEN (6) | CIPM (5), PEMT (5), RLMT (5), PDSV (5) |

**SFIA skill code key (used above):**
ARCH Solution architecture · STPL Enterprise and business architecture · ITSP Strategic
planning · SWDN Software design · PROG Programming/software development · TEST Functional
testing · NFTS Non-functional testing · SINT Systems integration and build · DEPL
Deployment · SLEN Systems and software lifecycle engineering · IFDN Infrastructure design
· DENG Data engineering · DATM Data management · DTAN Data modelling and design · DAAN
Data analytics · MEAS Measurement · PROD Product management · REQM Requirements definition
and management · BUSA Business situation analysis · CEXP Customer experience · RLMT
Stakeholder relationship management · BENM Benefits management · BURM Risk management ·
GOVN Governance · SCTY Information security · INAS Information assurance · AUDT Audit ·
AIDE AI and data ethics · COPL Continuity management · ITMG Technology service management
· PBMG Problem management · SLMO Service level management · FMIT Financial management ·
INVA Investment appraisal · BUDF Budgeting and forecasting · COMG Cost management · POMG
Portfolio management · PGMG Programme management · DEMM Demand management · FEAS Feasibility
assessment · ISCO Information systems coordination · INOV Innovation management · EMRG
Emerging technology monitoring · CNSL Consultancy · CIPM Organisational change management ·
OCEN Organisational change enablement · OFCL Organisational facilitation · METL Methods and
tools · PDSV Professional development · ETDL Learning delivery · PEMT Performance management ·
SUPP Supplier management · SORC Sourcing.

> *SFIA® is a registered trademark of the SFIA Foundation. Codes and skill titles are
> SFIA 9 (published October 2024); role profiles, levels and groupings here are DTA's
> own opinionated mapping. DTA's use is properly licensed — Sailesh is a contributor to
> **SFIA 10** development and has a direct relationship with the SFIA Foundation. That
> makes the framework grounding a **credential** for DTA, not a constraint: the operating
> model is defined against the standard by someone helping to write its next version.*

---

## 16. How this maps to the site

| This document | Site destination |
|---|---|
| §1 Thesis / Owned Autonomy | Homepage hero + mission; top of `/approach/` |
| §2 Banking context, zero-ops | `/approach/` "the part FinTechs underestimate"; Insights post |
| §3 C3 spine | `/approach/` "how it all fits"; architecture credibility note |
| §4 Squad + "living the Accountable Bank" | `/approach/` squad roster; homepage operating-model teaser |
| §5 DBBs | `/approach/` "how delivery is organised" |
| §6 Foundation (first squad is special) | `/approach/` "what it really takes"; Insights post |
| §7 Value streams | `/approach/` "how delivery is organised" |
| §8 Engaging the bank (thin slice, SM&CR) | `/approach/` reorganise section |
| §9 Transformation backbone | `/approach/` "where DTA helps" |
| §10 Coaches | `/approach/` people & culture; consultancy-partner page |
| §11 Leadership | `/approach/` leadership section; NED/board-facing material |
| §1/§15 Frameworks (BIAN/SAFe/TOGAF/SFIA/DBB) | `/approach/` credibility note |
| §13 Where DTA helps | `/approach/` "where DTA helps"; homepage offerings |
| §14 Proposition → spike | `/approach/` closing band; The Accountable Bank showcase |

> **RESOLVED:** No separate `/for-banks/` or `/for-founders/` pages. One incumbent-led
> narrative on `/approach/`, with founder signposts woven in. A **sanitised** version
> of the operating model and role architecture is the public credibility artefact —
> the concept, the roles and the named SFIA skills, shown as proof of rigour. The
> **full SFIA role library with levels, and the DBB catalogue, are DTA IP** that a
> client pays for. (Decisions log #15.)

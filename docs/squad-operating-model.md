# The Squad Operating Model for Modern Banking

**A DTA working document**
**Status:** Draft for discussion · **Owner:** Sailesh Panchal · **Last updated:** 2026-06-13

---

## How to use this document

This is a shared working document, not site copy yet. We use it to think the
model through in a structured way; once a section feels right, we lift it into
the public site (`/approach/`, the homepage operating-model section, and the
Composable Bank showcase).

Two reader types must recognise themselves in everything below:

- **Audience A — the incumbent (PRIMARY).** An established organisation — bank or
  larger FinTech — that already runs real operations and now needs a whole-
  organisation transformation: adopt the model and migrate towards it without
  breaking what works. This is our lead audience (the large-scale transformation
  client a Deloitte would pursue).
- **Audience B — the new-venture builder (SECONDARY, signposted).** Someone
  standing up a **new sub-division inside a bank**, or a **startup founder**
  creating a new bank for the first time — who needs to avoid both under-building
  (no real bank underneath) and over-building (a cost base they can't carry).
  We address them through clear signposts woven into the incumbent narrative,
  not a separate site path.

Wherever the advice diverges, the document calls it out explicitly:
> **Incumbent:** … **Founder:** …

Sections marked **🗨️ To discuss** are open questions; **RESOLVED** markers
record decisions taken.

---

## Decisions log (2026-06-13)

1. **Thesis — LOCKED.** Strategy-led *construction* of the organisation of the
   future: a whole-org transformation with a high-level vision + roadmap, ~2
   years out, changing people, process and technology together. Public wording
   approved. (§1)
2. **Site structure.** One narrative, **incumbent-led** (primary target), with
   **founder signposts** woven in — not two pages or competing CTAs. (§7, §11)
3. **Frameworks.** Present as proven industry models — **BIAN, SAFe, TOGAF
   (ABBs)** — assembled into DTA's opinionated, customised view. **DBB is our
   own coined term**, mirroring TOGAF's ABB. (§1, §4, §5)
4. **Squad boundaries.** No single right shape; we have run it both ways. The
   answer depends on the client's existing people and talent, and **AI is
   blurring the role boundaries** significantly. DTA advises the choice rather
   than prescribing one. (§3)
5. **Engagement model — RESOLVED.** DTA is an **advisory**. The client creates
   *their own* blueprint; **DTA's opinionated model, method and reference
   architecture are our IP** and are not handed over. The reference prototype
   backs the technology; Sailesh's experience backs the rest. A focused blueprint
   engagement is advisory and decision-oriented (a go/reshape/stop
   recommendation), not a productised deliverable that transfers the IP. (§8)
   *Internal (not for the site):* the model is the asset — it could scale via
   trusted associates joining, or be licensed/sold to a larger consultancy as
   an advisory capability.
6. **Tone.** Credible to a bank CRO, never intimidating to a founder. Agreed. (§6)
7. **Reality-check framing — RESOLVED.** In a climate where banks are cutting
   costs everywhere, we show **what is really important** — what to protect and
   invest in, not just what to cut. Positive framing, not fear-selling. (§2)
8. **Audiences — EXTENDED.** Three contexts share the model: an **existing bank**
   (transform / optimise under cost pressure), someone standing up a **new
   sub-division inside a bank**, and a **startup founder** building new. The
   site leads incumbent, signposts the new-venture cases. (§7)

---

## 1. The thesis — RESOLVED

**The bank — and the organisation — of the future has to be *constructed*, not
assembled.** It needs a strategic approach to construction: a whole-organisation
transformation, expressed as a high-level vision and a roadmap pitched roughly
two years out, that changes **people, process and technology** together.

One-sentence form (candidate for the site):

> The organisation of the future is built on purpose — a two-year vision and
> roadmap that transforms people, process and technology together, not a
> technology project bolted onto today's org.

Supporting points:

- It is **strategy-led construction**, not a set of disconnected initiatives.
- It is a **whole-organisation transformation**, not an engineering re-org.
- It is governed by a **high-level vision and a roadmap**, with a realistic
  **~2-year** horizon.
- It moves **people, process and technology** in step; change one alone and the
  transformation stalls.
- The pay-off is **composability** — one coherent platform and operating model
  carrying many propositions, countries, currencies and brands, because
  variation lives in configuration and reusable building blocks, not duplicated
  stacks or duplicated org charts.

### Frameworks we build on — and what's ours

This is an **opinionated model built on industry-proven foundations**, which our
advisory then customises to each client. We are explicit about what is
established and what is DTA's own view:

- **BIAN** — the banking industry's reference architecture for capabilities and
  service domains. Established standard.
- **SAFe** — the Scaled Agile Framework for value streams and coordinated
  delivery. Established standard.
- **TOGAF** — the enterprise-architecture method; gives us **Architecture
  Building Blocks (ABBs)**. Established standard.
- **Domain Building Blocks (DBBs)** — *our term.* DTA coined it, deliberately
  mirroring TOGAF's ABBs: where an ABB is a reusable *technical/architecture*
  capability, a **DBB is a reusable *banking* capability** (journey + policy +
  controls + evidence + execution). It is our opinionated contribution, not an
  industry standard.

Honest framing for the site: **proven frameworks, assembled into an opinionated
model, customised per client** — with DBB as our named idea sitting alongside
TOGAF's ABB.

---

## 2. Banking context — why a bank is bigger than its app

The most common mistake, especially for founders, is to mistake the customer
app for the bank. The proposition is the visible 10%. Underneath sits identity,
consent, entitlements, mandates, a ledger, evidence, reconciliation, payment
rails, financial crime, complaints, treasury, capital, and a named human who is
accountable to a regulator for each of them.

That weight multiplies with ambition:

- **Multi-currency** — FX, settlement, reconciliation and accounting per
  currency.
- **Multi-country** — a different regulator, licence, language, tax regime and
  consumer-protection regime in each market.
- **Multi-regulator** — overlapping obligations that rarely compose cleanly.

### The "zero-ops" myth

"Zero-ops" is a useful design ambition, not an organisational reality.
Automation and agents reduce *effort*; they do not remove the *obligation*. A
bank still needs accountable owners for risk, capital, conduct, financial crime
and resilience — whether or not a human touches each transaction. The model's
job is to make that obligation cheaper and more observable, not to pretend it
away.

> **Incumbent:** you already carry this weight — the risk is that it's
> *fragmented* across silos and duplicated per product.
> **Founder:** the risk is the opposite — discovering the weight in production,
> after a licence condition or an incident forces the issue.

> **RESOLVED:** Reframe positively as **"what's really important."** Banks are
> cutting costs everywhere; our value is showing what to *protect and invest in*,
> not just what to cut — for an existing bank, a new sub-division, or a startup
> founder. Credibility signal, not fear-selling.

---

## 3. The squad

The unit of delivery is a small, senior, cross-functional squad. Deliberately
small: large enough to own a capability end-to-end, small enough to stay fast
and accountable.

| Role | Count | Owns |
|---|---|---|
| Product Owner | 1 | Proposition value, priorities, outcomes |
| Tech Lead / Architect | 1 | Technical design, quality, architectural fit |
| Engineer | 2 | Build, test, ship |
| Data Engineer | 1 | Data, evidence, reconciliation, measurement |

**Five people. One squad. Accountable for the Domain Building Blocks it owns.**

Principles:

- A squad owns **one or more** Domain Building Blocks (DBBs) — see §4.
- A squad is **durable**, aligned to capability, not a temporary project team.
- Seniority over headcount: agentic tooling lets a small senior squad do what
  used to take a much larger team.

> **RESOLVED — DTA's position:** There is no single right answer, and we have
> run it both ways successfully. Whether design, QA, risk/compliance, SRE and
> even data sit *inside* each squad, in a shared enabling team, or as
> cross-cutting chapters/guilds depends on the client's **existing people and
> talent**. **AI is now moving the needle and significantly blurring these role
> boundaries** — a smaller, more senior, AI-augmented squad can absorb work that
> used to need dedicated roles. Navigating this choice deliberately is part of
> what DTA advises on: we bring a sensible default and adapt it, rather than
> prescribing one shape for everyone. (The 5-person squad above is that
> default, not a mandate.)

---

## 4. Domain Building Blocks (DBBs)

A **Domain Building Block** packages a meaningful banking capability as a
reusable unit that combines: the customer/colleague **journey**, the **policy**
and controls, the **evidence** it produces, and the **execution** it performs.

Examples (from the showcase): onboarding, party & relationship graph, pooled
goals, tokenised deposit, Faster Payments / ISO 20022 messaging, consent &
entitlements, agentic decision gateway.

Why DBBs matter:

- They are the **unit of ownership** — squads own DBBs, not screens or services.
- They are the **unit of reuse** — a proposition is *composed* from DBBs rather
  than copied. Family Wealth and International Student share onboarding, party
  graph, consent and payments; they differ only where they should.
- They keep **business variation** in composition and configuration, not in
  forked technology.

> **RESOLVED (with default):** DBB is **our coined term** (mirroring TOGAF's
> ABB) — we name the *concept* and a representative set of DBBs publicly, because
> it's a genuine differentiator. The full catalogue, contracts and
> implementation status stay in the protected Architecture Room. Default for the
> public site: concept + ~6–8 illustrative DBBs, no contracts.

---

## 5. Value streams — the SAFe model

Squads group into **value streams** aligned to a proposition and its P&L. This
is the SAFe model applied to banking: coordination *across* squads without
re-centralising delivery into a programme office.

- A value stream owns a proposition (or a coherent family of them) end-to-end.
- It aligns funding, priorities and outcomes to value, not to projects.
- It gives leadership a small number of accountable lines to manage, instead of
  hundreds of features.

> **Incumbent:** value streams are how you retire the project-and-programme
> machine without losing control.
> **Founder:** value streams are how your first 2–3 squads stay coherent as you
> grow past the "everyone in one room" stage.

> **RESOLVED:** Name **SAFe explicitly** as the proven foundation (incumbents
> expect it), use its core concepts, and present our application as an
> opinionated, customised view. We don't hide the lineage — we add our own
> framing (e.g. DBBs) on top. Keep heavy SAFe jargon (ART, PI planning) light in
> founder-facing passages.

---

## 6. The whole business reorganises around the squads

This is the part that separates a real transformation from a re-org of
engineering. The framework of the **entire business** comes to revolve around
the value streams:

- **Risk & controls** align to how value is now delivered and evidenced.
- **Finance** funds value streams, not projects; the P&L maps to propositions.
- **HR & people** hire, grow and reward around durable squads and chapters.
- **Regulatory affairs & compliance** engage continuously with value streams,
  not at gates.
- **Operations** shift from manual processing to exception handling and
  oversight of agent-prepared work.

If these functions don't move, the squads become a fast engine bolted to a slow
chassis, and the transformation stalls.

> **RESOLVED (default):** Yes — one simple before/after (silos → value streams),
> and name the cultural shift explicitly: **accountable autonomy**, and
> **evidence over status reporting**. One diagram, not a treatise.

---

## 7. The two journeys

The model is one destination with two very different starting points. **The site
leads with the incumbent journey (7A)** as the spine of the narrative; the
founder journey (7B) is woven in as signposts and a lighter entry point, not a
separate path.

### 7A. The incumbent — adopt and migrate

The hard work is sequencing change while keeping the lights on.

1. Start with architecture & strategy: which propositions justify the change,
   and what is the target operating model?
2. Pick a beachhead proposition and stand up the first value stream + squads
   around its DBBs.
3. Use **shadow integration** — project consented data and events into a shadow
   ledger/view so you can prove value alongside the existing estate without
   re-platforming.
4. Expand DBB by DBB, value stream by value stream; migrate the business
   functions in step with the technology.
5. Decommission the old path only once the new one is proven.

### 7B. The founder — build it right the first time

The hard work is building *enough* bank without building a cost base you can't
carry.

1. Start with architecture & strategy: the proposition, the P&L, the licence
   and jurisdiction perimeter.
2. Stand up the first squad around the smallest set of DBBs that makes the
   proposition real (onboarding, accounts, payments, consent).
3. Build the **minimum credible bank** underneath — the accountable functions
   that a regulator and a customer actually require — designed on purpose.
4. Compose the next proposition from the same building blocks instead of
   forking.
5. Scale squads into value streams as the business grows.

| | Incumbent | Founder |
|---|---|---|
| Main risk | Fragmentation & duplication | Under-building the real bank |
| First move | Beachhead + shadow integration | Minimum credible bank + first squad |
| Hardest part | Migration sequencing | Knowing what's genuinely required |
| DTA's biggest lever | Whole-bank transformation | Architecture, strategy & first squads |

> **RESOLVED:** One narrative, **incumbent-led** (our primary large-transformation
> target), with clear **founder signposts** woven in. Not two pages or competing
> CTAs — the incumbent story is the spine, founder guidance sits alongside as
> asides and a lighter entry point.

---

## 8. Where DTA helps

Three engagement shapes, which often run in sequence:

1. **Whole-bank transformation, from the CEO down** — proposition & P&L,
   customer experience, operating model, people & culture, risk & controls, and
   the production architecture that ties it together.
2. **Stand up specific squads** — build and embed individual squads around their
   DBBs, with the agentic tooling, custom skills and evals that let them ship
   safely from day one.
3. **Plan the migration** — the sequencing, shadow integration and change path
   that moves an existing bank or FinTech onto the new model.

It always starts with architecture (business, domain, technology, enterprise)
and the strategy of the proposition and value creation.

> **RESOLVED:** DTA is an **advisory**. The client builds *their own* blueprint;
> our opinionated model, method and reference architecture are **our IP**, not a
> handover. A focused blueprint engagement is the low-commitment first step —
> advisory and decision-oriented (a go/reshape/stop recommendation) — backed by
> the reference prototype and Sailesh's experience, not productised IP transfer.

---

## 9. From proposition to working spike

The conversion path that ties strategy to proof:

1. The client chooses a proposition (e.g. the Family Wealth Hub).
2. DTA helps build a **spike** for it — either **standalone**, or
   **shadow-integrated** alongside the existing bank.
3. The reference prototype shows the technology is genuinely possible, and that
   it connects directly to business value in an **agentic** way: agents observe,
   prepare, check and recommend, while policy and accountable people keep
   authority and approve execution.

The Composable Bank showcase is the shop window for this: four propositions, one
governed platform, every journey demonstrable in the browser.

> 🗨️ **To discuss:** What's the smallest "spike" we'd actually scope, and how do
> we price/scope standalone vs shadow-integrated so the next step feels concrete?

---

## 10. Open questions — all resolved

All open items are now decided (see the **Decisions log** at the top). The doc is
ready to drive site copy:

1. **Named first offer** → advisory blueprint engagement; client builds their own
   blueprint; DTA model is IP. (Decisions log #5, §8)
2. **Reality-check** → reframed as "what's really important" in a cost-cutting
   climate; positive, not fear-selling. (Decisions log #7, §2)
3. **Thesis wording** → locked. (Decisions log #1, §1)

---

## 11. How this maps to the site

| This document | Site destination |
|---|---|
| §1 Thesis | Homepage hero + mission; top of `/approach/` |
| §2 Banking context, zero-ops | `/approach/` "the part FinTechs underestimate"; an Insights post |
| §3 Squad | `/approach/` squad roster; homepage operating-model teaser |
| §4 DBBs / §5 Value streams | `/approach/` "how delivery is organised" |
| §6 Whole-business reorg | `/approach/` reorganise section |
| §7 Two journeys | `/approach/`: incumbent-led narrative with founder signposts |
| §1 Frameworks (BIAN/SAFe/TOGAF/DBB) | `/approach/` "how delivery is organised"; a credibility note |
| §8 Where DTA helps | `/approach/` "where DTA helps"; homepage offerings |
| §9 Proposition → spike | `/approach/` closing band; Composable Bank showcase |

> **RESOLVED:** No separate `/for-banks/` or `/for-founders/` pages. One
> incumbent-led narrative on `/approach/`, with founder signposts woven in.

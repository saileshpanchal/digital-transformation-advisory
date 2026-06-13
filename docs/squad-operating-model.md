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

- **Audience A — the incumbent.** An established bank or larger FinTech that
  already runs real operations and now wants to *adopt the model* and migrate
  towards it without breaking what works.
- **Audience B — the founder.** A FinTech or challenger *creating a new bank
  for the first time*, who needs to avoid both under-building (no real bank
  underneath) and over-building (a cost base they can't carry).

Wherever the advice diverges, the document calls it out explicitly:
> **Incumbent:** … **Founder:** …

Sections marked **🗨️ To discuss** are open questions for us to work through.

---

## 1. The thesis

Modern banking propositions are not won or lost on technology. They are won on
whether a differentiated proposition can make money, earn trust, and *operate*
through the institution that has to deliver it.

So the model starts with architecture and strategy, expresses delivery as small
accountable squads, organises those squads around reusable banking capabilities,
groups them into value streams, and then reshapes the wider business to support
them. Technology is the enabler, not the entry point.

The pay-off is **composability**: one coherent platform and operating model can
carry many propositions, countries, currencies and brands — because business
variation lives in configuration and reusable building blocks, not in duplicated
stacks or duplicated org charts.

> 🗨️ **To discuss:** Is "composable banking" the right umbrella term for the
> site, or do we lead with "agentic, value-stream-aligned banking"? What single
> sentence is the thesis?

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

> 🗨️ **To discuss:** Do we want a crisp "what a real bank actually requires"
> checklist on the site? It's a strong reality-check for founders and a
> credibility signal for incumbents — but it must not read as fear-selling.

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

> 🗨️ **To discuss:** Where do design, QA, risk/compliance and SRE sit — inside
> the squad, as a shared "platform/enabling" team, or as a chapter/guild across
> squads? Does a data engineer belong in every squad or in a shared data value
> stream? This is the question clients will probe hardest.

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

> 🗨️ **To discuss:** How prescriptive do we get publicly about the DBB
> catalogue? A named, visible catalogue is compelling proof but risks looking
> like a product spec. Where's the line for the public site vs the protected
> Architecture Room?

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

> 🗨️ **To discuss:** How much explicit SAFe vocabulary (ART, PI planning, etc.)
> do we use? It reassures incumbents and can alienate founders. Option: use the
> concepts, brand the labels as DTA's, footnote the SAFe lineage.

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

> 🗨️ **To discuss:** Do we show a simple "before/after" org picture
> (silos → value streams)? And do we name the cultural shift explicitly —
> accountable autonomy, evidence over status reporting?

---

## 7. The two journeys

The model is one destination with two very different starting points.

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

> 🗨️ **To discuss:** Should the site present these as two explicit paths (two
> CTAs, "I run a bank" / "I'm building one"), or one narrative with contrasts?

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

> 🗨️ **To discuss:** Are these three the right "ways to engage" for the site, or
> do we also need a low-commitment entry point (e.g. a paid discovery / blueprint
> sprint) as the first step? We already reference a six-week blueprint in the
> showcase — should it be a named offer here too?

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

## 10. Open questions to resolve before site copy

1. The one-sentence thesis (see §1).
2. Two explicit audience paths vs one narrative (see §7).
3. How prescriptive to be publicly about DBBs and SAFe (see §4, §5).
4. Whether to add a named, low-commitment first offer (see §8).
5. Tone balance: credible to a bank CRO, not intimidating to a founder.
6. How much of the "real bank is big" reality-check to show without fear-selling.

---

## 11. How this maps to the site

| This document | Site destination |
|---|---|
| §1 Thesis | Homepage hero + mission; top of `/approach/` |
| §2 Banking context, zero-ops | `/approach/` "the part FinTechs underestimate"; an Insights post |
| §3 Squad | `/approach/` squad roster; homepage operating-model teaser |
| §4 DBBs / §5 Value streams | `/approach/` "how delivery is organised" |
| §6 Whole-business reorg | `/approach/` reorganise section |
| §7 Two journeys | New: explicit audience paths (TBD) |
| §8 Where DTA helps | `/approach/` "where DTA helps"; homepage offerings |
| §9 Proposition → spike | `/approach/` closing band; Composable Bank showcase |

> 🗨️ **To discuss:** Do the two audiences (§7) warrant their own pages
> (`/for-banks/`, `/for-founders/`), or sections within `/approach/`?

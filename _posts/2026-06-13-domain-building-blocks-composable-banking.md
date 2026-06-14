---
layout: corporate-post
title: "Domain Building Blocks: The Unit BIAN Doesn't Give You"
date: 2026-06-13
categories: [Banking, Architecture]
tags: [composable-banking, bian, domain-driven-design, togaf, enterprise-architecture, banking-transformation]
excerpt: "Most banks already have a capability map. BIAN tells you what the capabilities are. It does not tell you how to package and run one so it can be reused, governed, and proven. That missing unit is the Domain Building Block."
author: Sailesh Panchal
---

Ask a bank's chief architect for their capability model and you will usually get something good: a service-domain map, often BIAN-aligned, that names every meaningful banking capability and how they relate. It is a genuine asset. It is also, on its own, the reason so many "composable bank" programmes stall.

The map tells you *what* the capabilities are. It does not tell you how to **package one capability so it can be reused across propositions, governed under Consumer Duty, executed safely by software, and proven to a regulator** — without copying the whole technology stack underneath it each time.

That packaging unit is what we call a **Domain Building Block (DBB)**. This note explains what it is, why a capability map alone leaves a gap, and how the DBB sits at the intersection of three things your architects already trust: BIAN service domains, domain-driven design, and TOGAF building blocks.

## What BIAN gives you — and where it stops

The Banking Industry Architecture Network gives the industry a shared vocabulary of **service domains**: discrete, non-overlapping banking capabilities (Customer Relationship Management, Payment Order, Collateral Administration, and so on), each with a defined role and service operations. Its great contribution is *carving the elephant at the joints* — agreeing where one capability ends and the next begins, so two banks (and their vendors) can talk about the same thing.

But BIAN is deliberately **implementation-agnostic**. By design, a service domain does not tell you:

- the **journey** a customer or colleague actually moves through;
- the **policy and authority** that decides whether an action is permitted;
- the **controls** that must hold for it to be compliant;
- the **evidence** the capability must emit to be auditable; or
- the **execution** — how the thing actually runs, deterministically and repeatably.

BIAN is the map. It is not the vehicle. A bank can be perfectly BIAN-aligned on paper and still have each "capability" implemented five different ways across five products, with controls bolted on afterwards and evidence reconstructed from logs. The map said *what*; nobody owned the *runnable, governed how*.

## The missing unit: the Domain Building Block

A **Domain Building Block packages a meaningful banking capability across journey, policy, controls, evidence, and execution** as one reusable, bounded thing. It is the unit you compose a proposition from — and the unit you can pick up and reuse in the next proposition without dragging the whole stack with it.

Underneath it sits its counterpart:

> **Domain Building Block** — a reusable banking capability combining journey, policy, controls, evidence, and execution.
>
> **Architecture Building Block (ABB)** — shared technical and control infrastructure used by several Domain Building Blocks and propositions (party graph and identity; consent, entitlements and mandates; the event spine and canonical contracts; the double-entry ledger; evidence and reconciliation; replaceable adapters behind ports).

The distinction is the whole point. A DBB is *business-meaningful and proposition-facing* ("Governed Contribution", "Cross-border Funding"). An ABB is *technical and shared* ("party graph", "event spine"). One DBB stands up on many ABBs; one ABB serves many DBBs. Business variation lives in the DBB composition, not in a duplicated technology stack.

<pre class="mermaid">
flowchart TB
  subgraph EX["Experiences (channels, brand, locale)"]
  end
  subgraph DBB["Domain Building Blocks — the business capabilities"]
    D1["Family Circle"]
    D2["Governed Contribution"]
    D3["Opportunity Request"]
    D4["Human Approval"]
  end
  subgraph ORCH["Agentic orchestration — plan, gate, execute, evidence"]
  end
  subgraph ABB["Architecture Building Blocks — shared infrastructure"]
    A1["Party graph &amp; identity"]
    A2["Entitlements &amp; mandates"]
    A3["Event &amp; evidence spine"]
    A4["Double-entry ledger"]
  end
  EX --> DBB --> ORCH --> ABB
</pre>

## Why this isn't a new invention — it's a disciplined synthesis

Architects are right to be sceptical of vendors coining new acronyms. The DBB is not a fourth framework competing with the ones you have. It is the **runnable composition unit that sits exactly where three established disciplines meet**:

**Domain-driven design gives it its boundary.** Eric Evans' and Vaughn Vernon's *bounded context* is the foundational idea that a model is only valid, and a capability only coherent, *inside a defined boundary* with its own language and rules. A DBB is a bounded context with a banking job: its boundary is what makes it safely reusable, because everything it needs to mean and to enforce travels inside it.

**BIAN gives it its place on the map.** A DBB realises one (or a tight cluster) of BIAN service domains. BIAN answers "which capability is this, and where does it stop?"; the DBB answers "and here is the journey, policy, controls, evidence and execution that make it real."

**TOGAF gives it its vocabulary — and a caveat worth stating plainly.** TOGAF already uses the term *Architecture Building Block* (a reusable, defined-function architecture component) alongside *Solution Building Blocks*. We use ABB in the same spirit and deliberately keep the word, because the lineage is real and useful. The DBB is closest to a domain-specialised, business-facing TOGAF building block — but with two TOGAF-silent properties promoted to first-class status: **controls and evidence**.

<pre class="mermaid">
flowchart LR
  BIAN["BIAN service domain<br/>(what the capability is)"] --> DBB
  DDD["Bounded context / DDD<br/>(the boundary &amp; model)"] --> DBB
  TOGAF["TOGAF building block<br/>(reusable component vocabulary)"] --> DBB
  DBB["Domain Building Block<br/>journey + policy + controls + evidence + execution"]
</pre>

## The part the older frameworks leave outside the block

Here is the difference that matters most to a bank in 2026.

In a classic architecture, **controls** and **evidence** are cross-cutting afterthoughts — a compliance overlay, a logging strategy, a reconciliation job. That was tolerable when capabilities were operated by people at human speed. It is not tolerable when an **agent** can observe, prepare, recommend, and execute within defined authority. The moment software can act, the governance has to be *inside the capability*, not stapled to the outside of it.

So a DBB carries, as part of its definition:

- **Policy and authority** — who or what is permitted to do this, and under what mandate. Identity is not authority; membership of a family or a network grants no access by itself.
- **Controls** — the invariants that must hold (balanced postings; a 1:1 backing check; a required approval) before an action completes.
- **Evidence** — every material step emits a record: the recommendation, the policy result, the approval, the command result, the audit trail.
- **Execution** — a deterministic *gather → execute → acknowledge* path, where a **material action cannot execute until an authorised human records approval.**

That last property is not aspirational. In our working reference prototype it is enforced and tested: an agent may prepare and propose, but a material proposal throws rather than executing until approval is recorded. Agents prepare; humans decide; the evidence is produced as a by-product, not reconstructed after the fact. *That* is what makes a capability defensible under Consumer Duty — and it only works if it lives inside the building block.

## What this means for a bank

If your capabilities are DBBs, three things become true that are not true of a capability map alone:

1. **You can add a capability without re-platforming.** A new proposition composes existing DBBs and adds the few it needs. A new money form or rail enters as a branch inside the relevant DBB, not as a parallel stack. Composition, not duplication.
2. **You can prove governance, not assert it.** Because controls and evidence are part of each block, "show me how this decision was authorised and recorded" has an answer by construction.
3. **You can let agents operate safely.** Authority, gates, and evidence are where the work happens, so automation extends reach without surrendering control.

A short honesty note, because it is the point of how we work: we have proven this end-to-end on **one** proposition (a multi-generational *Family Wealth* journey) in a working prototype with tests behind it. The other propositions we discuss publicly are **blueprints** — designed against the same DBB/ABB model, not yet engine-backed. We would rather tell you exactly which is which than imply a finished platform.

## Where to start

You almost certainly do not need a new capability map — you need to turn the one you have into *runnable, governed building blocks*, and to learn the real organisational cost of doing so before you commit to the whole estate. That is precisely what our **six-week Proposition Blueprint** is for: take one proposition, define its DBBs and the ABBs beneath them, and produce a board-ready recommendation to go, reshape, or stop — with an optional 90-day proof of a single bounded journey.

If your capability model is excellent and your propositions still take eighteen months each, the gap is almost certainly the missing unit. BIAN told you *what*. The Domain Building Block is *how*.

---

*A companion technical note on tokenised-deposit conformance (ERC-7943 alignment) is maintained separately; this paper deliberately stays at the architecture-decision level rather than the instrument level.*

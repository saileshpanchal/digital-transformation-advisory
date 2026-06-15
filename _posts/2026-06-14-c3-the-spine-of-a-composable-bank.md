---
layout: corporate-post
title: "C3: Capability, Context, Consent — the Spine of Owned Autonomy"
date: 2026-06-14T12:00:00+00:00
categories: [Strategy, Architecture]
tags: [composable-banking, architecture, agentic, owned-autonomy, consent, domain-building-blocks, semantic-layer]
excerpt: "Owned Autonomy needs an architecture. A bank can only be accountable for what its agents do, and sovereign over what they run on, if three things are shared across every proposition: governed capability, shared meaning, and the authority to act. We call that spine C3 — Capability, Context, Consent."
author: Sailesh Panchal
---

"One platform, many propositions" is an easy thing to say and a hard thing to build. The trap is that each new proposition quietly grows its own copy of everything underneath — its own capabilities, its own vocabulary, its own idea of who's allowed to do what. Do that a few times and "composable" has collapsed back into copy-paste, with a different stack and a different org chart per product. Worse, the moment you let an **agent** act, a bank that can't say *who authorised this and how it was proven* has lost the plot.

[Owned Autonomy](/) — agentic capability a bank is **accountable** for and **sovereign** over — only works if there's a shared backbone every proposition, squad and agent runs on. We define that backbone as three planes. We call it **C3: Capability, Context, Consent.**

This is the overview; each plane gets its own paper. The Capability plane already has one — [Domain Building Blocks: the unit BIAN doesn't give you](/2026/06/13/domain-building-blocks-composable-banking/).

## The shape

<pre class="mermaid">
flowchart TB
  subgraph CAP[Capability: what we can do]
    DBB[Domain Building Blocks]
  end
  subgraph CTX[Context: shared meaning and measurement]
    SEM[Shared semantic layer]
    MEAS[Measurement]
  end
  subgraph CNS[Consent: the right to act]
    AUTH[Authority]
    POL[Policy]
    GATE[Agentic gateway]
    EVID[Evidence]
  end
  REC[Agent prepares and recommends] --> GATE
  AUTH --> GATE
  POL --> GATE
  GATE -->|human or mandated approval| DBB
  DBB --> EVID
  DBB --> MEAS
  SEM -.->|shared meaning| GATE
  SEM -.->|shared meaning| DBB
</pre>

**Capability** does the work. **Context** gives it shared meaning and tells you whether it's working. **Consent** governs whether it may act, and proves what happened. Every action threads all three in the same shape — which is exactly why one platform can carry many propositions, and why a bank can answer for what its agents do.

## Capability — what we can do

The unit of Capability is deliberately *not* a microservice or a screen. It's a **Domain Building Block (DBB)** — a reusable banking capability that packages the journey, the policy and controls, the evidence it produces, and the execution it performs, as one owned, governed thing.

DBBs are why a proposition is *composed* rather than copied. Onboarding, the party-and-relationship graph, consent and entitlements, payments, FX, tokenised deposit — these are shared blocks. Family Wealth and Cross-Border Real-Time Payments reuse most of them and differ only where they should. A squad owns one or more DBBs end-to-end; a proposition is an assembly of DBBs, configured — not a fork of the platform.

The term is ours, set deliberately alongside TOGAF's Architecture Building Blocks: an ABB is reusable *technical* infrastructure; a DBB is a reusable *banking* capability on top of it. The full argument is in the [DBB paper](/2026/06/13/domain-building-blocks-composable-banking/).

## Context — shared meaning and measurement

Context is the quiet plane everything else depends on, and the one most often missing. It's "what does this mean, and is it working?"

- **The shared semantic layer** — canonical contracts and a common vocabulary: the party, relationship and asset graph, and the hard distinctions between **money, movement, message and decision**. This is the precondition for agents. An agent can only be trusted across domains if "account," "owner," "mandate" and "settled" mean the same thing everywhere. Without shared meaning, services and agents talk past each other, and every integration becomes a translation.
- **Measurement** — observability, metrics, evidence-as-data, reconciliation, and agent and model evals. This is the precondition for trust. You cannot run agents in a regulated business on faith; you run them because you can *see* what they did and prove it was right.

A useful boundary lives here: ISO 20022 is a message standard *within* the semantic layer — it carries the instruction, but it is not the money, the rail, or the meaning by itself.

## Consent — the right to act

Consent is the "may this happen?" plane, and it's where agentic banking either earns trust or loses it. It has four parts:

- **Authority** — identity, entitlements, mandates, delegated authority: *who or what* may act, and within what bounds. (Identity is not authority; membership of a family or a network grants nothing by itself.)
- **Policy** — the rules: purpose, amount, timing, counterparty, jurisdiction, limits — *whether, when and how* an action may proceed.
- **Evidence** — a tamper-evident record of what happened and why. Proof, not logs.
- **The agentic gateway** — the controlled chokepoint where agents observe, prepare and recommend, and where authority, policy and human (or mandated) approval gate execution.

The principle that makes the whole thing safe: **agents propose; the gateway disposes.** An agent never acquires authority by making a recommendation. It assembles context, checks consent, and prepares an action — but a policy and an accountable human (or a pre-agreed mandate) decide whether it executes. That's how a bank gets the speed of automation while remaining accountable for, and sovereign over, every action.

## Why it's a spine, not a stack

The point of C3 is that the three planes interlock into one continuous path. An agent **observes** signals (Context), **prepares and recommends** an action, which is checked against **authority and policy** and gated at the **agentic gateway** (Consent); on approval it **executes a DBB** (Capability) and emits **evidence and measurement** (Consent and Context). Same shape, every time, for every proposition.

That's what lets the bank be genuinely composable *and* accountable: Capability is assembled from shared blocks, Context keeps it coherent and observable, and Consent keeps it safe and answerable. It's also how the operating model and the architecture line up — squads own Capability; Context and Consent are the shared spine, owned by the enabling value streams.

If you've read [our approach](/approach/), C3 is the architectural counterpart to the squad operating model — and it's the backbone beneath every proposition in our [clean-room demonstration](/composable-bank/). It is, in short, the architecture that makes [Owned Autonomy](/) real.

Next in the series: **Context** — why shared meaning is the precondition for agents; then **Consent** — how you let agents act without ever handing them authority. If you're wrestling with this on a real transformation, [book a call](/connect/).

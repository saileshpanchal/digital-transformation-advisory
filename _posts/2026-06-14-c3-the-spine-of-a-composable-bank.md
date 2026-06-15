---
title: "C3: Consent, Capability, Context — the Spine of a Composable Bank"
date: 2026-06-14T12:00:00+00:00
categories: [Strategy, Architecture]
tags: [composable-banking, architecture, agentic, consent, domain-building-blocks, semantic-layer, governance]
excerpt: "Composable banking only works if three things are shared across every proposition: the right to act, the things you can do, and the meaning and measurement that ties them together. We call that spine C3 — Consent, Capability, Context. This is the first in a series defining it."
author: Sailesh Panchal
---

"One platform, many propositions" is an easy thing to say and a hard thing to build. The trap is that each new proposition quietly grows its own copy of everything underneath — its own idea of who's allowed to do what, its own vocabulary, its own definition of "done." Do that a few times and "composable" has collapsed back into copy-paste, with a different stack and a different org chart per product.

A composable bank avoids that because it has a **spine** — a shared backbone that every proposition, every squad and every agent runs on. We define that spine as three pillars. We call it **C3: Consent, Capability, Context.**

This is the first in a short series. Here's the whole shape; the pillars get their own papers next.

## The shape

<div class="mermaid">
flowchart TB
  subgraph CTX[Context: meaning and measurement]
    SEM[Shared semantic layer]
    MEAS[Measurement]
  end
  subgraph CNS[Consent: the right to act]
    AUTH[Authority]
    POL[Policy]
    GATE[Agentic gateway]
    EVID[Evidence]
  end
  subgraph CAP[Capability: what we can do]
    DBB[Domain Building Blocks]
  end
  REC[Agent prepares and recommends] --> GATE
  AUTH --> GATE
  POL --> GATE
  GATE -->|human or mandated approval| DBB
  DBB --> EVID
  DBB --> MEAS
  SEM -.->|shared meaning| GATE
  SEM -.->|shared meaning| DBB
</div>

**Capability** does the work. **Consent** governs whether it may, and proves what happened. **Context** gives it shared meaning and tells you whether it's working. Every action threads all three in the same shape — which is exactly why one platform can carry many propositions.

## Consent — the right to act

Consent is the "may this happen?" layer, and it's where agentic banking either earns trust or loses it. It has four parts:

- **Authority** — identity, entitlements, mandates, delegated authority: *who or what* may act, and within what bounds.
- **Policy** — the rules: purpose, amount, timing, counterparty, jurisdiction, limits — *whether, when and how* an action may proceed.
- **Evidence** — a tamper-evident record of what happened and why. Proof, not logs.
- **The agentic gateway** — the controlled chokepoint where agents observe, prepare and recommend, and where authority, policy and human (or mandated) approval gate execution.

The principle that makes the whole thing safe: **agents propose; the gateway disposes.** An agent never acquires authority by making a recommendation. It assembles context, checks consent, and prepares an action — but a policy and an accountable human (or a pre-agreed mandate) decide whether it executes. That's how you get the speed of automation without surrendering accountability.

## Capability — what we can do

Capability is the "what can we do?" layer, and the unit is deliberately *not* a microservice or a screen. It's a **Domain Building Block (DBB)** — a reusable banking capability that packages the journey, the policy and controls, the evidence it produces, and the execution it performs, as one owned thing.

DBBs are why a proposition is *composed* rather than copied. Onboarding, the party-and-relationship graph, consent and entitlements, payments, FX, tokenised deposit — these are shared blocks. Family Wealth and Cross-Border Payments reuse most of them and differ only where they should. A squad owns one or more DBBs end-to-end; a proposition is an assembly of DBBs, configured — not a fork of the platform.

(The term is ours, deliberately set alongside TOGAF's Architecture Building Blocks: an ABB is reusable *technical* infrastructure; a DBB is a reusable *banking* capability that sits on top of it.)

## Context — meaning and measurement

Context is the quiet pillar that everything else depends on, and the one most often missing. It's "what does this mean, and is it working?"

- **The shared semantic layer** — canonical contracts and a common vocabulary: the party, relationship and asset graph, and the hard distinctions between **money, movement, message and decision**. This is the precondition for agents. An agent can only be trusted across domains if "account," "owner," "mandate" and "settled" mean the same thing everywhere. Without shared meaning, services and agents talk past each other, and every integration becomes a translation.
- **Measurement** — observability, metrics, evidence-as-data, reconciliation, and agent and model evals. This is the precondition for trust. You cannot run agents in a regulated business on faith; you run them because you can *see* what they did and prove it was right.

A useful boundary lives here too: ISO 20022 is a message standard *within* the semantic layer — it carries the instruction, but it is not the money, the rail, or the meaning by itself.

## Why it's a spine, not a stack

The point of C3 is that the three pillars interlock into one continuous path. An agent **observes** signals (Context), **prepares and recommends** an action, which is checked against **authority and policy** and gated at the **agentic gateway** (Consent); on approval it **executes a DBB** (Capability) and emits **evidence and measurement** (Consent and Context). Same shape, every time, for every proposition.

That's what lets the bank be genuinely composable: Capability is assembled from shared blocks, Consent keeps the assembly safe and accountable, and Context keeps it coherent and observable. It's also how the operating model and the architecture line up — squads own Capability; Consent and Context are the shared platform spine, owned by the enabling value streams.

If you've read [our approach](/approach/), C3 is the architectural counterpart to the squad operating model — and it's the backbone under every proposition in the [Composable Bank showcase](/composable-bank/).

Next in the series: **Consent** — how you let agents act without ever handing them authority. If you're wrestling with this on a real transformation, [book a call](/connect/).

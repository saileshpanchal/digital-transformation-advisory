---
layout: corporate-post
title: "Independent Architecture, Proven Primitives: the Platform Decision Comes Second"
date: 2026-06-17
categories: [Banking, Architecture]
tags: [banking-architecture, target-architecture, vendor-selection, regulatory, composable-banking, owned-autonomy]
excerpt: "Most banks choose a platform first and discover the hard parts later. The independent move is to define a target architecture and prove the primitives that usually fail before committing, so the platform conforms to the architecture rather than the other way round."
author: Sailesh Panchal
---

A bank decides to modernise. The shortlist is platforms. Eighteen months and a large budget later, the strain shows up in the same places every time: custody and settlement finality, the audit trail, how payments and economic crime and customer data actually share state, resilience at the branch and ATM edge. The platform was chosen before anyone had proven those parts would work together, in this bank, under this regulator.

That is the wrong order. The platform is not the first decision. It is close to the last.

## Choose the platform last

The independent move is to define a target architecture first, prove the parts that usually fail, and only then choose the platform that conforms to it. The architecture leads; the platform follows. That single reversal changes what a platform selection even is: instead of comparing vendor decks against each other, you score every vendor against an architecture you already own and have already tested.

It matters now because the hard things are arriving together. Agentic operations, tokenised deposits, real-time and cross-border rails, and tighter economic-crime obligations all land at once, and they cross domains that most banks built separately. A platform decision taken in that environment, on the strength of a reference architecture shaped by the vendor's own product, is a decision taken before the real questions have been answered.

## Architecture, proven before the commitment

Good strategy and architecture work defines what the bank should build. The harder question is whether the defined target state holds together once it is built, and that is the question worth answering before the budget is committed: does settlement stay final under this failure mode, can the audit trail reconstruct who was allowed to do what, do the domains share state without leaking it, does the edge degrade safely when the centre is unreachable. An executable layer answers it by proving the riskiest primitives, so the architecture rests on something that runs rather than on a vendor's reference diagram.

Regulators have moved the same way. The FCA, the PRA and the Bank of England increasingly ask for architectural evidence rather than assertions. "We will be resilient" is not an answer; a demonstrable account of how is.

So the work is built to be evidence, not narrative:

**Executable, not slideware.** Build the hard primitive and run it, so "this works" is something you can watch, not something you are asked to believe.

**A claim register.** Separate, in writing, what is substantiated from what is still blueprint. Stating plainly what is proven and what is designed is a discipline, and it is what a regulator and a board can rely on.

**Decision records.** The reasoning behind each architectural choice, kept, so the path from a proven primitive to a target state is legible rather than lost in a slide.

**Clean-room and vendor-agnostic.** No vendor intellectual property in the architecture. The target state stays yours, and every platform is evaluated against it rather than substituted for it.

**Cross-domain by design.** Payments, economic crime, custody, data and resilience are modelled together, the way a bank is actually organised, staffed and regulated, rather than as separate stacks that meet for the first time in production.

## What the bank ends up holding

A target architecture it owns and can defend. Proof that the hard primitives work, taken before the large commitment rather than discovered after it. A way to evaluate platforms against its own architecture. And architectural evidence it can take to a regulator. The platform decision becomes lower-risk because it is made last, against something proven, by a bank that now knows what good looks like.

<pre class="mermaid">
flowchart LR
  D["Executable demonstration<br/>proven primitives"] --> A["Target architecture<br/>+ decision records"]
  A --> B["Phased build"]
  B --> P["Platform selection<br/>against the proven architecture"]
</pre>

## One capability, three legs

A target architecture on its own is still a drawing. What makes it real is that it sits inside a way of working. It works as a capability with three legs: the target architecture (what good looks like, proven), the [operating model](/approach/) to build it, and the [capability intelligence](/capability-intelligence/) to staff it with the right people. The architecture says what to build; the operating model says how a small senior squad builds it without a transformation programme swallowing the bank; capability intelligence says who, on the evidence, can actually deliver it.

A short note on what is real, because it is the point of how we work. The propositions in our [Clean-Room Demonstration](/composable-bank/) are interactive demonstrations on synthetic data, built to production-grade controls. They are a demonstration, not production, and each is labelled for what it is. The deeper architecture, the schemas, the control internals and the platform topology sit in the post-MOU briefing, not on a public page. We would rather prove a primitive and be precise about the rest than imply a finished product.

## Where to start

Take one decision the bank is about to make: a core or platform choice, a tokenised-deposit pilot, an economic-crime re-architecture. Pick the primitive inside it that everyone is quietly unsure about, and prove that first. Our six-week Proposition Blueprint is built for exactly this: define the target architecture for one proposition, prove the part that usually fails, and reach a board-ready decision before the budget is committed.

The platform matters. It is simply not the first thing to decide. Prove the hard parts, define the architecture they imply, and choose the platform that conforms to it.

---
layout: corporate-post
title: "Data Products for Agentic Banking: The Layer a Transaction Model Can't Skip"
date: 2026-06-16
categories: [Banking, Architecture]
tags: [data-products, data-engineering, agentic, banking-transformation, bian, composable-banking, owned-autonomy, semantic-layer]
excerpt: "A transaction foundation model turns a bank's own event history into one reusable intelligence layer. But a model trained on raw events is not operable in a regulated bank until the data beneath it is governed. The missing layer is not the model. It is the data product."
author: Sailesh Panchal
---

There is a good argument going around, and it is worth taking seriously. NVIDIA has set out [why financial institutions are converging on transaction foundation models](https://blogs.nvidia.com/blog/financial-institutions-transaction-foundation-models/): instead of building a separate model for fraud, another for credit, another for churn, a bank trains one model on its own transaction and event history and reuses that learned representation across many tasks. Thoughtworks frames the same shift as [building a unified intelligence layer for payments](https://www.thoughtworks.com/en-gb/insights/articles/power-of-transaction-foundation-models-building-the-unified-intelligence-layer-for-payments) — moving from dozens of isolated feature pipelines to one shared backbone that learns "the language of money movement."

The strategic claim underneath both is the part that matters: **a bank's proprietary event history is the asset, not any single model trained on it.** That is correct, and it is the right place to be looking.

But it skips a layer. A foundation model trained directly on raw transaction logs is an impressive science project. It is not yet something a regulated bank can put in front of a fraud team, a credit committee, or the FCA. Between the raw event history and the reusable intelligence sits a layer that the model-centric framing tends to assume away — and it is the layer that decides whether any of this is operable.

That layer is the **data product**. And the argument of this note is simple: the missing unit in agentic banking is not the model. It is the *governed data product* — and a transaction-based platform is structurally advantaged at producing it.

## What "train on your own data" quietly assumes

"Train a model on the bank's transaction history" assumes the transaction history is a thing you can point a model at. In most banks it is not.

The event history is fragmented across card, account-to-account, acquiring, servicing, disputes, sanctions, app behaviour and open-banking systems — each a partial view, each with its own definitions. Even where the data is reachable, it arrives without the things that make it usable in a regulated decision:

- **Meaning.** What *is* this event? Two systems that both say "payment" rarely mean the same thing. A model learns the correlations in the noise; it does not learn the bank's intended semantics unless something supplies them.
- **Authority.** Who was permitted to cause this? A transaction with no attached mandate, consent or approval state is a number, not a governed fact.
- **Lineage and evidence.** Can you trace this from the customer action that triggered it to the control outcome it produced? If not, no regulator will accept a decision derived from it.
- **Sensitivity.** Which attributes are personal, special-category, or mandate-bound, and who is allowed to see or act on them?

A model can be brilliant at prediction and still be unusable, because the substrate it learned from cannot answer "who was allowed to do this, what does it mean, and can you prove it." The intelligence is only as governable as the data underneath it. **The hard part of agentic banking was never the model. It is the ontology and governance of the data the model and the agents both depend on.**

## The unit that fills the gap: the governed data product

A **data product** is a governed, reusable view of a banking concept — packaged with the things that make it safe to use, not just the values. It carries:

- a **governed meaning**, tied to business events and an accountable owner (a **Transaction Ontology**, not a folder of tables);
- **authority and consent** travelling *with* the data — mandates, permissions and approval states as first-class fields, not a separate lookup bolted on later (**consent-bearing data**);
- **lineage and evidence** — traceable from customer action to control outcome (**evidence-grade data products**);
- **sensitivity boundaries** — personal and mandate-bound attributes bounded by role, purpose and exposure policy;
- **reusable context** — one product serving many engines and propositions, so each team stops rebuilding its own private version of the bank.

This is the same discipline we apply to capabilities in the [Domain Building Block](/2026/06/13/domain-building-blocks-composable-banking/): take the thing everyone treats as a cross-cutting afterthought — controls and evidence — and promote it to a first-class property of the unit. A DBB does it for a *capability*. A data product does it for the *data that capability runs on*. They are the same move, one layer apart, and they are designed to fit: data products are structured around the same DBB, ABB and BIAN boundaries your architects already trust, so a product is portable and intelligible rather than a one-off extract.

## Why a transaction-based platform is structurally advantaged

Here is the part that is our own argument, not the industry's.

You can bolt a data-product layer onto any estate, and many banks will spend years doing exactly that — reverse-engineering meaning, authority and lineage out of systems that were never built to emit them. But if your platform is **transaction-based** — if business events, states, permissions, relationships and evidence are *native* to how it runs — then the governed data product is close to a by-product rather than a salvage operation.

We learned this the hard way, building it. Years ago we architected a UK payments platform whose authoritative source of truth was the **event log, not the ledger**. The accounting service was a downstream projection — a consumer of the event stream, not the centre of the system. That choice was made for operational reasons (scheme conformance, dual-site availability, multi-rail support), but the shape that fell out of it is exactly the shape this decade needs. When the sequence of events *is* the truth, every reusable data product is a governed projection of that same spine, rather than a fragile reconciliation across systems that each think they are the master.

We call that spine the **Governed Event Spine**, and it is the structural reason a transaction-based platform produces evidence-grade data products cheaply: the meaning, the authority and the lineage are recorded as the events happen, not reconstructed from logs afterwards. The same separation made another property fall out for free — **decisioning sat as a peer to settlement, not inside it.** That is what makes an agent's decision governable: when the decision is a separable, evidenced step rather than a side effect buried in a payment flow, "show me how this was authorised and recorded" has an answer by construction.

Two decades ago we used the same idea for a different proposition: a multi-currency vault we built for a yacht, where the owner could see the funds held against the asset and a defined set of authorised actors — captain and crew — could spend against it under policy, in two currencies. In today's language that is **proposition-native intelligence with policy-bounded actor authority** — exactly the grammar an agent needs, designed long before agents could use it. The architectural slot was right; the substance has caught up.

## From data product to engine — the reuse that actually compounds

Once the data products exist, the model-centric vision finally becomes deliverable — because now the reusable layer is *governed*, and the engines are built on it rather than around it.

<pre class="mermaid">
flowchart TB
  EV["Business events<br/>(card, A2A, servicing, disputes, mandates)"]
  ON["Transaction Ontology<br/>(governed meaning + accountable owner)"]
  SP[("Governed Event Spine<br/>event log as source of truth")]
  subgraph DP["Data products — governed, reusable"]
    P1["Party &amp; Relationship"]
    P2["Authority &amp; Consent"]
    P3["Transaction Context"]
    P4["Case &amp; Evidence"]
  end
  subgraph EN["Engines — built on the products"]
    E1["Fraud"]
    E2["AML / KYC"]
    E3["Risk"]
    E4["Reporting"]
    E5["Servicing"]
  end
  PR["Propositions &amp; agents<br/>(customer action · agent action · human oversight)"]
  EV --> ON --> SP --> DP --> EN --> PR
</pre>

Fraud, AML, KYC, risk, reporting and servicing stop being six private interpretations of the bank and become six consumers of the same governed products. A transaction foundation model, if the bank builds one, becomes one more consumer of that layer — a powerful one — rather than the thing the whole strategy depends on. The value to a Chief Data Officer is reusable intelligence with less duplicated data engineering and clearer domain ownership. The value to a CISO is the inverse and just as concrete: **purpose-bounded exposure, clearer trust boundaries, and auditability of exactly what each engine and agent can see and act on.** A shared governed foundation reduces duplication, improves lineage, and tightens data-exposure boundaries across every engine at once. That is the security argument for data products, and it is usually the one that gets left out of the model-centric pitch.

## We have already built the engine

This is where we part company with the think-pieces: the data-product-to-engine pattern is not a diagram we are hoping to validate. We have built the engine, and one proposition runs on it end to end.

Our [Family Wealth](/composable-bank/) proposition is live on our reference engine: a real flow in which governed data products become customer action, autonomous agent action, and human oversight, with the evidence produced as a by-product rather than reconstructed after the fact. It is the proof that the model is operational, not just coherent — an agent prepares and proposes, and a material action cannot execute until an authorised human records approval. That is the same [consent](/2026/06/15/consent-let-agents-act-without-authority/) and [context](/2026/06/15/context-shared-meaning-agents-need/) discipline that runs through [C3](/2026/06/14/c3-the-spine-of-owned-autonomy/), our Capability · Context · Consent reference architecture, and through what we call [Owned Autonomy](/2026/06/15/owned-autonomy-agentic-banking-a-bank-owns/) — a bank owning its agentic capability rather than renting it.

A short honesty note, because it is the point of how we work. One proposition is live; another is a working live demonstration; the rest are explicitly **blueprints**. The data-product catalogue in our [public product view](/composable-bank/data-products/) is an **illustrative operating model** — it shows the *shape* of each product, deliberately, not a claim that all of them are already built. The deeper material — the ontology internals, the schemas and canonical objects, the control maps and the platform design — sits behind an MOU, in the architecture discussion, not in a blog post. We would rather show you the product shape and prove one engine than imply a finished platform. Our Clean-Room Demonstration is built to production-grade controls on synthetic data: a demonstration, not production, and labelled as such.

## Where to start

The instinct, reading the transaction-foundation-model argument, is to start with the model. Start with the layer beneath it instead. **Build the governed intelligence layer first** — the data products — and the engines, and any foundation model you choose to train, become things you compose rather than megaprojects you gamble on.

That is what our **six-week Proposition Blueprint** is for: take one proposition, define the data products it needs and the DBBs and ABBs beneath them, and produce a board-ready recommendation — go, reshape, or stop — with an optional 90-day proof of a single bounded journey. You learn the real organisational cost of governed data on one proposition before you commit the estate.

The model-centric framing is right about the prize: your own event history, turned into one reusable intelligence asset. It is just one layer too high about how you get there. The reusable asset is not the model. It is the governed data product — and the bank that builds that layer first is the bank whose agents can actually be trusted to act.

---

*A public product view of the data-product model is maintained at [digital-transformation-advisory.com/composable-bank/data-products](/composable-bank/data-products/). This note stays at the architecture-decision level; the ontology and schema detail sit in the post-MOU architecture discussion by design.*

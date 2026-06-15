---
layout: corporate-post
title: "Context: The Shared Meaning Agents Can't Act Without"
date: 2026-06-15T00:00:00+00:00
categories: [Strategy, Architecture]
tags: [owned-autonomy, architecture, agentic, semantic-layer, measurement, data-engineering]
excerpt: "Context is the quiet plane of the C3 spine — a shared semantic layer plus measurement. Skip it and your capabilities won't compose, your agents can't be trusted across domains, and you can't prove the economics. Meaning is architecture, not documentation."
author: Sailesh Panchal
---

This is the second paper in the C3 series. The [overview](/2026/06/14/c3-the-spine-of-owned-autonomy/) sets out the spine — **Capability, Context, Consent** — that makes [Owned Autonomy](/) real. The first plane, Capability, has its own paper: [Domain Building Blocks](/2026/06/13/domain-building-blocks-composable-banking/). This one is about the plane almost everyone skips: **Context**.

Context is "what does this mean, and is it working?" It has two halves — a **shared semantic layer** and **measurement** — and a regulated bank that wants agents to act needs both before it needs anything clever.

## Why the quiet plane is the one that breaks you

Every large enterprise eventually hits the same wall: different teams use different definitions for *customer*, *relationship*, *account*, *mandate*, *settled*, *approved*. Each definition is reasonable in its own corner. Together they're a tax. Integration becomes translation. Controls drift product by product. Evidence from one journey can't be compared with evidence from another. The software all works; the organisation still doesn't compose.

You can survive that at human speed — people paper over the seams. You cannot survive it once an **agent** is reasoning across those seams and preparing actions. An agent that thinks "owner" means one thing in the family-wealth domain and something subtly different in payments will, eventually, prepare exactly the wrong action with total confidence.

## The shared semantic layer: meaning as architecture

The first half of Context is a **shared semantic layer** — canonical contracts and a common vocabulary that every Domain Building Block, every agent and every human draws on:

- the **party, relationship and asset graph** — who exists, how they're connected, and what they own, with relationship kept strictly separate from authority;
- the canonical distinctions between **money, movement, message and decision** — the legal-and-economic form of value, the rail that moves it, the instruction that describes it, and the authority that permits it, never conflated;
- shared **states and events** — what "pending", "authorised", "settled", "reconciled" mean, once, everywhere.

The move that matters is treating **meaning as architecture, not documentation**. A glossary on a wiki is a description; a semantic layer is enforced — the contracts the DBBs are built against. That's what lets capabilities *compose* rather than merely coexist, and it's the precondition for agents: an agent can only be trusted across domains if the entities, constraints and events it reasons over have stable meaning across the whole organisation. Without it, autonomy is brittle, because the ground shifts from one domain to the next.

ISO 20022 lives here, with a boundary worth stating plainly: it's a rich **message** standard *within* the semantic layer. It carries the instruction beautifully. It is not the money, the rail, or the meaning by itself.

## Measurement: proof, not reporting

The second half of Context is **measurement**, and it belongs in the spine for the same reason meaning does: in an agentic bank, you run agents not on faith but because you can *see* what they did and prove it was right.

So measurement is not a downstream reporting function bolted on at quarter-end. It's part of the runtime and the governance:

- **evidence-as-data** — every material step emits a record (the recommendation, the policy result, the approval, the outcome), produced as a by-product, not reconstructed from logs afterwards;
- **observability and reconciliation** — you can watch a capability work and prove the books balance;
- **agent and model evals** — you measure whether the agents are actually good, continuously, the way you'd measure any other control.

This is where the [operating model](/operating-model/) shows its hand. Growth in our model is **evidence-led**: the **Glass Tube** runs a single domain end-to-end so a bank can *watch and measure* the real organisational change and economics before scaling — not a slide deck claiming they'll appear. And the squad's **Data Engineer** owns data, evidence and measurement as a first-class job, not an afterthought. Measurement is how you turn "the demo looked great" into "here is the proven unit economic."

## Why this is the precondition for the other two planes

Capability and Consent both lean on Context. A Domain Building Block only *composes* with another if they share meaning. The Consent plane can only authorise and evidence an action if "this action, on this party, for this amount" is expressed in stable, shared terms. Get Context right and the other two planes click together. Get it wrong and you have local optimisation, semantic drift, duplicated controls, and evidence nobody can compare — which is most stalled "composable bank" programmes, diagnosed honestly.

Next in the series: **Consent** — how you let agents act without ever handing them authority. If shared meaning and measurable proof are where your transformation is stuck, [book a strategy call](/connect/).

---
title: Financial Intelligence — research brief and angle
type: intelligence-brief
status: for-review (proposed eighth Intelligence, INT-009)
date: 2026-06-23
related: docs/architecture/conflict-register.yml (INT-009, BIZ-001)
note: External statistics below are industry research, attribute on any public use; figures vary by source.
---

# Financial Intelligence

The angle, for review. Not yet built into the site.

## The problem it addresses

Transformations fail when the P&L impact is understood too late. The evidence is consistent:

- Around **70% of transformations fall short** of their objectives ([McKinsey](https://www.mckinsey.com/capabilities/people-and-organizational-performance/our-insights/common-pitfalls-in-transformations-a-conversation-with-jon-garcia)); only about **35% achieve their objectives** across 850+ companies ([BCG](https://www.bcg.com/publications/2020/increasing-odds-of-success-in-digital-transformation)).
- Of those that ship, only about **10% exceed profit expectations and 45% fall short** of them (McKinsey).
- Failed initiatives show **cost overruns averaging ~47%** ([Deloitte](https://www.deloitte.com/)), and organisations can lose a large share of invested capital.
- On the operating-model side, **67% of organisations without a documented target operating model reported significant cost overruns; with a clear one, 82% came within 15% of budget** ([Deloitte 2025 Global Operating Model Survey](https://www.deloitte.com/)).

The recurring root cause is not technology. It is **poor financial planning, unclear success metrics, business-case erosion, and the lack of an accountable financial owner (the CFO) early.** A business case is signed once, then nobody tracks projected against actual until the value has already leaked.

## What the financial lens covers

1. **As-is cost baseline** across the five dimensions you named: people, process, technology, infrastructure and property. What the bank actually spends to run today.
2. **Target operating-model cost** — the to-be cost base of the bank the transformation is building.
3. **The financial transition** — the gap between the two and how you cross it: dual-running, change-the-bank versus run-the-bank, and the investment-before-return curve that sinks many programmes.
4. **Value realisation** — the business case as a living thing: projected versus actual by initiative, hard and soft benefits, with a tracker rather than a one-off slide.
5. **Cost modelling of the operating model** — the squads and supporting roles, their run-rate and their fixed-capacity funding. DTA designs the squads, so it can model their cost.
6. **CFO buy-in** — a credible, holistic financial frame early enough to commit, not a reconstruction after the spend.

## DTA's role: direct the when and the scope, not the deep analysis

This is the important boundary. **DTA does not do the bank's full financial impact analysis** — that is the CFO and the finance function, with their own numbers. DTA provides the **financial frame** that gets the organisation to the right decision:

- the **shape** of the as-is, target and transition, so the P&L impact is visible early;
- the **cost model of the operating model DTA designs** (squads, supporting roles, fixed-capacity funding);
- a **value hypothesis per proposition** and the **tracker structure** to hold it to account;
- and the **sequencing and scoping guidance**: when to invest, where the investment-before-return curve sits, and what to protect versus cut.

Output: enough to get the CFO bought in and to scope and time the transformation. A frame and a direction, not a forecast. The proving ground feeds it real inputs (cost-to-serve, the performance envelope that drives infrastructure cost), but the audited numbers stay with the client.

## Interconnected by design

Financial Intelligence is not a silo, and that is the point you made. It reads from the other lenses:

- **Capability** supplies squad and role costs.
- **Platform** supplies infrastructure run-cost and the cost of dual-running with the core.
- **Value** supplies the P&L itself: deposits, margin, cost-to-serve.
- **Experience and Trust** supply the benefit side: retention, good outcomes, avoided harm.
- **Control** supplies the cost of control and risk.

**Business Architecture (BIZ-001) is the connective tissue**: it maps Intelligences and capabilities to propositions and their P&L. Every proposition, capability and squad carries a cost and a value; Financial Intelligence is where they meet, and Business Architecture is how they are tied to the proposition.

## Proposed canonical one-liner

> Financial Intelligence is understanding the P&L of change early: the as-is cost base, the target operating-model cost, and the transition between them, modelled enough to get the CFO bought in and to scope and time the transformation. DTA frames and interconnects it; the client owns the numbers.

## If adopted as the eighth Intelligence

- **Question:** do you understand the P&L of this change early enough to commit to it?
- **Outcomes it governs:** an early as-is baseline; a costed target operating model; a transition and dual-running plan; value realisation tracked against the case; a CFO-grade business frame.
- **Where we show it:** the operating-model squad and role cost modelling; the proving ground's cost-to-serve and performance-envelope inputs.
- **Related:** Capability, Platform, Value, Control, tied through Business Architecture.

## The decision for you

1. **Adopt as the eighth Intelligence** (the set becomes eight; homepage and hub rework, plus a page). Distinct CFO/P&L lens, and you feel it is missing. **Recommended.**
2. **Fold the financial lens into Capability, Platform and Value**, with Business Architecture named as the connective layer, and no separate eighth lens.

Recommendation: **(1)**. The financial blind spot is distinct enough, and commercially central enough, to deserve its own lens, with Business Architecture introduced alongside it as the tie. Note it is a canon change: "Seven" becomes "Eight" across the site.

## Expanded cost model (owner direction, 2026-06-23)

Adopted as the eighth Intelligence. The model must carry, at minimum:

**Cost base and funding**
- As-is cost base: people, process, technology, infrastructure, property.
- Suppliers and committed contracts: third parties, licences, outsourced deals, with terms and break points.
- Addressable versus committed funding: change is funded only from the addressable slice; committed/locked spend cannot be redirected. Cost the change against the addressable part, not the whole base.

**The shifted cost shape**
- When delivery was people, the doers (a two-pizza squad) were roughly 80% of cost, supporting staff the rest.
- AI-amplified engineering breaks that ratio. AI is its own cost line, to build and to run.
- Add setup (cloud, DevOps pipelines, data environments) and the governance the model now needs (AI governance, data governance, risk governance, security).

**One-off and transition**
- Setup / one-off: cloud, pipelines, data environments, tooling.
- Transition and dual-running: old and new worlds in parallel until proven.
- Decommissioning and contract exit, including break fees.
- Change, training and adoption.

**The value side (offsets)**
- Revenue uplift, cost-to-serve reduction, loss and fraud reduction, capital efficiency, retention. Hard and soft benefits, tracked projected versus actual.

**Run-rate versus one-off:** separate one-offs from the ongoing run-rate; the target run-rate is what the CFO ultimately commits to.

## Page versus paper

- **Website page** (`/financial-intelligence/`): specific, and shows the interlock - the other lenses as P&L contributors (Capability gives squad cost; Platform gives infra and dual-running; Cognitive gives AI build/run and AI governance; Control gives data/risk governance; Value, Experience and Trust give the benefit side). No citation dump.
- **This paper:** keeps the background citations and the failure evidence for internal reference and deeper engagement material.

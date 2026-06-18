---
layout: corporate-post
title: "Proving the Change Worked: The Outcome Gap the FCA Keeps Naming"
date: 2026-06-18
categories: [Banking, Architecture]
tags: [consumer-duty, customer-outcomes, outcomes-monitoring, evidence, data-products, owned-autonomy, c3, banking-transformation]
excerpt: "Three years into the Consumer Duty, the FCA keeps finding the same gap: firms can show what they did, but not whether it improved the outcome for the customer. That is not a reporting problem. It is an architecture problem, and repackaging existing data will not close it."
author: Sailesh Panchal
---

There is a question every bank now has to answer, and most still cannot: *did the change actually make things better for the customer?* Not "did we ship it," not "did the journey complete" — did the outcome improve, and can you prove it, for the groups it was meant to help.

This is not a hunch. It is the finding the regulator keeps publishing. The FCA's [Consumer Duty](https://handbook.fca.org.uk/handbook/prin2a) (Principle 12, PRIN 2A) requires a firm to *"act to deliver good outcomes for retail customers."* It has applied to open products since 31 July 2023 and to closed products since 31 July 2024. Three years in, the FCA's own reviews return the same verdict from different angles.

## The gap, in the regulator's own words

In its [insurance multi-firm review of outcomes monitoring](https://www.fca.org.uk/publications/multi-firm-reviews/insurance-multi-firm-review-outcomes-monitoring-under-consumer-duty), published in 2024 across twenty larger firms, the FCA found firms still basing outcomes monitoring on *repackaged existing data* — the very thing it had already warned was not enough. Numbers arrived with little narrative and no trend behind them. Thresholds were set so loosely they were almost impossible to breach. Red-amber-green ratings stayed green while the underlying data was deteriorating. And firms did not consistently monitor outcomes for different groups of customers, including vulnerable ones.

The [board-report reviews](https://www.fca.org.uk/publications/good-and-poor-practice/consumer-duty-board-reports-good-practice-areas-improvement) found the same shape from the top down: over-reliance on process-completion metrics rather than outcome metrics, and boards urged to push past MI dashboards to something that actually explains whether outcomes are good or poor.

One finding matters more than the rest for anyone running a transformation. The FCA reported that firms could not demonstrate **how improvements to customer outcomes were monitored after a change was made.** Read that again. A firm spots a poor outcome, changes something to fix it, and then cannot show whether the fix worked. That is the whole job of a transformation, and it is precisely the part the data could not evidence.

This is not a niche failing by a few stragglers. It is an acknowledged, recurring gap, named by the regulator across sectors and across years. The firms are not lazy. They are fighting their own data.

## Why the usual approaches cannot close it

Reach for the tools a bank already has, and you find they are either lagging or process-shaped. Complaints tell you about harm after it has landed. NPS and surveys sample sentiment, not outcomes. An MI dashboard counts steps completed. Sampling and manual file reviews do not scale to "every customer, every change, by group." None of them answers the Duty's actual question: *did this change improve the outcome, and for whom?*

You can close the gap with any of these, but only at a cost that climbs every reporting cycle: analysts hand-assembling narrative, joining spreadsheets to find vulnerable customers, reconstructing what a number means before a board can read it. That reconstruction *is* the complexity tax, and it is why the FCA keeps seeing repackaged data. Teams are not careless. The data they have is the wrong shape for the question they are being asked.

Here is the deeper reason, and it is the same one underneath [agentic banking's data problem](/2026/06/16/data-products-for-agentic-banking/): the outcome was never written down at the point of action. A bank records that money moved, a form was submitted, a journey finished — and discards the thing the Duty cares about. Did the customer understand the decision? Did the product suit them? Did the change help? The answer existed at the moment of the interaction and was thrown away. Everything after that is statistical reconstruction or hand-built narrative.

## The fix is structural, not editorial

You do not close this gap by writing a better board report. You close it by changing what the business records as it runs.

Treat every material change as a hypothesis about customer behaviour, and make the hypothesis explicit *before* you ship: the outcome it should produce, the metric that would show it, and the customer groups it has to hold for. Wire the measurement to the change rather than bolting it on afterward, and the "after a change" gap closes by definition — the before-and-after comparison exists because you defined it up front, not because someone went looking for it a quarter later.

Underneath that sit two signals from a single interaction, the pair we describe in our work on [data products](/2026/06/16/data-products-for-agentic-banking/):

- the **interaction microdata** — how the customer's intent actually formed: the sequence, the hesitation, where they needed help;
- the **governed decision trace** — what was decided, the authority that permitted it, the policy gate that fired, and the evidence emitted.

Monitoring by customer group then falls out of the data rather than being assembled on top of it. You are not joining tables to find vulnerable customers after the fact; the classification travels with the record. This is the same discipline that runs through [C3](/2026/06/14/c3-the-spine-of-owned-autonomy/), our Capability, Context and Consent architecture: when every material action leaves an evidence trail by construction, a board report becomes a *query over evidence the business already holds*, not a project to rebuild it. You cannot prove an outcome you never measured, and you cannot measure one your systems were never built to record.

## Why we can say this without hand-waving

We have built the evidence trail, not just drawn it. In our [Family Wealth demonstration](/composable-bank/), an agent cannot take a material action until an authorised human records approval, and each step emits evidence as a by-product rather than reconstructing it later. That part is real, and you can watch it run.

A short honesty note, because it is the point of how we work. The continuous outcome-monitoring loop in this piece is the *approach* we design with clients, and in parts a **blueprint**, not a live production product we are claiming every bank already has. Our Clean-Room Demonstration is built to production-grade controls on synthetic data: a demonstration, not production, and labelled as such. We would rather prove one engine end to end than imply a finished platform.

## Where to start

The Consumer Duty did not invent this problem. It made it unavoidable, and it put a regulator's signature on the diagnosis. The firms that struggle are the ones trying to evidence an outcome they never measured, from data that never carried it. No amount of dashboard polish fixes a substrate that threw the answer away.

So start one layer down. Take a single proposition, define the outcomes it is meant to produce and the data products that would evidence them, and build the measurement into the change from the first day. That is what our new [Customer Outcomes](/customer-outcomes/) view is about, and what the six-week Proposition Blueprint produces: a board-ready recommendation grounded in evidence you can actually stand behind. Get the substrate right on one journey, and "prove the change worked" stops being the hardest slide in the pack and becomes a query you can run.

---

*Consumer Duty is an FCA framework and the four outcomes are the FCA's. Our role is to help firms deliver and evidence good outcomes, not to certify compliance. Sources: [FCA Handbook PRIN 2A](https://handbook.fca.org.uk/handbook/prin2a); FCA, [insurance multi-firm review of outcomes monitoring](https://www.fca.org.uk/publications/multi-firm-reviews/insurance-multi-firm-review-outcomes-monitoring-under-consumer-duty) (2024); FCA, [Consumer Duty board reports: good practice and areas for improvement](https://www.fca.org.uk/publications/good-and-poor-practice/consumer-duty-board-reports-good-practice-areas-improvement).*

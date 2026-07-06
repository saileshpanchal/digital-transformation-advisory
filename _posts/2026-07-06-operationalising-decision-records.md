---
layout: corporate-post
title: "Decision Records Are Not Documentation: They Become Operational Control Points"
date: 2026-07-06 11:00:00 +0100
categories: [Banking, Architecture]
tags: [decision-records, tdr, mtdr, governance, operational-resilience, consumer-duty, decision-debt, banking-transformation]
excerpt: "Most organisations file decisions and then operate blind to them. When decisions, policies, obligations, controls, evidence, risks and services live in one governed graph, a decision record stops being paperwork and starts answering the questions boards actually ask."
author: Sailesh Panchal
---

Ask a CRO five questions about any system change that went wrong last year. What decision authorised it? What obligation does that decision satisfy? Which services depend on it? What risk did we accept when we took it? What evidence proves the control worked? In most organisations each answer lives in a different tool, owned by a different team, reconstructed after the fact by whoever drew the short straw.

That reconstruction cost is [decision debt](https://github.com/saileshpanchal/mtdr): the judgement behind decisions evaporates, and governance spends its time compensating for the missing intelligence.

## The record is the easy part

We have now published the format we use as an open standard. **TDR, the Transformation Decision Record**, with **MTDR** as its markdown reference format, is MIT-licensed, tool-neutral and regulator-neutral: [github.com/saileshpanchal/mtdr](https://github.com/saileshpanchal/mtdr). It records what was known at the time, by whom, with what confidence; the alternatives rejected; the options foreclosed; a named accountable owner. It ships with four practice skills, written for humans and structured so AI assistants can apply them directly, including a new intake skill that recognises when a conversation or an incident contains a decision worth recording at all. It works alongside ADRs, Confluence, LeanIX and your GRC platform; it replaces none of them.

The standard is deliberately the easy part. Give away the format. The hard part, and the valuable part, is what happens when the records stop being files.

## What changes when decisions join the graph

In our Accountable Bank, a clean-room demonstration on synthetic data, decision records are not documents in a folder. They are nodes in one governed graph, joined to the policies they cite, the regulatory obligations those policies satisfy, the controls that implement the policies, the evidence that proves the controls, the risks each decision carries (drawn from a taxonomy modelled in advance, not invented per decision), the services each decision governs, and the customer outcomes it affects. Powered by the Transformation Intelligence Platform, the whole chain is queryable, live, in the browser.

Then the five questions stop being an investigation:

- **What decision authorised this?** A traversal from the service to its governing decision, with the named owner on the record.
- **What obligation does it satisfy?** Decision to policy to obligation, one walk.
- **What depends on it?** The dependency graph answers with the blast radius: every service transitively impaired if this one fails.
- **What risk does it carry?** The pre-modelled risk, with its mitigating controls, and an honest zero where no control exists.
- **What evidence proves the control worked?** The evidence items on the chain, each declaring what kind of evidence it is and where it may travel.

There is a sixth question the graph makes possible, and it is the one that turns records into control points: **did the decision remain true when it was executed?** Each decision that governs a service carries a contract agreed at decision time: what the service is expected to do, what signals mean it is breaching, what response is approved. What actually happened folds back into the same graph, so divergence between the decision and reality is a query result, not a retrospective.

## From blueprint to demonstrated

Three weeks ago we described [the self-diagnosing bank]({% post_url 2026-06-16-the-self-diagnosing-bank-operational-resilience-as-architecture %}) and were explicit that incident assembly and blast-radius reporting were an architecture blueprint, not something running in our demonstrator. The first slice now runs. Blast radius and incident briefs are live traversals over the governed graph in the Accountable Bank: impacted services, governing decisions and their accountable owners, expected behaviour, obligations at risk, journeys and customer outcomes in the blast area.

Claims discipline, as always: the dependency data is curated from our architecture catalogue rather than discovered at runtime, the events are the demonstration log rather than live telemetry, and every evidence item in the demonstrator is synthetic. Self-registering services, live telemetry and autonomous repair remain design work, and the demonstrated repair path is deliberately conservative: repairs proposed in shadow and applied only on human approval.

## Why this matters to the accountable executive

Under SM&CR you personally attest to reasonable steps. Under Consumer Duty you evidence outcomes, not intentions. Under PS21/3 and DORA you demonstrate resilience rather than describe it. All three regimes ask, in different dress, the same question the graph answers structurally: *can the organisation prove why it acted, who authorised it, what risk it accepted, what outcome it protected, and what evidence supports that position?*

Start with the standard: it costs nothing and works with the tools you have. The record you write this quarter is the control point your successor queries in three years.

The public view above explains the capability model. Detailed contracts, event flows and topology remain in the protected Architecture Room; approved visitors can request access.

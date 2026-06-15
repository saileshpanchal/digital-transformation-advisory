---
layout: corporate-post
title: "Consent: How to Let Agents Act Without Handing Them Authority"
date: 2026-06-15T00:05:00+00:00
categories: [Strategy, Architecture]
tags: [owned-autonomy, architecture, agentic, consent, governance, accountability]
excerpt: "Consent is the control plane of the C3 spine: authority, policy, evidence and an agentic gateway. It's how a regulated bank lets an agent do more than advise while keeping explicit, inspectable control of what it's allowed to do — the architectural heart of Owned Autonomy."
author: Sailesh Panchal
---

This is the third paper in the C3 series. The [overview](/2026/06/14/c3-the-spine-of-owned-autonomy/) sets out the spine — **Capability, Context, Consent**. We've covered [Capability](/2026/06/13/domain-building-blocks-composable-banking/) and [Context](/2026/06/15/context-shared-meaning-agents-need/). This paper is about the plane that decides whether [Owned Autonomy](/) is real or just a slogan: **Consent**.

Consent is the "may this happen?" plane. It's the difference between an agent that advises and an agent that acts — and the reason a regulated bank can allow the second without losing control.

## Identity is not authority

Start with the most common and most expensive confusion in agentic systems. Identity and authentication tell you *who a principal is*. They do not tell you whether this action, by this principal, on behalf of this party, for this amount, at this moment, under this mandate, is **permitted** — in business, legal, operational and regulatory terms — and *provable* afterwards.

That second question is Consent, and it is a much richer thing than IAM. Membership of a family, a network or an org chart grants nothing by itself. A valid login is necessary and nowhere near sufficient. Consent is where the real decision lives.

## The four parts

Consent has four elements, and each has a distinct job:

- **Authority** — *who or what* may act, on whose behalf, within what delegation or mandate. Entitlements, mandates, power of attorney, multi-signature, delegated authority — all live here, and all are kept strictly separate from identity and relationship.
- **Policy** — *whether, when and how* the action may proceed: purpose, amount, timing, counterparty, jurisdiction, limits; allowed, prohibited, conditional, or escalated.
- **Evidence** — what happened and *why*: the inputs, the policy result, the approvals, the outcome. **Proof, not logs** — produced as the action runs, not reconstructed afterwards.
- **The agentic gateway** — the runtime point where authority and policy are checked, human approval is required where it must be, and evidence is captured, *before* the action is allowed.

## The agentic gateway: where theory becomes operation

The gateway deserves the spotlight, because it's where the architecture earns its keep. It is not an API proxy or an orchestration bus. It is the **runtime control membrane between agent intent and enterprise action**.

The principle is simple and absolute: **agents propose; the gateway disposes.** An agent may observe, gather context, prepare and recommend — but it never acquires authority by recommending. A material action cannot execute until authority is confirmed, policy is satisfied, and, where required, an accountable human records approval. In our working reference engine this isn't aspiration: a material proposal *throws* rather than executing until approval is recorded, and the evidence is produced as a by-product. Agents prepare; humans decide; the proof is automatic.

A well-designed gateway doesn't slow the bank down. It makes faster action *safe enough to permit* — which is the only kind of speed a regulator will tolerate.

## The principle underneath

All of this rests on one line we keep coming back to:

> **You cannot be accountable for what you do not control.**

Accountability is the obligation a regulated bank can never delegate; sovereignty over the agents, data and models is its precondition. Consent is where that principle becomes machinery — the plane that lets a bank answer, for every single agent action, *who authorised this, under what policy, and where's the proof.* That is the architectural heart of [Owned Autonomy](/): agentic capability the bank owns rather than rents, accountable and sovereign by construction.

## Boundaries worth stating plainly

- **Programmable payment ≠ programmable money.** Policy on an ordinary deposit (whether/when/how a payment runs) is not the same as conditions enforced in the monetary instrument itself.
- **Private-key control ≠ legal authority.** Holding a token or a key can prove control of a thing; it does not, by itself, confer the legal right to act.
- **Consent ≠ identity.** Worth repeating, because almost every "agent governance" pitch that's really just IAM trips on it.

That completes the C3 series — [Capability](/2026/06/13/domain-building-blocks-composable-banking/), [Context](/2026/06/15/context-shared-meaning-agents-need/), Consent — the spine beneath [our approach](/approach/) and every journey in our [Clean-Room Demonstration](/composable-bank/). If letting agents act safely is the problem on your desk, [book a strategy call](/connect/).

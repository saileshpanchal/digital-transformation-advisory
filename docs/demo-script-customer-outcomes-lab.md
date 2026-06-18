---
title: Customer Outcomes proving ground — 5-minute demo script
type: demo-script
status: blueprint
date: 2026-06-18
related:
  page: /customer-outcomes/
  prototype: ultim8-prototype (Family Wealth journey)
  public_demo: /composable-bank/family-wealth/
honesty: >-
  This describes a PROPOSED extension of the existing prototype, not a shipped
  product. The Family Wealth journey, its synthetic data, and the journey player
  exist today. The capture overlay, variant toggle, misunderstanding heatmap and
  evidence-pack export are the parts to build. Label demonstrated-vs-blueprint
  out loud during any walkthrough. Consumer Duty is an FCA framework; we help
  firms test and evidence outcomes, we do not certify compliance.
---

## What this is

A script for using the existing prototype as a **customer outcomes proving ground**, and for walking a prospect through the idea in five minutes. The pitch is not "we have a lab." It is: *we already built a working proposition prototype with real journey data, agent actions under controls, and a simple, extensible interface, and the same prototype can be turned into a place to test whether a proposition is likely to deliver good outcomes before the bank commits to build.*

**The differentiator.** Anyone can run a focus group on a static mock-up. The thing almost nobody can test is what happens to a customer's outcome when an AI agent acts for them: did they understand the agent's action, did they agree to it, could a vulnerable customer tell what happened, was there a control before anything material occurred. The prototype already runs agents under C3 controls (Capability, Context, Consent) with the evidence recorded, so it can test the agentic outcome question, not just the screen-comprehension one. Lead with this.

## What exists vs what to build

| Element | State | Notes |
|---|---|---|
| Family Wealth journey + synthetic data | **Built** | The realistic journey people step through. |
| Journey player / clickable UI | **Built, simple** | Deliberately minimal; designed to extend. |
| Proposition-setup panel (target market, vulnerability hypotheses, desired outcomes) | Build | A short form that frames the run. |
| Variant toggle (A/B of a message, fee explanation, control) | Build | Swap one screen's copy or control mid-walkthrough. |
| Session-capture overlay (tag confusion, drop-off, confidence) | Build | Moderator taps to mark a step; one keypress per signal. |
| Misunderstanding heatmap (per step, per lens) | Build | Reads from the capture overlay. |
| Outcome evidence pack (export) | Build | One-page board view: risks, harms, mitigations, changes. |

Say this out loud at the start of any demo, so the line between demonstrated and blueprint is never blurred.

## The five-minute script

**0:00 — Frame the problem (30s).**
"Most banks evidence customer outcomes after launch, when the journey is built and the fees are in the system. By then a poor outcome is expensive to fix. The FCA expects firms to test where customers struggle, not assume it away. So we test the proposition first, on a prototype, while it is still cheap to change."

**0:30 — Proposition setup (45s).** Open the setup panel. Enter a target market, one vulnerability hypothesis ("customers near a payment-difficulty threshold"), and the outcome the proposition should produce. "This is the hypothesis we are going to test, written down before anyone builds anything."

**1:15 — Journey walkthrough, with the agent in it (75s).** Play the Family Wealth journey as a customer would: onboarding, the key choice, a fee disclosure, a support path. Then reach the agentic step: the agent proposes a material action, and a human must approve before it executes, with evidence recorded. This is the part to dwell on. "A focus group can ask if they understood this screen. We can ask something harder: did the customer understand what the agent just did for them, did they mean to let it, and could they have stopped it? That is the outcome question agents create, and it is already running here."

**2:30 — Variant testing (45s).** Toggle the fee explanation to a clearer variant. "Same proposition, two ways of saying the same thing. In a real session we run both with customers and compare where understanding holds."

**3:15 — Session capture (45s).** Show the moderator overlay: tap to mark a confusion point at the fee step, a drop-off at eligibility, low confidence at exit. "Each tap is a recorded signal against the exact step, not a memory written up afterwards."

**4:00 — Misunderstanding heatmap (45s).** Open the heatmap. "Customers understood the headline benefit, in green. They misread the fee and the cooling-off terms, in red. That is the evidence a board and a regulator want, and it points straight at the two screens to change."

**4:45 — Evidence pack (15s).** Export the one-page pack: risks, observed harms, mitigations, design changes. "You leave with this, before you have spent a penny building the wrong version."

## Mapping to the page

- Five stages on the page = the five script beats (setup, walkthrough, variant, capture, evidence).
- Outcome lenses = the heatmap's columns (target-market fit, comprehension, fair value, support friction, vulnerability impact, exit friction).
- Agentic lenses (the differentiator) = agent-action comprehension, consent and control, intervention and override. These only exist because the prototype runs agents under controls.
- Outputs section = the evidence pack.

## Demo hygiene

- Use synthetic data only; never a real customer record.
- Name each built-vs-blueprint element as you reach it.
- Do not say "compliant" or "compliance-proven." Say "evidence the firm can use to make its own outcomes judgement."

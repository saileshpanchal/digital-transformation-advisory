# The C3 Architecture — Consent, Capability, Context

**A DTA working document — the architecture spine**
**Status:** Draft for discussion · **Owner:** Sailesh Panchal · **Created:** 2026-06-14

> **Interpretation note (correct me if a pillar's scope is off):** capturing "C3"
> as the three-pillar spine you sketched —
> **Consent** (authority, policy, evidence, agentic gateway),
> **Capability** (Domain Building Blocks), and
> **Context** (shared semantic layer + measurement) —
> the shared backbone every proposition and squad runs on.

---

## Why a spine

"One platform, many propositions" only works if three things are shared and
coherent across every proposition: **the right to act**, **the things you can
do**, and **the meaning and measurement** that ties it all together. Without a
shared spine, each proposition reinvents authority and vocabulary, agents can't
be trusted across domains, and "composable" collapses into copy-paste.

That backbone is **C3**. Capability does the work; Consent governs whether it
may and proves what happened; Context gives it shared meaning and tells you
whether it's working.

---

## The three pillars

### 1. Consent — the right to act ("may this happen?")

- **Authority** — identity, entitlements, mandates, delegated authority: *who or
  what* may act, and within what bounds.
- **Policy** — the rules: programmable controls (purpose, amount, time,
  counterparty), jurisdiction, limits — *whether, when and how* an action may
  proceed.
- **Evidence** — a tamper-evident record of what happened and why: audit,
  provenance, reconciliation. **Proof, not logs.**
- **Agentic gateway** — the controlled chokepoint where agents observe, prepare
  and recommend, and where authority + policy + human (or mandated) approval gate
  execution. **Agents propose; the gateway disposes.** Authority is never
  acquired by an agent making a recommendation.

*Boundaries:* programmable *payment* (control in the consent/policy layer) ≠
programmable *money*; private-key control ≠ legal authority.

### 2. Capability — what we can do ("what can we do?")

- **Domain Building Blocks (DBBs)** — reusable banking capabilities packaging
  journey + policy + controls + evidence + execution. Owned by squads, composed
  into propositions. (Our term, mirroring TOGAF's ABB.)
- **Architecture Building Blocks (ABBs)** — the shared technical/control
  infrastructure DBBs run on: party graph, event spine, ledger and projections,
  ports/adapters, observability.

*Boundary:* business variation lives in the **composition and configuration** of
DBBs, not in duplicated stacks.

### 3. Context — meaning and measurement ("what does it mean, and is it working?")

- **Shared semantic layer** — canonical contracts and a common vocabulary /
  ontology: the party / relationship / asset graph, and the **money / movement /
  message / decision** distinctions, so every DBB, agent and human shares
  meaning. Without it, services and agents talk past each other.
- **Measurement** — observability, metrics, evidence-as-data, reconciliation, and
  agent/model evals: the continuous feedback that says what's happening and
  whether it's working.

*Boundary:* ISO 20022 is a message standard *within* the semantic layer — not the
money, the rail, or the meaning by itself.

---

## How the three form the spine

Every action threads the spine in the same shape:

```
Observe  →  Agent prepares & recommends  →  Check authority & policy
   (Context: meaning + signals)              (Consent)
         →  Human / mandated approval  →  Execute a Domain Building Block
            (Consent: agentic gateway)        (Capability)
         →  Emit evidence + measurement
            (Consent evidence · Context measurement)
```

- **Capability** does the work.
- **Consent** governs whether it may, and proves what happened.
- **Context** gives it shared meaning and tells you if it's working.

This is *why* one platform carries many propositions: Capability is composed,
Consent keeps it safe and accountable, Context keeps it coherent and observable.

---

## How C3 maps to what we've already built

- **Money / Movement / Message / Decision** (the showcase model): Decision =
  **Consent**; Money & Movement = **Capability** (DBBs); Message + meaning =
  **Context** (semantic layer).
- **The agentic operating loop** (Observe → Recommend → Check → Approve → Execute
  & evidence) *is* Consent's agentic gateway in motion.
- **The squad model:** squads own **Capability** (DBBs); **Consent + Context**
  are the shared platform spine, owned by enabling / platform value streams.
- **Every proposition** — Family Wealth, Premium Yacht, Franchise Network,
  International Student, Cross-Border Real-Time Payments — runs on the *same* C3
  spine. That is the composability proof.

---

## The insight-paper series (plan)

| # | Paper | Thesis |
|---|---|---|
| 0 | **Overview — C3: the spine of a composable bank** | Why composability needs a shared backbone, and what the three C's are. *(Drafted as a post.)* |
| 1 | **Consent** — authority, policy, evidence, agentic gateway | How you let agents act without giving them authority; proof over logs. |
| 2 | **Capability** — Domain Building Blocks | Why the unit of reuse is a banking capability, not a service or a screen. |
| 3 | **Context** — the shared semantic layer & measurement | Why shared meaning is the precondition for agents, and measurement the precondition for trust. |

Each pillar paper: definition → why it matters → boundaries → how it shows up in
a proposition → what DTA helps with. Suitable to drip for LinkedIn/Medium.

---

## Open questions

- **Naming:** is "C3" the public-facing label, or an internal shorthand with a
  friendlier public name?
- **Depth/audience per paper:** executive insight, architecture paper, or both
  (exec post + technical appendix)?
- **Diagrams:** one canonical spine diagram reused, or a bespoke diagram per
  pillar?
- **Cadence:** drip the series, or publish together?

# The C3 Architecture — Capability, Context, Consent

**A DTA working document — the architecture spine of Owned Autonomy**
**Status:** Draft for discussion · **Owner:** Sailesh Panchal · **Created:** 2026-06-14

> **Reconciled with the parallel "Owned Autonomy" work (2026-06-14).** The site,
> the DBB paper, `docs/lexicon.md` and `docs/claim-register.md` standardise on
> **C3 = Capability · Context · Consent**. This doc follows that order. C3 is the
> *architecture*; **Owned Autonomy** (accountable + sovereign) is the *principle*
> it delivers.

---

## Why a spine

"One platform, many propositions" only works if three things are shared and
coherent across every proposition: **the capabilities you can do**, **the meaning
and measurement** that ties them together, and **the authority to act**. Without
a shared spine, each proposition reinvents capability and vocabulary, agents
can't be trusted across domains, and a bank can't answer for what its agents do —
so "composable" and "accountable" both collapse.

That backbone is **C3**. Capability does the work; Context gives it shared meaning
and tells you whether it's working; Consent governs whether it may act and proves
what happened.

---

## The three planes

### 1. Capability — what we can do

- **Domain Building Blocks (DBBs)** — reusable banking capabilities packaging
  journey + policy + controls + evidence + execution. Owned by squads, composed
  into propositions. (Our term, mirroring TOGAF's ABB.) **Full treatment: the
  flagship paper, _Domain Building Blocks: the unit BIAN doesn't give you_
  (`_posts/2026-06-13-…`).**
- **Architecture Building Blocks (ABBs)** — shared technical/control
  infrastructure DBBs run on: party graph, event spine, ledger, ports/adapters,
  observability.

*Boundary:* business variation lives in the **composition/configuration** of
DBBs, not in duplicated stacks.

### 2. Context — shared meaning and measurement

- **Shared semantic layer** — canonical contracts and a common vocabulary /
  ontology: the party / relationship / asset graph, and the **money / movement /
  message / decision** distinctions, so every DBB, agent and human shares
  meaning. (`docs/lexicon.md` is the seed of this layer.)
- **Measurement** — observability, metrics, evidence-as-data, reconciliation, and
  agent/model evals: the continuous feedback that says what's happening and
  whether it's working.

*Boundary:* ISO 20022 is a message standard *within* the semantic layer — not the
money, the rail, or the meaning by itself.

### 3. Consent — the right to act

- **Authority** — identity, entitlements, mandates, delegated authority: *who or
  what* may act, and within what bounds. (Identity ≠ authority.)
- **Policy** — purpose, amount, timing, counterparty, jurisdiction, limits —
  *whether, when and how* an action may proceed.
- **Evidence** — a tamper-evident record of what happened and why. **Proof, not
  logs.**
- **Agentic gateway** — the controlled chokepoint where agents observe, prepare
  and recommend, and where authority + policy + human (or mandated) approval gate
  execution. **Agents propose; the gateway disposes.**

*Boundaries:* programmable *payment* (control in the consent/policy layer) ≠
programmable *money*; private-key control ≠ legal authority.

---

## How the three form the spine

Every action threads the spine in the same shape:

```
Observe  →  Agent prepares & recommends  →  Check authority & policy
   (Context)                                  (Consent)
         →  Human / mandated approval  →  Execute a Domain Building Block
            (Consent: agentic gateway)        (Capability)
         →  Emit evidence + measurement
            (Consent evidence · Context measurement)
```

- **Capability** does the work.
- **Context** gives it shared meaning and tells you if it's working.
- **Consent** governs whether it may, and proves what happened.

This is *why* one platform carries many propositions, and why a bank can own its
agentic capability — accountable and sovereign — rather than rent it.

---

## How C3 maps to what we've already built

- **Money / Movement / Message / Decision:** Money & Movement = **Capability**
  (DBBs); Message + meaning = **Context** (semantic layer); Decision = **Consent**.
- **The agentic operating loop** (Observe → Recommend → Check → Approve → Execute
  & evidence) *is* Consent's agentic gateway in motion.
- **The squad model:** squads own **Capability** (DBBs); **Context + Consent** are
  the shared spine, owned by enabling / platform value streams.
- **Owned Autonomy** is the principle (accountable + sovereign); **C3** is the
  architecture that delivers it; the **clean-room demonstration** shows it
  running.
- **Every proposition** — Family Wealth, Premium Yacht, Franchise Network,
  International Student, Cross-Border Real-Time Payments — runs on the *same* C3
  spine. That is the composability proof.

---

## The insight-paper series (plan)

| # | Plane | Paper | Status |
|---|---|---|---|
| 0 | — | **Overview — C3: the spine of Owned Autonomy** | **Drafted** (`_posts/2026-06-14-c3-…`) |
| 1 | Capability | **Domain Building Blocks: the unit BIAN doesn't give you** | **Exists** (`_posts/2026-06-13-…`) |
| 2 | Context | The shared semantic layer & measurement | To write (builds on `docs/lexicon.md`) |
| 3 | Consent | Authority, policy, evidence & the agentic gateway | To write |

Each pillar paper: definition → why it matters → boundaries → how it shows up in
a proposition → what DTA helps with. Suitable to drip for LinkedIn/Medium.

---

## Open questions

- **Order confirmation:** standardised on **Capability · Context · Consent** to
  match the existing site/lexicon/DBB paper. Flag if you prefer Consent-first.
- **Depth/audience per paper:** executive insight, architecture paper, or both?
- **Cadence:** drip the remaining two papers, or publish together?

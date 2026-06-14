# Proposition: Cross-Border Real-Time Payments

**A DTA proposition spec — for the Composable Bank model**
**Status:** Draft for discussion · **Owner:** Sailesh Panchal · **Created:** 2026-06-14

> A fifth proposition for the showcase. This document is written in the same
> shape as the existing four (hero → graph → journey → agent loop → outcomes →
> clarifications → platform composition) so it can be built into the
> `ultim8-prototype` showcase and then wired into the public site. It is **not**
> live yet — no `/composable-bank/cross-border-payments/` route exists until the
> prototype build adds it.

---

## 1. The idea (in Sailesh's words, captured)

Open Banking enables cross-border **real-time** payments and updates the
**correspondent model** — from a SWIFT-and-nostro relay to real-time, locally
cleared movement.

- A multinational opens a **UK account in £**, **pre-funds** it, and then
  initiates payments **via API** (or programmatically) from, say, **Canada** —
  paying into the UK over domestic instant rails (Faster Payments) rather than
  through correspondent hops.
- In euro, **SEPA Instant + one-leg-out (OLO)** makes the equivalent possible
  where one leg sits outside the SEPA zone.
- **Tokenised deposits and stablecoins** make pre-funding, liquidity and
  settlement easier still.
- Real-world signal: *[to verify]* Lloyds Bank's "**Gem**" solution is cited as
  an example along these lines; few others appear to be following. **Spelling,
  product name and specifics to confirm before any public use.**
- The **flow value is high** — see market context below — and this should
  **compose into our model**, not sit as a separate stack.

---

## 2. Market context (why this matters)

Cross-border payments in 2025 (FXC Intelligence market-sizing):

| Use case | Flows 2025 | Share of flows | Revenue 2025 | Share of revenue | Take rate |
|---|---:|---:|---:|---:|---:|
| Wholesale | $164tn | 79% | $164.0bn | 26% | 0.1% |
| B2B LE (large enterprise) | $20.4tn | 10% | $48.5bn | 8% | 0.2% |
| B2B SME | $14.4tn | 7% | $191bn | 31% | 1.3% |
| B2C | $2.1tn | 1% | $51.3bn | 8% | 2.4% |
| C2B | $4.9tn | 2% | $105.3bn | 17% | 2.1% |
| C2C | $2.1tn | 1% | $64.5bn | 10% | 3.1% |
| **Total** | **$208tn** | | **$625bn** | | **0.3%** |

*Source: FXC Intelligence market-sizing and pricing datasets. (Attribution/licence
to confirm before publishing the figures on the public site.)*

**Read-through:** the value sits in **wholesale and B2B** ($199tn of the $208tn),
where take rates are thinnest and most exposed to disruption. A model that
removes correspondent hops — pre-funded local accounts + domestic instant rails +
API/Open-Banking initiation — competes on **speed, certainty and transparency**,
and lets a bank win share of enormous flows even as unit economics compress.

---

## 3. Proposition hero

**Audience:** transaction-banking, payments and treasury leaders at banks and
multinationals moving high-value cross-border flows; PSPs and platforms that
currently depend on correspondent banking.

**Commercial promise:** move money across borders in real time, with end-state
certainty, by replacing correspondent relays with **pre-funded local accounts,
domestic instant rails and API initiation** — and a clear path to tokenised
deposits and regulated stablecoins as they mature.

**Four outcomes:**
- Real-time, final settlement instead of multi-day correspondent uncertainty.
- Transparent, predictable cost and FX versus opaque lifting fees.
- Win share of high-value wholesale/B2B flows where incumbents are slow.
- A liquidity model (pre-funding, tokenised deposits) the treasury can control.

---

## 4. Relationship and asset graph

- The **multinational / originator** and its group treasury.
- **Pre-funded local accounts** held per currency/market (e.g. a £ UK account).
- **Local clearing identities** and instant-rail participation (Faster
  Payments; SEPA Inst; others by market).
- **Beneficiaries** and their local accounts.
- **Money forms**: bank deposit, tokenised bank deposit, regulated stablecoin,
  external fiat account represented in a shadow ledger.
- **Consents & mandates**: who may initiate, for how much, to whom, under what
  policy (programmable *payment* controls, distinct from programmable *money*).

Explicit separation: holding a pre-funded account and an API key permits
*initiation within mandate*; it does not by itself confer authority beyond the
agreed policy, and a token/private key does not equal legal title to underlying
value.

---

## 5. Interactive journey (deterministic demo)

1. Establish a **pre-funded local account** (e.g. UK £) and its initiation
   mandate.
2. From abroad (e.g. Canada), **initiate via API / Open Banking** within the
   mandate.
3. **Quote FX and route** over the appropriate instant rail (Faster Payments
   domestically; SEPA Inst one-leg-out for euro).
4. An **agent** prepares the payment: checks consent, liquidity, sanctions/AML
   signals, and rail status; recommends route and timing.
5. **Policy and a human (or mandated rule)** approve; the payment **executes,
   reconciles, and produces ISO 20022 evidence** — with tokenised-deposit or
   stablecoin settlement shown as an alternative leg.

---

## 6. Agent-native operating loop

Observe (liquidity, FX, rail status, screening) → Recommend (route, timing,
funding) → Check policy, mandate and authority → Human or mandated approval →
Execute, reconcile and evidence. Agents reduce preparation and reconciliation;
accountable authority and screening decisions remain explicit.

---

## 7. Commercial outcomes

- Capture share of **wholesale/B2B** flows with real-time certainty.
- Earn payments, FX and liquidity revenue while undercutting correspondent cost.
- Reduce reconciliation, investigation and "where is my payment" overhead.
- Open a credible path to **tokenised-deposit and stablecoin** settlement.

---

## 8. Required clarifications (money / movement / message / decision)

- **Correspondent vs real-time:** pre-funded local accounts + domestic instant
  rails replace correspondent relays; the bank still owns liquidity, screening
  and accountability.
- **Programmable payment vs programmable money:** API-initiated, policy-governed
  *payments* over ordinary deposits are not the same as conditions enforced in
  the monetary instrument itself.
- **Tokenised deposit vs stablecoin:** a tokenised deposit remains a claim on
  the issuing bank; a stablecoin's protections depend on issuer, backing and
  regime. Distinct legal and economic meanings.
- **ISO 20022 is the message, not the money or the rail.** It carries the
  instruction; it does not move or settle value.
- **One-leg-out** means one party sits outside the instant scheme's zone; the
  obligations and reachability differ from a fully in-scheme payment.

---

## 9. How it composes into the model

This proposition is deliberately **mostly reuse** — the proof that one platform
carries many propositions.

**Reused Domain Building Blocks (existing):** party & relationship graph,
identity & screening, consent/entitlements/mandates, accounts & wallets,
tokenised deposit, FX, ISO 20022 messaging, agentic decision gateway, evidence &
reconciliation.

**New DBBs this proposition introduces:**
- **Pre-funded regional account** (per-currency local account + liquidity view).
- **Instant-rail adapters** (Faster Payments; SEPA Inst incl. one-leg-out;
  extensible per market).
- **Correspondent/nostro-vostro shadow view** (so the old and new models can run
  side by side during migration).
- **Cross-border initiation** (API / Open Banking) under mandate.

**Architecture Building Blocks (shared):** event spine, double-entry ledger and
projections, shadow ledger, ports/adapters, policy & jurisdiction controls,
audit & observability.

This is also a strong **migration** story (ties to `/approach/` §7A): a bank can
stand the real-time model up *alongside* correspondent banking via shadow
integration, prove it on a corridor, then shift volume.

---

## 10. Research-backed callouts (to draft, then verify)

- Correspondent banking vs real-time cross-border (definition + boundary).
- SEPA Instant Credit Transfer and **one-leg-out** — scope, reachability, status.
- UK Faster Payments for inbound real-time settlement of pre-funded flows.
- Tokenised deposit vs stablecoin vs e-money (legal/economic distinctions).
- ISO 20022 as message standard, not rail/settlement.

---

## 11. Claims to verify before any public use

1. **Lloyds "Gem"** (name/spelling/scope) and the "few others following" claim.
2. **SEPA Inst one-leg-out** current availability and constraints (EPC scheme).
3. **FXC Intelligence figures** — attribution/licence to reproduce on the site.
4. Any specific corridor/FX/settlement-time claims used in the demo.

> Suggested next step: run a deep-research pass on items 1–2 against primary
> sources (EPC, Pay.UK, bank disclosures) before this proposition is published.

---

## 12. Build & wiring checklist (later)

- [ ] Add the proposition content object + page to the `ultim8-prototype`
      showcase (`/composable-bank/cross-border-payments/`).
- [ ] Per-route title/description/canonical + OG tags (as for the other routes).
- [ ] Add to the showcase index and the platform page.
- [ ] Add to the main-site links: homepage "See it in action" list, `/approach/`
      proposition list, footer/nav as appropriate.
- [ ] Run `scripts/check-public-showcase.sh` (no codenames; FXC attribution ok).
- [ ] Verify claims (§11) before publish.

> 🗨️ **To discuss:** Proposition name — "Cross-Border Real-Time Payments",
> "Real-Time Correspondent", or "Borderless Settlement"? And do we target the
> **wholesale/large-enterprise** buyer (huge flows, thin margin) or the **B2B
> SME** segment (smaller flows, far richer 1.3% take rate) as the lead use case?

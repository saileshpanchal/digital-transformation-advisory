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
- Real-world signal — **corrected by research:** Lloyds Bank's "**Gem**" exists
  but is a **cloud/API corporate cash-management & payments platform** (39
  currencies, direct UK/Euro clearing membership, FX) — **not** a SWIFT
  replacement or tokenised real-time-settlement product. And real-time /
  tokenised cross-border is a **crowded tier-1 field** (JPMorgan Kinexys, Citi
  Token Services, HSBC Tokenised Deposit Service, Visa B2B Connect, SWIFT's own
  shared ledger). So we will **not** claim Gem pioneered this or that "few
  follow." Our edge is the **composable + agentic + deposit-economics** model,
  not being first. (See Research findings §A.)
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

**Audience (lead):** **B2B SMEs** making and receiving cross-border payments —
the richest cross-border take rate. **Variation:** multinationals (e.g. franchise
merchant networks, multi-entity groups) running the same flows at scale on the
**same platform** — composes with the Franchise Network proposition. Buyers:
transaction-banking, payments and treasury leaders, and the banks/PSPs serving
them.

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

## 7a. The revenue stack — more than a service fee

The sharpest part of this proposition (Sailesh's angle): pre-funded local
accounts don't just enable a *chargeable* real-time service — **the pre-funding
itself is a deposit**, and deposits are exactly what banks are fighting for.
Three revenue layers stack:

1. **Service + FX margin.** A chargeable real-time cross-border service, plus FX
   margin earned on loading/converting the pre-fund. *(Indicative magnitudes:
   wholesale ~10–30 bps, SME/retail ~100–400 bps — directional ranges from
   vendor sources, not a quote; see §B.)*
2. **Net interest income on the balances.** Pre-funded balances are deposits the
   bank funds assets against — earning a spread even on overnight/short-dated
   money. Stable deposits are prized funding under Basel **NSFR** (95%/90% ASF
   for stable/less-stable retail & SME vs 50%/0% for corporate/financial
   wholesale). UK sight-deposit spreads have run ~**2–2.5pp**; reported UK bank
   NIMs ~**2.3–3.1%**. *(NSFR factors and BoE rates are citable; see §D.)*
3. **Agentic yield optimisation.** Automated, **policy-bounded** sweeps and
   allocation — including tokenised money-market funds and tokenised-deposit
   settlement — to maximise return on otherwise-idle balances, within
   human-gated limits. *(What's real vs hype: see §E.)*

The agentic layer turns idle pre-funding from a **cost** (trapped nostro
liquidity — a BIS-recognised drag) into a **managed, revenue-generating asset**.
That reframes the pitch from "a cheaper payment" to "win the deposit, earn the
float, and monetise the liquidity — safely."

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

## 11. Claims status (after deep research, 2026-06-14)

| Claim | Status | Action |
|---|---|---|
| Lloyds "Gem" pioneered real-time SWIFT replacement | **FALSE** | Drop. Gem is a cash-mgmt/API platform. |
| "Few banks are following" | **FALSE** | Drop. Reposition vs a crowded tier-1 field. |
| SEPA OCT Inst (one-leg-out) is live | **TRUE** (euro leg only) | Safe with the euro-leg caveat. |
| Pre-funded local-account model is real | **TRUE** | Safe; cite providers + BIS on liquidity cost. |
| Deposits prized (NSFR ASF factors) | **TRUE** | Safe; cite Basel. |
| UK sight-deposit spread ~2–2.5pp; NIM ~2.3–3.1% | **TRUE** | Safe; cite BoE / bank reports. |
| FX margin bps ranges | **INDICATIVE** | Use as ranges, not quotes. |
| "$27tn idle in nostro accounts" | **UNVERIFIED** | Do **not** attribute to BIS; drop or soften. |
| Stablecoin limits (£20k/£10m), 40/60 backing | **PROPOSED, not law** | Do **not** state as settled. |
| FXC figures ($208tn / $625bn) | **TRUE (published)** | Needs **FXC licence** to reproduce publicly. |
| $164tn wholesale split | **PARTIAL** | Behind FXC paywall; soften / attribute. |
| JPM $3bn/day, MMF AUMs | **PARTIAL** | Secondary sources; verify before quoting. |

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

> **RESOLVED:** Name = **Cross-Border Real-Time Payments**. Lead segment = **B2B
> SME** (richest cross-border take rate; largest retail revenue pool). The same
> platform also serves **multinationals — e.g. a franchise merchant network — as
> a variation**, not a separate build (ties to the Franchise Network
> proposition). This is the composability proof: one platform, SME as the lead,
> multinational as configuration.

---

# Public-safe copy draft (v1)

Build-ready copy with **no flagged claims** (no FXC figures, no "$27tn", no "few
banks", no proposed-as-final stablecoin numbers). Lead B2B SME; multinational as
variation.

## Hero

**Cross-Border Real-Time Payments**
Move money across borders in real time — without the correspondent-banking relay.

For B2B SMEs paying and getting paid internationally — and the multinationals
(franchise networks, multi-entity groups) that run the same flows at scale.
Pre-fund a local-currency account, initiate by API or Open Banking, and settle
over domestic instant rails. Faster money, transparent cost — and, for the bank,
a deposit worth winning.

## Four outcomes

- Real-time, final settlement instead of multi-day correspondent uncertainty.
- Transparent, predictable FX and fees.
- A deposit relationship — pre-funding earns net interest, even overnight.
- Liquidity that works — agentic, policy-bounded optimisation of idle balances.

## How it works (deterministic demo)

1. Open and pre-fund a local-currency account (e.g. GBP in the UK).
2. Initiate from abroad by API / Open Banking, within mandate.
3. Route over the right instant rail (Faster Payments; SEPA Instant one-leg-out
   for euro), with a live FX quote.
4. An agent checks consent, liquidity, screening and rail status, and recommends
   route, timing and funding.
5. Policy and an accountable human approve; the payment executes, reconciles and
   produces ISO 20022 evidence — with tokenised-deposit settlement shown as an
   alternative.

## The variation: multinational / franchise

The same building blocks serve a multinational running many entities and
currencies — e.g. a franchise merchant network. More accounts, more rails, more
approvals; the **same platform, identity, consent, ledger and evidence**.
(Composes directly with the Franchise Network proposition.)

## Say-it-carefully (boundaries)

- Pre-funded local accounts + domestic instant rails **reduce** correspondent
  hops; the bank still owns liquidity, screening and accountability.
- Programmable *payment* (policy on an ordinary deposit) ≠ programmable *money*.
- Tokenised deposit (a claim on the bank) ≠ stablecoin (issuer/reserve risk).
- ISO 20022 is the message, not the money or the rail.
- One-leg-out standardises the euro leg; the other leg isn't guaranteed instant.

---

# Research findings (deep research, 2026-06-14)

Method note: a six-angle fan-out (EPC, ECB, Pay.UK, BoE, FCA, BIS, FSB, bank
disclosures, FXC). Several primary sites (BoE, EPC, FCA, Citi, JPM, FXC) block
automated fetch (HTTP 403); figures flagged PARTIAL rest on search extracts /
reputable secondary summaries and should be confirmed against the primary PDFs
before client-facing use.

## A. Bank real-time / tokenised cross-border products

- **Lloyds "Gem"** exists — a cloud/API corporate cash-management & payments
  platform (39 currencies; direct UK/Euro clearing membership; FX). **Not** a
  SWIFT-replacement or tokenised real-time-settlement product. *(WELL-EVIDENCED
  it exists; feature wording PARTIAL — official page 403.)*
- The field is **crowded among tier-1s:** JPMorgan **Kinexys** (JPM Coin / JPMD
  deposit token, ~$3bn/day reported — PARTIAL); **Citi Token Services** + 24/7
  USD clearing (live, UK/US/SG/HK); **HSBC Tokenised Deposit Service** (live,
  multi-market); **Visa B2B Connect** (multilateral, correspondent alternative);
  **SWIFT** building a shared ledger for tokenised 24/7 settlement.
- "Few banks following" is **not fair**. Defensible narrower line: *few have
  live, at-scale, composable + agentic deposit-economics models.*
- Sources: Lloyds Gem page; jpmorgan.com/kinexys; Citi 24/7 USD clearing release
  (2025); about.hsbc.com.sg tokenised deposit; visa B2B Connect; swift.com
  payment-innovation.

## B. SEPA One-Leg-Out Instant (OCT Inst) + UK FPS

- **OCT Inst:** EPC scheme, live **28 Nov 2023**; 2025 rulebook in force **5 Oct
  2025**. Governs **only the euro leg** (settles via TIPS); the non-euro leg is
  out of EPC scope, so **end-to-end instant is not guaranteed**. Adherence
  voluntary. *(WELL-EVIDENCED.)*
- **UK FPS** uses a Bank-of-England **pre-funded settlement model** (a
  settlement-risk mechanism, not an open "park GBP and pay" facility). Access:
  directly-connected settling / non-settling participant, or agency. A non-UK
  entity needs **FCA authorisation** in practice; Wise was first non-bank direct
  participant (2018). **Open Banking PIS initiates from a payer's account — not
  the same as holding a pre-funded balance.** *(FPS model WELL-EVIDENCED;
  foreign-entity eligibility PARTIAL.)*
- Sources: EPC OCT Inst pages + 2025 rulebook PDF; ECB TIPS OLO doc; Pay.UK FPS
  participation; BoE non-bank PSP access; Open Banking Ltd PIS standards.

## C. Pre-funded local-account model & providers

- Recognised pattern: hold local-currency balances per market, pay out over
  domestic instant rails (FPS, SEPA, PIX, UPI, SPEI), reconcile internally — no
  money crosses the border per transaction. **Trade-off = trapped liquidity**
  (same economics as nostro). BIS/CPMI confirms prefunding's opportunity +
  regulatory-capital cost. *(WELL-EVIDENCED; some provider detail PARTIAL.)*
- Providers: **Banking Circle, Wise Platform, Nium, Thunes, Airwallex,
  Currencycloud (Visa), Citi** (90-market local clearing). Stablecoin pre-funding
  (USDC; Nium-Circle, Thunes) is emerging to cut trapped capital.
- **Do NOT publish** the "$27tn idle in nostro" figure as a BIS stat — untraceable;
  older estimates ~$5tn. Use BIS qualitative framing instead.
- Sources: bis.org CPMI d194/d205; wise.com/platform; bankingcircle.com; nium.com;
  thunes.com; airwallex docs; currencycloud; citigroup TTS.

## D. Deposit economics (the revenue case)

- Deposits are prized funding: Basel **NSFR ASF** 95% (stable retail/SME), 90%
  (less-stable), 50% (corporate <1yr), 0% (financial wholesale). *(WELL-EVIDENCED.)*
- BoE: higher Bank Rate incentivises competing for deposits; UK deposit **beta
  ~0.22** on 2022 hikes (PARTIAL — finance-press). Dec-2024 effective rates:
  sight ~2.17%, time ~3.74% vs Bank Rate ~4.75% → **~2–2.5pp** spread on sight
  balances. *(WELL-EVIDENCED — BoE.)*
- UK NIMs 2024–25: Lloyds ~2.95→3.06%, NatWest ~2.34% → **~2.3–3.1%**. NIB/float
  is effectively free funding (Curinos $32m illustration — PARTIAL).
- **FX margin:** wholesale ~10–30 bps; SME/retail ~100–400 bps (**indicative**;
  vendor sources). FCA (2025) confirms FX-markup **opacity** (Consumer Duty).
- Sources: bankingengland.co.uk transmission + effective-rates Dec-2024; BIS
  BCBS d295/d271 (NSFR); Lloyds/NatWest FY results; FCA Consumer Duty FX practice.

## E. Tokenised deposits / stablecoins / agentic yield

- **Tokenised deposit** = bank liability on a programmable ledger; stays in
  prudential perimeter, FSCS-eligible; depositor bears bank credit risk (rails
  change, not the claim). **Stablecoin** = issuer/reserve risk, no deposit
  protection; BIS says they can break "singleness of money." **E-money** =
  separate regime. *(WELL-EVIDENCED.)*
- UK 2025 regime is **consultation, not law:** FCA **CP25/14** (par redemption,
  statutory trust over backing); BoE systemic-stablecoin consult (proposed
  **£20k individual / £10m business** holding limits; ~40% unremunerated BoE
  deposits / ~60% gilts; no interest to holders). **Do not present proposed
  numbers as settled.** ECB building **Pontes/Appia** (central-bank-money DLT
  settlement, targeted Q3 2026).
- In production: **tokenised MMFs** (BlackRock BUIDL, Franklin BENJI), Citi/JPM
  tokenised-deposit rails, **Partior** atomic settlement. Specific AUM/volume
  figures PARTIAL.
- **Agentic automation** realistically adds continuous monitoring + rules-based
  sweeps/rebalancing **within policy limits, human-gated** — incremental, not new
  financial capability. **Private-key control ≠ legal title.**
- Sources: BoE systemic-stablecoin consult (Nov 2025); FCA CP25/14; BIS Bulletin
  73 + unified-ledger; FSB tokenisation (Oct 2024); EBA tokenised-deposit report;
  ECB papers; Partior; NY Fed tokenised funds; IMF agentic-AI-in-payments (2026).

## F. Market sizing (FXC + cross-checks)

- FXC: **$208tn flows / $625bn revenue (2025)** confirmed from FXC's own release;
  B2B SME largest retail revenue pool ($191bn); take rates tightened 2022–25.
  **$164tn wholesale split PARTIAL** (paywalled). Order of magnitude corroborated
  by McKinsey (~$150tn flows; ~$240bn revenue — narrower scope), Juniper (B2B
  ~$186tn), BIS (wholesale ~$145tn). FSB sets a ≤1% **retail** cost target and
  **no** wholesale target.
- **FXC licence required** to reproduce figures/chart publicly (their Terms allow
  internal use with attribution only). Paraphrase-with-attribution is safer; clear
  public republication with FXC.
- Sources: fxcintel.com press release + market-sizing pages + Terms; McKinsey
  Global Payments 2024; Juniper B2B; BIS CPMI brief10; FSB G20 targets + 2025
  progress report.

## Publish-safety summary

- **Safe (with attribution):** OCT Inst euro-leg; pre-funded model + BIS liquidity
  cost; NSFR factors; BoE deposit spreads & NIMs; the crowded-field competitor
  list; tokenised-deposit vs stablecoin distinctions.
- **Indicative only (label as ranges):** FX bps; deposit beta; NIB illustrations.
- **Do NOT publish without licence/verification:** FXC figures/chart (licence);
  "$27tn nostro"; proposed UK stablecoin limits/backing as if final; specific
  bank volumes (JPM $3bn/day) and MMF AUMs.

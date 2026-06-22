# BoE Systemic Stablecoin Issuer Code of Practice — primary-source fact-check

**Date:** 2026-06-22 · **Status:** internal research, not public copy · **Owner:** DTA

**Source (primary):** *The Bank of England Systemic Stablecoin Issuer Code of Practice* — **DRAFT**, 38 pages, read in full from the issuer's PDF. Accompanies a BoE Policy Statement and a **consultation on the draft Code of Practice**.

## Headline correction (read this first)

The document is a **DRAFT Code of Practice out for consultation**, not a finalised, in-force rulebook:

- Every page is watermarked **DRAFT**; commencement is a placeholder `[dd/mm/yy]`.
- It is made under s189 Banking Act 2009 and a *[statutory trust enabling power]*; **footnote 1 states legislation is still required** to give the Bank powers for the statutory trusts.
- Open placeholders remain: the FCA Handbook rule reference for a redemption request; `4.3 [in an insolvency/failure [TBD]]`; the monetisation-risk haircut is *"[the haircut applicable under the Bank's liquidity facility for systemic issuers]"* with **footnote 2: "Subject to the Bank confirming the availability of a liquidity facility … and setting the applicable haircuts in due course."**

**Claim implication:** for DTA public copy the regime stays **proposed / consultation stage**. Cite specific provisions as *"the BoE's draft Code of Practice"*, attributed, with a "draft, not yet in force" caveat. **Do not** say "finalised", "the rulebook is written", or "settled law". This keeps the existing claim-register stance (`§D`: proposed / developing) correct.

## Verified provisions (usable, BoE-attributed, draft-caveated)

| Provision | Verified detail | CoP location |
|---|---|---|
| Backing assets | Pool is **exclusively** central bank money + short-term UK government debt securities | Part 2, 1.1 |
| Central bank money minimum | **≥ 30%** of product total (best endeavours); hard notify floors at < 20%, or < 25% for 5 consecutive business days | Part 2, 1.2–1.4; defs |
| "Short-term" gilts | UK govt, GBP, **residual maturity ≤ 186 days** (~6 months) | Part 1 defs |
| Repo / reverse repo | Permitted; **max maturity 1 business day**; reverse repo over-collateralised | Part 2, 2.1–2.3 |
| Two statutory trusts | **Backing assets trust** + **wind-down reserve trust** (pending enabling legislation) | Part 3, 4.1 / 4.7 |
| Safeguarding excess | May retain **up to 5%** excess in the backing pool | Part 3, 3.15(2) |
| Daily reconciliation | **Internal and external safeguarding reconciliation at least once each business day**; identify + resolve discrepancies by end of business day; investigate, evidence, notify the Bank | Part 3, 3.5–3.22 |
| GBR capital | **Higher of** (a) 6 months operating expenses or (b) aggregate cost of recovery actions + orderly wind-down | Part 4, 3.1 |
| Financial risk reserve | Interest-rate + monetisation + counterparty-credit components, via PRA CRR methods | Part 4, 4.2–4.5 |
| MMF eligibility | Short-term MMF units eligible for **capital / liquid assets** (NOT the backing pool) | Part 4, 3.7 |
| Redemption SLA | **≤ 24 hours** from receipt of a *full* redemption request (KYC/AML complete + coins returned); in GBP unless holder asks otherwise; fair/transparent fees | Part 5, 3.3 / 4 |
| Remuneration | **No interest on holding/retention**; activity-based payment rewards permitted | Part 6, 1.1–1.2 |
| Issuance guardrail | **Must not issue where a product's total exceeds £40 billion** (temporary); notify + plan if exceeded/expected | Part 7, 1.1–1.2 |
| Records | 5-year retention | Parts 3 / 7 |

## In the pasted analysis but NOT verifiable from this CoP — do not use

- **"Definitive / finalised PS, rulebook written"** — contradicted (it is draft + consultation).
- **"Confirmed: Central Bank Liquidity Facility"** — explicitly **subject to confirmation** (footnote 2). Treat as proposed, not confirmed.
- **"CPMI-IOSCO aligned GBR", "Monte Carlo"** — not in the CoP text (CoP requires 1-in-1,000 stress scenarios; no CPMI-IOSCO or Monte Carlo named). Unverified.
- **"95% → 70% gilt step-up", FCA→Bank transition path, non-sterling deference, DSS guidance, FSRC, digital-pound dual-track** — not in the CoP (would be in the PS/other papers). Unverified from this source.
- **Individual £20k / business £10m holding limits "replaced by £40bn"** — this CoP contains only the £40bn product guardrail; holding limits are not in it. Cannot confirm the "replaced" framing here.

## Why this is DTA ground (the defensible connection)

The CoP's **daily internal + external safeguarding reconciliation, discrepancy identification and resolution, minting/burning adjustment, evidence retention, and Bank notification** (Part 3, 3.5–3.22) are the *same problem* DTA's Phase 9 work addresses: the ledger commit journal (9P, merged), drift detection / clean-drift-incomplete classification (9A, in review), and repair (9B, planned). A systemic stablecoin issuer must continuously prove backing-pool value equals product total and resolve divergence on a clock — that is reconciliation + evidence-by-construction, DTA's exact reference-architecture territory, plus Sailesh's payments/economic-crime background.

## Recommended use (held until claims signed off)

Not an 8th Intelligence. Work it in as **Value Intelligence depth** (programmable money, backing, settlement, redemption) reaching **Control** (capital, safeguarding, reconciliation) and **Trust** (redemption, consumer protection), plus:

1. One **Experience Journey** — "Sterling Stablecoin / Systemic Issuer" (**Blueprint**), anchored on the prototype's **Substantiated tokenised-deposit** demo and the reconciliation architecture.
2. **Value Intelligence + Architecture Library** enrichment (a settlement / backing-and-reconciliation reference architecture).
3. One **Insight** post demonstrating command of the draft regime.

**Discipline for all of the above:** BoE-attributed; "draft Code of Practice, in consultation, not yet in force"; **advisory + reference architecture + proof, not a builder of GBR calculators or trust deeds** (partner for treasury-quant and trust-law); **no pricing public**; route every figure through the claim register.

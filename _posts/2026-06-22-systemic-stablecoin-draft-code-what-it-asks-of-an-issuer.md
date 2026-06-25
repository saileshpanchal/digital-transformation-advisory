---
layout: corporate-post
title: "The systemic stablecoin rulebook is taking shape. Here is what the draft Code asks of an issuer."
date: 2026-06-22
categories: [payments]
tags: [stablecoins, payments, regulation, reconciliation]
description: >-
  The Bank of England has published its Policy Statement and, in Appendix 4, a
  draft Code of Practice for systemic stablecoin issuers. It is not yet in
  force, but it is specific enough to design against now.
---

The Bank of England has published its Policy Statement on sterling-denominated systemic stablecoins, and with it, in Appendix 4, a draft Code of Practice for systemic stablecoin issuers. The Bank intends to finalise the Code by end-2026, after which it will apply to recognised systemic issuers. It is a draft and a consultation, not settled law. It is also specific enough that a serious issuer can start designing against it today.

Here is what the draft Code actually asks for, and the one part most teams underestimate.

## What the draft Code requires

**Backing.** A systemic issuer must hold a backing asset pool made up exclusively of central bank money and short-term UK government debt securities, with at least 30% in central bank money and the short-term gilts limited to a residual maturity of 186 days or fewer. One-day repo and reverse repo are permitted, with over-collateralisation. This is active treasury management, not a passive deposit held in a drawer.

**Safeguarding.** The Code sets out two statutory trusts, a backing assets trust and a wind-down reserve trust, with the enabling legislation still to come. An issuer may hold up to a 5% excess in the backing pool. It must run an internal and an external safeguarding reconciliation at least once every business day, identify any discrepancy between the backing pool and the value of coins in issue, and resolve it by the end of that day.

**Capital and reserves.** General business risk capital is the higher of six months of operating expenses or the cost of the issuer's recovery and orderly wind-down. On top of that sit a financial risk reserve, calculated from interest-rate, monetisation and counterparty-credit components, and a wind-down reserve.

**Redemption.** A holder must be able to redeem, and the issuer must complete redemption no later than 24 hours after a valid request, meaning once the customer-due-diligence checks are done and the coins are returned. No undue fees.

**Remuneration.** No interest on holding a coin. Activity-based rewards tied to using it as a means of payment are allowed.

**Scale.** A temporary issuance guardrail caps any single systemic stablecoin product at 40 billion pounds, with a duty to notify the Bank and submit a plan if a product approaches it.

## The part most teams underestimate

Read the safeguarding chapter again. An issuer must prove, every business day, that the value of the backing pool equals the value of the coins in issue, find any divergence, and resolve it before the day closes, with the evidence retained. That is not a reporting task bolted on at the end. It is a reconciliation and evidence problem designed into the ledger from the start.

This is the discipline we build for. Our prototype's reconciliation layer keeps an authoritative commit journal, proves a derived shadow agrees with the ledger, classifies any divergence as clean, drift, or incomplete, and repairs it under a maker-checker approval, without ever mutating the authoritative ledger. A systemic stablecoin issuer needs exactly that shape: continuous proof that backing equals issuance, divergence surfaced rather than papered over, and a record a supervisor can read.

## Where DTA helps

We are an independent advisory. For an issuer or a bank weighing this, we define the target architecture, prove the difficult parts in a working model, and leave a vendor-neutral specification: the backing treasury and reconciliation design, the redemption path against the 24-hour clock, the safeguarding and trust structure, and the evidence trail the Code expects. We partner for the treasury-quant and trust-law detail rather than pretending to own it. We do not sell a platform, and we do not present a draft provision as a current legal requirement.

The Code is not final, and the statutory trusts still need legislation. The shape is clear enough to design against now, and the issuers that treat reconciliation and evidence as architecture, rather than reporting, will be the ones ready when it is.

*Source: Bank of England, Policy Statement on sterling-denominated systemic stablecoins, and the draft Code of Practice for systemic stablecoin issuers at Appendix 4. Provisions cited are from the draft, which the Bank intends to finalise by end-2026.*

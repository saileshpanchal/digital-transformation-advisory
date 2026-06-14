---
title: "Cross-Border Payments: The Real Prize Is the Deposit, Not the Fee"
date: 2026-06-14
categories: [Strategy, Payments]
tags: [cross-border-payments, real-time-payments, stablecoins, tokenised-deposits, correspondent-banking, open-banking, deposits, composable-banking]
excerpt: "Cross-border payments are being rebuilt on real-time rails and pre-funded local accounts. Most of the conversation is about cheaper, faster payments. The bigger prize is the deposit — and the net interest, FX and liquidity revenue that sits on top of it."
author: Sailesh Panchal
---

Cross-border payments are enormous — industry market-sizing runs to hundreds of trillions in annual flows — and the value is wildly uneven. Wholesale dominates the volume but earns the thinnest take rates; the richer margins sit in **B2B SME** payments, where smaller businesses still pay a lot to move money across a border slowly.

The usual pitch for fixing this is "faster and cheaper." Real-time rails, fewer hops, lower fees. That's real, and it matters. But it frames the opportunity as a race to the bottom on price — and it misses the bigger prize.

The bigger prize is the **deposit**.

## How the model is changing

The traditional way to move money across a border is correspondent banking: a chain of banks, each holding accounts with the next, relaying the payment and the message (over SWIFT) until it arrives — often days later, with fees and FX lifted along the way, and limited certainty about when it lands.

The model that's replacing it looks different:

- **Pre-fund a local-currency account** in the destination market — say, a sterling account in the UK.
- **Initiate the payment from abroad** by API or Open Banking, within a mandate.
- **Settle over the destination's domestic instant rail** — Faster Payments in the UK, SEPA Instant in the euro area — rather than relaying through correspondents.

The money is already in the country; the cross-border leg becomes a local, real-time payment. In euro, the European Payments Council's [One-Leg-Out Instant Credit Transfer scheme](https://www.europeanpaymentscouncil.eu/what-we-do/epc-payment-schemes/one-leg-out-instant-credit-transfer) (live since late 2023) standardises the euro leg of exactly this kind of payment — though it's worth being precise: it governs the euro leg, not an end-to-end instant guarantee.

This is not a fringe idea. The largest transaction banks are already building it — JPMorgan's Kinexys, Citi Token Services with 24/7 USD clearing, HSBC's tokenised deposit service, Visa's B2B Connect, and SWIFT's own shared-ledger work. The direction of travel is settled. The open question is who does it *well* — and who captures the value beyond the payment fee.

## The deposit hiding in plain sight

Here's the part most of the "faster, cheaper" framing skips. **The pre-funding is a deposit.** And deposits are precisely what banks are fighting hardest to win right now.

Stack up the revenue:

1. **The service and the FX.** A chargeable real-time cross-border service, plus the FX margin earned loading and converting the pre-fund.
2. **Net interest on the balance.** Pre-funded balances are deposits the bank funds assets against — earning a spread *even on money held overnight*. Stable deposits are the funding banks value most; liquidity rules like the Net Stable Funding Ratio reward them far more than wholesale money. At today's rates, the spread on instant-access balances is meaningful, not rounding-error.
3. **Liquidity that works for you.** Idle pre-funding has always been a cost — trapped nostro liquidity is a recognised drag on correspondent banking. Automated, policy-bounded treasury actions — sweeps, money-market allocation, increasingly tokenised settlement — can turn that idle balance into managed yield, within human-approved limits.

So the pitch isn't "a cheaper payment." It's: **win the deposit, earn the float, and monetise the liquidity — safely.** That's a transaction-banking proposition with three revenue layers, not one.

## Where stablecoins and tokenised deposits fit

This is where the tokenisation conversation becomes concrete rather than hype. Oliver Wyman's recent analysis, [*Stablecoins are coming for Europe's payments profit pools*](https://www.oliverwyman.com/our-expertise/insights/2026/may/stablecoins-impact-european-payments.html), makes two points worth holding together: stablecoins are starting to erode payments profit pools — beginning in **wholesale** — and, where real-world (non-crypto) usage exists at all, it skews heavily to **B2B** (their analysis puts it around 58%). At the same time, penetration into everyday payment flows is still limited, and Europe trails the US.

Read alongside the pre-funding model, the implication is clear. Tokenised money makes pre-funding and settlement easier and more continuous — top up a local position on demand, settle 24/7 — which strengthens exactly the B2B cross-border use case.

But the distinctions matter, and they are not cosmetic:

- A **tokenised bank deposit** is still a claim on the issuing bank, inside the prudential perimeter, with the same protections as a normal deposit. The rails change; the legal claim doesn't.
- A **stablecoin** carries issuer and reserve risk, not deposit protection. Its safeguards depend entirely on the issuer and the regime.
- The regimes are still being written. The EU's MiCA framework is live; in the UK the FCA and the Bank of England are *consulting* on stablecoin rules — so the detail isn't settled, and nobody should design as if it were.

Get those boundaries right and tokenisation is an accelerant. Get them wrong and you've imported risk you didn't price.

## Why we think about this as one composable proposition

None of this is a standalone product. It's a proposition you should be able to **compose** from capabilities you already have — identity, consent and mandates, accounts and wallets, FX, ISO 20022 messaging, an agentic decision gateway, evidence and reconciliation — plus a few new building blocks: pre-funded regional accounts, instant-rail adapters, and cross-border initiation.

We treat each of these as a **Domain Building Block**, owned by a small, senior squad, grouped into a value stream aligned to the proposition. Lead with the **B2B SME** use case, where the margin is richest. Then the *same* platform serves a **multinational — a franchise merchant network, a multi-entity group** — as a variation, not a separate build: more accounts, more rails, more approvals, but the same identity, consent, ledger and evidence underneath. That's the whole point of a composable bank: [one platform, many propositions](/composable-bank/).

And it's the part incumbents and founders both underestimate. The payment is the visible 10%. The deposit economics, the liquidity management, the screening and the accountability are the other 90% — and they're where the money and the risk actually live.

If you're rethinking cross-border — whether you run a bank, a sub-division, or you're building something new — this is exactly the kind of work we help with: [our approach](/approach/) starts with the architecture and the proposition, then builds the squad to deliver it. [Book a call](/connect/) if it's on your desk.

---

*Sources and further reading: [Oliver Wyman — Stablecoins are coming for Europe's payments profit pools](https://www.oliverwyman.com/our-expertise/insights/2026/may/stablecoins-impact-european-payments.html); [European Payments Council — One-Leg-Out Instant Credit Transfer](https://www.europeanpaymentscouncil.eu/what-we-do/epc-payment-schemes/one-leg-out-instant-credit-transfer); [BIS Bulletin 73 — Stablecoins versus tokenised deposits](https://www.bis.org/publ/bisbull73.htm).*

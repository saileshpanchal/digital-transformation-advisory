# DTA Website — Claim Register

**Purpose.** Every material claim the public website makes must be honest. This register is the single source of permitted wording for **website copy** (Home, Approach, Showcase links, Insights). No copy ships a claim that is not listed here with an approved status and wording.

**Authority split.** The authoritative audit of *what the demonstrator actually does* is the prototype's own **`docs/marketing-claim-audit.md`** (maintained alongside the live demo). This register does **not** duplicate it — for any demo-capability claim, defer to that audit and the live **"Live engine" / "Blueprint" badges** in the showcase. This register governs the **website-specific** claims the audit doesn't cover: the spine vocabulary, market/macro facts, industry-context citations, track record, and boundary rules.

**Metadata.** Verification date: **2026-06-14** · Register owner: DTA (Sailesh) · Demo-audit owner: the demonstrator/marketing stream.

**Status taxonomy.** *Substantiated* (backed by code that runs in tests/the live demo) · *Partial* (mechanism narrower than the words) · *Aspirational/Blueprint* (described, not implemented — must be labelled) · *External* (third-party fact — attribute, never imply as DTA's) · *Needs-source* / *Needs-sign-off* / *Needs-trademark-check* (cannot ship until resolved here).

---

## Material-claims tracking (v5 schema)

Each material claim is tracked by: **source** (repo + commit/file, or external URL) · **owner** · **approval status** · **expiry** (re-verify by) · **pages using it** · **status**. Default expiry is quarterly; demo-capability rows expire whenever the prototype `marketing-claim-audit.md` changes.

| Claim | Source (repo + commit / file) | Owner | Approval | Expiry | Pages using | Status |
|---|---|---|---|---|---|---|
| 3 propositions on the live engine (Family Wealth, Int'l Student, Premium Yacht); Franchise = blueprint | prototype `marketing-claim-audit.md` (feat/live-marketing-demos) | demo/marketing stream | Approved | on audit change | index, approach, /composable-bank/ | Substantiated (live engine) |
| Cross-Border Real-Time Payments — live showcase proposition (EUR→GBP inbound; B2B SME lead, multinational variation; **public-safe copy only** — no FXC/$27tn/proposed-stablecoin/"few banks" claims). **Claim softened (fact-check 2026-06-15):** promise is a "real-time cross-border payment *experience*" (pre-funded local accounts + domestic instant rails + API initiation), not universal end-to-end instant settlement — OCT Inst governs the euro leg only; FPS is a pre-funded settlement model. | prototype `dbb-crossborder-payment` + `runtime-crossborder` (tests green); `marketing-claim-audit.md` #7/#8/#10; EPC/BoE/FCA per the proposition doc | demo stream | Approved | on audit change | composable-bank/cross-border-payments, index, approach | Substantiated — Live engine (simulated FX/settlement feeds) |
| "Clean-Room Demonstration" — technical capability; production-quality in design; platform not yet product-ready | this repo `index.html`, `approach.html` | DTA | Approved | 2026-09-14 | index, approach | Substantiated (wording) |
| Agents prepare; humans approve material actions; evidence per step | prototype `agentic-gateway` tests | demo stream | Approved | on audit change | index, approach | Substantiated |
| Owned Autonomy / C3 / Accountability–Sovereignty / Clean-Room Standard / Glass Tube / DBB | `docs/lexicon.md` | DTA | Approved (DTA-original) | 2026-09-14 | index, approach, operating-model, posts | Coin & own |
| SFIA-defined, FPE-led squad (skill *names*, no levels) | `docs/squad-operating-model.md` (sanitised) | DTA | Approved | 2026-09-14 | index, approach | Substantiated (sanitised) |
| SFIA 10 contributor; SFIA use properly licensed; SFIA® trademark | SFIA Foundation relationship | Sailesh | Approved | 2026-12-31 | approach, capability-intelligence | External — sourced |
| Capability Intelligence — outcome positioning ("high-performance squads"; brief→evidence→squad→growth); SFIA codes invisible | spec 2026-06-14; SFiA-AI engine | DTA | Approved | 2026-09-14 | capability-intelligence | Substantiated (capability + wording) |
| Capability Intelligence worked example | synthetic; SFiA-AI engine (extraction/evidence/gaps/collaborators Generated/Derived; collaboration-optimised composition + Managed Cycle = Illustrative future) | DTA | Approved (labelled synthetic + provenance) | 2026-09-14 | capability-intelligence | Substantiated with provenance labels |
| WEF Future of Jobs 2025 (63% skill gaps / 85% upskilling) | weforum.org | Sailesh | Attribute only | 2026-09-14 | capability-intelligence | External — sourced |
| Privacy — "sensitive client, candidate and employee information can be processed on device or within a controlled environment" | DTA delivery capability (governed AI; on-device/controlled-env) | DTA | Approved (capability statement; no infra/security-tier detail) | 2026-09-14 | capability-intelligence | Substantiated (capability statement) |
| Two Blueprints distinct (Proposition Blueprint = offer; Capability Blueprint = work-product) | `docs/lexicon.md` | DTA | Approved | 2026-09-14 | approach, capability-intelligence, index | Coin & own |
| SFIA tools (SFiA-AI / jobfinder / recruitment) status | repos; jobfinder app "coming soon", recruitment pitch-stage | Sailesh | **No public product links yet** | 2026-09-14 | (none) | Not linked |
| ~~"none are built on SFIA" market claim~~ | — | — | **Removed** (unsubstantiable) | — | (none) | Deleted v6 |
| Track record (Metro, Lloyds, JPM, Travelex, Orwell) | existing leader bio | Sailesh | Approved (existing bio) | 2026-12-31 | index | Approved |
| Prior licensed-banking platform (ipagoo) | — | Sailesh | **Needs-sign-off** | — | (none until signed off) | Needs-sign-off |
| "The Accountable Bank" as a brand | — | Sailesh | **Needs-trademark-check** | — | (none; use "Clean-Room Demonstration") | Needs-TM |
| Market/macro facts (2028 repricing, FXC sizing, FCA/BoE) | external + prototype thesis (marked external) | Sailesh | Attribute only; FXC needs licence | 2026-09-14 | (posts, attributed) | External |

---

## A. Demonstrator capability — DEFER to `marketing-claim-audit.md`

As of 2026-06-14 the live demo backs more than it used to. **Do not restate demo capability from memory** — pull current status from the prototype audit and the on-page badges. Summary the website may rely on:

| Proposition | Status | Website may say | Review |
|---|---|---|---|
| Family Wealth Hub | **Substantiated — Live engine** (mock external feeds) | "runs on the live engine" | 2026-06-14 |
| International Student Banking | **Substantiated — Live engine** (mock external feeds) | "runs on the live engine" | 2026-06-14 |
| Premium Yacht Portfolio | **Substantiated — Live engine** (mock external feeds) | "runs on the live engine" | 2026-06-14 |
| Cross-Border Real-Time Payments | **Substantiated — demonstrated with labelled mocks** (EUR→GBP inbound; claims #7/#8/#10 in the prototype audit revised) | "demonstrated, with simulated external feeds" | 2026-06-14 |
| Franchise Network Operations | **Blueprint** (honestly labelled) | "a design blueprint" | 2026-06-14 |

Rule: external feeds are **simulated** (FX, settlement, valuation, card) — say "simulated/mock external feeds," and "a recorded entitlement, not a card processor." Cards = recorded entitlement only.

---

## B. Platform & architecture claims (website wording)

| Claim | Status | Permitted website wording | Review |
|---|---|---|---|
| Agents prepare; humans approve material actions; everything leaves evidence | **Substantiated** (agentic-gateway HITL gate, tested) | "Agents prepare; a human approves every material action; each step leaves evidence — demonstrated in our live engine." | 2026-06-14 |
| Common-platform architecture (one engine, many propositions) | **Substantiated (narrowed)** — several propositions now run on one engine | "One governed engine carrying multiple propositions — three run live today, with more as blueprints." | 2026-06-14 |
| Tokenised deposit with 1:1 backing | **Substantiated** | State plainly. | 2026-06-14 |
| ISO 20022 / Faster Payments on the same engine | **Substantiated** (standalone + cross-border inbound) | "ISO 20022 messaging on the same engine." | 2026-06-14 |
| Demonstrations use simulated services, no live customer money | **Substantiated** | Keep this disclaimer visible (the Clean-Room Demonstration Standard). | 2026-06-14 |

---

## C. The offer (reused site-wide)

| Claim | Status | Permitted wording | Review |
|---|---|---|---|
| Offer ladder: Talent & Squads → Build & Run Propositions → Owned Autonomy Transformation | **Engagement model** | Describe as engagement shapes; lead with talent for the fast path. Hold the premium ("control-grade, not body-shop"); do not read as staff-aug. | 2026-06-14 |
| Six-week Proposition Blueprint → optional 90-day Proof | **Substantiated as advisory offer** (self-qualified) | Keep the qualifier: advisory and decision-oriented; not a claim a production platform is built in six/ninety days. | 2026-06-14 |
| Advisory IP model — client builds their own blueprint; DTA model/method/reference architecture stay DTA IP | **Engagement model** (per `squad-operating-model.md`) | "You keep the capability; our opinionated model stays our IP." | 2026-06-14 |

---

## D. Market / macro claims (EXTERNAL — attribute, never imply as DTA's own)

| Claim | Status | Permitted wording | Review |
|---|---|---|---|
| 2028 profit-pool repricing; 9% / $170bn at risk; Lloyds/NatWest/JPMorgan/HSBC facts | **External** (the thesis note marks these as external, not prototype outputs) | Always attributed ("McKinsey estimates…", "Lloyds settled…"). | 2026-06-14 |
| Cross-border market sizing (FXC: $208tn flows / $625bn revenue) | **External — licence required** | Do not reproduce FXC figures/chart without an FXC licence; paraphrase-with-attribution only. See the cross-border proposition's claims table. | 2026-06-14 |
| "feedback window closed 3 July 2026" | **DATE DEFECT** | ❌ Future date written as past. Use "closes 3 July 2026" or omit. | 2026-06-14 |
| FCA/BoE tokenisation vision (20 May 2026); UK stablecoin limits (£20k/£10m, 40/60 backing) | **Needs-source / proposed-not-law** | Cite primary FCA/BoE source; never state proposed numbers as settled. | 2026-06-14 |

---

## E. Approach-page industry-context claims

| Claim | Status | Permitted wording | Review |
|---|---|---|---|
| Forward Deployed Engineer (FDE), Palantir-origin | **External — sourced** ([Palantir blog](https://blog.palantir.com/a-day-in-the-life-of-a-palantir-forward-deployed-software-engineer-45ef2de257b1); [Wikipedia](https://en.wikipedia.org/wiki/Forward_Deployed_Engineer)) | Cite as industry context, not a DTA brand. | 2026-06-14 |
| IBM Forward Deployed Unit (FDU): humans at the edges, agents in the middle, under human direction | **External — sourced** ([IBM Newsroom, 14 May 2026](https://newsroom.ibm.com/2026-05-14-A-New-Way-to-Make-AI-Actually-Work-in-the-Real-World); [IBM Think](https://www.ibm.com/think/insights/conversation-forward-deployed-engineers-incomplete)) | Attribute to IBM; never as a DTA capability. | 2026-06-14 |

---

## F. Spine & lexicon terms (see `docs/lexicon.md`)

| Term | Status | Permitted wording / rule | Review |
|---|---|---|---|
| **Owned Autonomy** | **DTA original — coin & own** | Lead term: "agentic capability a bank owns rather than rents — accountable and sovereign." | 2026-06-14 |
| **C3 (Capability · Context · Consent)** | **DTA original — coin & own** | Reference architecture; DBB = the Capability plane. | 2026-06-14 |
| **The Accountability–Sovereignty Principle** | **DTA original — coin & own** | "You cannot be accountable for what you do not control." | 2026-06-14 |
| **Clean-Room Demonstration Standard** | **DTA original — coin & own** | The honesty discipline: isolated, synthetic data, production-grade controls, explicitly non-production. Always "a demonstration, not production." | 2026-06-14 |
| **DBB (Domain Building Block)** | **DTA original** | A reusable banking capability (journey + policy + controls + evidence + execution); sits alongside TOGAF's ABB. | 2026-06-14 |
| **"accountable banking"** | **Catch-phrase — pre-trademark** | Use freely (lowercase) across posts and site to build mindshare; trademark later. | 2026-06-14 |
| "agentic banking" / "agent-ready banking" (Zafin) / "autonomous finance" etc. | **Descriptor-only** | Use to be understood; never claim as DTA coinage. | 2026-06-14 |
| **"The Accountable Bank"** (proper-noun product name) | **Needs-trademark-check** | ❌ Do not launch as a brand until cleared. The visible demo label is "**our Clean-Room Demonstration**"; keep the `/composable-bank/` slug. | 2026-06-14 |
| Internal architecture codenames | **Off public site** | Kept in private notes / the book only. Banned in this public repo by `scripts/check-public-showcase.sh`. | 2026-06-14 |

---

## G. Credibility / track-record claims

| Claim | Status | Permitted wording | Review |
|---|---|---|---|
| Team architected the prior licensed-banking platform (ipagoo) | **Needs-sign-off** | Only with Sailesh's confirmed wording; sensitive history. | 2026-06-14 |
| Senior roles at Metro, Lloyds, JPM, Travelex | **Approved (existing bio)** | Use the leader-bio wording already on the site. | 2026-06-14 |

---

## Pre-publish checklist (gates every copy PR)

1. Every claim maps to a row here (or, for demo capability, to the prototype's `marketing-claim-audit.md`) with a resolved status.
2. Live-engine propositions carry a "Live engine" badge; Franchise carries "Blueprint." (Owned by the showcase build.)
3. No future date is written as past (re-check the 3 July 2026 line).
4. Market facts attributed; FXC figures not reproduced without licence.
5. Run `scripts/check-public-showcase.sh` — zero forbidden-codename hits in the repo and built site; no "for sale" / "production platform" overclaim.

---

## Internal positioning notes (NOT public) — cross-border (fact-check 2026-06-15)

- **PMF (corridor-based, not universal):** High fit = cross-border SMEs with repeat payables/receivables · mid-market multi-entity corporates · **banks/PSPs embedding it** (they monetise the deposits). Medium = large global corporates (incumbents already have local clearing). **Low = retail remittance** (over-built; price/simplicity matter more). Believable promise = "predictable execution on key corridors, with auditability, API control and liquidity I control," not "send money anywhere instantly."
- **Revenue spine (durability order):** NII/float on pre-funded balances → FX spread → platform/SaaS fees (API, treasury controls, reconciliation) → liquidity services (sweeps) → per-txn/corridor fees → compliance value-adds. **Deposit economics is the core, not payment fees.**
- **Differentiator:** the pre-funded-local-rails model is **commoditised** (Banking Circle, Nium, Thunes, Airwallex, Currencycloud). DTA's edge is the **owned, accountable, agentic, deposit-economics** integration — not being first or fastest. The **agentic layer is an enhancer/differentiator, not the primary revenue engine.**
- **Claim discipline:** "real-time cross-border" → "real-time cross-border *experience*"; OCT Inst = euro-leg only; FPS = pre-funded settlement model; FCA CP25/14 = consultation (proposed, not law). (Sources: EPC, BoE, Pay.UK, FCA — per the proposition doc's research.)

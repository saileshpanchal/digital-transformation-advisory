# DTA Composable Bank Microsite

**Date:** 2026-06-13  
**Status:** Design approved; written spec ready for review  
**Owner:** Digital Transformation Advisory Ltd  
**Public path:** `/composable-bank/`

## 1. Purpose

Build a DTA-led microsite that shows prospective bank partners what it takes to create modern banking propositions across business model, customer experience, operations, controls, culture, and technology.

The microsite does not sell a software product. It demonstrates DTA's thought leadership and ability to help a bank:

- shape a differentiated proposition;
- connect the proposition to a credible operating model and P&L;
- define the domain and architecture building blocks;
- prove key journeys through a deterministic browser experience; and
- agree a bounded design-partner pilot.

The working TypeScript prototype remains supporting evidence. DTA may show it to approved technology and architecture teams, but the public story must not present Ultim8, Heimdall, or any reference implementation as a production platform for sale.

## 2. Audience and Desired Decision

### Primary audience

Bank executives responsible for strategy, propositions, transformation, wealth, retail banking, commercial banking, operations, and technology.

### Secondary audience

Architecture, engineering, data, security, risk, compliance, payments, and operations teams that need to assess whether the propositions share a credible platform model.

### Desired decision

The visitor should agree that:

1. the four propositions are commercially meaningful;
2. one coherent platform can support them;
3. agent-native operations can reduce back-office cost without removing accountable authority;
4. DTA understands the whole-bank change required; and
5. a scoped design-partner pilot is the right next step.

## 3. Positioning

### Core message

**DTA helps banks turn ambitious propositions into controlled, operable pilots.**

DTA brings proposition strategy, customer experience, P&L design, operating model, culture, controls, data, and modern architecture into one transformation approach.

### Supporting messages

- One platform can support many countries, languages, currencies, products, brands, and customer experiences.
- Business variation belongs in proposition configuration and domain building blocks, not duplicated technology stacks.
- Agents can observe, prepare, reconcile, and recommend. Policy and accountable people retain authority.
- Programmable money and programmable payments are different concepts.
- A tokenised bank deposit, regulated stablecoin, external fiat account, and shadow-ledger balance have different legal and economic meanings.
- ISO 20022 describes business messages; it is not the money or the settlement mechanism.
- A shadow ledger improves visibility and control; it does not silently replace an external bank's authoritative ledger.

## 4. Experience Architecture

The public microsite will be a data-driven React application built as static multi-page output. Each clean path will contain an `index.html`, so direct links work on GitHub Pages without a server-side router or 404 workaround.

### Public routes

| Route | Purpose |
|---|---|
| `/composable-bank/` | Executive landing page and proposition selector |
| `/composable-bank/family-wealth/` | Family Wealth Hub drill-down |
| `/composable-bank/premium-yacht/` | Premium Yacht Portfolio drill-down |
| `/composable-bank/franchise-network/` | Franchise Network Operations drill-down |
| `/composable-bank/international-student/` | International Student Banking drill-down |
| `/composable-bank/platform/` | Common platform, money model, agentic model, DBB, and ABB summary |

The landing page will include the pilot configurator. Every proposition and platform page will return to that conversion path.

### Protected deployment

Detailed technical material will remain in a separate Cloudflare Pages deployment protected by Cloudflare Access.

Public pages may link only to an access-request action. They must not contain protected diagrams, contracts, event flows, ledger design, adapter boundaries, deployment topology, technical due-diligence material, or production secrets.

## 5. Public Landing Page

The landing page must move from executive value to proposition choice, then to common-platform confidence and a pilot decision.

### Page sequence

1. **DTA thesis**
   - Lead with the bank outcome, not the reference technology.
   - State that DTA joins proposition, P&L, experience, operating model, culture, controls, and architecture.
   - Label the browser interactions as deterministic demonstrations, not live banking services.

2. **Agent-native operating model**
   - Show the common loop: Observe → Recommend → Check → Human approve → Execute and evidence.
   - Explain that agents reduce preparation, reconciliation, and servicing effort.
   - Keep decision rights, policy, and human accountability explicit.

3. **Four propositions**
   - Give each proposition enough commercial substance to invite exploration.
   - Show its economic outcome, target relationship, distinctive capability, and interactive proof.
   - Remove generic headings such as "Choose a proposition" when the space can carry stronger proposition content.

4. **One common platform**
   - Show that experiences vary while identity, permissions, orchestration, events, ledgers, evidence, and adapters remain coherent.
   - Link to the full public platform page.

5. **DTA transformation model**
   - Cover proposition and P&L, customer experience, operating model, people and culture, risk and controls, and production architecture.

6. **Technical access**
   - Explain what an approved technology audience can inspect.
   - Open a prefilled email request to `sailesh.panchal@digital-transformation-advisory.com`.

7. **Pilot configurator**
   - Let visitors select proposition, market scope, proof focus, and success measure.
   - Generate a downloadable text brief.
   - Generate a prefilled email to Sailesh.
   - Store and transmit nothing from the page.

## 6. Shared Proposition-Page Pattern

All four drill-down pages will use one component system and one content schema. This consistency should prove platform reuse without making the propositions feel templated.

### Required sections

1. **Proposition hero**
   - Audience and relationship model
   - Commercial promise
   - Four economic or operating outcomes

2. **Relationship and asset graph**
   - Parties, entities, accounts, assets, roles, and declared relationships
   - Explicit separation between relationship and authority
   - Hover or keyboard-focus explanations for major nodes

3. **Interactive customer and operating journey**
   - Four or five selectable steps
   - Step detail, control implications, agent contribution, and evidence produced
   - Step, autoplay, reset, and replay where a sequential demonstration adds value

4. **Agent-native operating loop**
   - Observe
   - Recommend
   - Check policy and authority
   - Human or mandated approval
   - Execute, reconcile, and evidence

5. **Whole-bank transformation lenses**
   - Proposition and P&L
   - Customer experience
   - Operating model
   - People and culture
   - Risk and controls
   - Production architecture

6. **Public capability architecture**
   - Proposition-specific Domain Building Blocks
   - Shared Architecture Building Blocks
   - Hover and focus detail for each block
   - Link to the common platform page

7. **Conversion**
   - Request full architecture access
   - Shape a design-partner pilot

### Interaction rules

- Hover detail must also open on keyboard focus and tap.
- Tooltips must not contain essential information that is unavailable elsewhere.
- Cards and graph nodes must expose clear accessible names.
- Motion must stop or simplify under `prefers-reduced-motion`.
- Page state must reset deterministically.
- No public interface will describe which capabilities are built, planned, missing, or production-ready.

## 7. Proposition Designs

### 7.1 Family Wealth Hub

#### Commercial proposition

Help a bank recognise connected family relationships, retain deposits across generations, and create governed pathways into housing, education, enterprise, and wealth transfer.

#### Graph

- grandparents, parents, children, and other declared relationships;
- independent, joint, and child accounts;
- pooled goals and individually owned contributions;
- attorneys, delegates, and multi-signature groups; and
- consented relationship insight for suitable offers.

Family membership never creates implicit account access, transaction authority, data visibility, or lending rights.

#### Interactive journey

1. Onboard independent customers and create declared graph connections.
2. Create a pooled saving goal with ownership, access, and payment controls.
3. Add conventional or tokenised contributions without merging legal ownership.
4. Let an agent prepare a housing, education, or wealth opportunity.
5. Apply Power of Attorney, multi-signature, customer, and bank approval rules before execution.

#### Commercial outcomes

- retain family deposits;
- originate next-generation relationships;
- improve wealth continuity and relevant offers; and
- reduce manual servicing and case preparation.

#### Required clarification

Deposits support lending through the bank's balance sheet. The experience must never imply that one family member's deposit is directly lent to another.

### 7.2 Premium Yacht Portfolio

#### Commercial proposition

Give private clients and family offices one governed view across owners, yacht-owning companies, operating companies, vessels, employees, contractors, operational money, and financeable asset value.

#### Graph

- beneficial owners, fractional owners, directors, advisers, and lenders;
- multiple holding and operating companies;
- multiple yachts and associated ownership structures;
- captains, crew, contractors, and suppliers;
- tax, VAT, flag-state, insurance, valuation, and reporting relationships; and
- company, vessel, card, wallet, and bank-account relationships.

#### Interactive journey

1. Establish ownership, company, vessel, and staff authority.
2. Replace the onboard cash safe with governed cards and wallets.
3. Detect maintenance, fuel, berth, food, hospitality, or payroll needs.
4. Let an agent prepare a funding, payment, or liquidity recommendation.
5. Apply company mandate, budget, tax, credit, collateral, and human approval before execution.

#### Commercial outcomes

- consolidate private and commercial relationships;
- control staff spending and reduce fraud;
- earn payments, FX, account, card, and advisory revenue; and
- support asset-backed finance or equity release against independently valued assets.

#### Required clarification

An ownership token is not a stablecoin or tokenised bank deposit. Tokenisation represents enforceable ownership or investment rights only when the legal structure supports them.

### 7.3 Franchise Network Operations

#### Commercial proposition

Give a franchisor permissioned financial and operational intelligence across companies, locations, employees, property, inventory, campaigns, and supply chains while each franchisee retains control of its legal books and bank relationships.

#### Graph

- franchisor and independent franchise companies;
- countries, cities, stores, and warehouses;
- owners, employees, roles, and spending authority;
- owned, leased, and rented property and equipment;
- external bank accounts and consent scopes;
- suppliers, logistics partners, inventory, campaigns, and returns.

#### Interactive journey

1. Connect franchisee accounts through explicit Open Banking consent.
2. Project permitted transactions and operational events into a common shadow ledger.
3. Reconcile cash, sales, inventory, property, supply-chain, and campaign signals.
4. Let an agent recommend funding, stock, budget, supplier, or logistics actions.
5. Require each affected entity to approve inter-company movements before execution.

#### Commercial outcomes

- improve network cash-flow visibility;
- support local accounts, payments, and credit;
- coordinate supply chain and logistics;
- measure marketing and asset ROI across the portfolio; and
- reduce manual reconciliation and intervention effort.

#### Required clarification

The franchisee's bank remains the authoritative financial ledger. The shadow ledger contains permissioned projections for visibility, reconciliation, analysis, and controlled action.

### 7.4 International Student Banking

#### Commercial proposition

Help an overseas student open a local account, establish compliant access to banking, and request funds from a home account or family contributor without surrendering privacy or control.

#### Graph

- student, parent or contributor, institution, and accommodation provider;
- home-country and destination-country identities;
- local account and external funding accounts;
- explicit contribution, visibility, and communication permissions; and
- jurisdiction, language, currency, product, and evidence requirements.

#### Interactive journey

1. Onboard the student for the destination market.
2. Open a local account in the required language and currency.
3. Connect a home account or invite a parent as a contributor.
4. Quote FX, initiate the approved payment, and track the ISO 20022 message and rail status.
5. Reconcile the funds, evidence source of funds, and let an agent prepare exceptions for human review.

#### Commercial outcomes

- acquire customers at a formative life stage;
- create family and cross-border relationships;
- earn account, payments, FX, and future credit revenue; and
- reduce onboarding and exception-handling cost.

#### Required clarification

A parent may contribute without receiving account visibility or spending authority. The student must grant each permission explicitly.

## 8. Common Platform Page

The platform page must show how four different experiences map onto one coherent operating architecture.

### Layer model

1. **Experiences**
   - customer, colleague, adviser, owner, operator, and partner channels;
   - country, language, currency, brand, product, and segment configuration.

2. **Domain Building Blocks**
   - reusable business capabilities that combine journey, rules, controls, evidence, and execution;
   - proposition-specific composition without copying the whole stack.

3. **Agentic orchestration**
   - deterministic or model-assisted planning;
   - policy, authority, and human gates;
   - repeatable execution and evidence.

4. **Architecture Building Blocks**
   - party graph and identity;
   - consent, entitlements, mandates, and delegated authority;
   - event spine and canonical contracts;
   - double-entry ledger and projections;
   - evidence, audit, reconciliation, and observability;
   - ports and replaceable adapters;
   - data, policy, and jurisdiction controls.

5. **Money and movement**
   - bank deposits;
   - tokenised bank deposits;
   - regulated stablecoins;
   - external fiat accounts represented in a shadow ledger;
   - card, account-to-account, token, and cross-border rails;
   - on-ramp and off-ramp services;
   - native ISO 20022 message handling.

### Educational model

The page will distinguish:

| Concept | Meaning |
|---|---|
| Money | The legal and economic form of value |
| Movement | The payment, transfer, or settlement rail |
| Message | The structured business information, including ISO 20022 |
| Decision | The authority, policy, consent, or approval that permits action |

### Public DBB and ABB language

A Domain Building Block packages a meaningful banking capability. An Architecture Building Block supplies reusable technical and control capability. Public copy will explain roles and reuse, not detailed contracts or implementation status.

### Research-backed callout layer

The platform and proposition pages will use accessible popovers to reveal advisory depth without turning the main journey into a technical paper.

Each callout will contain:

1. a plain-English definition;
2. why the distinction matters to a bank;
3. a boundary statement explaining what the concept is not;
4. a proposition example; and
5. an optional primary-source link or jurisdiction note.

DTA research notes will guide topic selection and explanation. Public legal, regulatory, payment-standard, and policy claims will be checked against current primary sources before publication. Internal notes, AI-generated research, and the TypeScript reference prototype are not themselves presented as independent evidence.

#### Core callout inventory

| Callout | Public explanation |
|---|---|
| Programmable payment | Rules govern whether, when, how, or to whom a payment is initiated or executed. The underlying money can remain an ordinary bank deposit. |
| Programmable money | Conditions are attached to, or enforced as part of, the monetary instrument itself. This is distinct from applying controls in the payment or account layer and may affect where or how the value can be used. |
| Agentic orchestration | A task-focused agent can observe, prepare, check, recommend, and execute within defined authority. It is not merely a chatbot, and it does not acquire legal authority by making a recommendation. |
| Tokenised bank deposit | A bank deposit liability represented on programmable infrastructure. It remains a claim on the issuing bank and is not automatically a stablecoin. |
| Stablecoin | A token designed to maintain a stable value. The holder's legal claim, backing, redemption rights, and protections depend on the issuer, structure, and regulatory regime. |
| Payment rail | The mechanism used to move or settle value. It is distinct from the monetary asset, the payment instruction, and the business message. |
| ISO 20022 | A financial-message standard and business vocabulary. It is not a payment rail, currency, ledger, or settlement asset. |
| On-ramp and off-ramp | Services that connect conventional accounts and payment rails with tokenised forms of value, including conversion, compliance, movement, and reconciliation. |
| Shadow ledger | A controlled projection of balances, transactions, or operational events from an authoritative external system. It supports visibility and reconciliation but does not silently replace the source ledger. |
| Distributed ledger | A shared-state and evidence mechanism that may support transfer or settlement. Recording a token on it does not, by itself, establish legal title to an off-chain asset. |
| Domain Building Block | A reusable banking capability combining journey, policy, controls, evidence, and execution. |
| Architecture Building Block | Shared technical and control infrastructure used by several Domain Building Blocks and propositions. |

#### Proposition callout inventory

- Family graph versus entitlement
- Joint ownership versus delegated access
- Power of Attorney versus multi-signature approval
- Pooled saving versus merged ownership
- Yacht operating company versus vessel asset
- Fractional vessel ownership versus tokenisation
- Asset-backed lending versus sale of an ownership interest
- Open Banking consent scope
- Authoritative ledger versus franchise shadow ledger
- Student contributor permission
- Source-of-funds evidence

#### Yacht fractional-ownership callout

**Can a yacht be fractionally owned?**

Yes. UK ship-registration rules recognise ownership of a share in a ship and the transfer or transmission of that share. A real proposition may use direct co-ownership, a company, partnership, trust, or another legal vehicle, subject to the vessel's flag, operating jurisdiction, tax position, finance, and contractual arrangements.

**Can those fractions be represented by tokens?**

Potentially, but the token is not the legal right merely because it exists on a distributed ledger. The legal documents, ship registry where relevant, company or shareholder records, custody model, transfer restrictions, and enforcement arrangements must connect the token to an enforceable interest.

If fractional interests are marketed or managed as investments, the arrangement may engage securities, collective-investment, financial-promotion, custody, tax, anti-money-laundering, and consumer-protection rules. Classification is specific to the rights, structure, offer, investor type, and jurisdiction.

The public site will therefore describe a yacht as a **high-value asset capable of fractional legal ownership or investment structuring**, not as a universally recognised "fractional asset class."

The callout must also state:

> Control of a private key can prove control of a token. It does not necessarily prove legal ownership of the underlying vessel, company, or investment right.

#### Initial primary sources

- [UK Merchant Shipping (Registration of Ships) Regulations 1993](https://www.legislation.gov.uk/uksi/1993/3138/contents)
- [FCA PS19/22: Guidance on Cryptoassets](https://www.fca.org.uk/publication/policy/ps19-22.pdf)
- [Bank of England: Central Bank Digital Currency opportunities, challenges and design](https://www.bankofengland.co.uk/paper/2020/central-bank-digital-currency-opportunities-challenges-and-design-discussion-paper)
- [ISO 20022 official site](https://www.iso20022.org/)

These links support definitions and perimeter awareness; they do not replace proposition-specific legal advice.

## 9. Content Model and Components

The public application will keep proposition content separate from rendering.

### Content model

Each proposition definition will contain:

- slug, title, eyebrow, summary, and audience;
- outcomes;
- graph nodes and relationships;
- journey steps;
- agent-loop labels;
- transformation lenses;
- DBBs and ABBs;
- legal and economic clarifications;
- research-backed callouts and source links;
- pilot defaults; and
- related platform capabilities.

### Shared components

- `SiteHeader`
- `ExecutiveHero`
- `AgentOperatingLoop`
- `PropositionCard`
- `PropositionHero`
- `RelationshipGraph`
- `InteractiveJourney`
- `TransformationLenses`
- `CapabilityBlockMap`
- `AccessiblePopover`
- `PlatformLayerMap`
- `MoneyMovementExplainer`
- `TechnicalAccessCallout`
- `PilotConfigurator`
- `SiteFooter`

Components will depend on typed content objects rather than proposition-specific markup. A new proposition should require a content definition and optional bespoke visual, not a duplicate page.

## 10. State and Data Flow

### Public interactions

All public interactions run locally in the browser.

1. A route selects the correct proposition definition.
2. The page initializes a deterministic journey state.
3. A user selects or advances a journey step.
4. The UI updates the graph, agent state, control state, evidence summary, and capability highlights.
5. Reset returns the page to its initial state.

No public interaction calls an external service, stores personal information, or moves money.

### Pilot brief

1. The visitor selects values in the pilot configurator.
2. A pure function creates a text brief.
3. The visitor downloads the brief or opens a `mailto:` link.
4. The page does not submit or retain the values.

### Technical access

1. The visitor selects "Request full architecture access."
2. The browser opens a prefilled email to Sailesh.
3. Sailesh reviews the request outside the microsite.
4. Sailesh adds an approved email address to the Cloudflare Access policy.
5. Cloudflare sends an individual, single-use email code.
6. Sailesh can revoke access by removing the email address.

## 11. Visual and Brand System

The microsite will use DTA's visual identity:

- cyan `#29ABE2`;
- near-black `#161616`;
- white;
- cool grey `#F5F7FA`; and
- Montserrat-led typography.

The design will use:

- strong editorial hierarchy;
- generous space;
- high-contrast dark technical sections;
- cyan as an action and relationship signal;
- clear diagrams instead of decorative illustration;
- restrained motion tied to state changes; and
- consistent proposition-page structure.

The public site must feel like DTA advisory work, not a fintech product landing page.

## 12. Protected Architecture

The protected deployment will include:

- detailed component and deployment diagrams;
- domain contracts and schemas;
- command, event, and evidence flows;
- permission, mandate, and approval models;
- ledger and projection design;
- adapter and provider boundaries;
- deterministic prototype scenarios;
- technical due-diligence notes; and
- production-readiness considerations.

### Architecture Room implementation status

The protected Architecture Room may show a dated implementation-status view for technical due diligence. This view must remain separate from the public proposition narrative.

#### Proven in the TypeScript reference prototype as of 2026-06-13

| Architecture lane | Proven reference capability |
|---|---|
| Canonical contracts | `Party`, `Relationship`, `Entitlement`, `Money`, `Posting`, `Wallet`, `Command`, `DomainEvent`, and `EvidenceStep` |
| Party and onboarding | `party-store`, relationship handling, individual and corporate onboarding |
| Identity adapters | Identity ports with deterministic government-ID, biometric, and bank-data adapters |
| Orchestration | Domain Building Blocks executed through the shared `dsl-engine` |
| Money and ledger | Balanced postings, wallets, 1:1 backing invariants, and the `tokenised-deposit` DBB |
| Money rails | Faster Payments and ISO 20022 flows through `dbb-faster-payment` |
| Execution and evidence | Commands, domain events, DSL execution, event-spine publication, and per-step evidence |
| Controls | Identity referral and `needs-action` states, scoped entitlements, rejection of unbalanced postings, token-backing checks, issuance controls, and idempotency |
| Agentic and proposition layers | Human-gated agentic gateway, Family Wealth DBBs, and public and protected showcase applications |
| Verification | Automated tests prove the stated control and ledger invariants |

This table describes a reference prototype, not a production platform or a claim that the complete bank proposition has been built.

#### Next prototype experiences

1. **Back-office banker view**
   - Project event-spine, ledger, decision, approval, and evidence records into a coherent banker experience.

2. **Full onboarding demonstration**
   - Deepen the current onboarding interface into the complete seven-stage stepped flow.

3. **Joined-up customer money journey**
   - Connect Faster Payments and tokenised deposits to a small customer surface.
   - Demonstrate deposit → tokenise → move → pay end to end in the browser.

Marketing and other parallel workstreams remain outside this Architecture Room implementation lane.

### Security and indexing

- Cloudflare Access email OTP protects every protected route.
- No shared password exists.
- Only manually approved email addresses receive access.
- `_headers` must set `X-Robots-Tag: noindex, nofollow`.
- HTML must include a matching robots meta tag.
- Public navigation must not expose protected route details.
- The deployment must contain no credentials, private keys, customer data, or production secrets.

The first release will not migrate GoDaddy DNS. A branded protected subdomain may follow a controlled DNS and Microsoft 365 record audit.

## 13. Error Handling

### Public site

- The static DTA 404 experience links back to the microsite landing and platform pages.
- Journey actions ignore repeated clicks while a transition runs.
- Autoplay stops at completion and cancels on reset or navigation.
- Unsupported browser features degrade to static content.
- Clipboard or download failure leaves the brief visible and selectable.
- `mailto:` remains the primary contact path; no form backend is required.

### Protected site

- Unapproved users remain at the Cloudflare Access boundary.
- Expired codes prompt a new Cloudflare code request.
- Revoked users cannot reach direct protected URLs.
- The app reveals no protected page titles or route inventory before authentication.

## 14. Accessibility and Responsive Behaviour

- Meet WCAG 2.2 AA for contrast, focus, semantics, and keyboard operation.
- Provide a skip link and logical heading structure.
- Use real buttons and links for interactions.
- Make popovers available by hover, focus, click, and tap.
- Keep focus within open dialogs and return it when they close.
- Announce journey-state changes through a polite live region.
- Never encode money form, authority, or risk by colour alone.
- Support 320px-wide screens without horizontal page scrolling.
- Replace dense desktop graphs with ordered cards or scrollable labelled diagrams on small screens.
- Honour reduced-motion preferences.

## 15. Publishing and Repository Boundaries

### Source of truth

The React source remains in the private `ultim8-prototype` workspace under `packages/ui-showcase`. The source may reuse prototype packages where they support deterministic public interactions, but public copy will not expose the prototype's internal codename or product status.

The DTA repository receives the static build at `composable-bank/` for GitHub Pages.

### Build handoff

1. Build the public showcase in `ultim8-prototype`.
2. Replace the generated files under the DTA repository's `composable-bank/`.
3. Build the DTA Jekyll site.
4. Run the public-boundary check.
5. Verify every clean public route in `_site/composable-bank/`.

### Public-boundary rules

The public build must not contain:

- files from `docs/` or `.superpowers/`;
- protected architecture source or artifacts;
- internal roadmap or gap analysis;
- environment files or credentials;
- private repository names or codenames in visitor-facing copy; or
- language that claims production readiness.

## 16. Test Plan

### Content and routing

- Every public route builds to its own `index.html`.
- Direct navigation and refresh work for every route.
- Every proposition uses the shared content schema.
- Public copy contains no "built versus planned" labels.
- Public copy does not name or impersonate Nettle or other illustrative brands.

### Proposition rules

- Family membership never grants permissions.
- Joint accounts, child accounts, Power of Attorney, and multi-signature authority remain distinct.
- Student contributors receive no visibility or control without explicit permission.
- Franchise Open Banking scope limits projected data and action.
- External franchisee ledgers remain authoritative.
- Yacht staff actions obey company, role, budget, and mandate controls.
- Asset tokens, stablecoins, and tokenised deposits remain distinct.
- Private-key control is never presented as sufficient proof of legal title to an underlying asset.
- Yacht fractional ownership is described as a structure-dependent legal interest, not a settled universal asset class.

### Money, ledger, and agent controls

- Balanced postings remain balanced.
- Tokenised contributions preserve 1:1 backing.
- The agent cannot execute material actions before required approval.
- An approved action executes once.
- Reset and replay produce the same end state.
- ISO 20022 messaging is not described as money or settlement.

### Interaction

- Each interactive journey supports selection, reset, and deterministic replay.
- Sequential demonstrations support step and autoplay.
- Autoplay can pause and cannot overrun the final step.
- Popovers work with mouse, keyboard, and touch.
- Essential callout definitions remain available without hover.
- Legal and regulatory callouts display their jurisdiction and publication or review date.
- The pilot brief downloads and produces the correct prefilled email.

### Accessibility and presentation

- Keyboard-only navigation covers all controls.
- Automated accessibility checks find no serious violations.
- Contrast meets WCAG AA.
- Reduced-motion mode removes non-essential transitions.
- Layouts work at mobile, tablet, laptop, and wide-desktop sizes.

### Publishing safety

- Existing prototype tests remain green.
- TypeScript type checks and UI builds pass.
- Jekyll builds without errors.
- The public-boundary script finds no protected artifacts.
- The protected build sets `noindex` headers and meta tags.
- Unapproved, approved, expired-code, revoked-user, and direct-URL Access cases are tested.

## 17. Acceptance Criteria

The design is complete when:

1. the DTA domain serves the landing page, four drill-down pages, and common platform page at clean URLs;
2. each proposition presents a credible commercial journey, operating model, agent role, and public DBB/ABB map;
3. visitors can interact with the journeys without external services;
4. the platform page clearly distinguishes money, movement, message, and decision;
5. the agent-native model always retains explicit policy and human authority;
6. the site uses the DTA brand and works across supported screen sizes and input methods;
7. the pilot configurator creates a downloadable brief and prefilled email;
8. architecture access requests go to `sailesh.panchal@digital-transformation-advisory.com`;
9. protected technical material remains outside the public build and behind Cloudflare Access; and
10. the public site contains no product-sale claim, production-readiness claim, or implementation roadmap.

## 18. Retained Scenario Detail

The following examples support future workshops, protected demonstrations, and consulting engagements. They should inform public hover detail without overloading the proposition pages.

### Family

- A family graph may connect customers who began as independent banking relationships.
- A pooled goal may qualify for higher rates or family offers while preserving individual ownership.
- Programmable payment controls can restrict purpose, amount, timing, merchant, or approver.
- Attorneys and multi-signature groups may operate under different scopes and expiry rules.

### Yacht

- One owner or family office may control several yachts and companies.
- Electronic cards and wallets can replace large onboard cash holdings used for fuel, berths, food, hospitality, maintenance, and emergency purchases.
- Crew vetting, spend patterns, and exception workflows can reduce fraud.
- Fractional ownership, valuation, and asset-backed lending create wealth-management opportunities, subject to legal, tax, securities, and credit controls.

### Franchise

- The party graph may reach individual employees, roles, access rights, and spending patterns.
- Property can be owned, leased, or rented and analysed as part of portfolio economics.
- Marketing budgets and ROI can be compared across cities, countries, and continents.
- Supply-chain and logistics decisions can be coordinated and paid centrally where contracts and authority allow.
- A detailed inventory scenario may track 100 coats sent to Paris, 59 sold, 10 returned by customers, and 41 returned for recycling, linking goods, cash, returns, and ROI.
- Agents may recommend moving funds, inventory, or capacity, but each legal entity must approve affected actions.

### Student

- The same proposition may launch as UK/English/GBP, France/French/EUR, or US/English/USD configuration.
- A student may request funds from a parent or a home-country account through Open Banking and cross-border rails.
- Source-of-funds evidence, FX, message status, rail status, and local account posting remain traceable as separate concerns.

## 19. Autoresearch Assessment

The overall microsite is not an autoresearch candidate because proposition quality, advisory credibility, and visual design require human judgement.

Verifiable subproblems can use short automated feedback loops:

- route completeness;
- accessibility violations;
- contrast;
- public-artifact leakage;
- schema validity;
- deterministic journey end states;
- balanced ledger postings; and
- 1:1 token backing.

These checks belong in normal CI. They do not require an autonomous optimization loop for the first release.

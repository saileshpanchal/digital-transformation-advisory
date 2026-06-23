---
title: DTA North Star
type: canonical-source
status: draft-for-approval
date: 2026-06-22
governs: public site, lexicon, claim register, propositions, architecture pages
origin: docs/superpowers/specs/2026-06-21-dta-architecture-review-design.md
register: docs/architecture/conflict-register.yml
decisions: docs/architecture/conflict-register.yml#p0_decisions (2026-06-22)
---

# DTA North Star

The internal canonical source for DTA. Public pages derive from the `public`,
`locked`-or-`stable` statements here. This document is **draft for approval**;
nothing downstream changes until the Mission and the Seven Intelligences are
locked.

## Mission

**Internal mission (the full scope).**
DTA helps institutions evolve their customers, colleagues, and technology
together, through multiple forms of intelligence, to create trustworthy,
inclusive, and resilient financial systems.

**Public expression (pick one — leads on the consumer commitment, D1).**

1. *"We help banks build the future of finance without leaving a single customer behind."*
2. *"Better outcomes for every customer, built on banking that evolves instead of rips and replaces."*
3. *"The future of banking, proven before it is built, and good for every customer."*

The chosen line leads the homepage; the full internal mission stays internal and
informs the Principles and Intelligences.

## Principles

Eight principles. They are how DTA decides, distinct from claims (what we assert)
and methods (how we deliver).

1. **Human-centred** — every change is judged by the outcome it creates for a real person.
2. **Evolution over replacement** — run the old and new worlds together and migrate safely; do not rip and replace.
3. **Capability before technology** — build human and organisational capability first; technology serves it.
4. **Human-in-the-loop** — agents prepare and propose; an accountable human authorises material action.
5. **Consumer outcomes** — design and evidence good outcomes for customers from the start, not as a post-launch audit.
6. **Preservation before optimisation** — retain knowledge, evidence, and institutional memory before optimising.
7. **Continuous control** — accountability and control are properties of the system, evidenced continuously, not asserted quarterly.
8. **Standards and interoperability** — build on open standards (ISO 20022, BIAN, recognised control frameworks) so work is portable and vendor-neutral.

## Cross-cutting themes

Three themes run across everything DTA does and are not replacements for
accountability, sovereignty, or Owned Autonomy.

- **Preservation** — retain knowledge, evidence, capability, and institutional memory.
- **Evolution** — operate old and new worlds together and migrate safely.
- **Augmentation** — enable humans and machines to think and act together.

## Seven Intelligences

Lenses across DTA's work, not filing folders. An artefact may carry several
Intelligences with no single primary parent. They do not replace Owned Autonomy
(a doctrine), C3 (a reference architecture), or DBBs (capability units).

1. **Experience Intelligence** — how customers and institutions experience a journey, and whether it delivers good, inclusive outcomes they understand and can act on.
2. **Capability Intelligence** — how human and organisational capability is understood, composed, and grown to deliver outcomes. Subdomains: **Skills, Knowledge, Judgment**.
3. **Cognitive Intelligence** — how humans and machines reason and act together: where reasoning sits, what agents may do, and how decisions are explained and intervened in.
4. **Value Intelligence** — how value is represented, exchanged, governed, settled, and measured (payments, deposits, tokenised value, contracts, economics).
5. **Trust Intelligence** — how justified trust is earned among customers, institutions, regulators, and systems (consent, privacy, inclusion, vulnerability, evidence).
6. **Platform Intelligence** — how systems evolve: composability, interoperability, coexistence with the core, governed data, and runtime architecture.
7. **Control Intelligence** — how accountable leaders set authority, observe outcomes, intervene, and evidence control continuously.

**Capability vs Cognitive (the boundary to hold).** Capability Intelligence is
the *latent* capability of people and organisations, including Judgment as a
skill. Cognitive Intelligence is reasoning *in operation* — how a live journey
allocates reasoning between human and agent. Judgment is British spelling and is
never a score inferred without evidence.

## Architecture hierarchy

```text
Mission
  -> Principles
  -> Seven Intelligences
  -> Experience Journeys
  -> Reference Architectures
  -> Prototype Specifications
  -> Ultim8
  -> Executable Systems
```

Preservation, Evolution, and Augmentation cut across every layer.

**Where existing concepts sit.**

- **Owned Autonomy** — a doctrine and intended outcome (accountable and sovereign), no longer the site's information architecture.
- **C3 (Capability, Context, Consent)** — a reusable reference architecture for governed human-machine action; sits beneath the Intelligences (mainly Cognitive and Control), not as a competing top level.
- **Domain Building Blocks** — capability units; an application of Capability Intelligence and the Capability plane of C3.
- **The clean room** — proof infrastructure behind advisory, journeys, architectures, and specifications. DTA is not a software or core-platform vendor (COM-002).

## Terminology to lock for launch

- **Clean-Room Demonstration** — the fenced environment and the running proof. **Clean-Room Demonstration Standard** — the rules: isolation, synthetic data, production-grade control design, claim labels, and non-production use. (TERM-008, P0)
- **working prototype** — a running proof. **working specification** — the portable, standards-based artefact a client takes to any vendor (the output). **Prototype Specification** — the executable blueprint produced from a reference architecture and a journey. "proving ground" is descriptive prose, not a noun. (TERM-009)
- **Glass Tube** — an engagement and pilot pattern; it may use the clean room but is not the clean room. (TERM-011)
- **Proposition Blueprint** (commercial engagement) and **Capability Blueprint** (people/capability work-product) stay distinct, with explicit type labels. (TERM-012)
- **Experience Journey** (end-to-end human or institutional application) vs **proposition** (commercial or product concept); one proposition may hold several journeys. (TERM-014)
- **Consumer Outcomes** is the public term; redirect `/customer-outcomes/` to `/consumer-outcomes/`. Use *customer* only for a specific bank-customer relationship. (TERM-013)
- **Composable Bank** is deprecated as a DTA product name; it remains a generic descriptor, and the URL is retained pending a redirect plan. (TERM-006)
- **Held terms:** *The Accountable Bank* (trademark check, quarantined from public use); *Ultim8* (internal runtime, provisional, public page held until stable); detailed *Judgment Intelligence* methods (internal).

## Provenance and stability

**Provenance (D6): two values only.**

- `public` — intended for unrestricted publication.
- `internal` — DTA method, working material, or protected IP; never published raw.

**Stability.**

- `locked` — approved canon; change needs an explicit decision.
- `stable` — publishable and evidence-backed.
- `developing` — draftable, publication held.
- `provisional` — exploratory; dependent content must not ship.

Public pages may use only `public` content that is `locked` or `stable`.
Generated demonstration content is `public` but is edited only via the prototype
source repository and carries one "Demonstration on synthetic data" marker (D7).

## Public versus protected boundary

**Publish (public):** the mission, principles, Intelligences, the architecture
story, concepts, outcomes, named roles, and the *shape* of evidence and governed
objects.

**Keep internal:** DBB catalogues, SFIA levels and role libraries, delivery
methods, ontology internals, schemas and canonical objects, control internals,
and platform, deployment, and engine-composition detail. (PROV-003) Publish a
public summary and link to controlled detail; never mix protected detail into
ordinary public copy.

## Honesty model

**Link, do not litter (D5/D9).** The site sells the vision and the proposition.
Claim and evidence detail lives in a single linked **Claims & evidence**
reference, not in repeated inline caveats. On public pages keep only:

- compact status badges where relevant: **Demonstrated · Specified · Blueprint · Illustrative**;
- one **"Demonstration on synthetic data"** marker on clean-room content (stated as a strength, not a disclaimer).

Three gates stay independent internally (provenance · stability · claim status),
but their public expression is light. Full detail belongs in the claim register
and in contract negotiation, tailored to each client.

## Status and next

- **Draft for approval.** On approval: lock the Mission line and the seven
  Intelligence definitions, flip the ten P0 register rows to `approved`, add the
  canonical strings to `docs/lexicon.md` and `_data/copy.yml`, then begin the
  site build (launch plan Tasks 2 onward).
- **Launch gate unchanged:** full site updated, all P0 rows resolved, and the
  site reconciled against the locked Phase 9 design (in `ultim8-prototype`)
  before launch. Phase 9 stays Blueprint/Specified until implementation evidence.

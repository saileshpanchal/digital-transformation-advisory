# DTA North Star

**Status:** Draft for approval

**Date:** 21 June 2026

**Role:** Internal canonical source. The public website, posts, propositions, and architecture views derive their wording from approved sections here. This document does not ship as a public page; it governs the pages that do.

**Origins:**

- `docs/superpowers/specs/2026-06-21-dta-architecture-review-design.md` (architecture model)
- `docs/superpowers/specs/2026-06-19-dta-controlled-evolution-website-design.md` (mission, commercial position, claim discipline)
- `docs/lexicon.md` and `docs/claim-register.md` (existing definitions and claim governance)

This North Star reconciles existing DTA ideas with one architecture model. It does not replace established terms. Owned Autonomy remains the doctrine, C3 remains a reference architecture, and Domain Building Blocks remain capability units. The Seven Intelligences are added as lenses across the work, not as a new owner of every concept.

## Mission

**Canonical mission (internal, fuller form):**

> DTA helps financial institutions evolve their customers, their colleagues, and their technology together, applying multiple forms of intelligence to build banking that is trustworthy, inclusive, and resilient, and that leaves no consumer behind.

**Public expression (shorter, derived form):**

> Help banks and fintechs build the future of banking without leaving any consumer behind.

The mission joins two commitments that must always travel together: helping institutions prepare for agentic and tokenised banking, and advocating for consumer outcomes and digital inclusion throughout that change. The mission explains why DTA exists. Owned Autonomy explains the governing design principle. The two are not interchangeable.

## Principles

The principles guide design decisions. They are not claims, and they are not methods. Each is published in a concise form once the wording here is accepted.

1. **Human-centred.** Design for the people a system serves and the colleagues who run it, starting from the person most easily excluded.
2. **Evolution over replacement.** Operate the old and new worlds together and migrate safely, rather than betting the institution on a single cutover.
3. **Capability before technology.** Decide the capability a bank needs before choosing the platform that delivers it.
4. **Human-in-the-loop.** When agents act, a person can understand the action, hold the authority, and intervene.
5. **Consumer outcomes.** Good outcomes are designed into a proposition, not evidenced after the harm is done.
6. **Preservation before optimisation.** Keep institutional knowledge, evidence, and accountability intact before tuning for efficiency.
7. **Continuous control.** Accountable leaders set authority, observe outcomes, intervene, and evidence control as the system runs, not only at audit.
8. **Standards and interoperability.** Express decisions in open standards, including ISO 20022 messaging, BIAN domain boundaries, and recognised control frameworks, so the result is portable and vendor-neutral.

## Cross-cutting themes

Three themes run across every Intelligence and every layer of the hierarchy. They describe how transformation happens; they do not replace Owned Autonomy, accountability, or sovereignty.

- **Preservation.** Retain knowledge, evidence, capability, and institutional memory through change.
- **Evolution.** Operate old and new worlds together and migrate safely.
- **Augmentation.** Enable humans and machines to think and act together.

## Seven Intelligences

The Seven Intelligences are lenses across DTA's work, not filing categories. An artefact may sit under several Intelligences at once and need not have a single primary parent. They reveal relationships; they do not force ownership. Each has one concise public definition below. Detailed inclusion and exclusion rules are canon work that continues after launch.

1. **Experience Intelligence.** Understanding the outcomes people need and the journeys they actually live, so propositions include those most easily excluded and earn understanding, agency, and trust.
2. **Capability Intelligence.** How human and organisational capability is understood, built, and evolved, across skills, knowledge, and judgment, so an institution can deliver and sustain change.
3. **Cognitive Intelligence.** How humans and machines reason and act together: where reasoning sits, what authority an agent holds, how decisions are explained, and how people intervene and learn.
4. **Value Intelligence.** How value is represented, exchanged, governed, settled, and measured, including deposits, payments, programmable money, and the economics of a proposition.
5. **Trust Intelligence.** How justified trust is earned among consumers, institutions, and regulators, through inclusion, consent, privacy, evidence, and resilience.
6. **Platform Intelligence.** How systems evolve and compose: interoperability, coexistence, governed data, and the runtime architecture that lets old and new operate together.
7. **Control Intelligence.** How accountable leaders set authority, observe outcomes, intervene, and evidence control continuously, kept distinct from the technical control plane that enforces it.

## Capability subdomains: Skills, Knowledge, Judgment

Capability Intelligence has three subdomains. They sit above the current squad and SFIA application rather than being replaced by it.

- **Skills.** What people and teams can do. Public copy uses SFIA concepts, role names, and skill names. Detailed levels of responsibility and role libraries are protected DTA IP.
- **Knowledge.** What an institution knows and can reason over, including governed knowledge structures and the graph work behind them.
- **Judgment.** How experienced people decide under uncertainty. Judgment is defined carefully and is never presented as a score that can be inferred without evidence. British spelling, Judgment, is canonical. Detailed Judgment methods remain canon work and stay protected until ready.

## Architecture hierarchy

The hierarchy is the order in which work moves from intent to running system. The Intelligences are lenses across it, and the three themes cut across all of it.

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

- **Experience Journey.** An end-to-end human or institutional application, distinct from a commercial proposition. One proposition may contain several journeys.
- **Reference Architecture.** A reusable architecture pattern, such as C3, for a recurring problem.
- **Prototype Specification.** The executable blueprint produced from a reference architecture and a journey.
- **Ultim8.** A runtime, held from public navigation until its public definition is stable.
- **Executable System.** What a client builds and runs from the specification.

## Existing concepts and how they fit

These terms keep their established definitions from `docs/lexicon.md`. The North Star states only how each relates to the hierarchy and the Intelligences.

- **Owned Autonomy.** DTA's doctrine: agentic capability a bank owns rather than rents, accountable and sovereign by construction. It expresses intended outcome, and it maps across Cognitive, Control, and Platform Intelligence. It is not the site's information architecture.
- **The Accountability-Sovereignty Principle.** The governing law: you cannot be accountable for what you do not control. Accountability is the obligation; sovereignty is the precondition.
- **C3 (Capability, Context, Consent).** A reference architecture for governed human-machine action. It sits beneath the Intelligence taxonomy rather than competing with it as a top-level hierarchy.
- **Domain Building Block (DBB).** A composable capability unit, and the Capability plane of C3. The public concept is published; the catalogue and detailed model are protected.
- **Governed data products.** The data-layer twin of the DBB. Public as a concept; detailed schemas are protected.
- **Clean-Room Demonstration and its Standard.** Proof infrastructure behind advisory, journeys, architectures, and specifications. The Demonstration is the fenced, running proof; the Standard is the rule set governing isolation, synthetic data, production-grade control design, claim labels, and non-production use. It is evidence, not DTA's product category.
- **Glass Tube.** An engagement and pilot pattern, a transparent vertical slice sized to the decision. A Glass Tube may use the clean room but is not the same as it.
- **Proposition Blueprint and Capability Blueprint.** The commercial engagement and the people-capability work-product, respectively. They are never blurred, and they carry explicit type labels wherever they appear.
- **Working specification and Prototype Specification.** The portable, vendor-neutral artefact a client takes to any vendor, and the executable blueprint layer in the hierarchy. Value comes from portability and vendor-neutrality, never from claimed framework certification.

## Provenance and stability

Three gates stay independent. Each answers a different question, and none substitutes for another.

- **Provenance** controls where content may appear: `public`, `gated`, `internal`, or `clean-room`. Each artefact carries one primary provenance. When public and protected treatments differ, the concept splits into separate register rows.
- **Stability** controls whether content may ship: `locked`, `stable`, `developing`, or `provisional`.
- **Claim status** controls what DTA may assert, governed by `docs/claim-register.md`: Demonstrated, Simulated, Specified, Illustrative, or Blueprint.

Publication rules:

- Public pages use only `public` content that is `locked` or `stable`.
- Clean-room pages use only `clean-room` content that is `locked` or `stable`, and keep synthetic, non-production, and claim labels visible.
- Gated and internal content is never copied into public output.
- A planned behaviour is labelled Specified or Blueprint, never Demonstrated.

## Public and protected content boundary

**Public.** Mission and principles; the three themes; the seven concise Intelligence definitions; the C3 plane names and the DBB concept; named roles, outcomes, and evidence boundaries; the clean-room boundary statement.

**Gated or internal.** SFIA levels of responsibility, role libraries, the DBB catalogue, detailed methods, schemas, policy logic, and implementation mechanics; internal architecture codenames; detailed Judgment methods; the Ultim8 runtime boundary until it is stable; the name The Accountable Bank until a trademark and category check passes.

**Clean-room.** Generated demonstration assets, runtime behaviour, synthetic data, and executable specifications, recorded with their source repository and build dependency rather than by copying protected implementation detail into the public site.

The two untracked insight drafts in the working tree stay unchanged during this work. Historical posts are preserved rather than rewritten to match new terminology.

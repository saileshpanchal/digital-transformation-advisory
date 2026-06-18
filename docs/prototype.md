---
title: The prototype — what it is, what it is for, how we position it
type: canonical-positioning
status: current
date: 2026-06-18
supersedes: any "not yet product-ready" framing
related:
  page: /customer-outcomes/
  landscape: docs/competitive-landscape.md
  performance: docs/performance-testing.md
  standard: docs/claim-register.md (Clean-Room Demonstration Standard)
---

The single reference for how we describe the prototype. Keep `_data/copy.yml`,
the pages, the posts and the claim register aligned to this.

## What it is

A **working proving-ground platform**. One governed, agent-native platform that
already runs several banking propositions (Family Wealth and others) under C3
controls, built to production-grade controls on synthetic data. It is real and
in use: it runs the demonstrations on this site. For its intended purpose, it
works.

## What it is for

To **prove a proposition before a bank commits to build it**: test it with test
consumers, learn where outcomes and understanding break down, and evidence the
result. The output is a **standards-based working specification** a client takes
to whatever vendor and build they choose to go live with.

## What it is not

Not a production banking system. It is **non-production by design**: it runs with
**test consumers, never real customers**, and it is not headed for production.
"Non-production" is the purpose, not a deficiency — so we **never** call it "not
yet product-ready". That phrase is retired.

## Why it is reusable

It is a **working specification because it is standards-based**: expressed in
ISO 20022 messaging, BIAN domain boundaries and recognised control frameworks.
Because those standards are the shared language vendors already use, the
specification is **portable, reusable and vendor-neutral** — DTA sits upstream
of implementation, not competing with it, and the client is not locked in.

Claim altitude (from `claim-register.md`): ISO 20022 = Substantiated; BIAN =
"structured around"; NIST 800-207 / OWASP LLM / BCBS 239 / DCAM = external,
attribute only. Always "expressed in / structured around / aligned to", **never
"certified / conformant"**.

## Performance and robustness

The specification is only complete if it carries a **performance envelope**, and
knowing **where it breaks** is part of that. We currently expect only a few
concurrent users, so the near-term goal is robustness and a stable baseline, not
scale. Two layers, tooled in `perf/` and explained in `docs/performance-testing.md`:

- **Layer A** — the client-side demonstration (render/memory/jank, soak for
  leaks). Testable today.
- **Layer B** — a build of the specification (latency, error rate, gate cost,
  concurrency). Its results become the non-functional requirements in the spec.

## One-liner

> A working proving-ground platform, standards-based and vendor-neutral, that
> turns a proposition into a tested, evidenced working specification before a
> bank builds it. Non-production by design.

---
title: Performance testing the prototype — where it breaks, and why that matters
type: engineering-note
status: working
date: 2026-06-18
related:
  page: /customer-outcomes/
  positioning: docs/competitive-landscape.md
honesty: >-
  The public prototype is a client-side demonstration on synthetic data, not a
  production system and not run with real customers. Engine/throughput testing
  applies to a vendor build or the reference engine, not to the marketing site.
  Performance limits discovered here become non-functional requirements in the
  working specification, not claims about a live platform.
---

## Why test a non-production prototype for performance

Two reasons, both tied to the positioning:

1. **It is a working specification.** A specification a vendor builds from is only complete if it carries a performance envelope: throughput, latency, concurrency and the point where the design degrades. Testing turns "it works" into "it works to *here*, and breaks *there*", which is exactly the non-functional requirement a vendor needs.
2. **It is used in moderated test-consumer sessions.** We need to know how far the demonstration itself can be pushed (event volume, session length, device class) before the experience degrades in a session.

So there are two distinct layers to test. Keep them separate.

## Layer A — the demonstration artefact (client-side, testable today)

The deployed demonstration is a static, client-side app on synthetic data. Current footprint:

| Asset | Size (uncompressed) |
|---|---|
| Main JS bundle | ~263 KB |
| CSS | ~31 KB |
| Per-proposition runtimes (yacht/student/crossborder) | ~2.5–6.6 KB each |
| **Total assets** | **~324 KB** |

Download size is not the risk (it gzips small). The risks are **client-side render and memory under load**, and **low-end device CPU**. What to test, and where it breaks:

- **Event/render volume.** A governed journey emits evidence at every step. Drive the journey to push hundreds, then thousands, of evidence events and watch frame rate and input latency. *Breaks at:* the event count where the evidence view janks or input lag becomes noticeable.
- **Long-session memory.** Run a proposition repeatedly in one tab for 30–60 minutes. *Breaks at:* the point heap growth shows a leak (retained DOM/listeners), i.e. how long a moderated session can run before a refresh is needed.
- **Device / network throttling.** Test at 4–6x CPU throttle and "slow 3G". *Breaks at:* the device class where time-to-interactive or step transitions exceed a usable threshold.
- **Concurrent journeys.** Multiple propositions / tabs at once. *Breaks at:* the tab count where the machine running a session struggles.

**Tools:** Lighthouse (perf score, TBT, LCP), Chrome DevTools Performance + Memory (heap snapshots over a soak), and **Playwright** to automate repeated journeys and capture metrics (`page.metrics()`, `performance.measure`, JS heap). A Playwright script that runs each proposition N times under CPU throttle, asserting frame budget and heap ceiling, gives a repeatable breaking-point report.

**Suggested first step:** a Playwright "soak + throttle" harness against the deployed demo (or a local `jekyll serve`), producing a one-page report: TTI per proposition, heap growth per 10 minutes, and the evidence-event count at which frame time exceeds 50 ms.

## Layer B — the architecture the specification describes (vendor build / reference engine)

This is the layer that matters most for the working specification, and it **cannot be tested from the public artefact** — it needs a running backend (the reference engine or a vendor's build of the spec). It is where "where it breaks" becomes capacity planning.

What to define and then find by test:

- **Throughput** — actions/sec end to end (agent propose → policy gate → approval → evidence write); evidence writes/sec at the store.
- **Latency** — p50/p95/p99 for the full governed action, and for the policy-gate evaluation in isolation (the per-action control cost is the usual hidden tax).
- **Concurrency knee** — ramp concurrent journeys until p95 latency climbs and throughput plateaus. That knee is the breaking point; report it as the supported concurrency.
- **Event-spine backpressure** — where queue depth grows faster than it drains; the projection lag between the event log and the read models.
- **Evidence write amplification** — how much storage/IO one journey generates; the cost of evidence-by-construction at volume.
- **Soak and spike** — memory/leak over hours; recovery after a traffic spike (ties to the self-diagnosing/resilience blueprint and its blast-radius idea).

**Tools:** [k6](https://k6.io/), Gatling or Locust for load and ramp profiles; a soak profile for leaks; a spike profile for elasticity. Define SLOs first (e.g. p95 governed action < X ms at Y concurrent journeys), then test to find where they break.

**Output:** a performance envelope (throughput, latency percentiles, supported concurrency, known breaking points) that drops straight into the working specification as NFRs. That is the difference between handing a vendor "build this" and "build this, and meet these numbers, which we already know are achievable in this shape."

## Note on honesty

Layer A characterises the demonstration. Layer B characterises a build of the specification, not the demonstration and not the marketing site. Report both as what they are. Numbers from Layer B are achievable-shape evidence for the spec, not claims about a live platform; keep the Clean-Room Standard ("a demonstration, not production") intact.

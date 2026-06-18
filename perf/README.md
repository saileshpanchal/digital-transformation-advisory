# Performance + robustness harness

Tooling to test the prototype for where it breaks, and to drive a
measure → improve → re-measure loop toward a useful level. Excluded from the
Jekyll build.

We currently expect only **a few concurrent users**, so both layers are tuned
for **robustness and a stable baseline**, not high-concurrency scale. The
high-load options are present for later.

Two layers, kept separate (see `docs/performance-testing.md` for the rationale):

## Layer A — the client-side demonstration (`layer-a/`)

What the public demo actually is: a static, client-side app on synthetic data.
The risks are render/memory under load and low-end CPU, not download size.
The harness sweeps CPU throttles and (optionally) soaks a journey to expose
leaks and jank.

```bash
cd perf
npm install
npx playwright install chromium
BASE_URL=http://localhost:4000 node layer-a/run.mjs        # against a local jekyll serve
SOAK_MIN=15 CPU_THROTTLE=1,4 node layer-a/run.mjs           # 15-min memory soak
```

Reports land in `perf/layer-a/report/<timestamp>.{md,json}` with a pass/fail
verdict against the budgets in `layer-a/journeys.mjs`. Tune the per-journey
`interact` selectors to the real prototype for sharper numbers.

## Layer B — a build of the specification (`layer-b/`)

This targets the **reference engine or a vendor build** of the working
specification, **not** the demo and **not** the marketing site. It models the
governed action flow (propose → gate → approve → evidence) and reports latency
percentiles, error rate and the policy-gate cost.

```bash
# needs the k6 binary (https://k6.io) and a running engine endpoint
k6 run -e BASE_URL=https://engine.internal -e SCENARIO=baseline layer-b/governed-action.js
k6 run -e SCENARIO=soak  layer-b/governed-action.js     # robustness over 30m
k6 run -e SCENARIO=ramp -e MAX_VUS=50 layer-b/governed-action.js  # find the knee, later
```

Edit `layer-b/flow.js` to match the engine's real API. The resulting
performance envelope (latency, supported concurrency, known breaking points)
becomes the non-functional requirements carried in the working specification.

## Honesty

Layer A characterises the demonstration. Layer B characterises a build of the
specification. Neither is a claim about a live production platform; numbers are
achievable-shape evidence and session limits. Keep the Clean-Room Standard
intact: a demonstration, not production.

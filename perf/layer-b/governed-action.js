// Layer-B load + robustness profile for a build of the working specification.
//
// Scope now: we expect only a FEW concurrent users, so the goal is not a
// high-concurrency knee but a stable, correct baseline with modest headroom,
// plus a soak to catch leaks/degradation over time. The ramp scenario still
// lets you push higher later to find the knee when scale matters.
//
// Run (needs the k6 binary + a running engine):
//   k6 run -e BASE_URL=https://engine.internal -e SCENARIO=baseline governed-action.js
//   k6 run -e SCENARIO=soak governed-action.js
//   k6 run -e SCENARIO=ramp -e MAX_VUS=50 governed-action.js   # find the knee
//
// Edit perf/layer-b/flow.js to match the engine's real API.

import { group, sleep } from 'k6';
import { Trend, Rate } from 'k6/metrics';
import { propose, gate, approve, evidence } from './flow.js';

const actionLatency = new Trend('governed_action_latency', true);
const gateLatency = new Trend('policy_gate_latency', true);
const errors = new Rate('governed_action_errors');

const SCENARIO = __ENV.SCENARIO || 'baseline';
const MAX_VUS = Number(__ENV.MAX_VUS || 50);

// Defaults sized for "a few concurrent users". Override via env.
const scenarios = {
  // Steady, low concurrency — the level we actually expect today.
  baseline: { executor: 'constant-vus', vus: Number(__ENV.VUS || 5), duration: __ENV.DURATION || '3m' },
  // Robustness: hold a small load for a while to expose leaks / drift.
  soak: { executor: 'constant-vus', vus: Number(__ENV.VUS || 5), duration: __ENV.DURATION || '30m' },
  // Sudden burst then back — does it recover gracefully?
  spike: {
    executor: 'ramping-vus', startVUs: 1,
    stages: [{ duration: '30s', target: 2 }, { duration: '20s', target: 25 }, { duration: '1m', target: 25 }, { duration: '30s', target: 2 }],
  },
  // Find the knee when scale eventually matters (open model, arrival-rate).
  ramp: {
    executor: 'ramping-arrival-rate', startRate: 1, timeUnit: '1s',
    preAllocatedVUs: MAX_VUS, maxVUs: MAX_VUS,
    stages: [{ duration: '1m', target: 5 }, { duration: '2m', target: 20 }, { duration: '2m', target: MAX_VUS }],
  },
};

export const options = {
  scenarios: { [SCENARIO]: scenarios[SCENARIO] },
  thresholds: {
    // SLOs — tune to what "useful" means for you. p95 generous for a few users.
    governed_action_latency: [`p(95)<${__ENV.SLO_P95_MS || 1000}`, `p(99)<${__ENV.SLO_P99_MS || 2000}`],
    policy_gate_latency: [`p(95)<${__ENV.SLO_GATE_P95_MS || 200}`],
    governed_action_errors: ['rate<0.01'],
    http_req_failed: ['rate<0.01'],
  },
};

export default function () {
  const start = Date.now();
  let ok = true;
  group('governed action', () => {
    const proposalId = propose();
    const g0 = Date.now();
    const g = gate(proposalId);
    gateLatency.add(Date.now() - g0);
    const a = approve(proposalId);
    const e = evidence(proposalId);
    ok = [g, a, e].every((r) => r && r.status >= 200 && r.status < 300);
  });
  actionLatency.add(Date.now() - start);
  errors.add(!ok);
  sleep(Number(__ENV.THINK_S || 1));
}

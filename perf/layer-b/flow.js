// The governed action flow, as HTTP calls: propose -> gate -> approve -> evidence.
//
// This is a TEMPLATE. It targets a build of the working specification (the
// reference engine or a vendor implementation), NOT the client-side demo and
// NOT the marketing site. Edit the paths and request bodies below to match the
// real engine's API; the rest of the harness (metrics, scenarios, thresholds)
// then works unchanged.

import http from 'k6/http';
import { check } from 'k6';

const BASE = __ENV.BASE_URL || 'http://localhost:8080';
const headers = { 'Content-Type': 'application/json' };

// --- edit these paths/bodies to match the engine ---------------------------
const PATHS = {
  propose: __ENV.PROPOSE_PATH || '/agent/propose',
  gate: __ENV.GATE_PATH || '/policy/evaluate',
  approve: __ENV.APPROVE_PATH || '/approvals',
  evidence: __ENV.EVIDENCE_PATH || '/evidence',
};

export function propose() {
  const res = http.post(BASE + PATHS.propose, JSON.stringify({
    journey: 'family-wealth', intent: 'contribute', amount: 250, currency: 'GBP',
  }), { headers, tags: { step: 'propose' } });
  check(res, { 'propose 2xx': (r) => r.status >= 200 && r.status < 300 });
  return res.json('proposalId') || 'proposal-stub';
}

export function gate(proposalId) {
  const res = http.post(BASE + PATHS.gate, JSON.stringify({ proposalId }), { headers, tags: { step: 'gate' } });
  check(res, { 'gate 2xx': (r) => r.status >= 200 && r.status < 300 });
  return res;
}

export function approve(proposalId) {
  const res = http.post(BASE + PATHS.approve, JSON.stringify({ proposalId, approver: 'test-human' }), { headers, tags: { step: 'approve' } });
  check(res, { 'approve 2xx': (r) => r.status >= 200 && r.status < 300 });
  return res;
}

export function evidence(proposalId) {
  const res = http.get(`${BASE}${PATHS.evidence}?proposalId=${proposalId}`, { headers, tags: { step: 'evidence' } });
  check(res, { 'evidence 2xx': (r) => r.status >= 200 && r.status < 300 });
  return res;
}

#!/usr/bin/env node
// Layer-A performance + robustness harness for the client-side demonstration.
//
// Goal (current): a "useful level" for a few concurrent users and for moderated
// test-consumer sessions. So we weight ROBUSTNESS (long-session memory, jank,
// stability) over peak throughput. Run it, improve the prototype, run it again.
//
// Usage:
//   npm i              # installs playwright
//   npx playwright install chromium
//   BASE_URL=http://localhost:4000 node run.mjs
//   SOAK_MIN=15 CPU_THROTTLE=1,4 node run.mjs
//
// Output: perf/layer-a/report/<timestamp>.{json,md}

import { chromium } from 'playwright';
import { writeFileSync, mkdirSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import { config, journeys } from './journeys.mjs';

const here = dirname(fileURLToPath(import.meta.url));
const stamp = new Date().toISOString().replace(/[:.]/g, '-');
const outDir = join(here, 'report');
mkdirSync(outDir, { recursive: true });

// PerformanceObservers injected before any app code runs.
function installObservers() {
  window.__perf = { lcp: 0, longtasks: [] };
  const obs = (type, fn) => { try { new PerformanceObserver(fn).observe({ type, buffered: true }); } catch {} };
  obs('largest-contentful-paint', (l) => { for (const e of l.getEntries()) window.__perf.lcp = e.startTime; });
  obs('longtask', (l) => { for (const e of l.getEntries()) window.__perf.longtasks.push(e.duration); });
}

const heapMB = (page) =>
  page.evaluate(() => (performance.memory ? performance.memory.usedJSHeapSize / 1048576 : null)).catch(() => null);

// One measured run of a journey at a given CPU throttle.
async function measure(browser, journey, throttle) {
  const context = await browser.newContext();
  const page = await context.newPage();
  await page.addInitScript(installObservers);
  const cdp = await context.newCDPSession(page);
  if (throttle > 1) await cdp.send('Emulation.setCPUThrottlingRate', { rate: throttle });

  const url = config.baseUrl + journey.path;
  await page.goto(url, { waitUntil: 'load', timeout: 60000 });
  await page.waitForLoadState('networkidle', { timeout: 30000 }).catch(() => {});

  const nav = await page.evaluate(() => {
    const n = performance.getEntriesByType('navigation')[0] || {};
    const fcp = (performance.getEntriesByName('first-contentful-paint')[0] || {}).startTime || 0;
    return { domInteractive: n.domInteractive || 0, load: n.loadEventEnd || 0, fcp };
  });
  const heapStart = await heapMB(page);

  // Drive the journey to emit evidence events; time the interaction.
  const t0 = Date.now();
  await journey.interact(page, config.maxSteps);
  const interactMs = Date.now() - t0;

  const perf = await page.evaluate(() => window.__perf);
  const heapEnd = await heapMB(page);
  const tbt = perf.longtasks.reduce((s, d) => s + Math.max(0, d - 50), 0);

  await context.close();
  return {
    throttle,
    fcpMs: Math.round(nav.fcp),
    lcpMs: Math.round(perf.lcp),
    domInteractiveMs: Math.round(nav.domInteractive),
    tbtMs: Math.round(tbt),
    longtasks: perf.longtasks.length,
    interactMs,
    heapStartMB: heapStart != null ? +heapStart.toFixed(1) : null,
    heapEndMB: heapEnd != null ? +heapEnd.toFixed(1) : null,
  };
}

// Soak: re-run interactions in one page for N minutes, sampling heap, to expose leaks.
async function soak(browser, journey, minutes) {
  const context = await browser.newContext();
  const page = await context.newPage();
  await page.addInitScript(installObservers);
  await page.goto(config.baseUrl + journey.path, { waitUntil: 'load', timeout: 60000 });
  const until = Date.now() + minutes * 60000;
  const samples = [];
  while (Date.now() < until) {
    await journey.interact(page, config.maxSteps);
    const h = await heapMB(page);
    samples.push({ t: Date.now(), heapMB: h != null ? +h.toFixed(1) : null });
  }
  await context.close();
  const valid = samples.filter((s) => s.heapMB != null);
  let growthPer10Min = null;
  if (valid.length >= 2) {
    const span = (valid[valid.length - 1].t - valid[0].t) / 60000 || 1;
    growthPer10Min = +(((valid[valid.length - 1].heapMB - valid[0].heapMB) / span) * 10).toFixed(1);
  }
  return { minutes, samples: valid.length, growthPer10Min };
}

function verdict(rows, soaks) {
  const b = config.budgets;
  const fails = [];
  for (const r of rows) {
    if (r.lcpMs > b.lcpMs) fails.push(`${r.id}@${r.throttle}x LCP ${r.lcpMs}>${b.lcpMs}`);
    if (r.tbtMs > b.tbtMs) fails.push(`${r.id}@${r.throttle}x TBT ${r.tbtMs}>${b.tbtMs}`);
    if (r.interactMs > b.interactMs) fails.push(`${r.id}@${r.throttle}x interact ${r.interactMs}>${b.interactMs}`);
  }
  for (const s of soaks) {
    if (s.growthPer10Min != null && s.growthPer10Min > b.heapGrowthMBPer10Min)
      fails.push(`${s.id} heap +${s.growthPer10Min}MB/10min>${b.heapGrowthMBPer10Min} (possible leak)`);
  }
  return fails;
}

async function main() {
  const browser = await chromium.launch({ args: ['--enable-precise-memory-info'] });
  const rows = [];
  const soaks = [];
  for (const j of journeys) {
    for (const t of config.cpuThrottles) {
      process.stdout.write(`measuring ${j.id} @ ${t}x ... `);
      const m = await measure(browser, j, t);
      rows.push({ id: j.id, ...m });
      console.log(`LCP ${m.lcpMs}ms TBT ${m.tbtMs}ms heap ${m.heapStartMB}->${m.heapEndMB}MB`);
    }
    if (config.soakMin > 0) {
      process.stdout.write(`soaking ${j.id} ${config.soakMin}min ... `);
      const s = await soak(browser, j, config.soakMin);
      soaks.push({ id: j.id, ...s });
      console.log(`heap growth ${s.growthPer10Min}MB/10min over ${s.samples} samples`);
    }
  }
  await browser.close();

  const fails = verdict(rows, soaks);
  const result = { baseUrl: config.baseUrl, budgets: config.budgets, rows, soaks, fails, passed: fails.length === 0 };
  writeFileSync(join(outDir, `${stamp}.json`), JSON.stringify(result, null, 2));

  const md = [
    `# Layer-A perf report — ${stamp}`,
    ``,
    `Base URL: \`${config.baseUrl}\``,
    ``,
    `## Per-journey (by CPU throttle)`,
    ``,
    `| Journey | x | FCP ms | LCP ms | TBT ms | longtasks | interact ms | heap MB (start→end) |`,
    `|---|--:|--:|--:|--:|--:|--:|---|`,
    ...rows.map((r) => `| ${r.id} | ${r.throttle} | ${r.fcpMs} | ${r.lcpMs} | ${r.tbtMs} | ${r.longtasks} | ${r.interactMs} | ${r.heapStartMB}→${r.heapEndMB} |`),
    ``,
    ...(soaks.length ? [
      `## Soak (memory robustness)`,
      ``,
      `| Journey | minutes | samples | heap growth MB / 10 min |`,
      `|---|--:|--:|--:|`,
      ...soaks.map((s) => `| ${s.id} | ${s.minutes} | ${s.samples} | ${s.growthPer10Min} |`),
      ``,
    ] : []),
    `## Verdict`,
    ``,
    fails.length ? fails.map((f) => `- BREAK: ${f}`).join('\n') : `- PASS: within budgets ${JSON.stringify(config.budgets)}`,
    ``,
  ].join('\n');
  writeFileSync(join(outDir, `${stamp}.md`), md);

  console.log(`\nReport: perf/layer-a/report/${stamp}.md`);
  if (fails.length) { console.log(`Breaking points found: ${fails.length}`); process.exitCode = 1; }
}

main().catch((e) => { console.error(e); process.exit(1); });

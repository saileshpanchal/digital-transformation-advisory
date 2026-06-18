// Layer-A perf harness config: the client-side demonstration.
//
// These journeys are the interactive demonstrations on the public showcase.
// `interact` drives a journey to generate evidence-event volume. The default
// is a DOM-agnostic heuristic (click visible advance controls); tune the
// selectors per journey to the real prototype for sharper numbers.

export const config = {
  // Override with BASE_URL env. Local: http://localhost:4000
  baseUrl: process.env.BASE_URL || 'https://digital-transformation-advisory.com',
  // Pass/fail budgets for the report. Tune to the device class you test on.
  budgets: {
    lcpMs: 4000,          // largest-contentful-paint
    tbtMs: 600,           // total blocking time (sum of longtask overage)
    interactMs: 12000,    // wall time to drive the journey; includes deliberate maxSteps*~120ms pacing (~5-8s mechanical floor at maxSteps=40). Real jank signal is TBT/longtasks, not this.
    heapGrowthMBPer10Min: 25, // soak: sustained growth above this looks like a leak
  },
  // Soak duration in minutes (env SOAK_MIN). 0 = skip the soak phase.
  soakMin: Number(process.env.SOAK_MIN || 0),
  // CPU throttle multipliers to sweep (env CPU_THROTTLE, comma-separated).
  cpuThrottles: (process.env.CPU_THROTTLE || '1,4,6').split(',').map(Number),
  // Max advance-clicks per interaction pass.
  maxSteps: Number(process.env.MAX_STEPS || 40),
};

// Heuristic interaction: click visible "advance" controls in sequence, re-querying
// each step because the SPA mutates the DOM. Safe by construction (best-effort,
// errors swallowed). Replace with journey-specific selectors to exercise the
// real evidence-emitting path.
async function defaultInteract(page, maxSteps) {
  for (let i = 0; i < maxSteps; i++) {
    const controls = page.locator(
      'button:visible, [role="button"]:visible, a[href^="#"]:visible'
    );
    const n = await controls.count().catch(() => 0);
    if (!n) break;
    try {
      await controls.nth(i % n).click({ timeout: 1000, trial: false });
    } catch { /* control vanished or non-actionable; keep going */ }
    await page.waitForTimeout(120);
  }
}

export const journeys = [
  { id: 'family-wealth',        path: '/composable-bank/family-wealth/',        interact: defaultInteract },
  { id: 'international-student', path: '/composable-bank/international-student/', interact: defaultInteract },
  { id: 'premium-yacht',        path: '/composable-bank/premium-yacht/',        interact: defaultInteract },
  { id: 'cross-border',         path: '/composable-bank/cross-border-payments/', interact: defaultInteract },
  // franchise-network is a blueprint (static) — included for a load baseline only.
];

import { chromium } from 'playwright';
const BASE = process.env.BASE_URL || 'http://127.0.0.1:4001';
const OUT = process.env.OUT || '.';
const b = await chromium.launch({ args: ['--no-sandbox'], executablePath: process.env.PW_EXECUTABLE_PATH || undefined });
for (const [name, w, h, full] of [['home-desktop', 1440, 900, true], ['home-desktop-fold', 1440, 900, false], ['home-mobile', 390, 844, true]]) {
  const ctx = await b.newContext({ viewport: { width: w, height: h }, deviceScaleFactor: 1 });
  const p = await ctx.newPage();
  await p.goto(BASE + '/', { waitUntil: 'networkidle', timeout: 60000 }).catch(() => {});
  await p.waitForTimeout(400);
  await p.screenshot({ path: `${OUT}/${name}.png`, fullPage: full });
  await ctx.close();
  console.log('saved', name);
}
await b.close();

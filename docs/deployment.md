# Deployment & publishing

## Where the site is actually served

The production site at **digital-transformation-advisory.com is served by Netlify** —
**not** GitHub Pages. Confirm any time with:

```bash
curl -sI https://digital-transformation-advisory.com/ | grep -i 'server:\|x-nf-'
# → server: Netlify   /   x-nf-request-id: …
```

> ⚠️ **`gh-pages` and `deploy.sh` are NOT the production path.** The repo still has a
> `gh-pages` branch and a `deploy.sh` that builds `_site` and pushes it there. Pushing
> `gh-pages` does **nothing** for the live domain — Netlify never reads it. A `gh-pages`
> push (and even a forced GitHub Pages build) will appear to "succeed" while the live
> site never changes. Do not use it to ship. (Treat `deploy.sh` as dead/legacy; remove
> or repurpose it.)

## How a deploy happens

Netlify auto-builds on push to **`master`** (config in `netlify.toml`):

- **Build:** `bundle install && bundle exec jekyll build && ./scripts/check-public-showcase.sh`
- **Publish:** `_site`
- Ruby 3.3.6, `JEKYLL_ENV=production`

To ship: **merge to `master`** → Netlify builds and deploys. If the build fails, **the
deploy is rejected and the live site silently stays on the last good build** — there is
no error visible on the site itself; you must read the Netlify build log.

## The boundary check (why a deploy can silently fail)

`scripts/check-public-showcase.sh` runs **after** the Jekyll build and **fails the build**
if forbidden internal codenames or protected-architecture references leak into either
`_site` **or tracked repo files** (it scans `git ls-files`, including `docs/`). See the
script for the current forbidden list.

Two consequences worth remembering:

1. Because it scans **tracked files too**, even committing a built artifact that contains
   a forbidden term fails the build. (This file avoids spelling those terms for that reason.)
2. Because Netlify **rejects** the deploy on failure, the symptom is *"I pushed/merged but
   the live site didn't change"* with no on-site error.

## Root cause of the 2026‑06‑15 publish failure

The `composable-bank/` showcase is built in a **separate repo** (the UI‑showcase
prototype) and synced into this repo as a static artifact under `composable-bank/`.

An "architecture access" link in that build pointed at the **internal reference‑prototype's
hostname, which contains an internal codename** on the boundary‑check's forbidden list. So
every Netlify build carrying the updated showcase failed `check-public-showcase.sh`, and
the deploy was **rejected** — the live site kept serving the previous build even though
both `master` and `gh-pages` already had the new content.

Hours were lost chasing GitHub Pages / GitHub Actions as the cause. They were a red
herring: the domain is on Netlify, and the homepage *looked* current only because earlier
copy changes had already shipped via `master`.

**Fix:** the architecture‑access link now uses the **email access‑request flow** (no
internal hostnames in the public build), which keeps protected architecture gated and lets
the boundary check pass.

## Lessons / checklist when "a change won't go live"

1. **Confirm the host:** `curl -sI` the domain — it's **Netlify**, ship via **`master`**, never `gh-pages`.
2. **Read the Netlify build log** for a failed deploy before blaming CDN lag.
3. **Run the boundary check locally** before merging a showcase change:
   ```bash
   bundle exec jekyll build && ./scripts/check-public-showcase.sh
   ```
   A clean run means the check will pass on Netlify.
4. Showcase copy/code lives in the **prototype repo**, not here — edit there, rebuild,
   sync `dist/` into `composable-bank/`, then verify the boundary check before merging.

# Site review — pre-publication sweep

> **2026-06-24 — BRANCH RECONCILIATION (read first).** This branch had diverged into two
> streams since 2026-06-21: a **remote** stream (8th *Financial Intelligence* lens, chart-led
> redesign of the Intelligence pages, new `/architecture/` landing, task-2–8 build) and a
> **local** stream (Sterling Stablecoin, BoE draft-Code, Phase-9 reconciliation proof, this
> review). They were **merged** (per user request). Resolution principle: the **intelligences
> subsystem + shared chrome = remote, wholesale** (so grid/hub/nav/pages agree on 8 lenses);
> **local's net-new content preserved** (Sterling page, richer experience-journeys with all 8
> journeys + Migration Twin, richer prototype-specifications). Local's **status-badge CSS and
> diagram-kit CSS were ported** into remote's stylesheet (local pages depend on them; remote
> replaced diagrams with charts). Acceptance test passed: build clean, 0 broken links (57
> pages), all pages console-clean, 8 lenses coherent, badges + diagrams render. Backup of
> pre-merge local tip: branch `backup/pre-merge-local-385f23e`.
>
> **Decisions that need your eyes:**
> 1. **consumer-outcomes is conceptually different per stream** — shipped **remote's** version
>    ("Test agentic journeys before you build them", proving-ground). Local's **advocacy-led**
>    version ("Banking should work for the people it is easiest to exclude") was set aside;
>    recover from `git show backup/pre-merge-local-385f23e:consumer-outcomes.html` if preferred.
> 2. **About page dropped** — remote's `_config.yml` excludes `about.md` and nothing links to
>    it (founder/leadership content lives in the homepage Leadership section). Local had
>    un-excluded it. Un-exclude + add a nav link if you want a standalone About.
> 3. **Copy/design findings below predate the merge** for the Intelligence pages, Platform
>    Intelligence, and the new Financial Intelligence page — those now ship **remote's**
>    versions and are **UNREVIEWED**. Re-review needed (see §5).
>


Working document for the page-by-page review of the DTA website before final publication.
Scope chosen by the user: **copy & messaging**, **design & layout**, **links & build**.
Claims discipline is tracked only as a background flag (it is a repo rule, so a violation still blocks publication).

Reviewed against the rendered site in `_site/` (Jekyll build) and the live local server at `http://localhost:4000/`.

Severity: **H** = blocks publication / wrong or broken · **M** = should fix before publish · **L** = polish / nitpick.

---

## 1. Links & build — DONE (global pass)

- `bundle exec jekyll build` — clean, **0 warnings / 0 errors**.
- **Internal links/assets:** check over `_site` — **56 pages scanned, 0 broken**. *Verified prod-valid:* deploy target is the **custom domain** (`CNAME` = digital-transformation-advisory.com) and the Pages workflow (`.github/workflows/pages.yml`) builds with the repo's `baseurl: ""`. So the mix of hardcoded root-relative links and `relative_url` links all resolve in production (the github.io-subpath risk does **not** apply).
- **External links:** enumerated and probed (outbound network confirmed working — gov/infra hosts return 200).
  - **(H) Both sister-company links are dead.** Home page links to `https://www.outcomeforeducation.com` and `https://www.xcceler8.com` — **neither domain has any DNS record** ("Could not resolve host", apex and www). Broken links to your own sister companies on the homepage. Fix or remove before publish.
  - Healthy: Calendly (CTA booking, 200), jsDelivr mermaid CDN (200), FCA / Bank of England / Oliver Wyman / BIS / EBA citations (200). WEF returns 403 to curl (bot-block only — fine in a real browser).
- Note: `customer-outcomes` is an intentional `noindex` redirect to `consumer-outcomes`; `success` is the form thank-you page. Both correct.
- Stale doc: `CLAUDE.md` says serve at `/digital-transformation-advisory/`, but `_config.yml` now has `baseurl: ""` — local URL is the root `/`. (L — fix the dev instruction.)

---

## 2. Copy & messaging — DONE (rendered `_site` pass, 21 pages + 2 new posts)

### THEME 1 (H) — The working demo has ~10 names. This is the single biggest issue.

One artefact (URL `/composable-bank/`) is referred to, across the site, as: **Clean-Room Demonstration**, "the demonstration", "working model", "working proof", "working proving ground", "working prototype", "Clean-Room platform", "the target architecture (… proven)", "clean-room prototype", "clean-room TypeScript pilot", plus the slug "composable-bank". Even the page whose job is to *define the vocabulary* (`prototype-specifications`) defines the term **"Working prototype"** then uses "working model" in its own hero.

**Recommendation:** designate **"Clean-Room Demonstration"** the canonical proper noun for the published experience, and **"working prototype"** for the artefact (matching prototype-specifications' own defined term). Demote everything else to clearly descriptive shorthand. Worst offenders:
- `platform-intelligence` — bare lowercase "the demonstration" (unlinked) where sibling lens pages link "Clean-Room Demonstration". (M)
- `capability-intelligence` — calls it "the target architecture (what good looks like, proven)" linked to /composable-bank/ — a third name. (M)
- `consumer-outcomes` — "the same working platform that runs our demonstrations". (M)
- Both new posts each invented their own variant ("clean-room prototype" / "clean-room TypeScript pilot"). (M — fix before publishing)

### THEME 2 (H) — Status-label vocabulary is inconsistent and has undefined extras.

Defined vocabulary is **Blueprint / Specified / Demonstrated**. Violations:
- `index` home status cards use **Demonstrated / Simulated / Specified** — drops "Blueprint" and adds **"Simulated"**, which is defined nowhere else. (H)
- `experience-journeys` running-status chips render visible text **"Demonstration"** while every other page renders the same chip as **"Demonstrated"**. Most visible inconsistency on the site. (H)
- `sterling-stablecoin` lens cards introduce undefined status words **"advisory"** and **"Designed"** ("Designed; blueprint." is also a telegraphic fragment). (M)

### THEME 3 (M) — `capability-intelligence` breaks the seven-lens set.

The other six lens pages are tightly templated (hero → "What this lens governs" 4-card → "Where you see it at DTA" → Related Intelligences → dark CTA, ~5 h2/10 h3, CTA "Discuss a challenge"). **Capability is ~3× longer (11 h2/14 h3), reads as a product page, is missing both backbone sections, and uses a different CTA ("Discuss a Capability Blueprint").** Decision needed: position it explicitly as the flagship deep-dive, or bring it onto the shared backbone.

### THEME 4 (M) — Heading hierarchy: skipped levels in before/after blocks.

`approach` and `operating-model` before/after blocks jump **h2 → h4** (the "From/To" labels) with no h3. (`index` and the "Inside a squad" block are clean.) Promote the From/To labels to h3 or add an intervening h3.

### Per-page specifics

**approach** — "SFIA 10" (M): SFIA responsibility levels are 1–7; reads as a non-existent level (framework version is SFIA 9). Clarify to "a contributor to the SFIA framework". · "fuller" vs "full-depth" Glass Tube (L) — standardise. · "SMCR" here vs "SM&CR" on operating-model (L) — standardise to SM&CR. · undefined jargon for a banking-exec audience: "paved road", "golden path", "evals", "harness" (L).

**capability-intelligence** — "compliance-strategy risk management and security-leadership thinly covered" (M): run-on, fix punctuation. · "(what good looks like, proven)" (L): "proven" is stronger than the site's careful status vocabulary. · also carries the "SFIA 10" claim (L).

**platform-intelligence** — demote "the demonstration" → linked "Clean-Room Demonstration" (M, see Theme 1).

**prototype-specifications** — hero "working model" contradicts the page's own defined term "Working prototype" (M). · "four journeys run as interactive demonstrations" may undercount the journey set — clarify "four of the Clean-Room journeys" (M).

**sterling-stablecoin** — "It shows best practice and brings parts of the regime to life today." (M): hollow superlative + cliché → concrete claim. · undefined status words (see Theme 2). · "gilts" vs "short-term UK government debt" (L). · BoE references are well-hedged ("draft", "consultation, not settled law") — **claims discipline clean here.** ✓

**experience-journeys** — "Demonstration" vs "Demonstrated" chip text (H, see Theme 2). · duplicated "synthetic migration model, not an operational digital twin" disclaimer (L).

**architecture-library** — card link verbs inconsistent ("See the demonstration / platform / data products / resilience") — unclear they all enter the one demo (M). · status chips used correctly (Reconciliation=Demonstrated/"runs", Resilience=Blueprint/"not yet built") ✓.

**policy-documentation** — "there are compelling legal basis" (M, subject-verb/number). · broken list parallelism "Requiring all staff…" then "Have developed a system…" (M). · modern-slavery statement dated **FY ending 01 April 2024** while site is 2026 (M) — refresh or mark under review. · person drift our/its (L).

**about** — "the first cloud-first regulated EMI **certified by the FCA and ACPR**" (M): "certified" + named regulators reads as endorsement. EMIs are *authorised/regulated*, not certified. Per the claims-discipline rule → "authorised in the UK and France". · also names AWS/Azure (L, borderline named-vendor — historical fact, judgement call).

**intelligences, trust-/cognitive-/value-/control-/experience-intelligence, connect, insights** — clean (one h1 each, correct nesting, consistent terminology, no slop). Minor: Experience lens "Working journeys" card lacks status labels its sibling card carries (L); C3 diagram caption differs between Cognitive and Control (L, likely intentional per-page emphasis — confirm).

### The two uncommitted blog posts

**"The Branch Kiosk That Proves Its Own Integrity"** — *almost ready; two fixes:*
- "cryptographically **prove** its own records weren't tampered with" (M) → "**detect whether** its own records have been tampered with" (a hash chain detects tampering / proves internal consistency; it doesn't prove non-tampering).
- "something a regulator **likes a great deal**" (M) → claims overreach (asserts what a regulator likes) → "is likely to value".
- terminology: "clean-room prototype" → align to Clean-Room Demonstration (M).

**"Why Your AI Agent Needs a Ledger, Not a Vector Database"** — *publication-ready; cleanest of the two.* Only fix: "clean-room TypeScript pilot" → align to Clean-Room Demonstration; drop "TypeScript" from the label (M).

Both posts share a near-identical closing-CTA paragraph that drifts ("proven … pilot" vs "built … prototype") — standardise the boilerplate.

### Note (not a defect)
`ultim8` is `published: false` by design (governance hold on TERM-010), so it is correctly absent from the build. Not reviewable as rendered output; intended behaviour.

---

## 3. Design & layout — DONE (`/browse` render pass)

**Coverage (stated honestly):** every page was checked for console errors + diagram render via `/browse` (20/20). **Screenshotted and eyeballed:** home, approach, capability-intelligence, sterling-stablecoin, trust-intelligence (baseline lens), + home/approach on mobile. The other ~15 pages are inferred clean from console-clean + shared `corporate` template + the copy agents' structural analysis — not individually eyeballed (a deliberate efficiency call, not full visual coverage).

**Overall: PASS.** The site is visually solid and consistent. Evidence:

- **Console:** 0 errors / 0 warnings across all 20 built pages.
- **Diagrams all render:**
  - `approach` mermaid flowchart → renders to SVG (desktop + mobile). ✓
  - The HTML/CSS card diagrams (`architecture-hierarchy`, `clean-room-boundary`, `c3-planes`, `seven-lenses`, `migration-twin`) reflow correctly — intentional design (not mermaid/SVG), so they stay legible at any width. ✓
  - `operating-model` has no diagram (correct — it points to `approach` for the flowchart).
- **Responsive:** no horizontal overflow at 375px (`scrollWidth == innerWidth`). Two-column before/after blocks and multi-card grids stack to a single column correctly on home and approach. ✓
- **Status chips** render with colour coding on `experience-journeys`, `sterling-stablecoin`, `architecture-library`. ✓
- **Lens-page consistency:** the six templated lens pages share one visual template; `capability-intelligence` is the visible outlier (much longer, different CTA) — same finding as Copy Theme 3.

### Design notes
- **(M, cross-ref Copy Theme 2)** On home, the `clean-room-boundary` card triad **Demonstrated / Simulated / Specified** sits directly below prose reading "Blueprint or Specified, never Demonstrated." The "Simulated" label is *deliberate* (it is the clean-room claim-boundary vocabulary, per the include's own comment), but the juxtaposition of two different triads in one section will confuse a reader. Worth reconciling the wording even though it is not a render bug.
- Screenshots saved under `/tmp/dta-review/` (home, approach, capability-intelligence, sterling-stablecoin; desktop + mobile for home/approach).

---

## 4. Prioritised fix list (for publication)

**Must fix before publish (H):**
1. **Dead sister-company links** — home links to `outcomeforeducation.com` and `xcceler8.com`; neither resolves (no DNS). Fix or remove. (Links §1)
2. **Demo naming** — pick one canonical name ("Clean-Room Demonstration" for the published experience; "working prototype" for the artefact) and sweep the ~10 variants. (Copy Theme 1)
3. **Status labels** — make chip text identical everywhere: `experience-journeys` renders "Demonstration" where every other page renders "Demonstrated" (verified by grep — same CSS class `status--demonstrated`, different visible text). Reconcile the home "Simulated" claim-boundary triad wording with the "never Demonstrated" prose above it (`Simulated`/`Specified` are genuinely defined chip styles, so they stay — the fix is wording). Remove/define the stray prose words "advisory"/"Designed" on `sterling-stablecoin`. (Copy Theme 2 + Design note)
4. **Claims discipline on the two about-to-ship posts** — these are present-tense claims about DTA's tech / a regulator's sentiment, which the repo's claims rule forbids (this is why they are H, not M, unlike the historical ipagoo bio line):
   - Branch Kiosk: "cryptographically **prove** its own records weren't tampered with" → "**detect whether** … have been tampered with".
   - Branch Kiosk: "something a regulator **likes a great deal**" → soften (don't assert a regulator's view).

**Should fix (M):**
5. `capability-intelligence` — decide flagship vs conform to the lens template. (Theme 3)
6. Heading skips h2→h4 on `approach` + `operating-model` before/after blocks. (Theme 4)
7. `policy-documentation` — grammar ("there are compelling legal basis"), broken list parallelism, stale FY-2024 modern-slavery date.
8. `about` — "certified by the FCA and ACPR" → "authorised" (claims discipline; **judgment call** — historical bio fact, not a forward claim, so M not H).
9. "SFIA 10" on `approach` + `capability-intelligence` — clarify (no such level; framework is SFIA 9).
10. `sterling-stablecoin` — "shows best practice and brings parts of the regime to life" → concrete claim.
11. Two new posts — align demo name (Branch Kiosk "clean-room prototype", Ledger "clean-room TypeScript pilot" → "Clean-Room Demonstration"). Standardise the shared closing-CTA boilerplate.

**Polish (L):** SMCR→SM&CR, "fuller"→"full-depth" Glass Tube, gilts vs "short-term UK government debt", define jargon (paved road / golden path / evals / harness), stale `CLAUDE.md` dev URL.

---

---

## 5. Post-merge re-review obligation (NEW — 2026-06-24)

The copy/design sweep in §2–§4 was run against the **local** stream. After the merge, these now
ship **remote's** versions and have **NOT** been reviewed against the merged result:

- All 8 Intelligence lens pages (chart-led redesign) — incl. the brand-new **financial-intelligence** page.
- **platform-intelligence** (reworked on remote).
- **intelligences** hub, **index** (8-lens), **architecture** (new landing), **connect**, **operating-model**, **consumer-outcomes** — all remote versions.

Still valid (local versions shipped): experience-journeys, prototype-specifications, sterling-stablecoin, policy-documentation, the two posts.

**Next:** re-run the copy + design sweep over the remote-origin pages above before publish.
Verified at merge time: build clean, 0 broken links, all pages console-clean, badges + diagrams render.

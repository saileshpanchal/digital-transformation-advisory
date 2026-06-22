# Handoff — `10-resilience.md` reconciliation update (for the prototype stream)

**Date:** 2026-06-22 · **For:** whoever owns the prototype's showcase content package (the one that builds the resilience page) in `ultim8-prototype` · **Why:** Phase 9 is complete on main (9P/9A/9B); the resilience page currently *under-claims* the reconciliation loop.

**Apply on a clean branch off `main`, rebuild the showcase, sync into `composable-bank/`, and run `check-public-showcase.sh`. Do not hand-edit the compiled bundle. Do not let the package codename namespace appear in rendered copy.**

## Change (move to real)

The ledger reconciliation loop is now Demonstrated (journal 9P merged; drift detection 9A via PR #24; maker-checker repair 9B via PR #25). Update the lines that describe reconciliation as target-state/blueprint:

- The current `status: blueprint` claim that the **"production edge↔core model … anti-entropy reconciliation … is target-state design"** should be split:
  - **Substantiated:** *"The reconciliation substrate now runs: an authoritative ledger commit journal, drift detection that classifies divergence as clean / drift / incomplete, and maker-checker repair that reapplies verified transactions or rebuilds the affected shadow partition. The authoritative ledger is never mutated by reconciliation."*
  - **Blueprint (unchanged):** the full **edge↔core deployment model** (queries at the edge, commands at the core, at scale) remains target-state.
- Where the page says *"evidence produced as one proposition runs, not a live self-diagnosing estate"*, you may add: *"the ledger now also reconciles a derived shadow against itself and repairs divergence under approval."*

## Keep verbatim Blueprint (do NOT upgrade)

- *"Self-diagnosis, automated incident assembly and blast-radius reporting are an architecture blueprint, not live in the pilot; the blast-radius figures are illustrative."*
- The **CMDB self-registration** line.
- *"The self-diagnosing platform and blast-radius reporting are blueprint, not live."*

These describe the self-diagnosing **estate**, which is broader than 9P/9A/9B and remains unbuilt. Do not conflate with the ledger reconciliation loop.

## After applying

Tell DTA so the public site can add its matching reconciliation proof point and resolve `BUILD-004`. Until then the DTA site keeps reconciliation framed as the prototype capability, linked to this page.

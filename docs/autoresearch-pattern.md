# The Autoresearch Pattern: A Reusable Framework for Measurable Improvement

**Author**: Sailesh Panchal, DTA Ltd
**Created**: 2026-03-21
**Status**: Living document — update when applying to new projects

---

## What This Document Is For

Every time we start a new project, we should ask: **can this problem benefit from an automated improvement loop?** The answer is "yes" more often than you'd think — and not just for AI model training.

This document captures the pattern so we don't forget to check. It includes the core framework, a decision checklist, the projects we've already applied it to, and a running list of candidates.

---

## The Core Pattern

Originally from Andrej Karpathy's autoresearch approach (2025), adapted by DTA for enterprise use.

### The Loop

```
┌─────────────────────────────────────────────────┐
│                                                 │
│  1. DEFINE measurable outcome (scoring fn)      │
│          │                                      │
│          ▼                                      │
│  2. BUILD gold benchmark (held-out, never       │
│     used in the loop — only for measurement)    │
│          │                                      │
│          ▼                                      │
│  3. RUN one iteration (~5 min budget)           │
│          │                                      │
│          ▼                                      │
│  4. SCORE against gold benchmark                │
│          │                                      │
│          ▼                                      │
│  5. CHECKPOINT — save state + score + timestamp │
│          │                                      │
│          ├── improved? → COMMIT, continue       │
│          │                                      │
│          └── regressed? → REVERT to last good   │
│                           checkpoint, adjust    │
│                                                 │
│  6. REPEAT until plateau detected               │
│                                                 │
│  Evidence output: CSV/JSONL with score at each  │
│  checkpoint — auditable, plottable, defensible  │
│                                                 │
└─────────────────────────────────────────────────┘
```

### The Five Requirements

For this pattern to work, a problem must satisfy ALL of these:

| # | Requirement | Why |
|---|---|---|
| 1 | **Verifiable scoring function** | You must be able to score an output programmatically — no human in the loop during the iteration cycle |
| 2 | **Held-out gold benchmark** | You need a fixed set of known-good examples that are NEVER used in the iteration. If you train on the exam, scores are meaningless |
| 3 | **Short iteration cycle** | Each cycle should complete in ~5 minutes. If an iteration takes 2 hours, overnight gives you 5 checkpoints — not enough signal |
| 4 | **Deterministic checkpoint/revert** | You must be able to save and restore state perfectly. Git commits for code/config. Model checkpoints for weights |
| 5 | **Plateau detection** | You need a stopping criterion. Without one, the loop runs forever or starts overfitting |

### The Three Outputs

Every application of this pattern produces:

1. **Evidence trail** (`training-curve.csv` or equivalent) — timestamp, iteration, composite score, component scores
2. **Best checkpoint** — the actual artifact (model weights, config, optimised code, etc.)
3. **Model card / audit record** — what was optimised, what the gold set was, final score, when it was run

---

## Decision Checklist: Should This Project Use Autoresearch?

Run through this when evaluating any new project:

### Step 1: Can you define a scoring function?

- [ ] Can the output be scored without a human reviewing it?
- [ ] Can you decompose the score into 3-6 verifiable components?
- [ ] Is "good" versus "bad" unambiguous for this domain?

If all three: ✅ proceed. If any are "no": this is a human-review problem, not an autoresearch problem.

**Examples of verifiable scores:**
- JSON validity (parser says yes/no)
- Skills exist in a reference taxonomy (lookup)
- Colour is within brand palette (hex match)
- API response time under threshold (timer)
- Test suite passes (exit code 0)
- Output matches expected schema (JSON Schema validation)
- Text readability score (Flesch-Kincaid)
- Image similarity to target (SSIM)

**Examples that DON'T work (need human judgement):**
- "Is this design beautiful?"
- "Does this copy feel on-brand?"
- "Is this architecture well-structured?"

### Step 2: Can you build a gold benchmark?

- [ ] Do you have (or can you create) 50-200 expert-validated examples?
- [ ] Are these examples representative of real-world inputs?
- [ ] Can you commit to NEVER using these in the iteration loop?

The gold set doesn't need to be huge — 200 is our standard for SLM training. For code optimisation, even 20 benchmark tests might be enough. The key is they're fixed, representative, and never contaminated.

### Step 3: Can each iteration run in ≤5 minutes?

- [ ] Can the "generate → score" cycle complete in under 5 minutes?
- [ ] If not, can you subsample or approximate to get under 5 minutes?
- [ ] Does the scoring function itself run fast (not minutes per example)?

If the cycle is 30+ minutes, you get too few checkpoints overnight to see a clear improvement trend.

### Step 4: Can you checkpoint and revert cleanly?

- [ ] Can the state be saved atomically (git commit, file copy, model checkpoint)?
- [ ] Can you restore any previous state without side effects?
- [ ] Is the iteration idempotent (same input → same starting state)?

### Step 5: What does the plateau look like?

- [ ] Do you know what "good enough" looks like for this domain?
- [ ] Can you define a plateau: "if score improves less than X over Y checkpoints, stop"?
- [ ] Have you set a maximum runtime (safety valve — don't run for 3 days)?

---

## Where We've Applied It

### 1. ForgeML — SLM Training (RLVR/GRPO)

**Project**: ForgeML (`~/Code/ForgeML/`)
**What iterates**: Qwen 2.5 3B model weights via GRPO reinforcement learning
**Scoring function**: `forge_score` composite metric
```python
forge_score = (
    0.30 * json_validity +
    0.25 * skill_f1 +
    0.25 * level_within_1 +
    0.15 * (1 - hallucination_rate) +
    0.05 * evidence_grounding
)
```
**Gold benchmark**: 200 expert-validated SFIA mapping examples (`data/eval/sfia-mapper-gold.jsonl`)
**Iteration cycle**: ~5 min (50 training steps on M5 Pro)
**Checkpoint mechanism**: Model weight snapshots to `checkpoints/rlvr/ckpt-{step}/`
**Evidence output**: `data/eval/training-curve.csv`
**Plateau detection**: Score improves < 0.005 over 10 consecutive checkpoints
**Result**: Model goes from forge_score ~0.41 (post-SFT) to ~0.85 (post-RLVR) overnight

**Why it works**: All five scoring components are programmatically verifiable — no human judgement needed during the loop. The SFIA taxonomy is the ground truth.

---

## Candidate Projects — Evaluate These

When starting any of these, run the checklist above.

### 2. ForgeML — RPGFuture Models (rpg-intent, rpg-narrative)

**What could iterate**: Intent classification accuracy, narrative coherence
**Scoring function candidates**:
- rpg-intent: intent_match_accuracy (enum match — verifiable)
- rpg-narrative: harder — readability score + keyword coverage, but "atmosphere" needs human eval
**Gold benchmark**: Would need 50-100 annotated player inputs with expected intents
**Verdict**: rpg-intent ✅ (enum match is verifiable). rpg-narrative ⚠️ (partial — readability yes, quality no)

### 3. Rebrand Pipeline — Tone Rule Optimisation

**What could iterate**: Tone adjustment prompts
**Scoring function candidates**: BLEU/ROUGE against designer's exemplar rewrites, brand-word frequency match
**Gold benchmark**: Designer's before/after text pairs from exemplar deck
**Verdict**: ⚠️ Marginal — the exemplar pairs are small (maybe 20-30 text blocks). Could work for prompt optimisation (DSPy-style) but the benchmark is thin.

### 4. SFIA Bundle Quality — Ontology Consistency

**What could iterate**: Automated detection of inconsistencies in SFIA taxonomy mappings
**Scoring function candidates**: Bidirectional skill-level consistency, description overlap detection, hierarchy validation
**Gold benchmark**: Known-correct subset of SFIA 9 validated by framework owners
**Verdict**: ✅ if gold benchmark can be assembled from SFIA 9 official data

### 5. API Performance Optimisation

**What could iterate**: API response times, query plans, cache hit rates
**Scoring function candidates**: p95 latency, throughput under load, cache hit %
**Gold benchmark**: Fixed set of representative API calls with expected response times
**Verdict**: ✅ — classic autoresearch candidate. Score = composite of latency + correctness + throughput. Iterations could try different indexing strategies, query rewrites, cache policies.

### 6. CV/Resume Parser Accuracy

**What could iterate**: Extraction accuracy from PDFs → structured data
**Scoring function candidates**: Field extraction F1, date parsing accuracy, section boundary detection
**Gold benchmark**: 100 manually annotated CVs with expected structured output
**Verdict**: ✅ if gold set can be built. This is almost identical to the SFIA mapper pattern.

### 7. Client Proposal Generator — Template Optimisation

**What could iterate**: Proposal section ordering, length, technical depth level
**Scoring function candidates**: Hard to verify programmatically — "proposal quality" is subjective
**Gold benchmark**: Would need client-rated proposals, which are sparse and biased
**Verdict**: ❌ — human judgement problem. Better solved with A/B testing or structured review, not autoresearch.

---

## Pattern Variations

### DSPy-Style Prompt Optimisation

Same loop, but instead of model weights, you're iterating on **prompt text**. The checkpoint is a prompt version (git commit). The scoring function evaluates outputs against the gold set. This is lighter than RLVR — no GPU needed, just API calls.

**When to use**: When the model is fixed (Claude API) but the prompt can be improved.
**Iteration cost**: ~£0.50 per cycle (API calls for 200-example eval).
**Stopping criterion**: Score improvement < 0.01 over 5 iterations.

### Code Performance Optimisation

Same loop, but the "model" is your codebase. Each iteration tries a code change (different algorithm, index, cache strategy). Score = benchmark suite result. Checkpoint = git commit. Revert = git revert.

**When to use**: When you have a performance benchmark suite and many possible optimisations.
**Iteration cost**: Time to run benchmark (aim for <5 min).
**Watch out for**: Correctness regression — always include correctness tests in the score, not just speed.

### Configuration Search / Game Balance Tuning

Same loop, applied to hyperparameter or configuration tuning. Each iteration adjusts config values. Score = system metric. Checkpoint = config file version.

**When to use**: When you have many config knobs and a measurable outcome.
**Upgrade**: After ~20 random-walk iterations, switch to **Bayesian Optimisation** (Gaussian process surrogate) for faster convergence in high-dimensional spaces. Validated by [BO for game design research](https://home.cs.colorado.edu/~mozer/Research/Selected%20Publications/reprints/KhajahRoadsLindseyLiuMozer2016.pdf) and [W&B Sweeps](https://wandb.ai/wandb_fc/articles/reports/What-Is-Bayesian-Hyperparameter-Optimization-With-Tutorial---Vmlldzo1NDQyNzcw). Near-optimal in ~50 iterations vs ~200 with random perturbation.

---

## Anti-Patterns — When NOT to Use This

| Situation | Why It Fails | Better Approach |
|---|---|---|
| Subjective quality ("is this good?") | Can't build a scoring function | Human review, A/B testing |
| Tiny gold set (<20 examples) | Scores are noisy, overfitting is invisible | Get more data first |
| Gold set uses same categories as training | Model memorises categories, not generalises | Reserve 1-2 categories as held-out archetypes |
| Iteration takes >30 minutes | Too few checkpoints for signal | Subsample, approximate, or use Bayesian optimisation |
| No revert mechanism | Regressions are permanent | Build checkpoint/revert before starting |
| One-shot decision (not iterative) | Nothing to loop over | Just make the decision |
| Score is binary (pass/fail) | No gradient to improve along | Add component scores with continuous values |

---

## References

- **Karpathy's autoresearch** (2025): `program.md` + `train.py` (editable) + `prepare.py` (locked) + git commit/revert per experiment. [Original concept from Karpathy's training experiments]
- **GRPO** (DeepSeek, 2024): Group Relative Policy Optimization — generates N outputs, scores all, learns from relative ranking. No critic model needed. [DeepSeek-R1 paper]
- **DAPO** (ByteDance/Tsinghua, 2025): Stabilisation extension of GRPO for long structured outputs. Clip-higher, dynamic sampling, token-level loss. [arXiv:2503.14476]
- **DSPy** (Stanford, 2024): Programmatic prompt optimisation framework — same checkpoint/score/iterate loop applied to prompts instead of weights. [dspy-ai.com]
- **forge_score composite metric**: DTA's domain-specific scoring function combining JSON validity, skill F1, level accuracy, hallucination rate, and evidence grounding.

---

## How to Use This Document

1. **New project kickoff** → Run the "Decision Checklist" in Step 1-5
2. **If checklist passes** → Copy the ForgeML pattern (scoring fn + gold set + checkpoint config)
3. **After applying** → Add to "Where We've Applied It" with results
4. **After deciding NOT to apply** → Add to "Candidate Projects" with reasoning, so we revisit later
5. **Share with clients** → The "Decision Checklist" section is client-safe. The implementation details are internal.

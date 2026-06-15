---
id: post-seed-001
title: "The Autoresearch Pattern: Improvement Loops That Actually Converge"
type: post-seed
sphere: ai-engineering
status: planned
target_date: 2026-04-15
confidence: likely
tags: [autoresearch, karpathy, forgeml, improvement-loop, slm-training]
related: [[autoresearch-pattern]], [[ForgeML]], [[SFiA-AI]]
---

## Overview

Andrej Karpathy's autoresearch pattern adapted for deterministic infrastructure. Five core requirements that make improvement loops predictable and convergent. Applied beyond ML: API performance tuning, prompt engineering, SFIA bundle quality scoring.

## Key Points

### The Problem
- Manual improvement cycles drift and plateau unpredictably
- No objective measure of convergence
- Each iteration expensive if not automated
- Checkpoint loss doesn't surface real-world performance

### The Solution: Five Requirements
1. **Verifiable scoring** — Metric that directly measures what you care about (forge_score, response_time_p95, not just loss)
2. **Gold benchmark** — Fixed reference set that doesn't change mid-loop
3. **Fast cycles** — <5 minutes per iteration (deterministic, parallelizable)
4. **Deterministic checkpoints** — Reproducible rollback, no randomness leaking in
5. **Plateau detection** — Algorithm knows when to stop (3-run convergence window)

### ForgeML Case Study
- Overnight run: forge_score 0.41 → 0.85 on UK banking dataset
- Karpathy Loop: propose → execute → evaluate → improve
- No human in the loop after setup
- Checkpoint saves every 30 mins, trains 16 LoRA adapters in parallel
- Stops when moving average plateaus

### Decision Checklist for CTOs
- Do you have a fast, objective score? (Days of hand-tuning signals you don't)
- Can you get a stable gold set? (Historical test set, not drift)
- Can you parallelize proposals? (Hyperparameters, prompts, configs)
- Is your iteration time <5 minutes? (Or is setup blocking infrastructure work?)
- Can you detect convergence automatically? (Or are you guessing?)

### Beyond ML
- **Prompt tuning**: ForgeML pattern applied to Claude system prompts via eval harness
- **API performance**: Cycle on cache strategy, batch size, worker count — same checkpoint-score-improve loop
- **SFIA taxonomy quality**: Score bundles on coverage+precision, propose new edges, evaluate on recruitment outcomes

## Source Material
- `docs/autoresearch-pattern.md` in DTA repo
- Karpathy Loop (Fabric saved notes)
- Bilevel Autoresearch paper (Fabric research library)

## Cross-References
- [[ForgeML]] — Implementation on UK banking SLM
- [[SFiA-AI]] — Applied to SFIA taxonomy refinement
- [[kuzuctl]] — Six-pass refine loop as autoresearch on knowledge graph

## Related Posts
- Two-Tier Model Deployment (post 5)
- Turning Karpathy's Autoresearch Into a Claude Code Skill (post 4)

## Next Steps
- Outline comparison matrix: autoresearch vs Bayesian optimization vs random search
- Metrics: convergence speed, checkpoint storage, false-plateau recovery
- Code snippet: ForgeML checkpoint scoring logic
- Interview section: Why we ditched manual hyperparameter tuning

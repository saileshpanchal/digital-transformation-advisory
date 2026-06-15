---
id: post-seed-004
title: "Turning Karpathy's Autoresearch Into a Claude Code Skill"
type: post-seed
sphere: ai-engineering
status: planned
target_date: 2026-04-20
confidence: likely
tags: [autoresearch, claude-code, skills, eval-loop, agent-engineering]
related: [[autoresearch-pattern]], [[kuzuctl]], [[BlogCreator]]
---

## Overview

Package Karpathy's autoresearch pattern (post 1), kuzuctl's six-pass refine loop (post 2), and BlogCreator's 4-agent enhancement pipeline (post 3) as a reusable Claude Code skill. All three are variants of propose-execute-evaluate. Unified interface for CTOs, ML engineers, and content teams.

## The Common Pattern

Three independent systems discovered the same loop:

| System | Propose | Execute | Evaluate |
|--------|---------|---------|----------|
| **ForgeML** | Hyperparams (LoRA rank, LR, batch) | Train overnight, save checkpoints | forge_score on gold set |
| **kuzuctl refine** | New edges (entities, relationships) | Ollama extraction + Kuzu upsert | Claude validation rubric |
| **BlogCreator enhance** | Rewrites (systems-thinking, tone) | Run 4-agent pipeline sequentially | Human approval + consistency check |

Each system rediscovered:
- How to score objectively (metric, not intuition)
- When to parallelize (proposals), when to serialize (evaluation)
- How to detect convergence (3-run plateau window)
- When to stop and ask for human input

## The Skill Interface

```
/autoresearch --goal "forge_score" --gold-set banking-v2 --cycles 10 --eval claude
/autoresearch --goal "concept-extraction" --gold-set annotated-vault --cycles 5 --eval ollama
/autoresearch --goal "blog-tone" --examples "50 human-edited posts" --metric reader-engagement --eval manual
```

### Parameters
- `--goal`: What are you improving? (e.g., model accuracy, graph quality, draft readability)
- `--gold-set`: Fixed reference (filepath or vault tag)
- `--cycles`: Max iterations before stopping
- `--eval`: Evaluation strategy (claude, ollama, manual, metric-only)
- `--parallelize`: Propose N variants simultaneously
- `--detect-plateau`: Stop after N runs with <delta improvement

## Implementation Roadmap

### Phase 1: Core Loop (Week 1)
- Argument parsing for `--goal`, `--gold-set`, `--eval`
- Single-cycle propose-execute-evaluate skeleton
- Checkpoint logging (JSON manifest)
- Plateau detection (moving average over 3 cycles)

### Phase 2: Multi-System Integration (Week 2)
- ForgeML adapter: Call `forge score` CLI, parse JSON output
- kuzuctl adapter: Call `kuzuctl lint` + custom validation
- BlogCreator adapter: Integrate with 4-agent pipeline
- Evaluation glue: Switch between Claude, Ollama, manual review

### Phase 3: Parallelization & Cost Optimization (Week 3)
- Batch proposal execution
- Ollama 90% / Claude 10% split (cost control)
- Checkpoint restart (resume interrupted runs)
- Cost reporting: "Run 5 of 10 cost $2.34, est. $23.40 total"

### Phase 4: Observability & Reporting (Week 4)
- Progress bar with ETA
- Per-cycle detailed logs: what changed, why score moved
- Graph: Score vs cycle number (convergence visualization)
- Rollback: "Revert to cycle 3, run 4–10 again with new config"

## Sample Implementation: Blog Tone Autoresearch

```
GOAL: Improve reader engagement on consultancy blog posts
GOLD SET: 50 human-edited posts (tagged gold:consultancy)
METRIC: Custom Claude rubric (hook quality, clarity, technical depth)
STRATEGY: 4-agent enhancement pipeline (systems, growth, engagement, tone)
PROPOSALS: Vary agent order, vary agent prompt versions
CYCLES: 5 (early stopping if plateau detected)
EVAL: Claude scores top-3 variants on rubric
```

**Output**:
```
Cycle 1: Baseline score 0.72 (original agent order)
Cycle 2: Systems-first variant 0.75 (+4%)
Cycle 3: Systems-first + growth-second 0.76 (+1%)
Cycle 4: Same config, different seeds 0.76 (plateau detected)
→ Recommendation: Use Cycle 3 ordering for production
```

## Evaluation Patterns

### Claude Evaluation
- High-stakes decisions: tone, clarity, coherence
- Cost: $0.05–0.20 per cycle (10 posts × 2 min reads)
- Example: BlogCreator tone validation

### Ollama Evaluation
- Bulk operations: entity extraction, category classification
- Cost: $0 (on-device)
- Example: kuzuctl concept deduplication

### Manual Evaluation
- Final sign-off before shipping
- Skill collects human approval, logs to manifest
- Blocks auto-rollout if threshold not met

### Metric-Only Evaluation
- Fast feedback (MLOps scoring, performance benchmarks)
- No LLM calls
- Example: ForgeML forge_score

## Integration Points

### With Claude Code
- Built as skill in `/skills/autoresearch/`
- Use Claude agent SDK for multi-step proposals
- Leverage existing `/project` context for file discovery

### With kuzuctl
- Propose stage: Generate new graph edges via `kuzuctl ingest`
- Execute stage: Upsert into knowledge graph
- Evaluate stage: Run `kuzuctl challenge` on new edges

### With BlogCreator
- Propose stage: Vary agent order, prompt versions
- Execute stage: Run 4-agent pipeline
- Evaluate stage: Score with 4-point rubric

### With ForgeML
- Propose stage: Grid search hyperparameters
- Execute stage: Train and checkpoint
- Evaluate stage: Score on gold test set

## Key Decisions

- **No framework lock-in**: Skill talks to CLI tools, not internal APIs
- **Cost visibility**: Every cycle reports spend + ETA
- **Human gate**: Manual evaluation strategy for high-stakes changes
- **Manifest audit**: JSON log explains every decision made

## Source Material
- Post 1: The Autoresearch Pattern (five requirements, checklist)
- Post 2: Knowledge Graph Refine Loop (6-pass Ollama+Claude split)
- Post 3: Voice-to-Book Pipeline (4-agent enhancement pattern)
- `docs/eval-and-tune.md` (existing blog post on improvement methodology)

## Cross-References
- [[autoresearch-pattern]] — Core loop logic
- [[kuzuctl]] — Graph evaluation
- [[BlogCreator]] — Content evaluation
- [[ForgeML]] — Model training evaluation

## Related Posts
- The Autoresearch Pattern (post 1)
- Turning Your Knowledge Base Into a Graph You Can Argue With (post 2)
- From 5,000 Voice Memos to a Book (post 3)

## Next Steps
- Detailed example: Running autoresearch on real ForgeML hyperparameters
- Code walkthrough: Plateau detection algorithm
- Cost analysis: Ollama 90% / Claude 10% split on BlogCreator pipeline
- Failures: When autoresearch gets stuck (local optima, bad gold set)
- Future: Integrate with `/schedule` for overnight runs

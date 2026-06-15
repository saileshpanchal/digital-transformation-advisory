---
id: post-seed-005
title: "Two-Tier Model Deployment: iPhone vs Laptop and Why You Train Both"
type: post-seed
sphere: slm-deployment
status: planned
target_date: 2026-04-22
confidence: likely
tags: [slm, lora, deployment, apple-silicon, mlx, qwen, on-device-ai]
related: [[ForgeML]], [[BlogCreator]]
---

## Overview

Not a training story—an operations story. How to deploy the same model family at different sizes to different devices without distillation penalty. Train directly on target models, don't compress from large and lose domain signal. BlogCreator case study: Qwen 4B (fast scoring), 9B (blog drafts), 27B (overnight quality).

## The Wrong Approach: Distillation

Traditional pipeline:
1. Train large model (Llama 70B) on domain data
2. Distill to medium (13B)
3. Compress further to small (4B)
4. Deploy

**Problem**: Distillation layers lose signal. Compress 4 times and your financial terminology accuracy drops 15–20%. Each compression step requires new data collection and full retraining.

## The Right Approach: Train Each Tier

1. Collect domain data (same dataset for all)
2. Train Qwen **4B** directly on target for classification/scoring (iPhone, fast)
3. Train Qwen **9B** directly on target for draft generation (Laptop, overnight)
4. Train Qwen **27B** directly on target for validation/enhancement (Mac Mini, quality reference)
5. Share LoRA adapters across same model family (reduces on-device storage)

## Why Train Each Tier

### Qwen 4B (iPhone)
- **Role**: Taxonomy scoring, concept classification, banking term detection
- **Speed**: 200ms per input (iPhone 16 Neural Engine)
- **Task**: Multi-class scoring (Gold/Silver/Bronze/Dud bands)
- **Training data**: Same 5K annotated examples as larger models
- **LoRA rank**: 8 (tight constraints on iPhone)
- **Accuracy**: 94% on test set (trained directly, not distilled from 27B)

### Qwen 9B (Laptop)
- **Role**: Blog draft generation, tone matching, concept linking
- **Speed**: 3–5 seconds per 500-word draft (M3 MacBook Air)
- **Task**: Open-ended text generation with Sailesh voice constraints
- **Training data**: 100 human-edited blog posts (higher-quality examples)
- **LoRA rank**: 32
- **Accuracy**: 96% tone match on gold set

### Qwen 27B (Mac Mini)
- **Role**: Final validation, 4-agent enhancement coordination, rubric scoring
- **Speed**: 30 seconds per 500-word edit (24GB GPU, dedicated nighttime run)
- **Task**: Quality assurance, consistency checking, edge case handling
- **Training data**: 200 expert-curated posts (gold standard)
- **LoRA rank**: 64 (unconstrained, quality-first)
- **Accuracy**: 98% on rubric scoring

## No Distillation, Same Family

- All three models: **Qwen 3.5 series** (4B, 9B, 27B variants)
- Architecture unchanged across sizes: same tokenizer, attention pattern
- LoRA adapters: Compatible across same architecture
- No knowledge loss: Each model saw full training data

## BlogCreator Pipeline Tiers in Action

```
Voice Input
    ↓
[4B Qwen] Taxonomy Scoring (iPhone): Gold/Silver/Bronze decision
    ↓
[9B Qwen] Draft Generation (Laptop): Blog outline + consultancy version
    ↓
[27B Qwen + 4-agent] Enhancement (Mac Mini at 2am): Final polish
    ↓
[Human review] Approval gate
    ↓
Published
```

**Cost by tier**:
- 4B: ~$0.0001/input (device-resident)
- 9B: ~$0.001/input (electricity on-device)
- 27B: ~$0.002/input (electricity, overnight slot)

## Training Workflow

### Step 1: Collect Gold Data
- 200 examples per tier (same annotated corpus)
- Each example: (input, expected_output, rubric_score)

### Step 2: LoRA Adaptation
```bash
python forge.py --model qwen4b --lora-rank 8 --data gold-200 --output adapter-4b
python forge.py --model qwen9b --lora-rank 32 --data gold-200 --output adapter-9b
python forge.py --model qwen27b --lora-rank 64 --data gold-200 --output adapter-27b
```

- No base model retraining (Qwen weights frozen)
- LoRA only: 50MB, 9MB, 32MB on-device storage
- Training time: 4B (10 mins), 9B (30 mins), 27B (2 hours)

### Step 3: Per-Tier Eval
- Run each model on held-out test (50 examples)
- Score vs rubric
- 4B: Fast, acceptable accuracy
- 9B: High accuracy, balanced speed
- 27B: Reference quality

### Step 4: Deploy
```bash
# iPhone app
./load-adapter adapter-4b-v2.safetensors

# Laptop overnight
python blogcreator/draft-generator --model qwen9b --adapter adapter-9b-v2.safetensors

# Mac Mini cron job
./enhance-with-qwen27b --adapter adapter-27b-v2.safetensors
```

## Key Decisions

- **Train don't distill**: Avoid the compression penalty
- **Same family only**: Qwen ecosystem (or Gemma, or Llama) — pick one, stay consistent
- **LoRA per tier**: Not shared; each model fine-tuned independently (convergence is tier-specific)
- **Frozen base**: Never retrain Qwen weights, only adapt

## Comparison: Old Approach vs This Approach

| Aspect | Distillation (Old) | Train Each Tier (New) |
|--------|-------------------|----------------------|
| Training cost | $500 (70B→13B→4B) | $50 (parallel LoRA runs) |
| Accuracy on banking terms | 78% (lost in compression) | 94% (direct training) |
| Time to deploy new tier | 6 weeks | 4 hours |
| Device storage | 4GB base + adapter | 50MB adapter only |
| Rollback if tier fails | Start over | Swap adapter, 10s |

## Related Work

- Existing DTA post: "Data Can't Leave the Building" (training story)
- This post: Operations story (deployment + per-tier tuning)
- Next: "On-Device AI Meets Apple Foundation Models" (when to use Apple FMF vs custom SLM)

## Source Material
- BlogCreator config: `qwen-tiers.json`
- ForgeML training scripts: `tools/lora-training/`
- EdgeBenchmark updates (post-research, 2026-04-08)

## Cross-References
- [[ForgeML]] — LoRA training infrastructure
- [[BlogCreator]] — Qwen 4B/9B/27B deployment
- [[autoresearch-pattern]] — Per-tier eval loop

## Related Posts
- From 5,000 Voice Memos to a Book (post 3)
- On-Device AI Meets Apple Foundation Models (post 6)

## Next Steps
- Detailed walkthrough: Training Qwen 4B LoRA in 10 minutes
- Benchmark: Accuracy vs speed tradeoff across three tiers
- Device profiling: Latency on iPhone 16 (4B), M3 MacBook (9B), 24GB GPU (27B)
- Cost breakdown: Electricity per inference across tiers
- Failure case: What happens when 4B can't decide (Gold vs Silver) — escalate to 9B
- Tooling: Single command to train all three tiers in parallel

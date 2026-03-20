---
title: "Practical AI for Enterprise: Two Approaches We're Building"
date: 2026-03-20
categories: [AI, Strategy]
tags: [digital-transformation, slm, fine-tuning, powerpoint, brand-conversion, python-pptx, on-device-ai, enterprise-ai]
excerpt: "Not every AI problem needs a fine-tuned model. We're working on two enterprise transformation projects that illustrate when to train a model and when to build a smart pipeline instead. Here's the thinking behind each."
---

There's a growing gap between what AI *can* do and what it *should* do for a specific business problem. Every week we see organisations reaching for large language models when a deterministic pipeline would be faster, cheaper, and more reliable. Equally, we see teams building brittle rule-based systems when a small, fine-tuned model would handle the variation they're struggling with.

This post describes two projects we're actively building at DTA. They're different domains, different architectures, and different answers to the same question: **where does the AI boundary sit?**

## Project 1: Domain-Specific Small Language Models

### The Problem

Enterprise applications often need language understanding — parsing job descriptions, mapping skills to frameworks, generating structured recommendations. The typical approach is to call a cloud API (GPT-4, Claude, etc.) for every request. This works, but it creates three problems:

1. **Latency.** A 2-3 second API round-trip is too slow for real-time interactions
2. **Cost.** At scale, per-token pricing for cloud LLMs adds up fast
3. **Privacy.** Sensitive data (CVs, internal skills profiles, salary data) leaves the organisation

### The Approach: Fine-Tuned SLMs via a Training Pipeline

We're building a **model factory** — a reusable pipeline that takes a base small language model (3-4 billion parameters), fine-tunes it on domain-specific data, and produces a standalone model file that runs entirely on-device.

The pipeline works in stages:

**Stage 1: Supervised Fine-Tuning (SFT)**
A cloud teacher model (Claude, in our case) generates high-quality training examples — question/answer pairs in the target domain. We fine-tune the base model on these examples using LoRA (Low-Rank Adaptation), which is memory-efficient enough to run on a single Mac with Apple Silicon.

```
Teacher (Claude API) → Training Data → LoRA Fine-Tune → Adapted Model
```

**Stage 2: Reinforcement Learning from Verifiable Rewards (RLVR)**
After SFT, the model can mimic the teacher's format but doesn't yet *understand* correctness. We use RLVR with GRPO (Group Relative Policy Optimization) to align the model against verifiable reward signals — things we can check programmatically:

- Does the JSON output validate?
- Are the referenced skills real entries in the framework?
- Is the assigned level within ±1 of the gold standard?

```python
# Simplified composite evaluation metric
forge_score = (
    0.30 * json_validity      +  # Structural correctness
    0.25 * skill_f1            +  # Skill identification accuracy
    0.25 * level_within_1      +  # Level assignment precision
    0.15 * (1 - hallucination) +  # Grounding in real data
    0.05 * evidence_grounding     # Citation quality
)
```

**Stage 3: Quantisation and Deployment**
The fine-tuned LoRA adapter (~50MB) is fused into the base model weights, then quantised to 4-bit using AWQ (Activation-aware Weight Quantization). The result is a ~1.6GB standalone model file that runs on any Apple Silicon device via MLX.

### Why This Needs a Model

The variation in natural language inputs is too high for rules. A job description might say "responsible for cloud infrastructure" or "leads Azure and AWS platform engineering" or "owns the tech stack" — all meaning roughly the same thing. A fine-tuned SLM handles this variation naturally because it's learned the *shape* of the domain, not just keyword matches.

The key insight: **the model factory is not the product**. It produces model files that consumer applications load at startup. The factory never touches production traffic. The consumer app calls the local model the same way it would call a cloud API — but the response comes back in milliseconds, costs nothing per-inference, and the data never leaves the device.

### What We've Learned So Far

- **Teacher quality matters more than quantity.** 500 gold-standard examples from Claude outperform 5,000 mediocre synthetic examples
- **LoRA targeting matters.** Including FFN layers (gate_proj, up_proj, down_proj) alongside attention layers significantly improves structured output format compliance
- **The Muon optimizer** (gradient orthogonalisation on projection matrices) is outperforming AdamW in our early experiments, consistent with recent research
- **Apple Silicon is a legitimate training platform** for models at the 3-4B scale. An M-series Mac with 36GB unified memory handles LoRA fine-tuning comfortably

## Project 2: AI-Assisted Brand Conversion for PowerPoint Decks

### The Problem

A client has 50 PowerPoint presentations in their old corporate brand. Following a rebrand, every deck needs converting: new fonts, new colours, new logo, new footer text, and — critically — a shift in *tone* from formal corporate prose to a more conversational voice.

Manual conversion by a designer takes 2-4 hours per deck. That's 100-200 hours of repetitive work.

### The Approach: Deterministic Pipeline + Claude for Tone

Our first instinct was "train a model." We quickly realised that was wrong. The visual rules of a brand are **finite and extractable**:

| What Changes | Count | Method |
|---|---|---|
| Font families | 4-6 mappings | Deterministic |
| Colour palette | 6-8 hex values | Deterministic |
| Logo image | 1 replacement | Deterministic |
| Footer text | 1 find-replace | Deterministic |
| **Tone of voice** | **Unbounded** | **AI (Claude in-context)** |

The insight: **95% of the work is mechanical, and only 5% needs intelligence.**

### How It Works

**Step 1: Designer creates two exemplar decks**
The designer takes one real presentation and recreates it in the new brand. Same content, different visual treatment. This gives us a paired before/after to diff.

**Step 2: Rule extraction (python-pptx)**
A Python script walks both exemplar decks slide-by-slide, matching text runs by position and content. It extracts:

```json
{
  "fonts": {
    "Georgia|32.0|bold": {
      "family": "Calibri",
      "size_pt": 36.0,
      "bold": true
    }
  },
  "colours": {
    "#003366": "#007C7A",
    "#CC9900": "#2ECC71"
  },
  "footer": {
    "find": "Old Corp Ltd. All rights reserved.",
    "replace": "New Brand Partners. Confidential."
  }
}
```

**Step 3: Deterministic conversion**
The conversion engine applies these rules to all 50 decks. python-pptx handles the heavy lifting — iterating every shape, every text run, every fill colour, and applying the mapping. A single deck converts in under 2 seconds.

**Step 4: AI tone adjustment (Claude)**
The script also detects *text changes* between the exemplar pair — cases where the designer rewrote the words, not just the formatting. From these examples, we extract tone rules:

```
Before: "Our methodology is evidence-based, outcome-driven, and designed
         for sustainable change."
After:  "Evidence-based. Outcome-driven. Built to last."
```

Pattern: **formal prose → punchy fragments. Passive → active. Corporate jargon → plain English.**

Claude applies these patterns to the body text of each converted deck, using the exemplar pairs as few-shot examples. The key constraint: **preserve all factual content, change only the voice.**

### Why This Does NOT Need a Model

The temptation to fine-tune was real. But consider:

- The font rules are exact: Georgia → Calibri, always
- The colour rules are exact: #003366 → #007C7A, always
- The logo replacement is a binary swap
- The footer is a string replacement

Training a model to learn these deterministic mappings would be slower, less accurate, and harder to debug than a simple lookup table. The only part that benefits from intelligence is the tone adjustment — and that's a perfect fit for Claude in-context, not a fine-tuned SLM.

**Rule of thumb: if you can write the transformation as a mapping table, don't train a model.**

## The Decision Framework

These two projects illustrate a pattern we apply across all our transformation work:

| Signal | Use a Model | Use a Pipeline |
|---|---|---|
| Input variation | High (natural language) | Low (structured data) |
| Rules expressible | No (too many edge cases) | Yes (finite, enumerable) |
| Output format | Semi-structured | Deterministic |
| Error tolerance | Approximate OK | Must be exact |
| Data sensitivity | High (needs on-device) | Low (can use cloud) |
| Volume | High (millions of inferences) | Medium (batch processing) |

Most enterprise AI projects are a **mix** — some parts need intelligence, others need precision. The art is drawing the boundary correctly.

The worst outcome is training a model for a deterministic problem (expensive, fragile, hard to debug) or building rules for a language understanding problem (brittle, endless edge cases, constant maintenance).

## What's Next

We're open-sourcing the brand conversion pipeline as a tool that any consultancy can use — you bring your designer's exemplar pair, and the pipeline handles the rest. The SLM training pipeline is being built as a reusable model factory that can serve multiple domain-specific applications from a single codebase.

If your organisation is navigating the "where does AI fit?" question, we'd be happy to share more of what we're learning. The best transformations start with a clear-eyed assessment of which problems are AI problems and which are engineering problems. Often, they're both.

---

*Sailesh Panchal is Director at Digital Transformation Advisory (DTA), working at the intersection of technology strategy, AI-native architecture, and platform engineering.*

---
id: post-seed-006
title: "On-Device AI Meets Apple Foundation Models: Where Custom SLMs Still Win"
type: post-seed
sphere: on-device-ai
status: planned
target_date: 2026-04-25
confidence: likely
tags: [apple, foundation-models, ios-26, slm, mlx, ollama, skillframe, rpgfuture]
related: [[SkillFrame]], [[RPGFuture]], [[BlogCreator]], [[kuzuctl]]
---

## Overview

Apple Foundation Models (iOS 26) provide a new baseline for on-device AI. But domain-specific pipelines (BlogCreator banking terminology, kuzuctl entity extraction, SkillFrame skill matching) still depend on custom small language models because general-purpose models can't deliver the precision needed. When to use each, and why custom models won't be replaced overnight.

## Apple Foundation Models: What's New

### In iOS 26
- **Built-in models**: Multiple sizes (1B, 3B, 7B equivalents in CoreML)
- **No downloads**: Pre-installed, no cold-start
- **Compute**: Optimized for Neural Engine (iPhone 16+, iPad M1+)
- **Privacy**: On-device, no cloud calls
- **Cost**: Amortised into OS, zero per-call cost
- **Baseline tasks**: Text classification, general Q&A, image captioning

### In Xcode 26
- Model integration: Drag-and-drop `.mlpackage` into project
- Prompt engineering: Built-in system prompt editor
- Testing: Simulator preview before ship
- Analytics: On-device latency dashboard

## The Problem: General-Purpose Can't Do Domain

### SkillFrame (Native iOS Skills App)
**Task**: "User has 3 hours free, recommend a skill to practice"
- Input: Free hours, current skill level, learning goal
- General FMF: "Try coding, reading, or exercise" (generic)
- Custom SLM (Qwen 4B + LoRA): Returns ranked list of 5 skills from SkillFrame catalog, with reason why skill #1 matches learning trajectory

**Why custom wins**: FMF doesn't know SkillFrame's taxonomy or user's prior achievements.

### RPGFuture (iOS RPG Game)
**Task**: "Generate NPC dialogue that references player's actions in this campaign"
- Input: NPC personality archetype, player's quest log (5 KB), tone (humorous/serious)
- General FMF: "You did good. Keep going." (forgettable)
- Custom SLM (Gemma 7B + LoRA): Weaves player's specific choices into dialogue, matches NPC voice, adapts formality to campaign tone

**Why custom wins**: FMF has no access to campaign-specific context or NPC personalities.

### BlogCreator (Content Pipeline)
**Task**: "Flag any UK banking terminology that's wrong or outdated"
- Input: Blog text + banking term lexicon (800 terms)
- General FMF: Catches some obvious errors, misses context ("Basel" could be city or regulation)
- Custom SLM (Qwen 4B + LoRA trained on 200 regulatory examples): 94% accuracy on ambiguous terms, knows PSD2 nuances

**Why custom wins**: Banking terminology is specialized; general models see <100 examples in training data.

### kuzuctl (Knowledge Graph Maintenance)
**Task**: "Extract entities and relationships from a wiki note"
- Input: Markdown note (~500 words on a system-design insight)
- General FMF: Extracts nouns and obvious subjects, misses causal relationships
- Custom SLM (Ollama Qwen 9B): Structured JSON output with LINKS_TO, TENSIONS_WITH, confidence scores

**Why custom wins**: kuzuctl's schema is project-specific; FMF returns unstructured text.

## The Comparison Matrix

| Use Case | Apple FMF | Custom SLM | Recommendation |
|----------|-----------|-----------|-----------------|
| Text sentiment (generic) | Excellent | Overkill | FMF |
| Skill recommendations (user-personalized) | Poor | Excellent | Custom |
| NPC dialogue (campaign-aware) | Poor | Excellent | Custom |
| Banking term flagging (domain jargon) | Mediocre | Excellent | Custom |
| Entity extraction (graph schema) | Poor | Excellent | Custom |
| Image caption (general) | Excellent | Unnecessary | FMF |
| Classify bug report (internal) | Mediocre | Excellent | Custom |

## Decision Framework

### Use Apple FMF If
- Task is general-purpose (classification, summarization, Q&A on public knowledge)
- Latency <100ms critical (FMF optimized on Neural Engine)
- User data shouldn't leave device AND task is generic (no cloud call needed)
- Cost is zero (amortised into OS)
- You don't have domain-specific training data

### Use Custom SLM If
- Task requires domain knowledge (finance, games, specific tools)
- You have 50+ gold examples to train on
- Schema or output format is rigid (JSON with specific keys)
- Cold-start latency acceptable (200ms–5s depending on model size)
- You own the model (no licensing risk from proprietary Apple FMF)

## Deployment Strategies

### Strategy 1: FMF + Custom Fallback
```
User asks: "Recommend a skill"
→ Try Apple FMF first (fast, generic)
→ If confidence <0.7, escalate to custom SLM (slower, precise)
→ Return winner's result
```
Hybrid speed + precision.

### Strategy 2: FMF for Filtering, Custom for Ranking
```
User has 500 skills in catalog
→ Apple FMF: Filter to top 50 (fast, generic "good match" classification)
→ Custom SLM: Rank top 50 by learning trajectory (slower, precise)
→ Return top 5
```
Scales efficiently.

### Strategy 3: Custom Offline, FMF Online
```
Overnight (offline):
→ Custom SLM: Embed and index all skill descriptions, campaign arcs, NPC voices

At runtime (user interactive):
→ Apple FMF: Classify user's text ("I want action RPG")
→ Lookup: Retrieve pre-indexed custom embeddings
→ Return instant results
```
Best of both: custom training power, FMF speed.

## Real-World Adoption Pattern

**SkillFrame** (iOS native app):
- General features: Apple FMF (classification, summaries)
- Skill matching: Custom Qwen 4B LoRA (learned on 2K+ user achievement sequences)
- On-device storage: 50MB LoRA adapter, zero base model (uses MLX)

**RPGFuture** (iOS game):
- NPC name generation: FMF (fast, generic names)
- NPC dialogue in-context: Custom Gemma 7B (knows campaign arc, player choices)
- Bottleneck: Storage (Gemma too large for iPhone). Solution: Run on Mac game server, return via API, cache results locally

**BlogCreator** (content pipeline):
- Taxonomy scoring: Apple FMF (fast initial sort)
- Banking term validation: Custom Qwen 4B (94% on regulated terms)
- Overnight enhancement: Custom Qwen 27B (reference quality, no latency constraint)

**kuzuctl** (knowledge graph CLI):
- No Apple FMF integration (not a user-facing app)
- Uses custom Ollama Qwen 9B (structured extraction, TENSIONS_WITH edges)
- Could accelerate with FMF pre-filtering in future

## Key Differences from Prior Art

- **Prior approach** (2024): "All on-device models are too small, use cloud API"
- **Apple FMF (2026)**: "Free, pre-installed, zero latency baseline"
- **This approach**: FMF for generic, custom for domain (not one or the other)

## Technical Constraints (April 2026)

### Apple FMF
- Max context: 2KB (context window small)
- Token limit: No fine-tuning (frozen weights)
- Output: Unstructured text (no JSON schema support built-in)
- Update: Apple controls release cycle (quarterly)

### Custom SLM (via MLX/Ollama)
- Max context: 4KB–8KB (depending on model)
- Fine-tuning: LoRA, full-param training supported
- Output: JSON, structured, deterministic if needed
- Update: You control (retraining whenever)

## Source Material
- iOS 26 release notes: CoreML Foundation Models section
- Xcode 26 docs: MLPackage import workflow
- SkillFrame design doc: Skill matching taxonomy
- RPGFuture gameplay loop: Campaign state machine
- BlogCreator banking term lexicon (800 terms)
- kuzuctl schema: Insight graph, TENSIONS_WITH edges

## Cross-References
- [[SkillFrame]] — Native iOS implementation
- [[RPGFuture]] — Game dialogue system
- [[BlogCreator]] — Content validation pipeline
- [[kuzuctl]] — Entity extraction and graph refining
- [[Two-Tier Model Deployment]] — Why we train Qwen 4B/9B/27B separately

## Related Posts
- From 5,000 Voice Memos to a Book (post 3)
- Two-Tier Model Deployment (post 5)
- Turning Your Knowledge Base Into a Graph You Can Argue With (post 2)

## Next Steps
- Benchmark: Apple FMF latency vs custom SLM on iPhone 16 (same task)
- Code walkthrough: SkillFrame skill matching with custom Qwen 4B
- Cost analysis: 1000 user sessions — FMF cost ($0) vs cloud API cost ($$)
- Failure case: FMF returns wrong answer, custom SLM corrects it (with examples)
- Future: Apple FMF + LoRA fine-tuning (if Apple adds support)
- Integration timeline: When to adopt FMF as baseline, custom as fallback

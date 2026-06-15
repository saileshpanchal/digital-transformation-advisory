---
id: post-seed-003
title: "From 5,000 Voice Memos to a Book: The Pipeline That Runs While You Sleep"
type: post-seed
sphere: content-engineering
status: drafting
target_date: 2026-04-14
confidence: proven
tags: [blogcreator, voice-to-text, pipeline, kuzu, mlx, qwen, parakeet, apple-silicon]
related: [[BlogCreator]], [[kuzuctl]], [[KuzuGraphKit]]
---

## Overview

126 GB of voice recordings (2021–2026) across 4 Obsidian vaults processed overnight via a 7-stage pipeline. Transcribe → Analyse → Draft → Enhance → Curate → Lineage-Track → Book-Assemble. Average 400 transcriptions per night. No manual intervention after voice input.

## The Archive

- **5,287 recordings** across 4 vaults (Thinking, Consulting, Research, Podcast)
- **126 GB raw audio** (codec mix: AAC, MP3, WAV)
- **Time span**: March 2021 – April 2026
- **Capture method**: iPhone Voice Memos, Otter.ai, Riverside.fm, Obsidian-embedded audio

## Pipeline Stages

### Stage 1: Transcription (Parakeet MLX)
- Model: parakeet-mlx on Apple Silicon
- Speed: 140x real-time (3hr audio → 90 seconds)
- Output: Immutable `.transcription` attachment in vault
- Cost: <$0.01/hr (on-device, no API calls)

### Stage 2: Analysis & Taxonomy Scoring
- Extract key concepts, entities, banking terminology
- Score against UK banking domain taxonomy
- Classify into bands: **Gold** (publishable), **Silver** (needs editing), **Bronze** (reference), **Dud** (false starts)
- Kuzu persistence: every score linked to model version + date

### Stage 3: Blog Draft Generation
- **Dual-track approach**:
  - Consultancy track: Formal, structured, 2000–3000 words
  - LinkedIn track: Casual, hook-first, 150–300 words, hashtags
- Model: Qwen 9B (single-threaded but high quality)
- Preserve voice: "Sailesh voice" detected from tone markers
- Output: Markdown + frontmatter in draft vault

### Stage 4: Enhancement (4-Agent Pipeline)
Each agent operates in sequence, no interference:
1. **Systems-Thinking Agent** — Adds second-order consequences, feedback loops
2. **Growth-Mindset Agent** — Reframes obstacles as learning opportunities
3. **Reader-Engagement Agent** — Adds hooks, analogies, questions
4. **Tone-Calibration Agent** — Matches "Sailesh voice" (curious, skeptical, practical)

Each agent outputs diff + reasoning. Human can accept, reject, or edit before next stage.

### Stage 5: Curation
- Compare consultancy + LinkedIn versions for coherence
- Flag tone inconsistencies
- Suggest images/diagrams (links to Excalidraw vault)
- Human review gate: approve or send back to enhancement

### Stage 6: Immutable Lineage Tracking
- **Kuzu schema**: Audio → TranscriptVersion → Concept → BlogPost → PublishEvent
- Every node timestamped and versioned
- Can trace: "Which voice memo led to this blog post? When was it recorded?"
- Enables: Book assembly by recording date, audio-note consistency checks

### Stage 7: Book Assembly
- Curated posts grouped by chapter (9 chapters: "UK Banking Digital Transformation")
- Cross-reference resolution (blog post links to other posts → table of contents)
- Lineage graph becomes book's research provenance
- Output: Single `.md` file exportable to Pandoc → PDF/ePub

## Quality Tiers & Qwen Model Selection

### Three Parallel Qwen Instances
- **Qwen 4B** (iPhone app): Fast taxonomy scoring, classification only
- **Qwen 9B** (overnight laptop): Draft generation, concept extraction
- **Qwen 27B** (Mac Mini, 2am slot): High-quality enhancement, final rubric scoring

No distillation: Train directly on target model, don't compress from large and lose domain signal.

## Special Handling: Banking Terminology

- Dictionary: 800+ financial terms (Fed policy, Basel III, PSD2, etc.)
- LoRA adapter: Corrects Qwen's generic banking slang to UK regulatory language
- Validation: Every term flagged post-pipeline for human approval before book assembly

## Planned: "Sailesh Voice" LoRA Adapter

- At 50 gold posts (currently at 42), train LoRA on human-edited versions
- Detect tone markers: informal second-person, technical but accessible, examples over theory
- Apply to all future drafts at stage 3
- Expected: Reduce enhancement stage 4 workload by 35%

## Performance Metrics

- **Throughput**: 400 transcriptions/night (2am–6am window)
- **End-to-end latency**: 18 hours (voice → published blog)
- **Cost**: <$5/night (all Ollama, one Claude validation pass)
- **Accuracy**: 96% on financial terminology (post-correction)
- **Publish rate**: ~12 posts/week from archive backlog

## Key Decisions

- **On-device transcription**: Privacy + cost, no Whisper API calls
- **Kuzu lineage**: Enable post-hoc analysis (e.g., "which insights come from 2023 recordings?")
- **Dual-track output**: Same voice, different audiences, single source
- **Offline enhancement**: No cloud dependency after transcription, audit trail complete

## Source Material
- `tools/voice-to-book/` in BlogCreator repo
- `config/qwen-tiers.json` (model selection logic)
- `bank-terms-lexicon.json` (terminology dictionary)

## Cross-References
- [[BlogCreator]] — Full implementation
- [[kuzuctl]] — Lineage graph backing
- [[KuzuGraphKit]] — Immutable DAG persistence
- [[Two-Tier Model Deployment]] — Why we run Qwen 4B/9B/27B in parallel

## Related Posts
- On-Device AI Meets Apple Foundation Models (post 6)
- The Autoresearch Pattern (post 1)
- Turning Your Knowledge Base Into a Graph You Can Argue With (post 2)

## Next Steps
- Detailed walkthrough: voice → 6 gold posts example
- Architecture diagram: 4-agent pipeline with feedback loops
- Performance graph: transcription speed vs model size
- Cost breakdown: hardware (amortised) vs API calls
- Screenshots: Kuzu lineage query for a published post
- Case study: How LoRA adapter training at 50-post threshold changed output quality

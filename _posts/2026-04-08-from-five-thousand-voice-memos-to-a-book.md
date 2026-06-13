---
title: "From 5,000 Voice Memos to a Book: The Pipeline That Runs While You Sleep"
date: 2026-04-08
categories: [Engineering, AI]
tags: [knowledge-management, llm-engineering, voice-transcription, book-generation, kuzu, mlx, ollama]
excerpt: "How I built a ML pipeline to convert 5,287 voice memos recorded over five years of banking consulting into a structured book on UK digital transformation—using local models, immutable lineage, and staged quality gates instead of one-shot prompts."
author: Sailesh Panchal
---

## The Trap

Five years of banking consulting leaves you with something precious and useless: 5,287 voice memos scattered across four different apps.

Pauses while walking to Pret. Thirty-second thoughts about SEPA harmonisation captured in an Uber. A four-minute tangent on PSD2 compliance recorded while waiting for a call. All of it—126 GB of audio—sitting in iCloud, slowly drowning in your decision paralysis.

The knowledge is there. Real patterns about digital transformation in UK banking. Causal loops connecting regulatory change to architecture decisions. Mistakes I've made at two banks and a fintech. But the knowledge is trapped in audio files I will never listen to again. Who has the time?

So I built a pipeline.

The ambition was simple: turn those 5,000 hours of raw thinking into a book. Not a collection of blog posts. Not a listicle farm. A proper book—nine chapters, 40,000 words, structured narrative arc—on transforming a UK bank from the CTO's perspective. Call it *The Transformation Paradox*.

But you cannot write a book by listening to 5,000 recordings. You need automation. You need stages. You need quality gates that separate the gold from the noise.

What follows is how I built it.

## The Architecture: Four Stages, Three Model Tiers, One Immutable Graph

The pipeline runs nightly at 2am. It pulls raw audio from four vaults, transcribes at 140x real-time, scores against 100 financial concepts, generates two formats of content, enhances with a four-agent system, and logs every decision in a Kuzu knowledge graph for audit and cross-referencing.

No prompt tells it "write me a book." The pipeline has stages.

### Stage 0: Transcribe (Audio → Transcript)

The first bottleneck is speech-to-text. I record on my phone (mostly Apple Voice Memos), backup to Dropbox, and keep originals in Google Drive as a belt-and-braces hedge. Four vaults: Voice Memos (2,847 files), Dropbox recordings (1,420), Google Drive (723), and Telegram voice notes (297).

| Vault | File Count | Format | Access |
|-------|-----------|--------|--------|
| Apple Voice Memos | 2,847 | .m4a | iCloud sync |
| Dropbox backups | 1,420 | .mp3 | Local mount |
| Google Drive archive | 723 | .mp3 | API via gcloud |
| Telegram voice notes | 297 | .ogg | Export script |

For STT, I tested two local models—parakeet-mlx and mlx-whisper—and found I needed both.

**parakeet-mlx** runs at 140x real-time on Apple Silicon. On a 2-minute voice memo, it produces output in under 1 second. Word error rate sits at 6.3%. For raw speed (processing 400 recordings in a batch), it's unbeatable. But it misses domain specifics. It hears "SEPA" as "sepia" and "CHAPS" as "chaps" (the riding wear, not the clearing house).

**mlx-whisper** is slower (3-4x real-time) but domain-aware. I seed its prompt with ~40 financial terms: CHAPS, BACS, SEPA, ISO 20022, FMV, PSD2, FIDO2, BaaS, BNPL, passporting, SCA. The model uses the prompt as a lexical hint. Correct rate for those 40 terms jumps from 40% to 94%.

So the pipeline does this: parakeet first for speed, flag any memo over 2 minutes as "high-stakes financial" (if it contains keywords like "compliance" or "architecture"), and re-transcribe those with mlx-whisper HQ.

A compiled regex corrects the remaining 6% of finance-specific mistakes—it catches patterns like "sepia clearing" and replaces them with "SEPA clearing" using context.

Result: 400 clean transcripts per night. Total cost: zero. (Ollama runs locally; no API fees.)

### Stage 1: Analyse (Transcript → Confidence Score)

The second stage is scoring. Not "is this good?" but "is this articulate enough to generate content from?"

I built a taxonomy of 5 themes and 100 financial concepts:
- Theme 1: Regulatory Compliance (PSD2, GDPR, FIDO2, SCA, Strong Customer Auth)
- Theme 2: Payments Modernisation (ISO 20022, SEPA, CBDC, Real-Time Payments)
- Theme 3: Enterprise Architecture (Systems Thinking, Domain-Driven Design, Event Sourcing)
- Theme 4: Talent & Culture (Team scaling, psychological safety, growth mindset)
- Theme 5: AI Integration (LLM ops, vector DBs, prompt engineering)

**Qwen 3.5-4B** (thinking mode disabled for clean JSON) scores each transcript on all five themes. Output:

```json
{
  "memo_id": "20260407_0247_psd2_discussion",
  "duration_seconds": 312,
  "themes": [
    {
      "name": "Regulatory Compliance",
      "relevance_score": 0.68,
      "confidence": 0.92,
      "concepts_detected": ["PSD2", "SCA", "passporting", "regulatory_arbitrage"]
    },
    {
      "name": "Payments Modernisation",
      "relevance_score": 0.44,
      "confidence": 0.87,
      "concepts_detected": ["ISO_20022", "Real-Time_Payments"]
    }
  ],
  "overall_quality_score": 0.58,
  "recommendation": "GOLD",
  "rationale": "Clear narrative arc, specific examples, actionable guidance."
}
```

The three confidence bands:

| Band | Score | Action |
|------|-------|--------|
| **Gold** | ≥55 | Auto-generate blog post + LinkedIn format |
| **Silver** | 40–54 | Generate, lower priority, queue for review |
| **Bronze** | 37–39 | Queue for Whisper HQ retranscription |
| **Dud** | <37 | Skip; log for manual review later |

Of 5,287 memos, 1,247 came back Gold. 2,104 Silver. 894 Bronze (queued for retranscription). 1,042 Dud (mostly background noise, false starts, or phone-call fragments).

Gold memos are the ones where I was actually thinking—not just ruminating.

### Stage 2: Generate (Transcript → Two Formats)

Gold memos fork into two tracks:

**Track A: Consultancy Article** (1,500–3,000 words). SEO-optimized, thought leadership tone. Structured: Problem statement, why it matters, decision tree, implementation pattern, common pitfalls, call to action. This goes to the blog and gets social distribution.

**Track B: LinkedIn Post** (300–600 words). Snappier. "Here's the insight; here's why you should care; here's the next step." Thread-friendly. Lower friction. Different audience (practitioners vs. architects).

Same transcript. Two prompts. Two voices. The pipeline generates both in parallel. (Qwen 9B does this overnight; we're not paying for latency.)

### Stage 3: Enhance (Content → Four-Agent Polish)

This is where the magic happens. After generation, I don't ship immediately. I run a four-agent enhancement pipeline. Each agent has a specific job:

1. **Systems Thinking Agent** (89% effectiveness): Reads the draft and identifies causal loops. If I wrote "Teams moved faster after we restructured," the agent asks: "But did velocity improve because of the structure, or because the reorganisation coincided with hiring senior engineers?" It surfaces confounds. It ties insights to feedback loops. It turns observations into models.

2. **Growth Mindset Agent** (92%): Reframes challenges as capability development. If the draft says "We struggled with microservices," the agent rewrites it: "We discovered microservices require different operational muscle—here's how we built it." Ownership over victimhood. Agency over passivity.

3. **Reader Engagement Agent** (87%): Injects Socratic questions and "Explore Further" links. It pulls from the Kuzu graph: if I mention ISO 20022, the agent fetches all related concepts (SEPA, Real-Time Payments, CBDC) and suggests cross-links. It turns monologue into dialogue.

4. **Tone Calibration Agent** (85%): Quality gate. Checks: Is this too jargon-heavy for practitioners? Too simplistic for architects? Is the voice consistent with my other posts? Does it land for a UK banking CTO? Flags anything that feels off.

Each agent is built with a five-layer prompt architecture:
1. **Identity**: "You are a systems thinking expert, trained on complex adaptive systems."
2. **Expertise**: "Your specialty is identifying feedback loops in socio-technical change."
3. **Context**: [Kuzu neighbourhood context: all related concepts, prior posts on this theme, decision history]
4. **Standards**: "Your output must be concrete (not hand-wavy), humble (not prescriptive), and tied to evidence."
5. **Output format**: "JSON with `suggestions` array, each item has `location` (which paragraph), `original_text`, `proposed_revision`, `rationale`."

The orchestrator fetches each agent's output, merges non-conflicting suggestions, and flags conflicts for manual review.

Cost per article: ~$0.30 (Claude API for agent coordination only; base generation is free on Qwen 9B).

### Stage 4: Lineage (Everything → Immutable Kuzu Graph)

Here's the bit that matters for regulators, auditors, and your own sanity: every artifact is traceable.

```
Audio file (20260407_0247.m4a)
  ↓
TranscriptVersion (v1: parakeet, v2: whisper HQ)
  ↓
ConceptExtraction (PSD2, SCA, Real-Time Payments)
  ↓
ConfidenceScore (0.58 → GOLD)
  ↓
BlogPost (1,847 words, published 2026-04-08)
  ↓
LinkedInPost (412 words, published 2026-04-08)
  ↓
BookChapter ("Regulatory Modernisation", position 3)
```

Kuzu nodes never overwrite. New versions create new nodes. If I re-transcribe a memo with Whisper HQ, a `TranscriptVersion` node links the old (parakeet) and new (whisper) outputs. The graph shows the evolution. An auditor can ask: "Show me every version of the PSD2 content" and trace the lineage.

This matters. If a regulator asks, "How did you arrive at this conclusion about SCA?" you can pull the graph: here's the memo, the timestamp, the transcription method, the quality score, the agents that touched it, the publication date.

No hand-waving. No "I think I wrote about that somewhere."

## The Model Tiers: Trade Latency for Quality

I use three Qwen models on Apple Silicon via MLX. No cloud API. No cost for overnight bulk work.

| Model | Size | VRAM | Latency | Use Case | Cost |
|-------|------|------|---------|----------|------|
| **Qwen 3.5-4B** | 3 GB | 1.2 GB | 0.8s per 1K tokens | Daily scoring, quick analysis | Free |
| **Qwen 9B** | 6 GB | 2.4 GB | 1.8s per 1K tokens | Blog generation, formatting | Free |
| **Qwen 27B** | 30 GB | 8 GB | 5.2s per 1K tokens | Diagram specs, complex reasoning | Free |

4B runs every memo nightly (scoring). 9B generates content (Track A and Track B). 27B handles overnight "think deeply" work—when I want Qwen to reason through architecture trade-offs, it gets the 27B model and 30 seconds per response.

The key insight: **free latency is valuable**. If a task takes 30 seconds but costs $0 (because it's midnight), run it. If it takes 5 seconds and costs $0.10, use Claude (10x faster, acceptable cost for spot-check validation).

My cost model for overnight processing: $0. For daytime validation: ~$50/month Claude API budget.

## The LoRA: Voice Adaptation at Scale

At 50 gold posts, I'll train a LoRA (Low-Rank Adapter) on top of Qwen 9B.

Training data: 50 (transcript, Sailesh's personal rewrite) pairs. The LoRA learns not the content, but the voice. How I restructure a rambling 5-minute thought into crisp argument. My preference for concrete examples over abstractions. My skepticism toward buzzwords.

Base model: Qwen 9B. The LoRA will be ~64 MB. After training, any Qwen 9B inference with the LoRA loaded will sound more like me.

I'm not training a new foundation model. I'm training my voice on top of an existing one.

## The Book: Nine Chapters from Chaos

The output is structured as nine chapters, crystallised from Kuzu themes:

1. The Transformation Paradox (Intro: why banks change, why it fails)
2. Regulatory Winds (PSD2, GDPR, future regulation)
3. Payments Plumbing (ISO 20022, SEPA, Real-Time Payments)
4. Systems Thinking (feedback loops, causal models, complexity)
5. Architecture Decisions (DDD, event sourcing, monolith vs. microservices)
6. Building Teams (talent, psychological safety, growth mindset)
7. AI Integration (LLMs, vector search, responsible deployment)
8. The Operator's Mindset (observability, chaos engineering, incident response)
9. The Systems Thinker's Manifesto (coda: synthesis, next decade)

Each chapter is built from a cluster of Gold memos. `ttb query journey --concept PSD2 --show-evolution` traces how my thinking on PSD2 compliance evolved across five years—which memo first articulated it, how the thinking deepened, where contradictions emerged, what I changed my mind on.

The book is not a collection of essays. It's a narrative with causal coherence, built from the graph.

## The Patterns: What CTOs Should Learn

Three principles stand out:

**1. Split problems correctly.** This pipeline works because each stage has one job. Transcription doesn't score. Scoring doesn't generate. Generation doesn't enhance. Each stage outputs clean JSON, which the next stage consumes. When something breaks, you know where. This is the same principle I wrote about in ["Fifty PowerPoints: How to Scale Content Without Burning Out"]({% link _posts/2026-03-20-fifty-powerpoints-and-a-rebrand-why-we-didnt-train-a-model.md %})—splitting the branding pipeline into extract, deterministic transform, and intelligent rewrite.

**2. Free latency is a weapon.** If it costs $0 to run overnight, run it deeply. If it costs money by the token, get ruthless about scope. The four-agent enhancement costs ~$0.30 per article because Claude sees only the final, filtered JSON from cheap models. It doesn't re-read the transcript; it doesn't second-guess the scoring. Money buys precision in specific places, not omniscience.

**3. Lineage is not optional.** You think you won't need an audit trail until you do. Then it's too late. Immutable Kuzu nodes cost nothing. The discipline of logging every version, every decision, every touch—it pays for itself the first time a stakeholder asks "where did you get that number?" and you can say "here, pull the graph."

## The Status

As of April 2026, the pipeline is production. 1,247 gold memos have generated blog posts. 894 have been retranscribed and are pending generation. The first book outline is crystallising around the nine chapters above.

Total elapsed time to build: 14 months (evenings and weekends). Total cost: ~$600 (mostly Claude API during development; now down to $50/month validation budget). Total time saved: hard to measure, but if I'd manually transcribed even 1% of those memos, I'd have lost three weeks of consulting work just sitting with an audio player.

The real value is this: five years of thinking are no longer lost. They're queryable. They're traceable. They're part of a coherent narrative. And the book will exist.

That's worth building a pipeline for.

---

**Sailesh Panchal** is a CTO advisor and architect specialising in digital transformation at UK banks. He writes about payments modernisation, systems thinking, and the engineering practices that survive contact with regulation.

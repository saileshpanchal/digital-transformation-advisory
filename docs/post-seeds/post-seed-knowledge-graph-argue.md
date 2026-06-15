---
id: post-seed-002
title: "Turning Your Knowledge Base Into a Graph You Can Argue With"
type: post-seed
sphere: knowledge-engineering
status: drafting
target_date: 2026-04-12
confidence: proven
tags: [kuzuctl, knowledge-graph, kuzu, sqlite, obsidian, llm, refine, challenge]
related: [[kuzuctl]], [[BlogCreator]], [[KuzuGraphKit]]
---

## Overview

Transform a markdown-first Obsidian vault into a queryable knowledge graph where contradictions surface as first-class edges and an LLM can red-team your reasoning overnight. kuzuctl materialises markdown into SQLite, Kuzu handles the graph layer (swappable via protocol).

## Architecture

### Data Layer
- **Primary**: Markdown files (Obsidian vault)
- **Derived**: SQLite knowledge graph (or Kuzu, protocol-abstracted)
- **Schema**: Insight → LINKS_TO → Insight (relationship types: references, supports, contradicts)
- **Contradictions**: TENSIONS_WITH edges for explicit conflicts
- **Confidence**: Dual labels (human-readable) + scores (0.0–1.0 for ML)

### GraphStoreProtocol Abstraction
- Swapped Kuzu for SQLite when kuzu-swift 0.11.3 reopen bug blocked deployment
- Protocol saved 3 weeks of rework — no CLI changes, just swap backend
- Lesson: Storage engines are implementation detail, not domain logic

## Six-Pass Overnight Refine Loop

1. **Extract** — Parse markdown frontmatter, pull entities and relationships
2. **Embed** — Dense vectors via Ollama (bulk, free) for semantic dedup
3. **Dedupe** — Cluster near-duplicate insights (Levenshtein + semantic)
4. **Enrich** — LLM fills missing relationships (Ollama 90%, Claude 10% validation)
5. **Validate** — Rubric scoring on consistency, clarity, actionability (Claude spot-check)
6. **Prune** — Remove orphans, dead references, rank confidence downward

### Ollama vs Claude Split
- **Ollama**: Bulk entity extraction, dense embeddings, candidate generation (runs overnight, costs <$0.01)
- **Claude**: High-stakes validation, tone calibration, final rubric scoring (10% of volume, metered)

## Challenge Command (Red-Teaming)

- Adversarial: "Find the weakest claim in this cluster"
- Structural: "What's missing from this evidence chain?"
- Contradiction detection: Walk TENSIONS_WITH edges, probe for unresolved conflicts
- Suggest fallback positions or stronger frames
- Outputs reasoning + confidence for each challenge

## Suggest Command (Discovery)

- Find open triangles (A links to B, B links to C, but no A→C)
- Orphan detection (nodes with <2 connections)
- Sphere filtering (only show challenges in "systems-thinking")
- Supports exploratory knowledge work

## BlogCreator Integration

Extends schema with Audio layer:
- Audio → TranscriptVersion → Concept → BlogPost → LinkedInVariant
- Immutable lineage: every post traceable back to voice memo timestamp
- 126 GB of recordings analysed through this DAG

## RefineManifest Audit Trail

- JSON log of every refine run: what changed, why, which LLM scored it
- Rollback support: revert last night's enrichment if validation rubric changed
- Transparency: justify every edge added by the system

## Key Decisions

- **Markdown primary**: If DB corrupts, `kuzuctl sync` rebuilds from source of truth
- **No project coupling**: KuzuGraphKit reusable by BlogCreator, SFiA-AI, any Swift project
- **Tensions as edges**: Contradictions tracked explicitly, not lost in merge logic

## Source Material
- `docs/PLAN.md` in kuzuctl (implementation order)
- `docs/KUZU-REOPEN-BUG.md` (why we abstracted storage layer)
- RefineManifest schema docs

## Cross-References
- [[kuzuctl]] — CLI and vault sync logic
- [[KuzuGraphKit]] — Graph library (protocol-based)
- [[BlogCreator]] — Audio lineage extension
- [[autoresearch-pattern]] — Overnight refine loop as autoresearch

## Related Posts
- From 5,000 Voice Memos to a Book (post 3)
- On-Device AI Meets Apple Foundation Models (post 6)

## Next Steps
- Walk through a TENSIONS_WITH resolution case study
- Show challenge output on real vault (anonymised)
- Explain the protocol swap story in detail
- Code snippet: VaultLint error reporting
- Performance: sync time for 10K notes

---
title: "Turning Your Knowledge Base Into a Graph You Can Argue With"
date: 2026-04-08
categories: [Engineering, AI]
tags: [knowledge-graphs, llm-tools, architecture, obsidian, kuzu, sqlite, kuzuctl]
excerpt: "How to build a derived graph layer on top of markdown files so you can ask 'what contradicts this?' instead of just 'does this exist?'"
author: Sailesh Panchal
---

You've been consulting for five years. Your Obsidian vault has 847 insights. You can search by keyword. You can search by tag. But you cannot ask your own knowledge base "what contradicts this claim?" and you cannot ask "what's the gap in my thinking here?"

That's the problem that led to kuzuctl.

## The Problem: Linear Search, Exponential Complexity

When you have fewer than 100 notes, text search is fine. You remember that you wrote something about "confidence scoring" six months ago. You search, find it, move on.

At 847 notes, things break. Here's what happens:

- You write a new insight: "Confidence should be semantic, not just statistical."
- You search for "confidence" and find 34 previous notes.
- You manually check each one for contradictions, connections, implications.
- You spend two hours in busywork, or you don't, and miss critical connections.
- You build the same idea twice, not realizing it's already in the vault.

This doesn't scale with your organisation. If you have a knowledge base serving 10 people, or 100 people, the problem gets worse. Everyone searches independently. No one knows what's contradictory.

The usual solution is a proper database. You migrate everything out of markdown into a relational schema. You hire someone to maintain it. Now markdown is a view, and the database is the source of truth.

But that inverts the problem: if the database goes down or gets corrupted, you've lost your real knowledge. And your markdown is now stale.

## The Decision: Markdown Primary, Graph Derived

We chose a different pattern: **markdown stays primary. The graph is derived.**

If you delete the Kuzu database tomorrow, `kuzuctl sync` rebuilds it from your markdown files in 30 seconds. The markdown is the source of truth. The graph is an acceleration layer—like a database index, not like a ledger.

This decision cascaded through everything:

- Node identity is anchored in frontmatter IDs, not file paths.
- The schema is optimized for synthesis, not normalization.
- Commands can assume the graph is stale (it rebuilds every night).
- The CLI is the consumer, not the source.

This pattern appeared again when we had to solve the Kuzu reopen bug. More on that in a moment.

## The Architecture: Three Swift Targets, One Protocol

The codebase has three Swift packages:

| Package | Purpose | Reusable? |
|---------|---------|-----------|
| `kuzuctl` | Obsidian vault CLI: sync, lint, ingest, search, challenge, suggest | No—vault-specific logic |
| `KuzuGraphKit` | Graph store abstraction (CRUD, embedding, conflict detection) | Yes—used by BlogCreator, SFiA-AI |
| `LLMKit` | Multi-provider LLM wrapper (Ollama, Claude, Mock) | Yes—any Swift project |

The critical move was `GraphStoreProtocol`. This abstract interface lets you swap storage backends without changing any command code:

```swift
protocol GraphStoreProtocol: Actor {
    func createNode(id: String, label: String, properties: [String: Any]) async throws
    func linkNodes(source: String, target: String, relation: String) async throws
    func searchByEmbedding(query: [Float], limit: Int) async throws -> [SearchResult]
    func detectTensions(nodeID: String) async throws -> [Tension]
}
```

We built this assuming Kuzu. Then kuzu-swift 0.11.3 had a reopen bug: the library could not safely reconnect after the process closed the database. This is critical for a CLI that might be invoked 100 times in a day (each time: open, query, close, exit).

We had two options:
1. Wait for Kuzu to fix the bug.
2. Implement SQLite and swap it in.

Because we had the protocol, option 2 took one week. We did not rewrite any commands. The CLI still worked, still output the same JSON, still passed the same tests.

This was a deliberate CEO-review decision: build for optionality, not for the prettiest tech. Kuzu is the long-term backend (better analytics, better scalability). SQLite is the reliable pivot. Both implement the same interface.

## The Schema: Confidence + Contradictions

Here's the core insight graph schema:

```
NODES:
  id (String, primary)
  label (String)
  confidence_label (String: "certainty" | "assumption" | "emerging" | "contested")
  confidence_score (Float: 0.0-1.0)
  description (String)
  embedding (FLOAT[768])
  frontmatter_id (String)
  source_file (String)

EDGES:
  source_id (String)
  target_id (String)
  relation (String)
  type ("LINKS_TO" | "TENSIONS_WITH")
  context (String)
```

Two design choices stand out:

**Dual confidence.** Humans read `confidence_label`: "Is this certain, or emerging?" Machines read `confidence_score`: "On a scale of 0–1, how much evidence supports this?" The label is for reasoning. The score is for filtering.

**TENSIONS_WITH as first-class edges.** Most graph systems treat contradictions as an absence (this edge doesn't exist because the two claims conflict). We model them explicitly. If note A says "cloud adoption reduces capex by 60%" and note B says "cloud adoption increases operational complexity by 40%", we create a TENSIONS_WITH edge between them. This lets us ask "what contradicts this?" and surfaces unresolved debates.

**Node identity by frontmatter ID, not path.** When you rename a file, the graph doesn't break. The frontmatter ID stays stable:

```yaml
---
id: cost-control-through-observability
confidence: "certainty"
tags: [cost, devops]
---
```

## The Overnight Refine Loop: Six Passes, Zero Cost

Every night at 3 AM, `kuzuctl refine` runs six semantic passes. This is where the graph stops being a static view and starts actively learning about itself.

**Pass 1: Embed.** Every node without a vector embedding gets one via nomic-embed-text (local Ollama, runs free). 768-dimensional vectors. Takes about 2 seconds per node on modern hardware.

**Pass 2: Deduplicate.** Compute cosine similarity between all pairs. If similarity > 0.95 and both nodes have high confidence, merge them. This catches "I wrote the same insight three times in different words."

**Pass 3: Enrich.** For nodes with missing descriptions, ask Claude (via LLMKit) to generate one from their wiki-links and neighbors. This fills gaps in sparse nodes.

**Pass 4: Detect contradictions.** For every pair of nodes with LINKS_TO edges, check: do their descriptions or embedding space conflict? If so, create a TENSIONS_WITH edge with a reason.

**Pass 5: Validate.** Sample 10% of nodes and ask Claude to verify that the confidence_score is correct based on the node's description and linked evidence. Adjust scores if needed.

**Pass 6: Prune.** Remove nodes with confidence_score < 0.3 that have no incoming edges. Don't delete them—move them to a "low_confidence" table so you can audit them later.

Every pass logs to a `RefineManifest`:

```json
{
  "run_date": "2026-04-08T03:00:00Z",
  "passes": [
    {
      "pass": "embed",
      "nodes_processed": 847,
      "nodes_created": 12,
      "duration_seconds": 45
    },
    {
      "pass": "deduplicate",
      "nodes_processed": 847,
      "merges": 3,
      "duration_seconds": 8
    },
    {
      "pass": "enrich",
      "nodes_processed": 847,
      "nodes_updated": 24,
      "tokens_used": 12400,
      "duration_seconds": 28
    },
    {
      "pass": "detect_contradictions",
      "nodes_processed": 847,
      "tensions_created": 7,
      "duration_seconds": 62
    },
    {
      "pass": "validate",
      "sample_size": 85,
      "score_adjustments": 12,
      "tokens_used": 8900,
      "duration_seconds": 35
    },
    {
      "pass": "prune",
      "low_confidence_archived": 2,
      "duration_seconds": 3
    }
  ],
  "total_duration_seconds": 181,
  "total_tokens_used": 21300
}
```

This audit trail answers "what changed last night, and why?" If you wake up and a confidence score shifted, you can see exactly which pass did it and what reasoning was applied.

## The Challenge Command: Red-Team Your Own Graph

The most useful command is `kuzuctl challenge`:

```bash
kuzuctl challenge "Cloud adoption always reduces capex"
```

Output:

```json
{
  "claim": "Cloud adoption always reduces capex",
  "verdict": "contested",
  "evidence": {
    "supported": [
      {
        "node_id": "cost-control-observability",
        "confidence": "certainty",
        "reasoning": "Operational savings in datacenter overhead"
      }
    ],
    "contested": [
      {
        "node_id": "cloud-operational-complexity",
        "confidence": "emerging",
        "tension": "Cloud adoption increases operational complexity (TENSIONS_WITH)"
      }
    ],
    "insufficient_evidence": []
  },
  "cypher_used": "MATCH (n {label: $claim})-[r]-(m) WHERE r.type IN ['SUPPORTS', 'TENSIONS_WITH'] RETURN n, r, m",
  "reasoning": "Your claim has direct support for cost reduction, but we found a contested edge claiming increased operational complexity. Neither claim is fully resolved—both confidence scores are below 0.8."
}
```

Notice the `cypher_used` field. This makes the reasoning reproducible. You can run that same query, inspect the results, and decide whether the algorithm was right. This transparency is why challenge is useful as a red-team tool, not just as an answer engine.

## The Suggest Command: Surfacing Synthesis Gaps

`kuzuctl suggest` finds patterns that *should* exist but don't:

- **Orphans**: Nodes with no incoming or outgoing edges (dead weight)
- **Open triangles**: A→B, A→C, but no B→C (synthesis gap)
- **Unresolved tensions**: TENSIONS_WITH edges with low confidence on both sides (debate, not decision)

```bash
kuzuctl suggest --sphere "cost-control"
```

Output tells you: "You have 8 insights about cost controls, but nodes 'cost-observability' and 'cost-ai-automation' are not connected. Are they related, contradictory, or independent?"

This is the inverse of search. Search answers "does this exist?" Suggest answers "what's broken in your thinking?"

## BlogCreator: The Same Graph, Extended

This year we're building BlogCreator—a tool to turn raw voice recordings into polished blog posts, with full lineage tracking.

Five thousand, two hundred and eighty-seven voice recordings (5,287) over five years. We didn't want to throw away the audio. We built the transcription system into the same Kuzu graph.

The schema extends kuzuctl's:

```
NODES:
  AudioFile → TranscriptVersion → Concept → BlogPost → Chapter → PublishedContent

EDGES:
  TRANSCRIBED_FROM (AudioFile → TranscriptVersion, with accuracy score)
  EXTRACTED_FROM (Concept → TranscriptVersion, with confidence)
  INCLUDED_IN (Concept → BlogPost)
  REFINED_BY (BlogPost → BlogPost, tracking iteration)
  IMMUTABLE_LINEAGE (PublishedContent → AudioFile, tracing back to source)
```

BlogCreator uses `KuzuGraphKit`—the same reusable library. Different schema, same protocol. This validates the architecture decision: separating vault-specific logic (kuzuctl) from graph-specific logic (KuzuGraphKit) let us reuse the whole graph layer for a completely different problem.

## When to Build a Graph (and When Not To)

Not every knowledge base needs this. Here's the decision table:

| Condition | Recommendation |
|-----------|-----------------|
| < 200 notes, < 5 years old | Use Obsidian search. Stay flat. |
| 200–1000 notes, individual use | Build a derived graph. Use SQLite. |
| 1000–10k notes, team use, synthesis-critical | Build a derived graph. Use Kuzu. Add challenge/suggest commands. |
| Raw data → structured output (transcription, contracts, research) | Build a lineage graph. Same protocol, different schema. |
| Graph is the product (recommendations, discovery, analytics) | Build graph-as-primary. Invest in the database. Accept the maintenance cost. |

The key: **Is the graph helping you think, or is it becoming the thing you think about?**

If it's helping you think—synthesis, contradiction detection, gap finding—it should be derived and lightweight.

If it's the thing you think about—someone built it, someone maintains it, it has its own schema version—it should be primary and mature.

We chose derived because the vault is the thought. The graph is the reasoning tool.

## Takeaway: Invert the Authority

Most graph projects start with "we need a database, let's extract data into it." This makes the database the source of truth and guarantees eventual consistency pain.

Invert it: keep your source of truth (markdown, voice recordings, whatever) and build a derived graph that can be thrown away and rebuilt. This trades some query latency for enormous operational simplicity.

You get to ask your knowledge base hard questions. You get reproducible reasoning (the SQL that built the answer). You get an audit trail (RefineManifest). And you never wake up wondering what corrupted your real data.

That's the kuzuctl pattern. Build it if you have 847 insights and your thinking is your product.

---

**Sailesh Panchal** is a CTO and founder of Digital Transformation Advisory. He consults with UK banking and fintech on AI strategy, platform architecture, and the boring operational decisions that make transformation stick.

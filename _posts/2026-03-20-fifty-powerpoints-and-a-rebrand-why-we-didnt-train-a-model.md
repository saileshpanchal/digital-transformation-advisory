---
title: "Fifty PowerPoints and a Rebrand: Why We Didn't Train a Model"
date: 2026-03-20
categories: [AI, Strategy]
tags: [digital-transformation, brand-conversion, powerpoint, python-pptx, enterprise-ai, automation]
excerpt: "A client needed 50 PowerPoint decks converted to a new brand identity. Our first instinct was to train a model. We were wrong. Here's the pipeline we built instead, and the decision framework that stopped us from over-engineering."
---

The brief was simple enough. A client had been through a rebrand — new name, new visual identity, new tone of voice. The old brand lived on in 50 PowerPoint decks: board packs, strategy documents, client proposals, quarterly reviews. Every one needed converting.

A designer quoted 2-4 hours per deck. At the midpoint, that's 150 hours of someone carefully changing Georgia to Calibri, swapping navy for teal, and rewriting "We are pleased to present our findings" as "Here's what we found." Important work. Also, the kind of work that makes a talented designer question their career choices by deck number twelve.

We were asked: can AI do this?

## The Training Reflex

Our first thought — and I suspect yours too — was to train a model. Feed it examples of old-brand and new-brand decks, let it learn the transformation, and apply it at scale. We're building [fine-tuned small language models](/2026/03/20/when-your-data-cant-leave-the-building/) for other projects. We have the pipeline. The hammer was in our hand, and this looked like a nail.

Then we opened a deck and started listing what actually changes in a rebrand.

| What Changes | Example | How Many Variants? |
|---|---|---|
| Font families | Georgia → Calibri | 4-6 unique mappings |
| Font sizes | 32pt heading → 36pt | Tied to the font mappings |
| Colour palette | #003366 → #007C7A | 6-8 hex values |
| Logo | Old logo.png → New logo.png | 1 swap |
| Footer text | "Old Corp. All rights reserved." → "New Brand. Confidential." | 1 find-replace |
| **Tone of voice** | **Formal prose → Punchy, conversational** | **Unbounded** |

Five of those six are lookup tables. Fixed inputs, fixed outputs, zero ambiguity. Georgia is *always* Calibri. #003366 is *always* #007C7A. The footer string is literally the same on every slide of every deck.

Training a neural network to learn a lookup table is like hiring a sommelier to check if milk has expired. Technically possible. Wildly inefficient. Harder to debug when it gets the answer wrong.

The sixth item — tone — is different. Rewriting "Our methodology is evidence-based, outcome-driven, and designed for sustainable change" as "Evidence-based. Outcome-driven. Built to last" requires understanding language, context, and intent. That's what language models are good at.

So we drew a line.

## The Line: 95% Pipeline, 5% Intelligence

We split the problem in two:

**Deterministic engine** (python-pptx): Handles every visual transformation — fonts, colours, logos, footers, borders, shape fills. Runs in under 2 seconds per deck. Produces identical results every time. Easy to audit, easy to fix, easy to explain to a client.

**AI tone adjustment** (Claude, in-context): Handles the language rewriting. Reads the text from each converted slide, applies the brand's tone rules, and rewrites while preserving all factual content. Uses the designer's own rewrites as few-shot examples — no training data required.

The beauty of this split is that each half plays to its strengths. The pipeline is fast and exact where you need exactness (your brand colour had better be #007C7A, not #007C79). Claude is flexible and contextual where you need intelligence (knowing that "we are pleased to present" and "we would like to share" are the same pattern, even though the words are different).

## How the Pipeline Works

### Step 1: The Designer Creates One Pair

This is the clever part, and it's the designer's one contribution to the entire process.

They take a single real deck and recreate it in the new brand. Same slides, same text, same structure — different visual treatment. Where they also change the *wording* (not just the formatting), that signals a tone shift.

We end up with two files: `source-exemplar.pptx` and `target-exemplar.pptx`.

### Step 2: The Script Diffs Them

A Python script walks both files slide-by-slide, shape-by-shape, text-run-by-text-run. For each matching text string, it compares the formatting and builds a mapping:

```json
{
  "fonts": {
    "Georgia|32.0|bold": {
      "family": "Calibri",
      "size_pt": 36.0,
      "bold": true
    },
    "Cambria|14.0|normal": {
      "family": "Calibri",
      "size_pt": 13.0,
      "italic": true
    }
  },
  "colours": {
    "#003366": "#007C7A",
    "#CC9900": "#2ECC71",
    "#F5F0E8": "#FAFAFA"
  },
  "footer": {
    "find": "© 2024 Meridian Consulting Group. All rights reserved.",
    "replace": "Apex Partners Ltd. Private & Confidential."
  }
}
```

The script also captures every text change — places where the designer rewrote the words. These become the tone examples:

```
Before: "Our team brings deep expertise in cloud migration,
         platform modernisation, and AI-native architecture."
After:  "Our people bring hands-on expertise in cloud,
         platforms, and AI — not just slide decks."
```

From these examples, we derive tone rules: formal → conversational, passive → active, long sentences → punchy fragments, corporate jargon → plain English.

### Step 3: Apply to 50 Decks

The conversion engine opens each deck and applies the mapping mechanically. Every text run gets its font checked and swapped. Every colour value gets looked up and replaced. Every footer gets rewritten. Every logo gets swapped.

On our test deck — a 6-slide cloud migration assessment — the pipeline made 105 font changes, 52 colour changes, and 6 footer updates in under 2 seconds.

### Step 4: Claude Adjusts the Tone

After the visual conversion, Claude reads each slide's text and applies the tone rules. The prompt pattern is straightforward:

*"Given these tone rules and examples, rewrite this text to match the target brand voice. Preserve all facts, technical terms, and proper nouns. Only change the language style."*

Claude sees the designer's own before/after examples, so it's learning the brand voice from the person who defined it — not from a training set we curated.

## What This Looks Like in Practice

Here's a slide from the test deck, before and after:

**Before (old brand):**
> The organisation currently operates 147 on-premises applications across three data centres. Our assessment identifies 82 applications suitable for cloud migration within the next 18 months. We recommend a phased approach beginning with non-critical workloads to establish patterns and confidence.

**After (new brand, visual conversion + tone adjustment):**
> 147 apps running on-prem across three data centres. We've identified 82 that are ready for cloud migration in the next 18 months. Start with non-critical workloads — build the pattern, build confidence, then scale.

Same facts. Same numbers. Same recommendation. Different voice. The fonts, colours, and footer changed too — but those are invisible in a text excerpt.

## The Decision That Mattered

The most important moment in this project wasn't writing the code. It was the conversation where we decided *not* to train a model.

We've seen too many organisations reach for AI when a well-structured pipeline would be faster, cheaper, and easier to maintain. The reverse is equally true — we've seen teams build increasingly brittle rule systems when a model would handle the variation naturally. The art is drawing the line in the right place.

Here's the framework we used:

| Signal | Reach for a Model | Reach for a Pipeline |
|---|---|---|
| Input variation | High — natural language, many phrasings | Low — structured, enumerable |
| Rules expressible? | No — too many edge cases | Yes — fits in a JSON file |
| Output must be exact? | Approximate is fine | Must be pixel-perfect |
| Error consequences | Graceful degradation | Hard failure |
| Debugging | "Why did the model say this?" | "This key maps to this value" |

The PowerPoint rebrand sits firmly on the pipeline side for 95% of the work. The tone adjustment is the 5% where a model earns its keep — not by learning from training data, but by understanding language in context.

## What We'd Tell the Sommelier

If you're staring at a problem and wondering whether it's an AI problem:

**Start by listing what changes.** If you can enumerate every transformation in a spreadsheet, you don't need a model. You need a script.

**Find the boundary.** There's usually a seam between the mechanical and the intelligent. Make the mechanical part deterministic, and only invite the AI to the part that actually requires understanding.

**Use the designer's work as your spec.** They've already done the hard thinking about what the transformation should look like. Your job is to scale it, not to reinvent it.

The 50 decks are converting. The designer is back to doing design work. And we didn't train a model.

---

*Sailesh Panchal is Director at Digital Transformation Advisory (DTA), specialising in technology strategy and AI-native architecture for enterprise clients.*

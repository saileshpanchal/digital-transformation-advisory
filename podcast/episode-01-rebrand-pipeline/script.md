# Episode 01: From Two PowerPoints to Fifty — Building a Brand Conversion Pipeline Live

**Format:** Screen-recorded walkthrough with voice narration
**Duration:** ~28 minutes
**Hosts:**
- **Sailesh Panchal** — CTO / Director, DTA (strategy, architecture, AI decisions)
- **Kiran Panchal** — Lead Designer (brand execution, exemplar deck creation, QA)

---

## COLD OPEN [0:00–1:30]

**[Screen: Side-by-side of an old-brand slide and new-brand slide]**

**Sailesh:** A client came to us after a rebrand. New name, new colours, new tone of voice. The old brand was still living in fifty PowerPoint decks — board packs, strategy documents, client proposals. Every one needed converting.

**Kiran:** A designer quoted two to four hours per deck. Multiply that by fifty and you're looking at 150 hours of changing fonts, swapping colours, and rewriting sentences. By deck twelve, you're questioning your career choices.

**Sailesh:** We were asked — can AI do this? And the honest answer was: yes, but not the way you'd think. We didn't train a model. We built a pipeline. And in this episode, we're going to build it from scratch, live, and convert all fifty decks by the end.

**Kiran:** I'm going to create the two reference decks that teach the system what the brand transformation looks like. Sailesh is going to run the code. And you'll see every step.

---

## ACT 1: THE BUSINESS PROBLEM [1:30–4:00]

**[Screen: Spreadsheet showing the 50 deck filenames, slide counts, dates]**

**Sailesh:** Let's set the scene. Here are the fifty decks. Board packs, quarterly reviews, client proposals, internal strategy docs. Some have 6 slides, some have 40. Total: roughly 800 slides.

What changes in a rebrand? Let's list it.

**[Screen: Table appearing line by line]**

| What Changes | Example | Variants |
|---|---|---|
| Font families | Georgia → Calibri | 4-6 mappings |
| Font sizes | 32pt → 36pt | Tied to fonts |
| Colour palette | #003366 → #007C7A | 6-8 hex values |
| Logo | Old logo → New logo | 1 swap |
| Footer text | "Old Corp" → "New Brand" | 1 find-replace |
| **Tone of voice** | **Formal → Conversational** | **Unbounded** |

**Sailesh:** Five of those six are lookup tables. Fixed input, fixed output, zero ambiguity. Georgia is *always* Calibri. Navy is *always* teal. Training a neural network to learn a lookup table is like hiring a sommelier to check if milk has expired.

The sixth one — tone — is genuinely hard. Rewriting "We are pleased to present our findings" as "Here's what we found" requires understanding language. That's where AI earns its keep.

So we drew a line: **95% deterministic pipeline, 5% AI intelligence.**

**Kiran:** And my job is to define *what* the transformation looks like by creating one pair of reference decks. The system learns from my design decisions, then scales them to fifty.

---

## ACT 2: KIRAN CREATES THE EXEMPLAR DECKS [4:00–9:00]

**[Screen: PowerPoint open, blank new presentation]**

**Kiran:** Here's what I'm going to do. I'm taking one of the real client decks — a 6-slide cloud migration assessment — and I'm going to recreate it in the new brand. Same content, same structure, different visual treatment.

### Step 2a: The Source Exemplar

**[Screen: Opening a real client deck]**

**Kiran:** This is our source exemplar. It's already in the old brand — Georgia font, navy colour scheme, the old logo, formal language. I'm saving a clean copy as `source-exemplar.pptx`.

The key rule: this deck has to be representative. It needs to include:
- A title slide (logo, company name, heading treatment)
- A body slide with bullet points (paragraph formatting, text colours)
- A slide with a chart or table (data visualisation colours)
- A slide with imagery (so the system can flag images for review)
- A footer on every slide

If a formatting pattern doesn't appear in the exemplar, the system won't learn it.

### Step 2b: The Target Exemplar

**[Screen: Redesigning the same deck slide by slide]**

**Kiran:** Now I'm rebuilding the same deck in the new brand. Slide by slide, I'm changing:

1. **Fonts** — Georgia headings become Calibri. Cambria body text becomes Calibri Light.
2. **Colours** — Every instance of #003366 (navy) becomes #007C7A (teal). Gold accents become green.
3. **Logo** — Old logo swapped for new logo, same position and size.
4. **Footer** — "© 2024 Meridian Consulting Group" becomes "Apex Partners Ltd. Private & Confidential."
5. **Tone** — This is the important one. On some slides, I'm also rewriting the text. Not changing the facts — changing the voice.

**[Screen: Split view showing a before/after text change]**

**Kiran:**
> **Before:** "Our methodology is evidence-based, outcome-driven, and designed for sustainable change across the enterprise."
>
> **After:** "Evidence-based. Outcome-driven. Built to last."

Same message. Different voice. When the system sees that I changed the *words* and not just the formatting, it flags those as tone shifts. Sailesh's code will use those examples to teach Claude what the new brand sounds like.

**Sailesh:** This is the critical insight. The designer's one pair of decks becomes the complete specification — the font rules, the colour map, *and* the tone guide. No separate brief, no guesswork. The system learns directly from Kiran's design decisions.

### Step 2c: Saving and Verifying

**[Screen: File explorer showing both files]**

**Kiran:** Two files saved:
- `tools/rebrand/assets/source-exemplar.pptx`
- `tools/rebrand/assets/target-exemplar.pptx`

Both have identical slide structure. Six slides each. Same text on matching slides — except where I deliberately changed the wording for tone.

**Sailesh:** That identical structure is what makes the diff work. The script walks both files in parallel: slide 1 in source vs slide 1 in target, shape by shape, text run by text run. If the structure doesn't match, it can't compare.

---

## ACT 3: EXTRACTING THE RULES [9:00–13:00]

**[Screen: Terminal]**

**Sailesh:** Now we extract the rules. One command:

```bash
python3 tools/rebrand/extract_rules.py \
  --source tools/rebrand/assets/source-exemplar.pptx \
  --target tools/rebrand/assets/target-exemplar.pptx \
  --output tools/rebrand/brand-mapping.json
```

**[Screen: Script running, output appearing]**

**Sailesh:** The script is doing four things:

1. **Extracting text runs** — walking every slide, every shape, every paragraph, every text run. For each one, it records the font family, size, bold/italic, and colour.

2. **Building the font map** — it matches text strings between source and target. If the same text appears in both decks but with different formatting, that's a font rule. "Georgia 32pt bold → Calibri 36pt bold."

3. **Building the colour map** — same principle. If text has colour #003366 in the source and #007C7A in the target, that's a colour rule. It also scans shape fills, borders, and backgrounds.

4. **Capturing text changes** — if the text itself changed (not just the formatting), it records the before and after. These are tone signals.

**[Screen: brand-mapping.json open in editor]**

**Sailesh:** Here's what came out. Let's walk through it.

**Fonts section:**
```json
{
  "Georgia|32.0|bold": {
    "family": "Calibri",
    "size_pt": 36.0,
    "bold": true
  }
}
```

Every unique font combination in the source deck, mapped to its target equivalent.

**Colours section:**
```json
{
  "#003366": "#007C7A",
  "#CC9900": "#2ECC71"
}
```

Hex-to-hex. No ambiguity. No "sort of teal."

**Text changes section:**
```json
[
  {
    "slide": 2,
    "source_text": "Our methodology is evidence-based...",
    "target_text": "Evidence-based. Outcome-driven. Built to last."
  }
]
```

**Kiran:** Those are my rewrites. The system captured them exactly.

**Sailesh:** Now I use Claude to analyse those text changes and generate tone rules:

```
Tone rules derived:
- Formal prose → punchy fragments
- Passive voice → active voice
- Long compound sentences → short declarative sentences
- Corporate jargon ("across the enterprise") → plain English
- Third person ("the organisation") → direct address ("you/we")
```

I add these to the mapping file. The extraction is done. This was a one-time setup — we never run it again unless the brand changes.

---

## ACT 4: CONVERTING ALL 50 DECKS [13:00–18:00]

### Step 4a: Loading the Input

**[Screen: File explorer showing input/ folder with 50 .pptx files]**

**Sailesh:** All fifty source decks go in `tools/rebrand/input/`. The batch converter processes them all in one run.

### Step 4b: Running the Conversion

**[Screen: Terminal]**

```bash
python3 tools/rebrand/convert.py \
  --batch tools/rebrand/input/ \
  --mapping tools/rebrand/brand-mapping.json \
  --output tools/rebrand/output/
```

**[Screen: Output scrolling as each file converts]**

**Sailesh:** Watch the output. For each deck, you see:
- How many slides were processed
- How many font changes were made
- How many colour values were swapped
- Any images flagged for manual review

**[Screen: Batch report appearing]**

```
BATCH CONVERSION REPORT
========================================
  Files:    50/50 converted successfully
  Fonts:    4,230 text runs updated
  Colours:  2,105 colour values updated
  Logos:    287 logos replaced
  Warnings: 43 images flagged for review
========================================
```

**Sailesh:** Under two minutes for all fifty. Every font changed, every colour swapped, every logo replaced, every footer rewritten. Deterministic, reproducible, auditable.

**Kiran:** Those 43 flagged images — those are charts, diagrams, and screenshots that contain old brand colours baked into the image. The script can't change pixels inside a PNG. Those need manual attention.

**Sailesh:** Right. And that's an honest output. The system tells you what it *can't* do, so you know exactly what needs human review.

### Step 4c: Tone Adjustment

**[Screen: Terminal running /rebrand tone]**

**Sailesh:** Now the AI step. For each converted deck, Claude reads the slide text and applies the tone rules. The prompt is simple:

> "Given these tone rules and examples, rewrite this text to match the target brand voice. Preserve all facts, technical terms, and proper nouns. Only change the language style."

Claude sees Kiran's own before/after examples from the exemplar deck, so it's learning the brand voice from the person who defined it.

**[Screen: Split view showing a slide before and after tone adjustment]**

**Before:**
> The organisation currently operates 147 on-premises applications across three data centres. Our assessment identifies 82 applications suitable for cloud migration within the next 18 months.

**After:**
> 147 apps running on-prem across three data centres. We've identified 82 that are ready for cloud migration in the next 18 months. Start with non-critical workloads — build the pattern, build confidence, then scale.

**Kiran:** Same numbers. Same recommendation. My voice. That's exactly what I would have written.

---

## ACT 5: QUALITY REVIEW [18:00–22:00]

**[Screen: PowerPoint open, flicking through converted decks]**

**Kiran:** Now I do what designers actually should be doing — quality review, not mechanical conversion.

I'm checking:
1. **Font consistency** — are there any runs the system missed? Usually theme-inherited fonts that don't appear in the XML as explicit font names.
2. **Colour accuracy** — spot-checking that #007C7A is actually #007C7A, not #007C79. The pipeline is exact, but I want to verify.
3. **Logo placement** — same position, same size, no distortion.
4. **Tone quality** — reading the rewritten text to make sure Claude didn't change the meaning. This is the one place where human judgement matters.
5. **Flagged images** — the 43 images the system couldn't convert. I'll recreate these in the new brand colours.

**Sailesh:** Notice the inversion. Without the pipeline, Kiran spends 150 hours on mechanical conversion and squeezes in quality review at the end when she's exhausted. With the pipeline, she spends maybe 4 hours on quality review and the creative work of redoing 43 images. The mechanical work took 2 minutes.

**Kiran:** And honestly, the flagged images are the interesting part. Those are the slides where I get to actually design, not just search-and-replace.

---

## ACT 6: THE ARCHITECTURE DECISION [22:00–26:00]

**[Screen: The decision framework table]**

**Sailesh:** Let's zoom out. Why didn't we train a model?

We build fine-tuned small language models for other projects — recruitment AI, skills assessment. We have the pipeline. But this problem didn't need it. And since people often misunderstand how that pipeline works, let me clear something up.

When we *do* train a model, people assume we fine-tune a massive model — 70 billion parameters — and then shrink it down to fit on a phone. We don't. We train two small models directly — a 2-billion-parameter model sized for iPhones, and a 4-billion for laptops. Both trained on a Mac, same training data, same pipeline, learning from examples that a larger model generated. The large model creates the curriculum — 1,800 training examples. Then it leaves. It's never involved again.

But before any training starts, we build the exam paper. Two hundred examples, validated by domain experts — real job descriptions mapped to real competencies by hand. These 200 examples are *never* used in training. They're the held-out gold set. Every five minutes during training, the model sits the same 200-question exam. That's how we know it's improving — apples to apples, every checkpoint.

The training loop itself: the model receives a job description and generates eight different attempts at the same skills assessment. Each one gets scored — is the JSON valid? Are the skills real? Is the level reasonable? Did it hallucinate a skill that doesn't exist? The eight outputs get ranked against each other — best become the positive signal, worst become the negative signal. The model adjusts. Five minutes later, checkpoint, score against the gold set, save the results to a CSV. Repeat.

You wake up in the morning and there's a training curve: 0.41 at 6pm. 0.69 by 8pm. 0.82 by midnight. 0.85 by 4am where it plateaus. Every checkpoint is a complete, usable model. You can open the CSV, show a compliance officer the exact score at each point, explain which model you shipped and why. That's auditable AI — not "trust us, the model is good."

The result is two model files — 1.2 gigabytes for iPhone, 2.5 for laptop. They run entirely offline. No API calls, no data leaving the device. The app picks the right one based on what hardware it's running on.

**Kiran:** So why didn't we do that here?

**Sailesh:** Because the PowerPoint rebrand doesn't need a specialist model. It needs a lookup table and a good writer.

| Signal | Model | Pipeline |
|---|---|---|
| Input variation | High — many phrasings | Low — structured, enumerable |
| Rules expressible? | No — too many edge cases | Yes — fits in a JSON file |
| Output must be exact? | Approximate is fine | Must be pixel-perfect |
| Error consequences | Graceful degradation | Hard failure |
| Debugging | "Why did it say this?" | "This key maps to this value" |

The PowerPoint rebrand sits firmly on the pipeline side for 95% of the work. The tone adjustment is the 5% where Claude earns its keep — and it doesn't need training. It needs context. Kiran's examples *are* the context.

**Kiran:** From a designer's perspective, what I love about this is that my work *is* the specification. I didn't write a brief that someone interpreted. I designed two decks and the system learned exactly what I intended. If the output doesn't match, we debug a JSON file, not a neural network.

---

## CLOSE [26:00–28:00]

**Sailesh:** So here's the scorecard:

| Metric | Manual | Pipeline |
|---|---|---|
| Time to convert 50 decks | ~150 hours | ~2 minutes + 4 hours QA |
| Consistency | Variable (human fatigue) | Exact (deterministic) |
| Auditability | "I think I changed that" | JSON mapping + conversion report |
| Designer time | Mechanical grunt work | Creative review + flagged images |
| AI used? | No | Yes — but only for tone (5%) |

**Kiran:** The decks are done. I'm back to doing design work. And we didn't train a model.

**Sailesh:** If you're staring at a problem and wondering whether it's an AI problem — start by listing what changes. If you can enumerate every transformation in a spreadsheet, you don't need a model. You need a script. Find the seam between the mechanical and the intelligent, and only invite AI to the part that actually requires understanding.

**[Screen: DTA logo, website URL]**

---

## TECHNICAL DEMONSTRATION STEPS

This is the exact sequence to reproduce on screen during recording.

### Pre-recording Setup

1. **Install dependencies:**
   ```bash
   pip3 install python-pptx Pillow
   ```

2. **Prepare workspace:**
   ```bash
   cd ~/Code/digital-transformation-advisory
   mkdir -p tools/rebrand/input tools/rebrand/output tools/rebrand/assets
   ```

3. **Have ready:**
   - One real client deck (6+ slides, representative of all formatting patterns)
   - New brand logo file (PNG, transparent background)
   - New brand guidelines (fonts, colours, tone) for Kiran's reference
   - The 50 source decks in `tools/rebrand/input/`

### Live Demo Sequence

| Step | Who | Action | Screen |
|---|---|---|---|
| 1 | Kiran | Open a real client deck in PowerPoint | PowerPoint |
| 2 | Kiran | Save clean copy as `source-exemplar.pptx` | File > Save As |
| 3 | Kiran | Recreate same deck in new brand → `target-exemplar.pptx` | PowerPoint (timelapse) |
| 4 | Kiran | Show side-by-side comparison of key slides | Split screen |
| 5 | Sailesh | Run `extract_rules.py` in terminal | Terminal |
| 6 | Sailesh | Open `brand-mapping.json`, walk through each section | VS Code |
| 7 | Sailesh | Generate tone rules from text_changes using Claude | Terminal / Claude |
| 8 | Sailesh | Update `brand-mapping.json` with tone rules | VS Code |
| 9 | Kiran | Verify font/colour mappings against brand guidelines | brand-mapping.json |
| 10 | Sailesh | Copy 50 source decks into `input/` | File explorer |
| 11 | Sailesh | Run `convert.py --batch` | Terminal |
| 12 | Sailesh | Show batch conversion report | Terminal |
| 13 | Sailesh | Run `/rebrand tone` for AI text adjustment | Claude Code |
| 14 | Sailesh | Open a converted deck, show before/after | PowerPoint split |
| 15 | Kiran | QA review: fonts, colours, logos, tone, flagged images | PowerPoint |
| 16 | Kiran | Fix a flagged image live (recreate chart in new colours) | PowerPoint |
| 17 | Both | Recap: decision framework, scorecard, closing thoughts | Slide/table |

### Recording Tips

- **Kiran's exemplar creation (Step 3):** Record in real-time, but edit down to a 2-3 minute timelapse in post. Show the key decisions: font selection, colour picker, logo swap, text rewrite.
- **Batch conversion (Step 11):** Let it run in real-time — the speed is the point. Under 2 minutes for 50 decks is dramatic.
- **Tone adjustment (Step 13):** Show 2-3 slides being rewritten live so viewers see Claude's output.
- **QA review (Step 15):** Show Kiran naturally reviewing, not scripted. Authentic reactions to the output quality are more compelling.

---

## EXTERNAL REFERENCES

### Tools and Libraries
- **python-pptx** — Python library for creating/modifying PowerPoint files
  https://python-pptx.readthedocs.io/
- **Pillow (PIL)** — Python imaging library (used for logo processing)
  https://pillow.readthedocs.io/
- **Claude API** — Anthropic's AI for the tone adjustment step
  https://docs.anthropic.com/

### Background Reading
- **python-pptx Working with Text** — Understanding text runs, paragraphs, and font properties
  https://python-pptx.readthedocs.io/en/latest/user/text.html
- **python-pptx Working with Presentations** — Slide layouts, masters, and shape types
  https://python-pptx.readthedocs.io/en/latest/user/presentations.html
- **RGBColor in python-pptx** — How colours are represented (`__str__()` returns '003366', not .red/.green/.blue)
  https://python-pptx.readthedocs.io/en/latest/api/dml.html#pptx.dml.color.RGBColor

### Design and Brand Conversion
- **Brand consistency at scale** — Why mechanical brand conversion fails without automation
  https://martech.org/brand-consistency/
- **Rebrand rollout playbook** — Common enterprise rebrand challenges (templates, collateral, tone alignment)
  https://www.columnfivemedia.com/how-to-do-a-rebrand/

### AI Decision Framework
- **When not to use ML** — Google's Rules of Machine Learning (Rule #1: "Don't be afraid to launch a product without machine learning")
  https://developers.google.com/machine-learning/guides/rules-of-ml
- **The AI Hierarchy of Needs** — Monica Rogati's framework: get the data pipeline right before reaching for AI
  https://hackernoon.com/the-ai-hierarchy-of-needs-18f111fcc007

### Related DTA Blog Posts
- **"Fifty PowerPoints and a Rebrand: Why We Didn't Train a Model"**
  https://dta-advisory.netlify.app/2026/03/20/fifty-powerpoints-and-a-rebrand-why-we-didnt-train-a-model/
- **"When Your Data Can't Leave the Building: Training Small Language Models for Enterprise"**
  https://dta-advisory.netlify.app/2026/03/20/when-your-data-cant-leave-the-building/

### Code Repository
- **Rebrand tool source** — `tools/rebrand/` in the digital-transformation-advisory repo
  - `extract_rules.py` — Rule extraction from exemplar pair
  - `convert.py` — Deterministic batch conversion engine
  - `tests/test_convert.py` — Automated test suite

# Digital Transformation Advisory (DTA)

DTA Ltd consultancy project — Jekyll blog + client tooling.

**Blog**: Jekyll site on GitHub Pages ([saileshpanchal.github.io/digital-transformation-advisory](https://saileshpanchal.github.io/digital-transformation-advisory))
**Tools**: Client delivery tools in `tools/` (not published to blog)

## Blog

```bash
bundle install
bundle exec jekyll serve
# Visit http://localhost:4000/digital-transformation-advisory/
```

Posts in `_posts/YYYY-MM-DD-title.md` with YAML frontmatter.

## Tools

### /rebrand — PowerPoint Brand Conversion

Converts PowerPoint decks from one brand identity to another. Built for a client with 50 decks that need converting to a new brand and tone.

**How it works**:
1. Designer creates two exemplar decks: old brand and new brand (same content, different visual treatment)
2. `/rebrand extract` analyses both decks, extracts font/colour/layout/tone rules to `brand-mapping.json`
3. `/rebrand convert-all` applies deterministic transformations (fonts, colours, logos, footers) via python-pptx
4. Claude handles intelligent tone adjustment — rewriting text to match new brand voice while preserving meaning

**What's deterministic (python-pptx)**: Font mapping, colour mapping, logo replacement, footer text, layout structure
**What's AI (Claude)**: Tone adjustment — rephrasing corporate jargon, adjusting formality, shifting brand voice

**This is NOT a fine-tuned model problem.** The visual rules are finite and extracted from two exemplar decks. Claude handles tone in-context — no training needed. The skill is code + rules, not ML.

```
tools/rebrand/
├── extract_rules.py      # Compare exemplar pair → brand-mapping.json
├── convert.py            # Apply mapping to .pptx files (deterministic)
├── brand-mapping.json    # Generated rules (fonts, colours, tone)
├── assets/               # Designer exemplar decks + new logo
│   ├── source-exemplar.pptx
│   ├── target-exemplar.pptx
│   └── new-logo.png
├── input/                # Drop 50 source decks here
└── output/               # Converted decks appear here
```

**Prerequisites**: `pip3 install python-pptx Pillow`

**Workflow**:
```bash
# 1. Extract rules (after designer provides exemplar decks)
/rebrand extract

# 2. Convert all decks
/rebrand convert-all

# 3. Or convert a single deck
/rebrand convert input/old-deck.pptx
```

## Related Projects

- **SFiA-AI** (`~/Code/SFiA-AI/`) — SFIA recruitment platform (separate product)
- **ForgeML** (`~/Code/ForgeML/`) — SLM training pipeline (separate product)
- **SkillFrame** (`~/Code/SkillFrame/`) — Native iOS/Mac skills app (separate product)
- **RPGFuture** (`~/Code/RGPFuture/`) — iOS RPG game (separate product)

## gstack

Use the `/browse` skill from gstack for all web browsing. Never use `mcp__claude-in-chrome__*` tools.

### Available gstack skills

- `/office-hours`, `/plan-ceo-review`, `/plan-eng-review`, `/plan-design-review`
- `/design-consultation`, `/review`, `/ship`, `/browse`
- `/qa`, `/qa-only`, `/design-review`, `/setup-browser-cookies`
- `/retro`, `/investigate`, `/document-release`, `/codex`
- `/careful`, `/freeze`, `/guard`, `/unfreeze`, `/gstack-upgrade`

# /rebrand

PowerPoint brand conversion skill. Converts presentations from one brand identity to another using a designer-created mapping.

## Three Modes

### 1. Extract Rules (one-time setup)
```
/rebrand extract
```
Compares source and target exemplar decks to generate `brand-mapping.json`.
Requires both exemplar decks in `tools/rebrand/assets/`.

### 2. Convert (single or batch)
```
/rebrand convert input/old-deck.pptx
/rebrand convert-all
```
Applies deterministic brand transformation (fonts, colours, logos, footers) then uses Claude for intelligent tone adjustment of text content.

### 3. Tone Adjustment (Claude-powered)
```
/rebrand tone input/old-deck.pptx
```
Reads all text from the deck, applies tone rules from `brand-mapping.json`, and rewrites text while preserving meaning. This is the AI step — everything else is deterministic.

---

## Instructions

When the user invokes `/rebrand`, follow these steps:

### For `/rebrand extract`:

1. Check that both exemplar files exist:
   - `tools/rebrand/assets/source-exemplar.pptx` (old brand)
   - `tools/rebrand/assets/target-exemplar.pptx` (new brand)
2. Run: `python3 tools/rebrand/extract_rules.py --source tools/rebrand/assets/source-exemplar.pptx --target tools/rebrand/assets/target-exemplar.pptx --output tools/rebrand/brand-mapping.json`
3. Read the generated `brand-mapping.json`
4. Review the `text_changes` array — these are places where the designer changed the actual text (not just formatting)
5. Generate `tone_rules` from the text_changes patterns. Look for:
   - Corporate jargon → plain English conversions
   - Passive → active voice changes
   - Formality level shifts
   - Brand-specific terminology changes
6. Update `brand-mapping.json` with the generated tone_rules
7. Ask the user to:
   - Verify font/colour mappings look correct
   - Set `logo_replacement.target_image_path` if swapping logos
   - Set `footer.find` / `footer.replace` for footer text
   - Confirm tone_rules or add custom rules

### For `/rebrand convert <file>` or `/rebrand convert-all`:

1. Check `tools/rebrand/brand-mapping.json` exists (run extract first if not)
2. For single file:
   ```
   python3 tools/rebrand/convert.py --input <file> --mapping tools/rebrand/brand-mapping.json --output tools/rebrand/output/<filename>
   ```
3. For batch (`convert-all`):
   ```
   python3 tools/rebrand/convert.py --batch tools/rebrand/input/ --mapping tools/rebrand/brand-mapping.json --output tools/rebrand/output/
   ```
4. Review the conversion report for warnings and flagged images
5. Then automatically run tone adjustment on each converted file (see below)

### For `/rebrand tone <file>` (or automatic after convert):

1. Read `brand-mapping.json` to get `tone_rules`
2. Use the `pptx` skill (or python-pptx via Bash) to read all text from the converted deck
3. For each text block, apply tone rules using Claude's intelligence:
   - Don't just find-replace — understand context
   - Preserve technical terms and proper nouns
   - Maintain the meaning while shifting the voice
   - Respect bullet point structure and slide hierarchy
   - Short text (titles, headers) needs different treatment than body text
4. Write the tone-adjusted text back to the PPTX
5. Report what was changed

### Tone Adjustment Prompt Pattern

When rewriting text for tone, use this approach for each text block:

```
Given these tone rules: {tone_rules}

Rewrite this slide text to match the target brand voice.
Preserve all factual content, technical terms, and proper nouns.
Only change language style, not meaning.

Source text:
{original_text}

Rewritten:
```

## File Structure

```
tools/rebrand/
├── extract_rules.py      # Rule extraction from exemplar pair
├── convert.py            # Deterministic brand conversion engine
├── brand-mapping.json    # Generated mapping (fonts, colours, tone rules)
├── assets/
│   ├── source-exemplar.pptx  # Designer's old brand reference
│   ├── target-exemplar.pptx  # Designer's new brand reference
│   └── new-logo.png          # Target brand logo (optional)
├── input/                # Drop source .pptx files here
├── output/               # Converted files appear here
└── tests/
    └── test_convert.py   # Conversion tests
```

## Prerequisites

- `python-pptx` installed: `pip3 install python-pptx Pillow`
- Designer has created source and target exemplar decks
- Both exemplar decks must have identical text content on matching slides
  (so the tool can diff the visual treatment)

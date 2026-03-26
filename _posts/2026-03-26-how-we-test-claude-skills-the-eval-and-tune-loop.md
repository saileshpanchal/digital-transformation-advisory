---
title: "How We Test Claude Skills: The Eval-and-Tune Loop"
date: 2026-03-26
categories: [Engineering, AI]
tags: [claude, skills, testing, evaluation, cli, developer-tools, open-source, gstack, quality-assurance]
excerpt: "Writing a Claude Code skill is easy. Knowing whether it actually works is harder. We built an eval-and-tune loop that benchmarks skills against a no-skill baseline, and the first thing we learned is that your initial assertions will be wrong."
---

Writing a Claude Code skill is easy. You write some markdown, drop it in `~/.claude/skills/`, and it activates automatically. The hard part is knowing whether it actually makes a difference.

We learned this building the [agent-friendly-cli skill](https://github.com/saileshpanchal/agent-friendly-cli) — a guide for building CLIs that AI agents can use effectively. The skill covers 16 principles: structured output, stderr separation, exit codes, TTY detection, and so on. But principles on paper mean nothing without evidence that they change outcomes.

So we built a testing loop. Here's what we learned.

## The Process

### 1. Draft the Skill, Then Write Test Prompts

Start with the skill content, then immediately write 2-3 realistic test prompts. Not "test the skill" prompts — real tasks someone would actually bring to Claude:

- "Build a deploy CLI in Python with Click"
- "Review this CLI code and tell me what's not agent-friendly"
- "Write a config import command that accepts file or stdin input"

These cover different modes: code generation, code review, and feature implementation. Each exercises the skill differently.

### 2. Run With-Skill and Without-Skill in Parallel

This is the key insight. Don't just test the skill — test the delta. Spawn six subagents: three with the skill loaded, three without. Same prompts, same model, different guidance.

The without-skill runs are your baseline. They show what Claude does naturally, without the skill's patterns. The comparison reveals what the skill actually teaches.

### 3. Draft Assertions While Runs Execute

Don't wait for results. While the agents run, write the grading criteria. For the CLI skill, our first assertions were:

- Does the code include `--output json`?
- Is there a `--dry-run` flag?
- Does it use flags instead of positional arguments?
- Are there distinct exit codes?

These felt reasonable. They were also mostly wrong — not wrong in what they checked, but wrong in what they revealed.

### 4. The First Round Won't Discriminate

Here's what happened when we graded:

| Eval | With Skill | Without Skill |
|------|-----------|--------------|
| Deploy CLI | 100% | 33% |
| Code Review | **100%** | **100%** |
| Config Import | 80% | 40% |

The deploy CLI and config import showed clear deltas. But the code review scored 100% for both versions. The skill found 11 issues; the baseline found 6. The skill categorized by severity; the baseline didn't. The skill caught stderr/stdout separation; the baseline missed it. Yet the assertions said they were equal.

The problem: our assertions tested for the obvious. "Does it mention interactive prompts?" Yes — both versions catch that. "Does it note missing JSON output?" Yes — both versions catch that too. The assertions were too easy.

### 5. Find What Discriminates

This is where the real work happens. Read both outputs side by side and ask: what does the with-skill version do that the baseline doesn't? For us, it was:

- **Severity categorization** — the skill version tiered issues as blocking/moderate/low
- **Stderr/stdout separation** — the baseline never mentioned it
- **Emoji fragility** — the skill flagged `print('Done!')` with emoji as parsing-fragile
- **Issue depth** — the skill found 8+ issues vs the baseline's 6

We added these as assertions and re-graded:

| Eval | With Skill | Without Skill | Delta |
|------|-----------|--------------|-------|
| Code Review | **100%** | **83%** | **+17%** |

Now the eval discriminated. The two failing assertions for the baseline — stderr/stdout separation and emoji fragility — were exactly the patterns the skill teaches that Claude doesn't know on its own.

### 6. Iterate Until Stable

The loop is: draft assertions, grade, find non-discriminating assertions, replace them with harder ones, re-grade. Stop when the assertions capture the real delta.

For code generation evals (the deploy CLI), the first round already discriminated well (+67%). Code generation is where skills have the most leverage — the model produces fundamentally different code with the right guidance.

For code review evals, it took two rounds. The model is already decent at spotting problems; the skill's value is in the subtler, deeper patterns.

## The Audit That Proved It

The same day we shipped the skill, we ran it against our own project — a transcription-to-blog pipeline with a CLI called `ttb`. The audit against the agent-friendly checklist was immediate and damning:

1. No `--output json` on any command — agents can't parse the Rich tables
2. No graph query commands — can't explore the knowledge graph programmatically
3. `audit-transcript` outputs Rich markup, not structured data
4. `enrich` outputs JSON (the only one that does)
5. No `--quiet` mode
6. Stats use Rich tables — not parseable
7. No graph-level query tools for listing concepts, finding themes, or exploring connections

The biggest win wasn't fixing existing commands — it was realising we needed `ttb query` subcommands that let agents explore the knowledge graph with `--output json`. The skill didn't just review our CLI; it revealed a missing capability.

That's the difference between a checklist you read once and a skill that's loaded into context every time you touch CLI code.

## What We'd Do Differently

**Start with discriminating assertions.** Don't test for the obvious. If baseline Claude already catches interactive prompts and missing JSON output, those assertions won't tell you if your skill adds value. Test for the patterns that require specific domain knowledge.

**Run more than 3 test cases.** Three is enough to validate the approach, but the signal gets noisy with small samples. For a production skill, we'd run 8-10 before shipping.

**Grade programmatically from the start.** We wrote a grading script that checks outputs against regex patterns. It's stringly-typed and a bit hacky, but it runs in seconds and produces consistent results. Manual review is important for qualitative assessment, but programmatic grading catches regressions.

## Get the Skill

The agent-friendly-cli skill is open source:

**[github.com/saileshpanchal/agent-friendly-cli](https://github.com/saileshpanchal/agent-friendly-cli)**

The eval workspace with all test cases, grading scripts, and benchmark data is in the repo. Fork it, run the evals against your own CLIs, and see what falls out.

The process itself — draft, test with/without, find discriminating assertions, iterate — works for any Claude Code skill. The specific assertions will be different, but the loop is the same.

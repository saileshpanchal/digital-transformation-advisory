---
title: "Building CLIs for Agents: What the Original Article Missed"
date: 2026-03-26
categories: [Engineering, AI]
tags: [cli, agents, developer-tools, claude, open-source, python, click, design-patterns, automation, gstack]
excerpt: "An article on agent-friendly CLIs went around recently. It covered the basics well but missed the patterns that matter most. We built a Claude Code skill that fills the gaps — structured output, stderr separation, exit codes, TTY detection — and benchmarked it at +40-67% improvement."
---

An article on building CLIs for agents went around recently. It made good points: make things non-interactive, add `--dry-run`, return data on success. Solid basics.

But it missed the patterns that actually make the difference between a CLI that agents can technically use and one they can use well. We took the original article, added the missing pieces, turned it into a [Claude Code skill](https://github.com/saileshpanchal/agent-friendly-cli), and benchmarked the results.

## What Was Missing

The original covered six patterns. We added twelve more. Here are the ones that matter most.

### Structured Output Is the Foundation

The original article mentioned returning data on success. That's a subset of the real principle: every command should support `--output json`. Not just success messages. Every list, every status check, every describe command. And the default should be human-readable tables, not JSON — you're serving two audiences.

```bash
# human-friendly default
$ mycli service list
NAME        STATUS    REPLICAS
web         running   3
api         running   2

# agent-friendly
$ mycli service list --output json
[
  {"name": "web", "status": "running", "replicas": 3},
  {"name": "api", "status": "running", "replicas": 2}
]
```

This one pattern eliminates the largest class of agent failures: parsing human-formatted text.

### Stderr vs Stdout Separation

This wasn't mentioned at all, and it's critical. Data goes to stdout. Diagnostics, progress, and logs go to stderr. Without this, agents can't pipe commands together — progress messages corrupt the data stream.

```python
def _emit(data: dict, output: str) -> None:
    """Data to stdout."""
    if output == "json":
        click.echo(json.dumps(data, indent=2))

def _log(msg: str) -> None:
    """Diagnostics to stderr."""
    click.echo(msg, err=True)
```

When `--output json` is set, be strict: no log lines should leak into stdout.

### Exit Codes That Mean Something

The original said "fail fast with actionable errors." That's necessary but not sufficient. Agents need distinct exit codes so they can branch without parsing stderr:

| Code | Meaning | Agent Action |
|------|---------|-------------|
| 0 | Success | Continue |
| 1 | General error | Read stderr, retry or escalate |
| 2 | Usage error | Fix invocation and retry |
| 3 | Auth error | Re-authenticate, then retry |
| 4 | Not found | Resource doesn't exist |
| 5 | Conflict | Already exists / state conflict |

An agent that gets exit code 3 knows to refresh its token. An agent that gets exit code 2 knows to check its flags. An agent that gets exit code 1 has to read and parse the error message. The more specific your codes, the faster the recovery.

### TTY Detection for Graceful Degradation

The original said "make it non-interactive." Better advice: detect whether you're talking to a human or a pipe, and behave accordingly.

```python
if not args.env:
    if sys.stdin.isatty():
        args.env = prompt_user("Which environment?",
                               choices=["staging", "production"])
    else:
        die("Error: --env is required\n"
            "  mycli deploy --env <staging|production>")
```

This gives humans the interactive experience they expect while failing fast for agents with an actionable error message.

### Auth Without Browsers

The original didn't mention authentication at all. Agents can't open browsers for OAuth or type passwords at prompts. Your CLI needs to support at least three auth methods:

```bash
# 1. Flag (highest priority)
$ mycli --token sk-abc123 service list

# 2. Environment variable
$ MYCLI_TOKEN=sk-abc123 mycli service list

# 3. Config file (written once by a human)
$ mycli auth configure --token sk-abc123
$ mycli service list  # reads from ~/.mycli/config
```

### Pagination

Also missing from the original. Dumping 10,000 results into an agent's context window is expensive and usually unnecessary. Support `--limit`, `--offset`, and ideally cursor-based pagination:

```bash
$ mycli logs list --limit 20 --output json
{
  "items": [...],
  "pagination": {
    "total": 1847,
    "limit": 20,
    "next_cursor": "eyJpZCI6MTIwfQ=="
  }
}
```

## The Full Checklist

We organized all 16 principles into three tiers. Here's the quick reference:

**Must-Have** — agents can't function without these:
- All inputs accepted as flags
- `--output json` on every data-returning command
- Stdout for data, stderr for diagnostics
- `--help` with examples on every subcommand
- Fail fast with actionable errors
- Distinct exit codes
- Auth via env vars / config files / `--token`

**Should-Have** — agents work much better:
- `--dry-run` for destructive actions
- `--yes` / `--force` to skip confirmations
- Idempotent commands
- Consistent `resource verb` structure
- Structured success responses
- `--quiet` mode
- Pagination

**Nice-to-Have** — makes agents more efficient:
- `--stdin` for pipe-friendly input
- Machine-readable progress on stderr
- Programmatic command/flag discovery
- Versioned output schemas
- Verbosity levels
- TTY detection

## We Benchmarked It

We didn't just write the list — we turned it into a Claude Code skill and tested whether it actually changes outcomes. We ran three eval scenarios (building a deploy CLI, reviewing existing code, writing a config import command) with and without the skill, then graded the outputs against specific assertions.

| Eval | With Skill | Without | Delta |
|------|-----------|---------|-------|
| Deploy CLI structure | 6/6 (100%) | 2/6 (33%) | **+67%** |
| CLI code review | 12/12 (100%) | 10/12 (83%) | **+17%** |
| Config import command | 4/5 (80%) | 2/5 (40%) | **+40%** |

The biggest delta was in code generation. Without the skill, the model produced CLIs with positional arguments, `print("Done.")` success messages, and no exit codes. With the skill, every command got `--output json`, stderr/stdout separation, TTY-aware confirmations, and structured dry-run previews.

The code review eval was closer because the model already catches obvious issues like interactive prompts. But the skill caught the subtler patterns: emoji in output being fragile for parsing, missing stderr/stdout separation, and the absence of severity tiers in the review itself.

## Get the Skill

The skill is open source and available on GitHub:

**[github.com/saileshpanchal/agent-friendly-cli](https://github.com/saileshpanchal/agent-friendly-cli)**

Install it:

```bash
mkdir -p ~/.claude/skills/agent-friendly-cli
curl -o ~/.claude/skills/agent-friendly-cli/SKILL.md \
  https://raw.githubusercontent.com/saileshpanchal/agent-friendly-cli/main/SKILL.md
```

It triggers automatically when you're writing CLI code with Click, argparse, Cobra, Clap, or any CLI framework. No slash command needed — just start writing CLI code and it activates.

The patterns themselves are language-agnostic. Whether you're building CLIs in Python, Go, Rust, or Node, the same principles apply. The skill just makes sure they're applied consistently.

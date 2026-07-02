#!/usr/bin/env bash
#
# Voice lint — catches AI-tells in marketing copy before merge.
# Usage: scripts/voice-lint.sh <file> [file...]
# Hard-fails (exit 1) on em-dashes and internal codenames. Reports banned words,
# self-promoting superlatives and likely eyebrow labels for manual review.
# Pair with the boundary check as a pre-merge gate.
#
set -uo pipefail

fail=0
banned='delve|crucial|robust|comprehensive|leverage|seamless|unlock|landscape|showcase|realm|tapestry|testament|furthermore|moreover'
# Internal codenames that must never reach public copy.
codenames='Heimdall|Nettle|Urd|Mimir|Muninn|Yggdrasil|Bifrost|Hermod'
# Self-promoting superlatives — the positioning is shown in artifacts, not asserted.
superlatives='top 1%|world.class|best.in.class|best.in.breed|leading'

for f in "$@"; do
  [ -f "$f" ] || { echo "skip (missing): $f"; continue; }

  # 1. Em-dashes — hard fail.
  if grep -n '—' "$f" >/dev/null 2>&1; then
    echo "EM-DASH in $f:"
    grep -n '—' "$f" | sed 's/^/    /'
    fail=1
  fi

  # 2. Banned words — report (review each; some may be in code/class names).
  if grep -niE "\b($banned)\b" "$f" >/dev/null 2>&1; then
    echo "banned-word in $f (review):"
    grep -niE "\b($banned)\b" "$f" | sed 's/^/    /'
  fi

  # 2a. Internal codenames — hard fail (never public).
  if grep -niE "\b($codenames)\b" "$f" >/dev/null 2>&1; then
    echo "CODENAME in $f:"
    grep -niE "\b($codenames)\b" "$f" | sed 's/^/    /'
    fail=1
  fi

  # 2b. Self-promoting superlatives — report (the positioning is shown, not asserted).
  if grep -niE "($superlatives)" "$f" >/dev/null 2>&1; then
    echo "superlative in $f (review: show it in the artifacts instead):"
    grep -niE "($superlatives)" "$f" | sed 's/^/    /'
  fi

  # 3. Eyebrow labels (Jekyll) — report count.
  ec=$(grep -cE 'class="eyebrow"|class="section-label"|class="[^"]*kicker' "$f" 2>/dev/null || echo 0)
  [ "$ec" != "0" ] && echo "eyebrow/section-label x$ec in $f (review)"

  # 4. Sentence/phrase-initial "The" — report density (an AI tell when it clusters).
  tc=$(grep -oE '(^|[.>"]|&gt;)[[:space:]]*The ' "$f" 2>/dev/null | wc -l | tr -d ' ')
  [ "$tc" -gt 8 ] 2>/dev/null && echo "'The'-opener density x$tc in $f (review: vary openers, esp. consecutive)"
done

if [ "$fail" -ne 0 ]; then
  echo ""
  echo "VOICE LINT FAILED — remove every em-dash and codename above."
  exit 1
fi
echo "voice-lint: no em-dashes, no codenames."

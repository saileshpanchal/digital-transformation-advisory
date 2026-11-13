#!/usr/bin/env bash
#
# Observatory launch check.
#
# Verifies that the public Observatory surfaces exist and carry the canonical
# North Star 4 language required for the launch.
set -euo pipefail

fail=0

require_file() {
  local file="$1"
  if [ ! -f "$file" ]; then
    echo "missing: $file"
    fail=1
  fi
}

require_text() {
  local file="$1"
  local text="$2"
  if [ ! -f "$file" ]; then
    echo "cannot scan missing file: $file"
    fail=1
    return
  fi
  if ! grep -Fq "$text" "$file"; then
    echo "missing text in $file: $text"
    fail=1
  fi
}

require_file observatory.html
require_file observatory-future-payments.html
require_file field-notes.html
require_file briefings.html
require_file docs/observatory-model-template.md

require_text observatory.html "Living models of how financial systems evolve"
require_text observatory.html "Five Observatory diagrams"
require_text observatory.html "Systems Evolution"
require_text observatory.html "Strategic Interaction"
require_text observatory.html "Future Narrative Journey"
require_text observatory.html "Executable Journey"
require_text observatory.html "Decision Gate"

require_text observatory-future-payments.html "When payments become programmable and agents can move money on behalf of customers, who is accountable"
require_text observatory-future-payments.html "Observatory Status"
require_text observatory-future-payments.html "Consultation deadline"
require_text observatory-future-payments.html "System Evolution"
require_text observatory-future-payments.html "Strategic Interaction"
require_text observatory-future-payments.html "The institutional decision"
require_text observatory-future-payments.html "Decision Gate"

require_text field-notes.html "Field Notes"
require_text briefings.html "Briefings"
require_text docs/observatory-model-template.md "Required evidence fields"
require_text docs/observatory-model-template.md "Claim guardrail checklist"

# 13 Nov 2026: the new navigation puts the Observatory, Field Notes and Briefings
# under Insights, and /insights/ becomes their hub. So the layout links /insights/, the hub links /observatory/, and
# "Insights" is no longer a stale label. Before this change the check already failed at 70360c8 on the missing
# docs/observatory-model-template.md, which this change leaves as it was.
require_text _layouts/corporate.html "/insights/"
require_text insights.html "/observatory/"
require_text insights.html "Observatory"

if [ "$fail" -ne 0 ]; then
  echo "observatory check failed"
  exit 1
fi

echo "observatory check passed"

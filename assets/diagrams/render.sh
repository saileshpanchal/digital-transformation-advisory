#!/bin/bash
# Render all diagram source files to SVG.
# D2 (.d2) and PlantUML (.puml) sources live in src/
# Rendered SVGs go to rendered/
#
# Usage: ./render.sh          (render all)
#        ./render.sh foo.d2   (render one file)
#
# Prerequisites: brew install d2 plantuml graphviz openjdk

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="$SCRIPT_DIR/src"
OUT_DIR="$SCRIPT_DIR/rendered"

mkdir -p "$OUT_DIR"

render_d2() {
  local src="$1"
  local name
  name="$(basename "$src" .d2)"
  echo "  D2: $name.d2 → $name.svg"
  d2 --theme 0 --pad 20 "$src" "$OUT_DIR/$name.svg" 2>&1
}

render_puml() {
  local src="$1"
  local name
  name="$(basename "$src" .puml)"
  echo "  PlantUML: $name.puml → $name.svg"
  plantuml -tsvg -o "$OUT_DIR" "$src" 2>&1
}

if [ $# -gt 0 ]; then
  # Render specific file
  file="$SRC_DIR/$1"
  if [[ "$1" == *.d2 ]]; then
    render_d2 "$file"
  elif [[ "$1" == *.puml ]]; then
    render_puml "$file"
  else
    echo "Unknown file type: $1 (expected .d2 or .puml)"
    exit 1
  fi
else
  # Render all
  echo "Rendering diagrams..."
  echo ""

  d2_count=0
  puml_count=0

  for f in "$SRC_DIR"/*.d2; do
    [ -f "$f" ] || continue
    render_d2 "$f"
    ((d2_count++))
  done

  for f in "$SRC_DIR"/*.puml; do
    [ -f "$f" ] || continue
    render_puml "$f"
    ((puml_count++))
  done

  echo ""
  echo "Done: $d2_count D2 + $puml_count PlantUML → $OUT_DIR/"
fi

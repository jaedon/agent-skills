#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <input.md> [output.pdf]" >&2
  exit 1
fi

INPUT_MD="$1"
if [ ! -f "$INPUT_MD" ]; then
  echo "Error: Input file not found: $INPUT_MD" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
CSS_FILE="$SKILL_DIR/templates/document.css"
KOREAN_WORD_FILTER="$SCRIPT_DIR/korean_word_filter.lua"

BASE_NAME="$(basename "$INPUT_MD" .md)"
OUTPUT_PDF="${2:-${BASE_NAME}.pdf}"
TMP_HTML="$(mktemp "${TMPDIR:-/tmp}/korean-markdown-to-pdf-XXXXXX")"

cleanup() {
  rm -f "$TMP_HTML"
}
trap cleanup EXIT

if command -v pandoc >/dev/null 2>&1 && command -v weasyprint >/dev/null 2>&1; then
  echo "Build path: Pandoc and WeasyPrint (HTML, CSS, and Korean word filter)."
  pandoc "$INPUT_MD" \
    --from markdown \
    --to html5 \
    --standalone \
    --css "$CSS_FILE" \
    --lua-filter "$KOREAN_WORD_FILTER" \
    -o "$TMP_HTML"
  weasyprint --base-url "$INPUT_MD" "$TMP_HTML" "$OUTPUT_PDF"
elif command -v pandoc >/dev/null 2>&1; then
  echo "Build path: Pandoc PDF fallback (different styling; no Korean word filter)." >&2
  pandoc "$INPUT_MD" \
    --from markdown \
    --css "$CSS_FILE" \
    -o "$OUTPUT_PDF"
else
  echo "Error: 'pandoc' (and optionally 'weasyprint') is required to build PDF." >&2
  echo "Install on Ubuntu/Debian: sudo apt-get install -y pandoc weasyprint" >&2
  echo "Install on macOS: brew install pandoc weasyprint" >&2
  exit 1
fi

echo "Generated: $OUTPUT_PDF"

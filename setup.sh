#!/usr/bin/env bash
set -euo pipefail

BASE_URL="https://raw.githubusercontent.com/dalandro/llm-wiki-template/main"
WIKI_DIR="${WIKI_DIR:-$HOME/llm-wiki}"
CLAUDE_MD="$HOME/.claude/CLAUDE.md"

SCAFFOLD_FILES=(
  "schema.md"
  "CLAUDE.md"
  "index.md"
  "log.md"
  ".gitignore"
  ".obsidian/app.json"
  ".obsidian/appearance.json"
  ".obsidian/community-plugins.json"
  ".obsidian/core-plugins.json"
)

download_scaffold() {
  echo "Installing scaffold to $WIKI_DIR..."
  mkdir -p "$WIKI_DIR/wiki" "$WIKI_DIR/raw-sources" "$WIKI_DIR/.obsidian"
  for file in "${SCAFFOLD_FILES[@]}"; do
    curl -fsSL "$BASE_URL/$file" -o "$WIKI_DIR/$file"
    echo "  $file"
  done
}

append_claude_md() {
  if grep -q "## LLM Wiki" "$CLAUDE_MD" 2>/dev/null; then
    echo "Wiki block already present in $CLAUDE_MD — skipping."
    return
  fi
  mkdir -p "$(dirname "$CLAUDE_MD")"
  cat >> "$CLAUDE_MD" << EOF

## LLM Wiki

Personal wiki at \`$WIKI_DIR\`. When a question seems like it might be covered there, read \`$WIKI_DIR/index.md\` first, then relevant pages.
EOF
  echo "Wiki block appended to $CLAUDE_MD."
}

# If run via curl pipe, $0 is "bash" — scaffold doesn't exist yet
if [[ "$0" == "bash" || ! -f "${0%/*}/schema.md" ]]; then
  download_scaffold
fi

append_claude_md

echo ""
echo "Done. Wiki at: $WIKI_DIR"
echo "Open the folder in Obsidian, then start Claude Code."

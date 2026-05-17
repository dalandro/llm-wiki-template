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
  if grep -q "# LLM Wiki" "$CLAUDE_MD" 2>/dev/null; then
    echo "Wiki block already present in $CLAUDE_MD — skipping."
    return
  fi
  mkdir -p "$(dirname "$CLAUDE_MD")"
  cat >> "$CLAUDE_MD" << EOF

# LLM Wiki

Personal wiki at \`$WIKI_DIR\`. Read \`$WIKI_DIR/index.md\` first to find relevant pages, then drill into them.

**Query:** When user asks something the wiki likely covers — read relevant wiki pages before answering. Don't re-derive what's already compiled.

**File back automatically:** Good answers, analyses, comparisons, or discoveries from any session should be written as new wiki pages without waiting to be asked. The wiki compounds — chat history disappears, wiki pages persist. Use judgment: a one-liner answer doesn't need a page; a useful synthesis does.

**Ingest style (when user adds a source):** Read it, discuss key takeaways interactively first, then write wiki pages. Don't silently batch-process — stay involved.

**What belongs in wiki:** Claude/dev setup, tool configs, dev preferences, project decisions, domain knowledge, any useful answer worth keeping. Not ephemeral task details.
EOF
  echo "Wiki block appended to $CLAUDE_MD."
}

# If run via curl pipe, $0 is "bash" — scaffold doesn't exist yet
if [[ ! -f "${BASH_SOURCE[0]%/*}/schema.md" ]] || [[ "${BASH_SOURCE[0]}" == "bash" ]]; then
  download_scaffold
fi

append_claude_md

echo ""
echo "Done. Wiki at: $WIKI_DIR"
echo "Open the folder in Obsidian, then start Claude Code."

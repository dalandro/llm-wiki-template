# llm-wiki

A personal knowledge base maintained by Claude Code. You drop in sources; Claude handles the rest — writing wiki pages, cross-referencing them, and filing back good answers from your conversations.

> "Obsidian is the IDE; the LLM is the programmer; the wiki is the codebase."
> — [Andrej Karpathy](https://gist.github.com/karpathy/b97dc906a95a7f7a6df8f0a0e5ef8a93)

## How it works

- **`raw-sources/`** — drop in articles, PDFs, notes, or web clips. Claude reads these, never modifies them.
- **`wiki/`** — Claude-maintained markdown pages. One concept per file, cross-referenced with `[[wikilinks]]`.
- **`index.md`** — catalog of all pages. Claude reads this first on every session.
- **`log.md`** — append-only timeline of all ingests and updates.
- **`schema.md`** — conventions and workflow operations Claude follows.
- **`CLAUDE.md`** — project-level instructions loaded automatically by Claude Code.

Claude builds up a compounding knowledge base across sessions. Unlike RAG, it doesn't re-derive from scratch every time — the synthesis, cross-references, and contradictions are already there.

## Setup

Requires [Claude Code](https://claude.ai/code).

```bash
curl -fsSL https://raw.githubusercontent.com/dalandro/llm-wiki-template/main/setup.sh | bash
```

Installs scaffold to `~/llm-wiki` and appends a wiki-awareness block to `~/.claude/CLAUDE.md`. To install elsewhere:

```bash
curl -fsSL https://raw.githubusercontent.com/dalandro/llm-wiki-template/main/setup.sh | WIKI_DIR=~/your-path bash
```

## Usage

Open the folder in [Obsidian](https://obsidian.md) to browse the graph and navigate wikilinks. Use Claude Code for everything else.

**Ingest a source:**
> "Ingest `raw-sources/article.md` and update the wiki."

**Ask a question:**
> "Query: what do I know about X?"

**Health check:**
> "Lint the wiki."

## Optional add-ons

- **Git backup** — initialize a private remote and push your wiki. Not included in setup; your own workflow. To have Claude auto-commit after every ingest, add to your `CLAUDE.md`:

  > **After Every Operation**
  > Commit with a semantic message: `git add -A && git commit -m "ingest: [[topic]] from filename" && git push`

  And append `, commit` to the Ingest operation line in `CLAUDE.md`.
- **Obsidian** — open the folder as a vault. Install the [Dataview](https://github.com/blacksmithgu/obsidian-dataview) community plugin when prompted. For clipping web pages directly into `raw-sources/`, install the [Obsidian Web Clipper](https://obsidian.md/clipper) Chrome extension.

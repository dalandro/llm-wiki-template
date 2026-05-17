# LLM Wiki Schema

## Purpose
Persistent, LLM-maintained knowledge base. Humans curate sources and ask questions; LLM handles bookkeeping.

## Folder Structure
```
llm-wiki/
├── raw-sources/     # immutable input documents (articles, PDFs, notes, clips)
├── wiki/            # LLM-generated knowledge pages
├── index.md         # content-oriented catalog of all wiki pages
├── log.md           # append-only timeline of ingest/update operations
└── schema.md        # this file — conventions and workflows
```

## Wiki Page Conventions
- One concept/entity per file
- Filename: `wiki/concept-name.md` (kebab-case)
- Header: `# Concept Name`
- Sections (use what applies):
  - **Summary** — 2-5 sentence overview
  - **Key Points** — bullet list of core facts
  - **Details** — deeper explanation
  - **Related** — `[[wikilinks]]` to other pages
  - **Sources** — citations from raw-sources/ or URLs
  - **Open Questions** — contradictions or gaps to resolve

## Operations

### Ingest
> "Read `raw-sources/foo.md`. First report: what pages you plan to create/update, what new claims exist, and where new data contradicts or strengthens existing pages — then wait for confirmation before writing."

On confirmation: create new pages, revise existing ones, note contradictions with old claims, update synthesis. Then update index.md and append to log.md.

### Query
> "Search the wiki and answer: [question]. Cite the wiki pages you used."

### Lint
> "Audit the wiki for contradictions, orphaned pages, missing cross-references, stale claims, and duplicate concepts under different names. Report findings."

### New Page
> "Create a wiki page for [topic] based on what's already in the wiki."

## Cross-Reference Rules
- Use `[[page-name]]` Obsidian wikilinks for internal links
- Every new page must appear in index.md
- Related pages must link back to each other

## log.md Format
```
## YYYY-MM-DD
- Ingested: [source file or URL]
- Created: [[page]], [[page]]
- Updated: [[page]]
- Notes: [anything notable]
```

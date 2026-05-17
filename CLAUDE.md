# LLM Wiki — Claude Code Instructions

This is an LLM-maintained knowledge base. Read `schema.md` for full structure and conventions before doing anything.

## On Session Start
1. Read `schema.md` — conventions, folder structure, workflow operations
2. Read `index.md` — current wiki state, what pages exist
3. Read `log.md` (last 20 lines) — recent activity

## Core Rules
- Wiki pages live in `wiki/` — one concept per file, kebab-case filename
- Raw sources live in `raw-sources/` — never modify these
- Every new wiki page must appear in `index.md`
- Use `[[wikilinks]]` for internal links, not markdown links
- After every ingest or update: append to `log.md`, update `index.md`

## Operations (invoke by name)
- **Ingest** `raw-sources/foo.md` — read source, report planned changes + contradictions with existing pages, then on confirmation: create/revise pages, note where new data contradicts or strengthens old claims, update index + log
- **Query** [question] — search wiki, synthesize answer with `[[page]]` citations
- **Lint** — audit for contradictions, orphans, missing cross-refs, stale claims

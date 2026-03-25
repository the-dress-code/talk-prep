# progress.md

Last updated: 2026-03-25 (Day 9)

## What works
- BraindumpProcessor.process/1 — file path in, structured map out
- Output shape: %{raw, themes, topics} with three-level hierarchy (topic/point/details)
- topics_with_no_points/1 — filters topics where points list is empty
- Ollama + Qwen pipeline runs end to end via req_llm
- `mix braindump <file>` — CLI entry point, processes file and prints readable output
- Tested on real talk content — produced usable output
- All tests passing (unit + integration), clean compile with no warnings
- Claude Code is the sole agent (Aider + Qwen phased out Day 8)
- verify.sh — full quality gate (compile + test + credo), lenient default, `--strict` opt-in

## Known issues
- needs_points flag always returns false — Qwen limitation, not a code bug
- Topic labels use Qwen's phrasing instead of speaker's verbatim words — tolerated for now
- Larger braindumps need receive_timeout: 300_000 (5 min) — currently hardcoded
- BraindumpValidator exists but is not wired into the pipeline

## Deferred — revisit when triggered
- **MCP:** Deferred Day 8 — no capability gap yet. Revisit when the agent needs to
  reach something it can't get to via the terminal (e.g., visual output, slide
  preview, external services). Details in docs/mcp_notes.md.

## What's next
- Day 10: Level 4+5 checkpoint — can the agent build on prior sessions? Can it do something it couldn't before?
- Product gate: process real talk content and get output you'd actually use (CLI exists, verify.sh in place — getting close)

# progress.md

Last updated: 2026-03-26 (Day 10)

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
- Day 11: Test compounding (Level 4 validation) — fresh CLI session, real task, does the agent pick up context?
- Day 12: Upgrade harness for Socratic questioner — write feature contract in AGENTS.md, write test stubs, upgrade verify.sh into a real feedback loop
- Days 13-16: Build Socratic questioner as first full Level 6 rep cycle (see AGENTS.md "Current sprint phase" for the rep cycle steps)
- Days 17-19: Second Level 6 rep (redundancy mapper or modular idea store)
- April 5: Socratic questioner ready for real talk prep use

### Socratic questioner (next feature)
When a topic or claim in a braindump lacks supporting evidence, ask the user
leading questions to draw it out. Store answers for later use. Never invent —
questions help the user surface their own knowledge. Full description in
product_vision.md. Feature contract will be written in AGENTS.md on Day 12.

## Tool setup (settled Day 10)
- Claude Code CLI (Sonnet) — primary daily tool for everything
- VS Code — open alongside for reading code/diffs
- Claude Code Desktop (Opus) — deep strategic sessions only

## Session conventions (added Day 10)
**READ sprint_log.md "Real-time coaching" section before starting any task.**
It has numbered rules for level callouts, anti-pattern flagging, and pushback
that must be followed every session. These are not optional.

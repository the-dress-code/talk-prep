# progress.md

Last updated: 2026-03-31 (Day 11)

## What works
- BraindumpProcessor.process/1 — file path in, structured map out
- Output shape: %{raw, themes, topics} with three-level hierarchy (topic/point/details)
- topics_with_no_points/1 — filters topics where points list is empty
- Ollama + Qwen pipeline runs end to end via req_llm
- `mix braindump <file>` — CLI entry point, processes file and prints readable output
- Tested on real talk content — produced usable output
- All pre-existing tests passing. 9 Socratic questioner stubs failing "not implemented" — expected, harness is in place
- Claude Code is the sole agent (Aider + Qwen phased out Day 8)
- verify.sh — full quality gate (compile + test + credo), lenient default, `--strict` opt-in
- Socratic questioner harness — feature contract in AGENTS.md, test stubs in test/socratic_questioner_test.exs, skeleton module in lib/talk_prep/socratic_questioner.ex

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
- Day 12: Upgrade verify.sh into a feedback loop (agent runs, parses output, self-corrects without human)
- Days 13-16: Build Socratic questioner as first full Level 6 rep cycle (see AGENTS.md "Current sprint phase" for the rep cycle steps)
- Days 17-19: Second Level 6 rep (redundancy mapper or modular idea store)
- April 5: Socratic questioner ready for real talk prep use

### Socratic questioner (next feature)
Feature contract is written — see AGENTS.md. Test stubs are in
test/socratic_questioner_test.exs. Skeleton module is in
lib/talk_prep/socratic_questioner.ex. Run `mix test` to see what needs
implementing. Build starts Day 13.

## Session conventions (added Day 10)
**READ sprint_log.md "Real-time coaching" section before starting any task.**
It has numbered rules for level callouts, anti-pattern flagging, and pushback
that must be followed every session. These are not optional.

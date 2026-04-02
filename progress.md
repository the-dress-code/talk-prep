# progress.md

Last updated: 2026-04-02 (Day 13)

## What works
- BraindumpProcessor.process/1 — file path in, structured map out
- Output shape: %{raw, themes, topics} with three-level hierarchy (topic/point/details)
- topics_with_no_points/1 — filters topics where points list is empty
- Ollama + Qwen pipeline runs end to end via req_llm
- `mix braindump <file>` — CLI entry point, processes file and prints readable output
- Tested on real talk content — produced usable output
- All pre-existing tests passing. 9 Socratic questioner stubs failing "not implemented" — expected, harness is in place
- Claude Code is the sole agent (Aider + Qwen phased out Day 8)
- verify.sh — structured per-phase output with PASS/FAIL labels, SUMMARY block, Ollama health check, lenient credo default, `--strict` opt-in
- Socratic questioner harness — feature contract in docs/socratic_questioner_contract.md, test stubs in test/socratic_questioner_test.exs, skeleton module in lib/talk_prep/socratic_questioner.ex
- WebFetch permissions for 3 framework article sites in .claude/settings.local.json

## Known issues
- needs_points flag always returns false — Qwen limitation, not a code bug
- Topic labels use Qwen's phrasing instead of speaker's verbatim words — tolerated for now
- Larger braindumps need receive_timeout: 300_000 (5 min) — currently hardcoded
- BraindumpValidator exists but is not wired into the pipeline
- FileIngestor has only read_file/1 — placeholder process_file/1 was removed on Day 8
- verify.sh feedback loop protocol is a text constraint, not mechanical — walk-away test (Day 13) showed the agent can bypass it and still produce passing tests. Harness needs mechanical enforcement (PreToolUse hook, Day 14).

## Deferred — revisit when triggered
- **MCP:** Deferred Day 8 — no capability gap yet. Revisit when the agent needs to
  reach something it can't get to via the terminal (e.g., visual output, slide
  preview, external services). Details in docs/mcp_notes.md.
- **AGENTS.md length:** Checked Day 13 — trimmed from 125 to 115. Accepted at 115.

## What's next
- Day 13.5 (standalone): uncertainty/confidence constraint for the agent
- Day 14: Tighten harness — make "don't read files first" mechanical via PreToolUse hook on Read
- Day 15: Agent builds Socratic questioner with tightened harness
- Day 16: Agent-Y adversarial review
- Day 17: Re-evaluation checkpoint
- April 5: Socratic questioner ready for real talk prep use

### Socratic questioner (next feature)
Feature contract is in docs/socratic_questioner_contract.md. Test stubs are in
test/socratic_questioner_test.exs. Skeleton module is in
lib/talk_prep/socratic_questioner.ex. Run `mix test` to see what needs
implementing. Build starts Day 13.

## Session conventions (added Day 10)
**READ sprint_log.md "Real-time coaching" section before starting any task.**
It has numbered rules for level callouts, anti-pattern flagging, and pushback
that must be followed every session. These are not optional.

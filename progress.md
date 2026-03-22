# progress.md

Last updated: 2026-03-22 (Day 7)

## What works
- BraindumpProcessor.process/1 — file path in, structured map out
- Output shape: %{raw, themes, topics} with three-level hierarchy (topic/point/details)
- topics_with_no_points/1 — filters topics where points list is empty
- Ollama + Qwen pipeline runs end to end via req_llm
- Tested on real talk content (chatgpt chat with meta-conversation mixed in) — produced usable output
- All tests passing (unit + integration)
- Aider + Qwen doing surgical edits with custom model (16k context, diff edit format)

## Known issues
- needs_points flag always returns false — Qwen limitation, not a code bug
- Topic labels use Qwen's phrasing instead of speaker's verbatim words — tolerated for now
- Larger braindumps need receive_timeout: 300_000 (5 min) — currently hardcoded
- BraindumpValidator exists but is not wired into the pipeline
- FileIngestor.process_file/1 is a placeholder — only read_file/1 is in use

## What's next
- Day 8: introduce Claude Code as second agent, wire up one MCP server
- Day 9: build verify.sh (mix compile + mix test + mix credo)
- Product gate: process real talk content and get output you'd actually use (in progress — first test promising)

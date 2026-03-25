# AGENTS.md

### What this project is
talk_prep is a private, local CLI tool that ingests braindump writing and
organizes ideas into a structured talk outline. All LLM processing happens
on-device via Ollama — no content ever leaves the machine.

## Hard constraints
- NEVER make HTTP calls to external APIs. All LLM calls go to Ollama at
  localhost:11434 via req_llm. If you're not sure, ask.
- Do not add dependencies without being asked. Check mix.exs before
  suggesting a new library.

## What "done" means
Code changes must pass `mix compile` and `mix test` before being considered done.
Do not commit unless asked.

## Agent history
- **Days 1–7:** Aider + Qwen (local, free). Used to learn context engineering
  (Level 3) and compounding (Level 4). Phased out on Day 8 — Qwen's limitations
  (inventing content, non-deterministic output, needs_points always false) made it
  a poor fit for Level 5+ work.
- **Day 8+:** Claude Code is the sole agent. Handles coding, orchestration, and
  harness engineering. Multi-agent returns at Day 15 — automated and adversarial,
  not manual.

## Stack
- Elixir / Mix / OTP
- req_llm ~> 1.7 (LLM HTTP client)
- Ollama (local LLM server, http://localhost:11434)

## Current output shape
BraindumpProcessor.process/1 returns:
```
%{
  raw: "original text",
  themes: ["theme1", "theme2"],
  topics: [
    %{
      topic: "label",
      needs_points: true | false,
      points: [
        %{point: "statement", details: ["example1", "example2"]}
      ]
    }
  ]
}
```

## Known issues (Ollama/Qwen)
- Topic labels tend to be Qwen's phrasing, not the speaker's verbatim words
- needs_points currently always returns false
- Output shape can vary between runs — Qwen is non-deterministic
- Complex prompts require receive_timeout: 300_000 for larger inputs

## CLI
- `mix braindump <path/to/file.txt>` — processes a braindump and prints structured output
- `./verify.sh` — full quality gate (compile + test + credo). Run before committing or handing off to a verifying agent. Pass `--strict` to fail on any credo issue.

## Code notes
- BraindumpValidator exists but is not wired into the pipeline yet.
- FileIngestor has only read_file/1 — placeholder process_file/1 was removed on Day 8.

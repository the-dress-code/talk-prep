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
- Do not commit. Your job is to write correct code and stop.

## What "done" means for Aider
Your job is to write correct code and stop. Do not commit.
After you make changes, tell me what you changed and why.
The human will run mix compile and mix test to verify.

## Stack
- Elixir / Mix / OTP
- req_llm ~> 1.7 (LLM HTTP client)
- Qwen qwen2.5-coder:14b via Ollama (local model, http://localhost:11434)

## Known Qwen limitations
- Topic labels tend to be Qwen's own phrasing rather than the speaker's verbatim
  words, despite being instructed otherwise. This is expected behavior for this
  model — not a bug to fix in the code.
- Complex prompts (3-level hierarchy) require receive_timeout: 120_000 or Qwen
  will time out. Default timeout is too short.
- Output shape can vary between runs — Qwen is non-deterministic. Test a few
  times before concluding a prompt change helped or hurt.
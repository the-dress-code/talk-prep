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
Before committing anything, you must run these commands in order:
1. `mix compile` — fix all errors and warnings before proceeding
2. `mix test` — fix all failures before proceeding
3. Only after both pass: commit with a clear message

If you cannot run these commands, stop and say so. Do not commit unverified code.

## Stack
- Elixir / Mix / OTP
- Jido ~> 2.0 (action pipeline)
- req_llm ~> 1.5 (LLM HTTP client)
- Qwen qwen2.5-coder:14b via Ollama (local model, http://localhost:11434)
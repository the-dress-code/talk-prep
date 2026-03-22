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
- Qwen qwen2.5-coder-16k via Ollama (local model, http://localhost:11434)
  - Custom model: base qwen2.5-coder:14b with num_ctx 16384
  - Aider launch: `aider --model ollama/qwen2.5-coder-16k --no-auto-commits --edit-format diff`
  - The 16k context window is required — default 2048 causes Qwen to drop
    the system prompt and rewrite entire files instead of making surgical edits

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

## Known Qwen limitations
- Topic labels tend to be Qwen's own phrasing rather than the speaker's verbatim
  words, despite being instructed otherwise. This is expected behavior for this
  model — not a bug to fix in the code.
- needs_points currently always returns false — Qwen does not flag topics that
  lack supporting points. Known issue, not a code bug.
- Complex prompts (3-level hierarchy) require receive_timeout: 120_000 or Qwen
  will time out. Default timeout is too short.
- Output shape can vary between runs — Qwen is non-deterministic. Test a few
  times before concluding a prompt change helped or hurt.

## Code notes
- BraindumpValidator exists but is not wired into the pipeline yet.
- FileIngestor.process_file/1 is a placeholder — read_file/1 is the one in use.
# Agentic Engineering Sprint Log

## Context for new chat sessions
Paste this file at the start of any new chat with Claude to resume the sprint.

### Who I am
- Functional developer, 2 years experience, stronger in Elixir than Clojure
- Learning agentic engineering, targeting Level 6 per Bassim Eledath's framework
- Conference speaker in the FP community

### The project
talk_prep — a private, local CLI tool that ingests braindump writing and extracts,
organizes, and maps ideas into a structured talk outline using Jido Actions and a
local Qwen model. Runs entirely locally for privacy.

### The tool stack
- Ollama running Qwen qwen2.5-coder:14b locally (free, private)
- Aider 0.86.2 as the agent CLI
- Elixir / Mix / OTP
- Jido 2.0
- req_llm ~> 1.5

### The framework (read these to understand the plan)
The sprint is built on three articles:
1. Bassim Eledath — "The 8 Levels of Agentic Engineering"
   bassimeledath.com/blog/levels-of-agentic-engineering
   Levels 3-5 are foundations. Level 6 (harness engineering + automated
   feedback loops) is the target. Key insight: context, compounding, and
   tools must be solid before automating feedback loops on top of them.

2. OpenAI — "Harness Engineering: Leveraging Codex in an Agent-First World"
   openai.com/index/harness-engineering
   Key insights: agents need feedback loops to self-verify, documentation
   lives in the repo not in people's heads, constraints beat instructions,
   AGENTS.md is a table of contents not an encyclopedia.

3. Anthropic — "Effective Harnesses for Long-Running Agents"
   anthropic.com/engineering/effective-harnesses-for-long-running-agents
   Key insights: initializer agent sets up environment, coding agent makes
   incremental progress, progress.md bridges sessions, verify before
   declaring done, test end-to-end not just unit level.

### Why these levels in this order
- Level 3 (context engineering): teaches you to control what the agent sees
- Level 4 (compounding): makes each session smarter than the last
- Level 5 (MCP + skills): gives the agent real capabilities beyond file edits
- Level 6 (harness engineering): agent verifies its own work, you step back
Skipping any level means the next one amplifies the mess instead of the work.

### The 17-day sprint outline (living document — adjust as we go)

Week 1 — Environment & Level 3 (Context Engineering)
- Day 1 ✅ Get Ollama + Qwen running locally, Aider installed and talking to Qwen,
  make one real change to a project (Ollama, Qwen, Aider)
- Day 2: Write first AGENTS.md for talk_prep, feel the difference it makes
- Day 3: Experiment with context — too little, too much, just right — build the instinct
- Day 4: Build talk_prep core — ingest a braindump file using Aider with good context
- Day 5: Consolidate — clean up AGENTS.md, clean git history, Level 3 checkpoint

Week 2 — Level 4 & 5 (Compounding + Capabilities)
- Day 6: Introduce plan→delegate→assess→codify loop, start progress.md
- Day 7: Add docs/ folder with architecture.md, see how it changes agent behavior
- Day 8: Define first real Jido Action that processes braindump text via Qwen
- Day 9: Install and wire one MCP into Aider (MCP)
- Day 10: Write first reusable skill — Elixir conventions checker
- Day 11: Level 4+5 checkpoint — does the agent feel more capable than Day 1?

Week 3 — Level 6 (Harness Engineering)
- Day 12: Write first real ExUnit tests for talk_prep Jido Action (ExUnit, Credo)
- Day 13: Write verify.sh — automated feedback script
- Day 14: Update AGENTS.md with verification contract, run full loop first time
- Day 15: Let Aider run a task solo against verify.sh — walk away, see what happens
- Day 16: Add adversarial reviewer pass (two-agent pattern)
- Day 17: Level 6 checkpoint — can the agent work, verify, and self-correct without you?

Note: days may bleed into each other. The "leveled up when" criteria matter
more than the day count. Project vehicle is talk_prep, not jido_lab.

### The plan
17 days, roughly 3 weeks at 3-5 hrs/day. See sprint outline above.
Each day we work step by step together in a Claude chat session.
Paste this entire file at the start of each new session to restore context.

---

## Daily Log

### Day 1 ✅
**Goal:** Get environment working
**Completed:**
- Installed Ollama, pulled qwen2.5-coder:14b
- Installed Aider 0.86.2 (required Python 3.12, not 3.13/3.14)
- Configured Aider to use Qwen via OLLAMA_API_BASE
- Made first real agent change to jido_lab, auto-committed by Aider
- Set up talk_prep as new project vehicle

**Key decisions:**
- Switched project from jido_lab to talk_prep (talk prep assistant)
- Local Qwen chosen for privacy — braindumps never leave the machine
- Aider over Cursor because Level 6 requires CLI-based feedback loops

**Lessons learned:**
- pipx requires Python 3.12 for aider-chat (not 3.13 or 3.14)
- `q` exits the git log pager
- `cat` prints file contents to terminal
- `echo >>` appends text to a file

**Left off at:** talk_prep Mix project created, pushed to github.com/the-dress-code/talk-prep

---

### Day 2
**Goal:** Write AGENTS.md, feel the difference context makes
**Completed:**
- [ ]
**Key decisions:**
-
**Lessons learned:**
-
**Left off at:**

---

### Day 3
*(fill in)*

---
## Open questions
*(add anything unresolved here)*
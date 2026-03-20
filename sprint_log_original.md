# Agentic Engineering Sprint Log

## How to use this file
Paste this entire file at the start of any new Claude chat session to restore
full context and resume the sprint exactly where you left off.

---

## Who I am
- Functional developer, 2 years experience, stronger in Elixir than Clojure
- Learning agentic engineering, targeting Level 6 per Bassim Eledath's framework
- Conference speaker in the FP community (Dutch Clojure Days, May 8, Amsterdam)

---

## The project: talk_prep
A private, local CLI tool that ingests braindump writing and extracts, organizes,
and maps ideas into a structured talk outline using Jido Actions and a local Qwen
model. Runs entirely locally for privacy — braindumps never leave the machine.

**Repo:** github.com/the-dress-code/talk-prep
**Local path:** ~/Projects/talk_prep

---

## Tool stack
- Ollama — runs Qwen locally (installed via Homebrew)
- Qwen qwen2.5-coder:14b — local LLM, free, private
- Aider 0.86.2 — agent CLI, installed via pipx with Python 3.12
- Elixir / Mix / OTP
- Jido ~> 2.0
- req_llm ~> 1.5
- OLLAMA_API_BASE=http://localhost:11434 (set in ~/.zshrc)

**To start a session:**
```bash
ollama serve        # if not already running as a service
cd ~/Projects/talk_prep
aider --model ollama/qwen2.5-coder:14b
```

---

## The framework
This sprint is built on three articles. Read them to understand why the plan
is structured the way it is.

1. **Bassim Eledath — "The 8 Levels of Agentic Engineering"**
   bassimeledath.com/blog/levels-of-agentic-engineering
   Levels 3–5 are the foundations. Level 6 (harness engineering + automated
   feedback loops) is the target. Skipping any level amplifies the mess instead
   of the work.

2. **OpenAI — "Harness Engineering: Leveraging Codex in an Agent-First World"**
   openai.com/index/harness-engineering
   Key insights: agents need feedback loops to self-verify; documentation lives
   in the repo not in people's heads; constraints beat instructions; AGENTS.md
   is a table of contents not an encyclopedia.

3. **Anthropic — "Effective Harnesses for Long-Running Agents"**
   anthropic.com/engineering/effective-harnesses-for-long-running-agents
   Key insights: initializer agent sets up environment; coding agent makes
   incremental progress; progress.md bridges sessions; verify before declaring
   done; test end-to-end not just unit level.

---

## Why these levels in this order
- **Level 3 (context engineering):** control what the agent sees — quality in, quality out
- **Level 4 (compounding):** each session is smarter than the last
- **Level 5 (MCP + skills):** give the agent real capabilities beyond file edits
- **Level 6 (harness engineering):** agent verifies its own work, you step back

**You've reached Level 6 when:** you give the agent a task, walk away, and come
back to find it either finished and verified — or clearly stuck with a specific
question. Not silently broken. Not falsely done.

---

## The 17-day sprint outline
*Living document — days may bleed into each other. The "leveled up when"
criteria matter more than the day count.*

### Week 1 — Environment & Level 3 (Context Engineering)
- Day 1  ✅  Get Ollama + Qwen running locally, Aider installed and talking to
            Qwen, make one real change to a project (Ollama, Qwen, Aider)
- Day 2      Write first AGENTS.md for talk_prep, feel the difference it makes
- Day 3      Experiment with context — too little, too much, just right — build
            the instinct
- Day 4      Build talk_prep core — ingest a braindump file using Aider with
            good context
- Day 5      Consolidate — clean up AGENTS.md, clean git history, Level 3
            checkpoint

**Level 3 leveled up when:** you can predict in advance whether a prompt will
confuse the agent, and you know how to fix it before running it.

### Week 2 — Level 4 & 5 (Compounding + Capabilities)
- Day 6      Introduce plan→delegate→assess→codify loop, start progress.md
- Day 7      Add docs/ folder with architecture.md, see how it changes agent
            behavior
- Day 8      Define first real Jido Action that processes braindump text via Qwen
- Day 9      Install and wire one MCP into Aider
- Day 10     Write first reusable skill — Elixir conventions checker
- Day 11     Level 4+5 checkpoint — does the agent feel more capable than Day 1?

**Level 4 leveled up when:** you start a session and the agent already "knows"
things you taught it last week, because you codified them properly.

**Level 5 leveled up when:** your agent can do something it literally could not
do before — access a real system, run a real check.

### Week 3 — Level 6 (Harness Engineering)
- Day 12     Write first real ExUnit tests for talk_prep Jido Action (ExUnit, Credo)
- Day 13     Write verify.sh — automated feedback script
- Day 14     Update AGENTS.md with verification contract, run full loop first time
- Day 15     Let Aider run a task solo against verify.sh — walk away, see what
            happens
- Day 16     Add adversarial reviewer pass (two-agent pattern)
- Day 17     Level 6 checkpoint — can the agent work, verify, and self-correct
            without you?

---

## Daily Log

### Day 1 ✅
**Goal:** Get environment working
**Completed:**
- Installed Ollama, pulled qwen2.5-coder:14b
- Installed Aider 0.86.2 (required Python 3.12, not 3.13 or 3.14)
- Configured Aider to point at local Qwen via OLLAMA_API_BASE
- Made first real agent change to jido_lab, auto-committed by Aider
- Created talk_prep as the new project vehicle, pushed to GitHub
- Added secrets, editor files, and .aider* to .gitignore

**Key decisions:**
- Switched project vehicle from jido_lab to talk_prep
- Local Qwen chosen for privacy — braindumps never leave the machine
- Aider over Cursor because Level 6 requires CLI-based feedback loops

**Lessons learned:**
- pipx requires Python 3.12 for aider-chat (3.13 and 3.14 are too new)
- `q` exits the git log pager (less)
- `cat` prints file contents to the terminal
- `echo >>` appends text to a file without opening an editor
- `git add` is required even for existing files that have been modified

**Left off at:** talk_prep Mix project created and pushed to
github.com/the-dress-code/talk-prep. sprint_log.md added to project.

---

### Day 2
**Goal:** Write AGENTS.md, feel the difference context makes
**Completed:**
**Key decisions:**
**Lessons learned:**
**Left off at:**

---

## Open questions
*(add anything unresolved here)*

## Before Day 2
- [ ] Create talk_prep Mix project locally: `mix new talk_prep --sup`
- [ ] Push to github.com/the-dress-code/talk-prep
- [ ] Add sprint_log.md to the project and commit it

## Real deadline context
The first real use of talk_prep is the Dutch Clojure Days talk,
May 8, Amsterdam. Talk title: "Clojure as Your First Language:
Shaping a Functional Mindset". This is a 45-minute talk for a
beginner-friendly audience. Details still forthcoming from the
conference. The tool needs to be useful enough to actually help
with this talk before May 8.
# Agentic Engineering Sprint Log

## How to use this file
Paste this entire file at the start of any new Claude chat session to restore
full context and resume the sprint exactly where you left off.

---

## Session conventions
- At the start of each day's session, generate a printable day checklist
  in the same format as the Day 1 checklist (goal, bullet steps, stretch goal).
- Follow the style of the Day 1 checklist — short goal line, plain bullet steps,
  one stretch goal, brief closing note. Clear and concise, no headers or sub-sections.
- Save the checklist as a markdown file in `checklists/day_N_checklist.md` and
  commit it to the repo.
- Also display the checklist in the chat message so it can be copied directly
  into Google Docs. Add a timestamp at the bottom of the md file (below a
  horizontal rule) in the format: *Generated: YYYY-MM-DD* — keep it out of
  the main checklist body.

- At the end of each day's session, after presenting the updated sprint log, ask the
  human to confirm they are happy with it before proceeding. Once confirmed, generate
  a Slack check-in message using the day's log entry (Completed, Lessons learned,
  Left off at) as the source. Format: first line is "Day N: Agentic Engineering
  Learning Sprint" followed by a second line with the day's goal as a title. Then
  concise bullet points — what got done, what was learned. No markdown, no asterisks,
  no formatting symbols. Use "Next:" instead of "Tomorrow:" for the closing item.
  Keep it tight. Manager knows about the sprint — no need to over-explain.

---

## Who I am
- Functional developer, 2 years experience, stronger in Elixir than Clojure
- Learning agentic engineering, targeting Level 6 per Bassim Eledath's framework
- Conference speaker in the FP community (Dutch Clojure Days, May 8, Amsterdam)

---

## The project: talk_prep
A private, local CLI tool that ingests braindump writing and extracts, organizes,
and maps ideas into a structured talk outline using a local Qwen model.
Runs entirely locally for privacy — braindumps never leave the machine.

**Repo:** github.com/the-dress-code/talk-prep
**Local path:** ~/Projects/talk_prep

---

## Tool stack
- Ollama — runs Qwen locally (installed via Homebrew)
- Qwen qwen2.5-coder:14b — local LLM, free, private
- Aider 0.86.2 — agent CLI, installed via pipx with Python 3.12
- Elixir / Mix / OTP
- req_llm ~> 1.7 (in deps, wired up and working)
- OLLAMA_API_BASE=http://localhost:11434 (set in ~/.zshrc)

**To start a session:**
```bash
ollama serve        # if not already running as a service
cd ~/Projects/talk_prep
aider --model ollama/qwen2.5-coder:14b --no-auto-commits
```

**Two agents, different roles:**
- Aider + Qwen — hands-on coding agent for iterative code changes (Levels 3–4)
- Claude Code — orchestration, planning, harness engineering (Levels 5–6)

**Two terminal tabs (when using Aider):**
- Tab 1 — Aider (interactive, stays open)
- Tab 2 — mix commands (mix compile, mix test)

**Practical workflow (current stage):**
- Aider writes code, does not commit
- You run `mix compile` and `mix test` in Tab 2 to verify
- You commit manually when both pass
- This is correct Level 3/4 behavior — you are the verifier
- Aider + Qwen will hit a ceiling around Level 5 — Claude Code takes over
  for harness engineering, verification loops, and walk-away tests (Day 8+)

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

## The 16-day sprint outline
*Living document — days may bleed into each other. The "leveled up when"
criteria matter more than the day count.*

### Week 1 — Environment & Level 3 (Context Engineering)
- Day 1  ✅  Get environment working (Ollama, Qwen, Aider)
- Day 2  ✅  Write AGENTS.md, feel the difference context makes
- Day 3  ✅  Context experiments — too little, too much, just right
- Day 4  ✅  Build braindump processor with good context
- Day 5  ✅  Plan review, product vision, revised sprint (Opus session)

**Level 3 leveled up when:** you can predict in advance whether a prompt will
confuse the agent, and you know how to fix it before running it.

### Week 2 — Level 4 & 5 (Compounding + Capabilities)
- Day 6      Consolidate + compounding loop — verify braindump output in iex,
            codify Days 1–5 lessons into AGENTS.md and docs/, clean up
            AGENTS.md, start progress.md. Test: does Aider produce better
            code now than on Day 2?
- Day 7      Build next feature from product vision — make the tool useful
            for the real talk. **Product gate: process real talk content and
            get output you'd actually use.**
- Day 8      Introduce Claude Code as second agent. Use it alongside Aider —
            experience multi-agent workflow. Wire up one MCP server
            (something immediately useful, not theoretical).
- Day 9      Build verify.sh (mix compile + mix test + mix credo). First
            harness artifact. Run Aider against it — does it pass first try?
- Day 10     Level 4+5 checkpoint — can the agent build on prior sessions?
            Can it do something it couldn't before?

**Level 4 leveled up when:** you start a session and the agent already "knows"
things you taught it last week, because you codified them properly.

**Level 5 leveled up when:** your agent can do something it literally could not
do before — access a real system, run a real check.

### Week 3 — Level 6 (Harness Engineering)
- Day 11     Write real ExUnit tests for BraindumpProcessor — not just shape
            checks but "does the output contain themes from the input?"
            Split unit tests (no Ollama) from integration tests.
- Day 12     Full verification loop — Claude Code runs a task, runs verify.sh,
            interprets results, fixes issues. You watch but don't intervene.
- Day 13     Walk-away test. Give the agent a task (e.g., add CLI entry point).
            Step away. Come back and evaluate.
- Day 14     Build redundancy mapper or Socratic questioner — more complex
            task for the harness. **Product gate: tool helps with real talk
            prep, output you'd rehearse from.**
- Day 15     Adversarial pattern — two-agent review (one writes, one
            critiques). The Socrates agent concept.
- Day 16     Level 6 checkpoint + talk prep. Use the full pipeline to
            generate your actual conference talk outline.

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

### Day 2 ✅
**Goal:** Write AGENTS.md, feel the difference context makes
**Completed:**
- Updated .gitignore (secrets, macOS, editor, aider entries)
- Created AGENTS.md with constraints, stack, done criteria, and file map
- Created checklists/ folder, added Day 1 and Day 2 checklists
- Ran Aider experiment: asked for a placeholder braindump processor module
- Observed agent behavior with AGENTS.md in context

**Key decisions:**
- Checklists stored as markdown in checklists/ and committed to repo
- Session conventions section added to sprint_log.md so future sessions
  auto-generate the day's checklist

**Lessons learned:**
- Location constraints in AGENTS.md held — module landed in the right place
- "Done means compile + test" constraint was ignored — agent committed without
  running either command; constraint needs stronger wording
- Dependency constraint partially failed — agent proposed adding jido and
  req_llm twice despite being told not to add deps without being asked
- mix compile can be run in a second terminal tab while Aider stays open
- Saying N to mix.exs edits twice was enough — agent backed off cleanly

**Stretch goal deferred:** Running the same task without AGENTS.md in context
carried forward to Day 3 as the opening experiment.

**Left off at:** braindump_processor.ex committed and compiling cleanly.
AGENTS.md needs stronger verification language before Day 3.

---

### Day 3 ✅
**Goal:** Build the instinct for context — too little, too much, just right
**Completed:**
- Ran no-context experiment: agent found correct file location without AGENTS.md
  but immediately reached for mix.exs
- Ran too-little-context experiment: same mix.exs failure, confirming constraint
  was doing real work
- Ran too-much-context experiment: bloated AGENTS.md buried constraints, same
  failures as no-context
- Strengthened verification contract language in AGENTS.md
- Trimmed AGENTS.md to minimum effective version — cut "Where things live"
  (repo-map handles it) and git conventions (agent ignores them)

**Key decisions:**
- Hard constraints and "done" moved to top of AGENTS.md — most important signal
  should hit the agent first
- "Where things live" section removed — repo-map makes it redundant

**Lessons learned:**
- Constraint visibility matters more than constraint presence
- The repo-map gives the agent enough structural context to land files correctly
  without explicit guidance
- The agent reached for mix.exs in every condition — prominence of the constraint
  matters, not just its presence
- Bloated AGENTS.md performed no better than empty AGENTS.md

**Left off at:** AGENTS.md trimmed and committed. Verification contract still
untested — will confirm on Day 4 when we build the real braindump processor.

---

### Day 4 ✅
**Goal:** Build a real braindump ingestion pipeline
**Completed:**
- Audited actual codebase — discovered sprint log tool stack was aspirational,
  not real (Jido was never in deps; req_llm was listed but not installed)
- Removed placeholder_braindump_processor.ex (Aider-generated, never wired up)
- Added req_llm ~> 1.7 to mix.exs manually, ran mix deps.get, confirmed clean compile
- Implemented BraindumpProcessor.process/1 via Aider with AGENTS.md in context
- Fixed several issues manually after Aider committed: api_key required by
  req_llm even for Ollama (pass `api_key: "ollama"`), response extraction
  via ReqLLM.Response.text/1, JSON fence stripping, and explicit prompt structure
- Added test/fixtures/sample_braindump.txt with real talk content
- Wrote ExUnit test asserting output shape — all 3 tests passing

**Key decisions:**
- Jido removed from project description — not in deps, not planned for near term
- req_llm calls Ollama via `:openai` provider with custom base_url — this is
  correct; Ollama exposes an OpenAI-compatible API
- Output shape agreed: `%{raw, themes, claims, summary}` where claims are
  `%{claim: "...", support: [...]}`
- Draft Aider prompts in chat before running — prevents vague prompts that
  produce wrong output shapes

**Lessons learned:**
- Aider auto-commits by default and ignores "do not commit" instructions —
  use `--no-auto-commits` flag to disable this; human verifies and commits manually
- req_llm requires an api_key even for local Ollama — pass `api_key: "ollama"`
- Use ReqLLM.Response.text/1 to extract text from a response (not response.message.content)
- Qwen will invent its own JSON schema if not given an explicit one — always
  specify the exact structure and say "return ONLY the JSON object, no markdown"
- The sprint log tool stack must reflect reality, not intent — verify against
  mix.exs before trusting it

**Open / unverified:**
- BraindumpProcessor.process/1 test passes but return value has not been
  manually inspected — we have not confirmed that `raw`, `themes`, `claims`,
  and `summary` are actually populated correctly in practice. Day 6 should
  include a manual verification step (e.g. run process/1 in iex and inspect
  the output).

**Left off at:** BraindumpProcessor.process/1 working and tested. Pipeline
runs end to end: file path in, structured map out. Ready for Day 5 consolidation.

---

### Day 5 ✅
**Goal:** Plan review, product vision, revised sprint (Opus session)
**Completed:**
- Brought in Claude Opus for independent assessment of the sprint plan
- Identified Aider + Qwen ceiling: solid for Levels 3–4, not sufficient for
  Level 6 autonomous workflows. Plan now uses Claude Code for Levels 5–6.
- Removed stale Jido references from sprint outline (Days 8, 12)
- Consolidated Week 2 from 6 days to 5, cut filler (architecture.md for a
  200-line project, Elixir conventions checker skill)
- Added two product gates tied to May 8 deadline and April 5 rehearsal target
- Defined product vision with two modes: Organize (never invent) and Improve
  (opt-in, AI suggestions allowed). Saved as docs/product_vision.md.
- Feature list: braindump ingestion, Socratic questioner, abstract → skeleton,
  redundancy mapper, modular idea store, plus improve mode (TBD)

**Key decisions:**
- Split agent roles: Aider + Qwen for hands-on coding (L3–4), Claude Code
  for orchestration and harness engineering (L5–6)
- "Never invent" is the core product constraint — all features organize the
  user's own words, except explicit improve mode
- Verify.sh moved earlier (Day 9) — simpler than originally scoped
- Test suite split (unit vs integration) deferred until Day 11 when it's needed

**Level assessment:**
- Level 3: ✅ solid — can predict prompt confusion, knows how to fix it
- Level 4: partial — sprint log compounds, but agent environment not yet tested
- Level 5: not yet — no MCP, no external tool access from agents
- Level 6: not yet — no harness, no walk-away test

**Left off at:** Sprint log updated with revised Days 6–16. Product vision
documented. Ready for Day 6 consolidation.

---

### Day 6 ✅
**Goal:** Consolidate + compounding loop

**Completed:**
- Manually verified BraindumpProcessor.process/1 output in iex — confirmed pipeline works end to end
- Iterated on prompt multiple times based on live output inspection
- Dropped summary field — Qwen was inventing content, violating core constraint
- Renamed claims/support → topics/points/details with three-level hierarchy
- Added needs_points flag to surface topics lacking supporting detail
- Defined topic/point/detail in the prompt with clear examples
- Fixed timeout failures — added receive_timeout: 120_000 to LLM call
- Added @tag timeout: 180_000 to integration test to match LLM timeout
- Documented Qwen limitations in AGENTS.md and product_vision.md
- Set up macOS Glass sound notification hook in Claude Code global settings

**Key decisions:**
- Skip code comments for Qwen limitations — docs are the right home, code comments go stale
- "Never invent" remains the product goal; Qwen partial invention is a tolerated limitation, not accepted behavior
- Output shape: %{raw, themes, topics} where topics have points (with details) and needs_points flag

**Lessons learned:**
- recompile() in iex is required to pick up changes compiled in another terminal — without it you are testing old code
- Qwen is non-deterministic — run multiple times before concluding a prompt change helped or hurt
- Qwen invents topic labels despite instructions; this is a model limitation not a prompt problem
- Complex prompts (3-level hierarchy) require receive_timeout: 120_000 or Qwen times out
- ExUnit default timeout (60s) is shorter than our LLM receive_timeout — integration tests need @tag timeout

**Open / carry to Day 7:**
- needs_points always returns false — Qwen not flagging topics that lack points
- Topic labels use Qwen's phrasing, not speaker's verbatim words — revisit with better model
- Compounding test not done — did not open fresh Aider session to compare Day 2 behavior
- progress.md not started
- AGENTS.md cleanup not done

**Left off at:** BraindumpProcessor producing useful topic/point/detail structure.
Prompt iteration paused — output is good enough to work with. All tests passing.
Ready for Day 7.

---

## Open questions
- needs_points flag always false — prompt issue or Qwen limitation?

## Real deadline context
The first real use of talk_prep is the Dutch Clojure Days talk,
May 8, Amsterdam. Talk title: "Clojure as Your First Language:
Shaping a Functional Mindset". This is a 45-minute talk for a
beginner-friendly audience. Details still forthcoming from the
conference. Rehearsal target: April 5. The tool needs to be useful
enough to actually help with this talk before May 8.

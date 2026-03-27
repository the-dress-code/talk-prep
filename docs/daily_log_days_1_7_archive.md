# Daily Log Archive — Days 1-7

These are the daily log entries from Phase 1 (Level 3, context engineering)
and the early part of Phase 2. The lessons and decisions from these days are
now captured in AGENTS.md, progress.md, and docs/framework.md. This file
exists for reference if you need the full narrative.

---

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

### Day 7 ✅
**Goal:** Carry-overs + attempted compounding test

**Completed:**
- Cleaned up AGENTS.md: added output shape, known issues, code notes
- Created progress.md for session bridging
- Attempted compounding test: asked Aider to add a function. Qwen rewrote
  the entire file every time. Initially blamed the model — human pushed back
  ("are you sure it can't do this?"). Root cause: Ollama's default 2048 token
  context was dropping Aider's system prompt. Fixed with custom model
  (qwen2.5-coder-16k, num_ctx 16384) + --edit-format diff. Qwen then
  produced a clean surgical edit.
- After fixing config, Claude Code wrote topics_with_no_points/1 directly
  instead of letting Aider try again. Wrong call — skipped the chance to
  validate the fix and undermined the point of using Aider.
- Ran processor on more complex braindump (~150 lines, mix of talk content and
  meta-conversation). Output was usable — product gate looking achievable.
- Bumped receive_timeout to 300_000 for larger inputs

**Key decisions:**
- Aider launch: `aider --model ollama/qwen2.5-coder-16k --no-auto-commits --edit-format diff`

**Lessons learned:**
- Investigate config before blaming the model
- Claude Code jumped to "Qwen can't do this" after 2 attempts because it
  matched a prior assessment. Human pushback found the real fix.
- Claude Code should not write code that Aider should be writing — defeats
  the purpose of the agentic workflow

**Open / carry to Day 8:**
- Compounding test still needed — got sidetracked by config fix. Need a clean
  test with fixed Aider: does AGENTS.md make the agent better across sessions?
- Decide if Aider + Qwen is still the right tool for code changes now that
  Claude Code is in the picture

**Left off at:** Aider config fixed. Processor working on more complex braindump.
All tests passing. progress.md created. Ready for Day 8.

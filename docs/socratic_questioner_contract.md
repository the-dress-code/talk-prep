# Socratic Questioner — Feature Contract

**Core constraint:** Never invent, only organize. Questions help the user
surface their own knowledge — the questioner never suggests answers.

**MVP scope:** Mode 2 (single claim) first. Mode 1 (pipeline) after Mode 2 works.

## Mode 2 — single claim (MVP)
```
mix socratic --claim "some claim string"
```
Directly questions a specific claim. No detection step needed.

## Mode 1 — pipeline (after MVP)
`mix braindump <file>` processes and prints readable output, then prompts:
"Question any claims? (y/n)". If yes, passes the already-processed map to
the Socratic questioner. No re-processing. Key distinction: supporting
evidence ≠ details — a point can have sub-bullets and still be an unsupported
assertion. Requires a separate LLM call per topic/point to detect unsupported claims.

## Interaction loop
1. User invokes `mix socratic --claim "..."` with a single claim
2. Terminal displays the claim and the first question in readable markdown
3. User answers
4. LLM generates follow-up or pushback based on answer, displayed in readable markdown
5. Repeat until user types `done` or `skip`
6. Move to next claim automatically

Terminal output is formatted markdown throughout the session. JSON is the persistent artifact saved to disk — not what the user reads during the session.

Exit signals:
- `done` — save current claim's Q&A, move to next claim
- `skip` — skip current claim without saving, move to next
- ctrl+c — save completed claims so far, print filename, exit
- empty answer — re-prompt once, then treat as skip

## Output shape per claim
```elixir
%{
  claim: "string",
  exchanges: [%{question: "string", answer: "string"}]
}
```

## Storage
- Location: `sessions/` directory at project root — create it if it doesn't exist
- One JSON file per session, timestamped: `sessions/socratic_YYYY-MM-DDTHH-MM.json`
- All Q&A pairs grouped by claim
- No file written if no claims were completed

## Done criteria
- `mix socratic --claim "..."` questions a claim end to end
- `done` / `skip` / ctrl+c all behave as specified
- Session file saved to `sessions/` with correct JSON structure
- No file written when session produces no completed claims
- `mix compile` and `mix test` pass

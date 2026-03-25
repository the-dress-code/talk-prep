# MCP — When to revisit

Deferred on Day 8. Claude Code's built-in tools already cover the feedback loop
for talk_prep (file I/O, bash, mix run -e, mix compile, mix test).

## What MCP does
Gives Claude Code new tools it doesn't have built-in — connections to databases,
APIs, web UIs, custom internal systems. It extends what the agent can *touch*.

## When to wire one up
When you hit a real capability gap — the agent needs to reach something it can't
get to via the terminal. Likely triggers:

- Excalidraw or visual output (product vision mentions mapping ideas to a board)
- Slide generation or Marp preview
- Interacting with a running web UI (preview MCP server)
- Connecting to external services (Slack, Linear, etc.)

## Not a reason to wire one up
- "The sprint plan says Level 5 requires it" — Level 5 is about the agent gaining
  capabilities, not about MCP specifically. If the capability already exists via
  bash, MCP adds nothing.

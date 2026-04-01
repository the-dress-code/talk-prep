# What is a test stub?

A test stub is a placeholder test that defines expected behavior before any implementation exists. It will always fail until someone builds the thing it describes.

## How it differs from a real test

A real test checks whether working code does the right thing — you write it against an implementation that already exists.

A test stub says "this behavior must exist" before any code is written. It fails by design until the implementation is built.

## Concrete example from Day 11

```elixir
test "returns a non-empty question string for a valid claim" do
  claim = "Vanilla ice cream is best on a hot day"
  question = SocraticQuestioner.build_first_question(claim)
  assert is_binary(question)
  assert String.length(question) > 0
end
```

This test says: given a claim string, `build_first_question` must return a non-empty string. The function doesn't exist yet — it just raises "not implemented." So this test fails right now.

When Day 13's agent writes the implementation, it runs `mix test`, sees this failing, writes the function, runs again. Green means done.

## Why this matters for Level 6

Without stubs, the agent on Day 13 decides for itself what each function should do. With stubs, it has no choice — the tests define the behavior and the agent has to match them. You stepped back from the implementation entirely. That's the harness doing its job.

## How to explain it to someone

"I wrote 9 failing tests before any code existed. Each test describes one specific behavior the feature must have. The agent's job is to write code until all 9 pass. I don't have to review the implementation — if the tests pass, the behavior is correct."

#!/bin/bash
set -e

STRICT=false
for arg in "$@"; do
  if [ "$arg" = "--strict" ]; then
    STRICT=true
  fi
done

echo "==> mix compile"
mix compile --warnings-as-errors

echo ""
echo "==> mix test"
mix test

echo ""
echo "==> mix credo"
if [ "$STRICT" = true ]; then
  mix credo --strict
else
  mix credo || true
fi

echo ""
echo "✓ verify passed"

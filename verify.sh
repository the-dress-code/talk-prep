#!/bin/bash

STRICT=false
for arg in "$@"; do
  if [ "$arg" = "--strict" ]; then
    STRICT=true
  fi
done

echo "==> [OLLAMA]"
if curl -s --max-time 3 http://localhost:11434/api/tags > /dev/null 2>&1; then
  echo "[OLLAMA: PASS]"
else
  echo "[OLLAMA: FAIL — Ollama is not running. Start it with: ollama serve]"
  echo ""
  echo "==> SUMMARY"
  echo "  ollama:  FAIL"
  echo ""
  echo "✗ verify failed"
  exit 1
fi
echo ""

COMPILE_STATUS="PASS"
TEST_STATUS="PASS"
CREDO_STATUS="PASS"

echo "==> [COMPILE]"
if ! mix compile --warnings-as-errors 2>&1; then
  COMPILE_STATUS="FAIL"
fi
echo "[COMPILE: $COMPILE_STATUS]"

echo ""
echo "==> [TEST]"
if ! mix test 2>&1; then
  TEST_STATUS="FAIL"
fi
echo "[TEST: $TEST_STATUS]"

echo ""
echo "==> [CREDO]"
if [ "$STRICT" = true ]; then
  if ! mix credo --strict 2>&1; then
    CREDO_STATUS="FAIL"
  fi
else
  mix credo 2>&1 || true
  CREDO_STATUS="PASS (non-blocking)"
fi
echo "[CREDO: $CREDO_STATUS]"

echo ""
echo "==> SUMMARY"
echo "  compile: $COMPILE_STATUS"
echo "  test:    $TEST_STATUS"
echo "  credo:   $CREDO_STATUS"

if [ "$COMPILE_STATUS" = "FAIL" ] || [ "$TEST_STATUS" = "FAIL" ] || [ "$CREDO_STATUS" = "FAIL" ]; then
  echo ""
  echo "✗ verify failed"
  exit 1
else
  echo ""
  echo "✓ verify passed"
  exit 0
fi

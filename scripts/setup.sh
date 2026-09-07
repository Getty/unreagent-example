#!/usr/bin/env bash
# Sets up the example project: fetch submodule + Node bridge deps.
set -euo pipefail
cd "$(dirname "$0")/.."

echo "==> Initializing submodule (UE LLM Toolkit) …"
git submodule update --init --recursive

BRIDGE="Plugins/ue-llm-toolkit/Plugin/UELLMToolkit/Resources/mcp-bridge"
if [ -d "$BRIDGE" ]; then
  echo "==> npm install in the MCP bridge …"
  ( cd "$BRIDGE" && npm install )
else
  echo "WARN: $BRIDGE not found — was the submodule cloned correctly?"
fi

echo
echo "Done. Next steps:"
echo "  1) Drop unreagent.exe (from the release) into this directory"
echo "  2) UE 5.7 installed? Otherwise set UE_ROOT or create unreagent.local.yaml"
echo "  3) claude on PATH? Otherwise set command in unreagent.local.yaml"
echo "  4) Start unreagent.exe"

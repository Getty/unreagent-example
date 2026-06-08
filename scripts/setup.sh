#!/usr/bin/env bash
# Richtet das Beispielprojekt ein: Submodule holen + Node-Bridge-Deps.
set -euo pipefail
cd "$(dirname "$0")/.."

echo "==> Submodule (UE LLM Toolkit) initialisieren …"
git submodule update --init --recursive

BRIDGE="Plugins/ue-llm-toolkit/Plugin/UELLMToolkit/Resources/mcp-bridge"
if [ -d "$BRIDGE" ]; then
  echo "==> npm install in der MCP-Bridge …"
  ( cd "$BRIDGE" && npm install )
else
  echo "WARN: $BRIDGE nicht gefunden — Submodule korrekt geklont?"
fi

echo
echo "Fertig. Naechste Schritte:"
echo "  1) unreagent.exe (aus dem Release) in dieses Verzeichnis legen"
echo "  2) UE 5.7 installiert? sonst UE_ROOT setzen oder unreagent.local.yaml anlegen"
echo "  3) claude im PATH? sonst command in unreagent.local.yaml setzen"
echo "  4) unreagent.exe starten"

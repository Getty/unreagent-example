# Richtet das Beispielprojekt ein: Submodule holen + Node-Bridge-Deps.
$ErrorActionPreference = "Stop"
Set-Location (Join-Path $PSScriptRoot "..")

Write-Host "==> Submodule (UE LLM Toolkit) initialisieren ..."
git submodule update --init --recursive

$bridge = "Plugins/ue-llm-toolkit/Plugin/UELLMToolkit/Resources/mcp-bridge"
if (Test-Path $bridge) {
    Write-Host "==> npm install in der MCP-Bridge ..."
    Push-Location $bridge
    npm install
    Pop-Location
} else {
    Write-Warning "$bridge nicht gefunden - Submodule korrekt geklont?"
}

Write-Host ""
Write-Host "Fertig. Naechste Schritte:"
Write-Host "  1) unreagent.exe (aus dem Release) in dieses Verzeichnis legen"
Write-Host "  2) UE 5.7 installiert? sonst UE_ROOT setzen oder unreagent.local.yaml anlegen"
Write-Host "  3) claude im PATH? sonst command in unreagent.local.yaml setzen"
Write-Host "  4) unreagent.exe starten"

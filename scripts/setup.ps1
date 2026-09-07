# Sets up the example project: fetch submodule + Node bridge deps.
$ErrorActionPreference = "Stop"
Set-Location (Join-Path $PSScriptRoot "..")

Write-Host "==> Initializing submodule (UE LLM Toolkit) ..."
git submodule update --init --recursive

$bridge = "Plugins/ue-llm-toolkit/Plugin/UELLMToolkit/Resources/mcp-bridge"
if (Test-Path $bridge) {
    Write-Host "==> npm install in the MCP bridge ..."
    Push-Location $bridge
    npm install
    Pop-Location
} else {
    Write-Warning "$bridge not found - was the submodule cloned correctly?"
}

Write-Host ""
Write-Host "Done. Next steps:"
Write-Host "  1) Drop unreagent.exe (from the release) into this directory"
Write-Host "  2) UE 5.7 installed? Otherwise set UE_ROOT or create unreagent.local.yaml"
Write-Host "  3) claude on PATH? Otherwise set command in unreagent.local.yaml"
Write-Host "  4) Start unreagent.exe"

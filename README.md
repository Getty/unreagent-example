# unreagent-example

Beispiel-UE-Projekt für den [**unreagent**](https://github.com/Getty/unreagent)
Launcher. Zeigt das vollständige Konzept verdrahtet:

```
Claude Code ─┬─► unreagent-MCP   (Prozess-Steuerung: start/stop/compile, Logs)
             └─► ue-llm-toolkit  (In-Editor-MCP: Blueprints, Assets, UE-Python)
```

- Der Launcher startet UE und Claude Code, überwacht beide und gibt dem Agenten
  **beide** MCP-Server über `--mcp-config` mit.
- Das In-Editor-Plugin [UE LLM Toolkit](https://github.com/ColtonWilley/ue-llm-toolkit)
  ist als **Git-Submodule** unter `Plugins/ue-llm-toolkit/` eingebunden (nicht
  kopiert — so bleibt es updatebar und lizenzkonform).

## Einrichten

```bash
git clone --recursive https://github.com/Getty/unreagent-example
cd unreagent-example
./scripts/setup.sh          # Windows: powershell -File scripts/setup.ps1
```

Schon geklont ohne `--recursive`? Dann holt `setup` das Submodule nach
(`git submodule update --init --recursive`) und installiert die Node-Bridge-Deps.

Danach:

1. `unreagent.exe` aus dem [Release](https://github.com/Getty/unreagent/releases)
   in dieses Verzeichnis legen.
2. Voraussetzungen: **UE 5.7** (sonst `UE_ROOT` setzen oder `engineRoot` in
   `unreagent.local.yaml`), **Node.js**, und **Claude Code** (`claude` im PATH,
   sonst `agent.command` in `unreagent.local.yaml` setzen).
3. `unreagent.exe` starten.

## Wie das Plugin gefunden wird

Der Upstream legt die `.uplugin` verschachtelt ab
(`Plugin/UELLMToolkit/UELLMToolkit.uplugin`). UE durchsucht `Plugins/` jedoch
**rekursiv**, findet sie also auch im Submodule-Unterordner. Die `unreagent.yaml`
zeigt entsprechend auf den tiefen Bridge-Pfad:

```yaml
mcp:
  extraServers:
    ue-llm-toolkit:
      command: node
      args: ["${PROJECT_DIR}/Plugins/ue-llm-toolkit/Plugin/UELLMToolkit/Resources/mcp-bridge/index.js"]
      env: { UNREAL_MCP_URL: "http://127.0.0.1:3000" }
```

## Lokale Overrides (`unreagent.local.yaml`, git-ignored)

```yaml
engineRoot: "D:/UE/UE_5.7"                 # falls Auto-Detect die Engine nicht findet
agent: { command: "C:/.../claude.cmd" }    # falls claude nicht im PATH
```

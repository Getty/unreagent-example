# unreagent-example

Example UE project for the [**unreagent**](https://github.com/Getty/unreagent)
launcher. Shows the full concept wired up:

```
Claude Code ─┬─► unreagent-MCP   (process control: start/stop/compile, logs)
             └─► ue-llm-toolkit  (in-editor MCP: blueprints, assets, UE Python)
```

- The launcher starts UE and Claude Code, monitors both, and hands the agent
  **both** MCP servers via `--mcp-config`.
- The in-editor plugin [UE LLM Toolkit](https://github.com/ColtonWilley/ue-llm-toolkit)
  is wired in as a **git submodule** under `Plugins/ue-llm-toolkit/` (not
  copied — so it stays updatable and license-compliant).

## Setup

```bash
git clone --recursive https://github.com/Getty/unreagent-example
cd unreagent-example
./scripts/setup.sh          # Windows: powershell -File scripts/setup.ps1
```

Already cloned without `--recursive`? Then `setup` fetches the submodule
(`git submodule update --init --recursive`) and installs the Node bridge deps.

After that:

1. Drop `unreagent.exe` from the [release](https://github.com/Getty/unreagent/releases)
   into this directory.
2. Requirements: **UE 5.7** (otherwise set `UE_ROOT` or `engineRoot` in
   `unreagent.local.yaml`), **Node.js**, and **Claude Code** (`claude` on
   PATH, otherwise set `agent.command` in `unreagent.local.yaml`).
3. Start `unreagent.exe`.

## How the plugin gets found

Upstream nests the `.uplugin` file
(`Plugin/UELLMToolkit/UELLMToolkit.uplugin`). UE scans `Plugins/`
**recursively** though, so it finds it even in the submodule subfolder.
`unreagent.yaml` points to the deep bridge path accordingly:

```yaml
mcp:
  extraServers:
    ue-llm-toolkit:
      command: node
      args: ["${PROJECT_DIR}/Plugins/ue-llm-toolkit/Plugin/UELLMToolkit/Resources/mcp-bridge/index.js"]
      env: { UNREAL_MCP_URL: "http://127.0.0.1:3000" }
```

## Local overrides (`unreagent.local.yaml`, git-ignored)

```yaml
engineRoot: "D:/UE/UE_5.7"                 # if auto-detect can't find the engine
agent: { command: "C:/.../claude.cmd" }    # if claude isn't on PATH
```

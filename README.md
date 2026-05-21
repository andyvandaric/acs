# ACS (Agnostic Config Suites)

Unified installer for the ACS agentic coding stack.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/andyvandaric/acs/main/install.sh | bash
```

```powershell
iex (irm https://raw.githubusercontent.com/andyvandaric/acs/main/install.ps1)
```

## What Gets Installed (Phase 1)

- **9router** — Multi-account routing, RTK compression, auto-fallback
- **Claude Code** — Interactive AI coding TUI with MCP tools
- **Hermes Agent** — Autonomous executor with self-learning skills

## Stack

All tools route through 9router (:20128) for:
- Multi-account rotation
- RTK input compression (20-40% savings)
- Caveman output compression (up to 65% savings)
- 3-tier fallback (subscription → cheap → free)
- Shared MCP servers (context7, exa, grep_app)

## License

MIT

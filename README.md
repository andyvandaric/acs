# ACS — Agnostic Config Suites

Unified installer for the agentic coding stack.

## Install

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/andyvandaric/acs/main/install.sh | bash
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/andyvandaric/acs/main/install.ps1 | iex
```

## What Gets Installed

- **acs-cli** — single binary, all platforms (Windows/macOS/Linux, amd64/arm64)
- After install, run `acs-cli setup` to configure the full stack:
  - 9router (AI model routing)
  - Claude Code CLI (+ plugins + hooks)
  - Hermes Agent (+ profile + automation)
  - Shared skills library

## Requirements

- Git
- Internet connection
- GitHub account with repo access

## After Install

```bash
acs-cli setup      # Configure everything
acs-cli doctor     # Verify installation
acs-cli service start  # Start services
```

## Troubleshooting

Run `acs-cli doctor --fix` to auto-repair common issues.

## License

Proprietary. Access granted per-user via private repository.

# ACS — Agnostic Config Suites

The agentic coding stack that makes AI work for you — not the other way around.

## Why ACS?

**Agent Capability System** — 25+ battle-tested skills that turn any AI coding agent into a senior engineer:

- **Spec-driven development** — features start with specs, not guesswork
- **Architecture blueprints** — multi-file changes planned before execution
- **TDD regression guards** — bugs get caught before they ship
- **Security review** — OWASP top 10 checked on every sensitive change
- **Git workflow orchestration** — parallel agents, atomic commits, clean history
- **Runtime validation** — installers and deploys verified in live environments
- **Self-learning** — agents improve their own skills after every task

Works with Claude Code, Hermes, Kiro, Codex, and any MCP-compatible agent. Tool-agnostic by design.

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
- **25+ agent skills** — architecture, security, TDD, release, marketing, and more
- Auto-registered as persistent service (starts on login)
- After install, run `acs-cli setup` to configure the full stack

## Setup

```bash
# Basic setup (all components)
acs-cli setup

# With Telegram bot + Exa search
acs-cli setup --telegram-token <BOT_TOKEN> --telegram-users <USER_IDS> --exa-key <EXA_KEY>
```

Setup installs and configures:
- 9router (AI model routing + multi-provider fallback)
- Claude Code CLI (+ plugins + hooks)
- Hermes Agent (+ Telegram gateway + automation)
- Agent Capability System (25+ skills, auto-deployed)
- API key auto-generated and registered

## Agent Capability System

Skills activate automatically based on task context. No manual invocation needed.

| Category | Skills |
|----------|--------|
| **Dev Workflow** | spec-writer, architecture-blueprint, code-review, tdd-regression-guard, git-workflow, parallel-orchestration |
| **Security** | security-review (OWASP, secrets, input validation, auth/authz) |
| **Quality** | runtime-validation, markdown-autofix, tooling-bootstrap |
| **Frontend** | frontend-ui-ux (styling, a11y, responsive) |
| **Business** | pitch-deck, funnel-builder, gtm-launch, technical-copy-seo, product-marketing, seo-audit, outbound-sequence, cro-audit, dx-onboarding |

Each skill includes: trigger conditions, step-by-step execution, context requirements, and quality gates.

## Uninstall

### Safe (keep skills, configs, data)

```bash
# macOS / Linux
curl -fsSL https://raw.githubusercontent.com/andyvandaric/acs/main/uninstall.sh | bash

# Windows
irm https://raw.githubusercontent.com/andyvandaric/acs/main/uninstall.ps1 | iex
```

Or via binary:
```bash
acs-cli uninstall
```

### Full Purge (remove everything)

```bash
# macOS / Linux
curl -fsSL https://raw.githubusercontent.com/andyvandaric/acs/main/uninstall.sh | bash -s -- --purge

# Windows
powershell -Command "& { irm https://raw.githubusercontent.com/andyvandaric/acs/main/uninstall.ps1 | iex } -Purge"
```

Or via binary:
```bash
acs-cli uninstall --purge
```

### What Gets Removed?

| Item | Safe | Purge |
|------|:----:|:-----:|
| Service + automation | ✓ | ✓ |
| Hooks + cron scripts | ✓ | ✓ |
| Skills | — | ✓ |
| Configs (Hermes, Claude) | — | ✓ |
| Kanban DB (backed up first) | — | ✓ |
| Binary + PATH | — | ✓ |

> Note: 9router and Hermes are NOT removed by ACS uninstaller.

## Requirements

- Git
- Internet connection
- GitHub account with repo access (private repository)

## After Install

```bash
acs-cli setup          # Configure everything
acs-cli doctor         # Verify installation
acs-cli service start  # Start background service
```

## Troubleshooting

```bash
acs-cli doctor --fix   # Auto-repair common issues
```

## License

Proprietary. Access granted per-user via private repository.

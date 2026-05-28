# ACS — Agnostic Config Suites

> **🌐 Language:** [English](README.md) | [Bahasa Indonesia](README.id.md)

The agentic coding stack that makes AI work for you — not the other way around.

---

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

---

## Latest Release

- ACS CLI: `0.16.0`
- Changelog: [CHANGELOG.md](CHANGELOG.md)

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

## Setup

```bash
# Basic setup
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

### Full Purge (remove everything)

```bash
# macOS / Linux
curl -fsSL https://raw.githubusercontent.com/andyvandaric/acs/main/uninstall.sh | bash -s -- --purge

# Windows
powershell -Command "& { irm https://raw.githubusercontent.com/andyvandaric/acs/main/uninstall.ps1 | iex } -Purge"
```

| Item | Safe | Purge |
|------|:----:|:-----:|
| Service + automation | ✓ | ✓ |
| Hooks + cron scripts | ✓ | ✓ |
| Skills | — | ✓ |
| Configs (Hermes, Claude) | — | ✓ |
| Kanban DB (backed up first) | — | ✓ |
| Binary + PATH | — | ✓ |

## Requirements

- Git
- Internet connection
- GitHub account with private repo access

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

---

## Don't have access yet?

ACS is distributed via private repository. Each buyer gets collaborator access.

<p align="center">
  <a href="https://wa.me/6281289731212?text=Mau%20order%20ACS%20nya%2C%20mohon%20infonya%20ya">
    <img src="https://img.shields.io/badge/Get%20Access-WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white" alt="Get Access via WhatsApp">
  </a>
</p>

<p align="center">
  <em>One-time purchase. Lifetime updates. No subscription.</em>
</p>

---

## License

Proprietary. Access granted per-user via private repository.

# ACS — Agnostic Config Suites

> **🌐 Language:** [English](README.md) | [Bahasa Indonesia](README.id.md)

The agentic coding stack that makes AI work for you — not the other way around.

---

## Why ACS?

**Agent Capability System** — a single binary that turns any AI coding agent into a full engineering team:

- **Multi-model routing** — 9router proxy connects all providers (OpenAI, Anthropic, Google, local) through one endpoint, auto-fallback when a provider goes down
- **Agent gateway** — deploy AI agents to Telegram, run 24/7, receive tasks from chat anytime
- **Self-healing infrastructure** — watchdog auto-restarts crashed services, gateway respawn, stale lock detection, 9router backoff recovery
- **Reactive dashboard** — Tide-powered UI with instant cache hydration, skeleton loading, WebSocket live updates, and prefetch on hover
- **30+ battle-tested skills** — spec writing, architecture, TDD, security review, git workflow — all activate automatically based on context
- **Codex multi-auth** — manage multiple AI accounts, switch contexts seamlessly
- **Sync & snapshots** — pre-sync backup, snapshot browser, quick undo, overlap detection with progress streaming
- **Auto-update** — binary updates automatically with realtime progress bar, SHA-256 verification, zero downtime, rollback on failure
- **Zero config routing** — set up once, all agents (Claude Code, Hermes, Kiro, Codex) connect to the same model pool

Works with Claude Code, Hermes, Kiro, Codex, and any MCP-compatible agent. Tool-agnostic by design.

---

## Install

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/andyvandaric/acs/main/install.sh | bash
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/andyvandaric/acs/main/install.ps1 | iex
```

The installer automatically:
- Detects your platform (Windows/macOS/Linux, amd64/arm64)
- Downloads the binary from the private repo via GitHub auth
- Verifies SHA-256 integrity
- Installs to `~/.acs/bin/`
- Registers as a persistent service (auto-start on login)

## What Gets Installed

- **acs-cli** — single binary, all platforms, all features
- **9router** — LLM proxy with multi-provider routing, combo fallback, PID management, and health checks
- **30+ agent skills** — architecture, security, TDD, release, marketing, and more
- **Web dashboard** — Tide-powered monitoring + management UI (port 20130)
- **Scheduler** — background tasks: health checks, auto-update, gateway monitoring, respawn
- **Gateway manager** — deploy agents to Telegram in seconds, self-healing with auto-restart

## Setup

```bash
# Full setup (all components)
acs-cli setup

# With WezTerm terminal (Windows, recommended)
acs-cli setup --wezterm

# With Telegram bot (optional)
acs-cli setup --telegram-token <BOT_TOKEN> --telegram-users <USER_IDS>
```

The `--wezterm` flag installs WezTerm as your dedicated standalone terminal (Windows only):
- Installs via winget
- Creates Desktop shortcut (launches directly, no intermediate shell)
- Adds right-click "Open in WezTerm" context menu
- Generates config with auto-detected shell (pwsh or powershell)

Setup is **idempotent** — safe to run multiple times. What it configures:

| Step | Function |
|------|----------|
| prerequisites | Check & install tools (git, bun, python) |
| 9router | Install LLM proxy + seed model database + generate API key |
| claude-code | Deploy config + MCP servers + hooks |
| hermes-agent | Deploy profiles + SOUL + automation |
| gateway | Set up Telegram bot gateway (if token provided) |
| shared-skills | Deploy 30+ agent skills |
| mcp-servers | Configure MCP tool servers |
| automation | Deploy hooks + scheduled tasks |
| tooling-deps | Validate and auto-fix tooling dependencies |
| git-credential | Provision .gitconfig per Hermes profile |

## Stack Architecture

```
┌─────────────────────────────────────────────────────┐
│                   ACS CLI (single binary)            │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ┌──────────┐  ┌──────────┐  ┌──────────────────┐  │
│  │ 9router  │  │ Gateway  │  │    Dashboard     │  │
│  │ :20128   │  │ Manager  │  │     :20130       │  │
│  └────┬─────┘  └────┬─────┘  └────────┬─────────┘  │
│       │              │                 │            │
│  Multi-model    Telegram bot      Tide reactive     │
│  routing +      deploy +          UI + WebSocket    │
│  fallback       self-heal         live updates      │
│                                                     │
│  ┌──────────┐  ┌──────────┐  ┌──────────────────┐  │
│  │Scheduler │  │  Skills  │  │   Auto-Update    │  │
│  │(watchdog) │  │  (30+)   │  │  (realtime bar)  │  │
│  └──────────┘  └──────────┘  └──────────────────┘  │
│                                                     │
│  ┌──────────┐  ┌──────────┐  ┌──────────────────┐  │
│  │  Sync    │  │  Kanban  │  │   Multi-Auth     │  │
│  │(snapshots)│  │  Board   │  │   (Codex/Claude) │  │
│  └──────────┘  └──────────┘  └──────────────────┘  │
│                                                     │
└─────────────────────────────────────────────────────┘
         ↕                ↕                ↕
   OpenAI / Anthropic   Telegram      Claude Code
   Google / Local       Bot API       Hermes / Kiro
```

## Agent Capability System

Skills activate automatically based on task context. No manual invocation needed.

| Category | Skills |
|----------|--------|
| **Dev Workflow** | spec-writer, architecture-blueprint, code-review, tdd-regression-guard, git-workflow, parallel-orchestration |
| **Security** | security-review (OWASP, secrets, input validation, auth/authz) |
| **Quality** | runtime-validation, markdown-autofix, tooling-bootstrap, investigation-protocol |
| **Frontend** | frontend-ui-ux (styling, a11y, responsive, dark/light mode) |
| **Business** | pitch-deck, funnel-builder, gtm-launch, technical-copy-seo, product-marketing, seo-audit, outbound-sequence, cro-audit, dx-onboarding |

Each skill includes: trigger conditions, step-by-step execution, context requirements, and quality gates.

## Dashboard

```bash
acs-cli service start    # Start everything (9router + gateway + dashboard + scheduler)
```

Open `http://localhost:20130` — dashboard features:

- **Command Center** — summary cards, announcements, experimental feature banners
- **Stack Manager** — start/stop/restart individual services with auto-start config
- **Gateway Manager** — start/stop/create/delete agent gateways, real-time status, self-heal indicators
- **Model Routing** — view active combos, provider status, usage metrics
- **Health Monitor** — warning system for duplicate tokens, stale locks, process issues
- **Sync & Snapshots** — browse config snapshots, restore previous state, quick undo
- **Scheduler** — view background tasks, gateway respawn status, update checks
- **Settings** — API keys, preferences, theme (dark/light)

Responsive layout: 2-col mobile, 3-col tablet, 4-col desktop. Full mobile support with swipe pagination and auto-hide sidebar.

## Gateway: AI Agent via Telegram

Deploy an agent you can chat with 24/7:

```bash
# Create a new gateway
acs-cli gateway create --name my-agent --telegram-token <TOKEN> --allowed-users <USER_ID>

# Start it
acs-cli gateway start my-agent

# List all gateways
acs-cli gateway list
```

Each gateway = 1 Telegram bot = 1 AI agent with its own personality and skills.

Self-healing: if a gateway dies, the scheduler detects it and restarts automatically. Telegram notification on auto-heal.

## Auto-Update

ACS CLI checks for updates automatically every 6 hours. For manual updates:

```bash
acs-cli update
```

Update flow: download new binary → realtime progress bar → verify SHA-256 → swap binary → restart service. Zero downtime.

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
| Database + logs | — | ✓ |
| Binary + PATH | — | ✓ |

## Requirements

- Git
- Internet connection
- GitHub account with private repo access (granted after purchase)

## After Install

```bash
acs-cli setup          # Configure all components
acs-cli doctor         # Verify installation
acs-cli service start  # Start background service
```

Open dashboard: `http://localhost:20130`

## Troubleshooting

```bash
acs-cli doctor         # Diagnose issues
acs-cli doctor --fix   # Auto-repair common problems
```

---

## Don't have access yet?

ACS is distributed via private repository. Every buyer gets collaborator access + lifetime updates.

<p align="center">
  <a href="https://wa.me/6281289731212?text=I%20want%20to%20order%20ACS%2C%20please%20send%20me%20the%20details">
    <img src="https://img.shields.io/badge/Order%20Now-WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white" alt="Order via WhatsApp">
  </a>
</p>

<p align="center">
  <em>One-time payment. Lifetime updates. No subscription.</em>
</p>

---

## License

Proprietary. Access granted per-user via private repository.

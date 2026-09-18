# ACS: Agnostic Config Suites
*(The Local Sovereign Operating System & Control Cockpit for Autonomous AI Agents)*

<div align="center">
<img src="https://dl.uikode.com/logo.svg" width="160" alt="ACS Logo">

![ACS](https://img.shields.io/badge/ACS-Agnostic_Config_Suites-blue?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.12.0-orange?style=for-the-badge)
![License](https://img.shields.io/badge/License-Proprietary-red.svg?style=for-the-badge)
![Status](https://img.shields.io/badge/Stack-Production_Ready-brightgreen?style=for-the-badge)

**Stop burning tokens. Stop freezing terminals. Take back sovereign control.**<br>
*(Berhenti membakar token. Berhenti mengalami terminal freeze. Ambil kembali kendali berdaulat.)*

[English](#english) | [Bahasa Indonesia](README.id.md)
</div>

---

<a id="english"></a>
## 🇺🇸 English

### 📖 About
**The AI Coding Revolution Needs a Sovereign Foundation**

You run AI coding agents to ship world-class software, not to waste hours untangling fragile JSON configurations or watching your context window vanish into thin air before writing line 1.

**Agnostic Config Suites (ACS)** is a high-performance, single-tenant **Local Sovereign Operating System** written in Go. It turns unpredictable, fragile AI coding assistants into an unbreakable, deterministic, cost-optimized engineering powerhouse.

---

### 📦 Installation

Install the unified `acs` binary directly via Sovereign CDN:

**Windows** (PowerShell Administrator):
```powershell
irm https://dl.uikode.com/install.ps1 | iex
```

**Linux / macOS** (Bash / Zsh):
```bash
curl -fsSL https://dl.uikode.com/install.sh | bash
```

*(Failover mirrors are hosted across GitHub Releases and UIKode Edge infrastructure).*

---

### ⚡ Quick Start & License Activation

ACS is protected by a proprietary enterprise license. Upon installation, activate your workstation in seconds:

1. **Activate License**:
   ```bash
   # Direct terminal activation
   acs activate <your-license-key>

   # Or log in via authorized GitHub OAuth account
   acs login
   ```

2. **Initialize Workspace & Verify System Health**:
   ```bash
   # Automatic environment setup, MCP configuration & rule synchronization
   acs setup

   # Run 16-point prerequisite diagnosis and auto-repair
   acs doctor --fix
   ```

3. **Start the Stack & Local Cockpit**:
   ```bash
   acs start
   ```
   *Dashboard cockpit immediately launches at `http://127.0.0.1:20130`.*

---

### 🛡️ Enterprise Protection & Local Sovereignty

- **Gated License Lifecycle**: Seamless offline license verification with cryptographic HMAC caching. No internet required for routine daily runs once activated.
- **Single-Tenant Data Isolation**: 100% of your telemetry, SQLite WAL databases, prompt logs, and configurations reside exclusively on your local workstation (`~/.acs/`). Zero cloud data leakage.
- **Zero Console Window / Non-Blocking Execution**: Native Win32 `CREATE_NO_WINDOW` and detached process isolation guarantee that background daemons, watchdogs, and tool wrappers never interrupt your desktop with flashing console windows.
- **Independent Non-Tree-Kill Process Isolation**: ACS dashboard operations run completely isolated from underlying proxies like 9router (`:20128`). Stopping or restarting ACS never interrupts active agent traffic.

---

### 💻 Modern CLI Command Reference

All operations are unified under the modern `acs` command:

#### Core Lifecycle
| Command | Description |
|---|---|
| `acs activate <key>` | Activate official commercial license key on workstation |
| `acs login` | Authenticate and claim license via GitHub OAuth browser flow |
| `acs status` | Display real-time service health, ports, and license validity |
| `acs start` | Start ACS background daemons and local Web Cockpit (`:20130`) |
| `acs stop` | Gracefully shut down ACS services (preserves 9router proxy) |
| `acs restart` | Perform zero-downtime hot restart of ACS services |
| `acs doctor [--fix]` | Run 16-point environment diagnosis with self-healing repairs |
| `acs update` | Check and install latest version from Sovereign CDN |
| `acs lang [id\|en]` | Switch CLI language between Indonesian and English |
| `acs uninstall` | Cleanly remove ACS, services, and associated path links |

#### Service & Infrastructure
| Command | Description |
|---|---|
| `acs service [start\|stop\|status]` | Manage OS background daemon (systemd / Windows Task Scheduler) |
| `acs dashboard` | Dashboard Web UI manager and direct browser launcher (`:20130`) |
| `acs scheduler` | Autonomous background task scheduler & auto-heal watchdog |
| `acs gateway` | Manage multi-account AI gateways (Kiro, Antigravity, etc.) |
| `acs router` | Control 9router multi-provider load-balancing proxy (`:20128`) |
| `acs setup` | Re-initialize workspace environments, templates, and agent rules |

#### Agentic Ecosystem & MCP
| Command | Description |
|---|---|
| `acs kanban` | Local visual task management and PRD Blueprint tracker |
| `acs mcp [list\|add\|remove]` | Manage Model Context Protocol (MCP) servers and tools |
| `acs accounts` | Manage KeyPool provider accounts and sticky quota allocations |
| `acs articles` | Query offline synthesized research and knowledge base |
| `acs sessions` | Inspect and manage active agent execution sessions |
| `acs logs [service\|daemon\|9router]` | Tail real-time aggregated service logs without truncation |

---

### ✨ Architectural Pillars

1. **Native Model Context Protocol (MCP)**: Zero-friction integration with filesystem, browser automation (CloakBrowser), code intelligence (LSP AST), and live web research tools.
2. **Zero-Idle-Token Architecture**: Dynamic skill injection cuts baseline token consumption by up to 89%, freeing massive reasoning headroom for actual code generation.
3. **Anti-Freeze Smart Circuit Breakers**: Flapping detection and cold-boot grace periods guarantee continuous uptime even during intermittent upstream network hiccups.
4. **Autonomous EDF Smart Quota Relay**: Earliest Deadline First (EDF) scheduler prioritizes expiring AI provider quotas to maximize usage value.
5. **Universal Project Auto-Discovery**: Automatically recognizes existing Claude Code CLI workspaces and surfaces active PRD blueprints in the Kanban cockpit.

---

<div align="center">
<b>Built with pride for high-velocity software engineers.</b><br>
Official Distribution & Sovereign CDN: <a href="https://dl.uikode.com">https://dl.uikode.com</a>
</div>

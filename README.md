# ACS: Agnostic Config Suites
*(The Local Sovereign Operating System & Control Cockpit for Autonomous AI Agents)*

<div align="center">
<img src="https://dl.uikode.com/logo.svg" width="160" alt="ACS Logo">

![ACS](https://img.shields.io/badge/ACS-Agnostic_Config_Suites-blue?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.29.0-orange?style=for-the-badge)
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

You run AI coding agents to ship world-class software, not to waste hours untangling fragile configurations or watching your context window vanish before writing line 1.

**Agnostic Config Suites (ACS)** is a high-performance **Local Sovereign Operating System**. It turns unpredictable AI coding assistants into an unbreakable, deterministic, cost-optimized engineering powerhouse.

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

---

### ⚡ Quick Start & License Activation

ACS is protected by a proprietary commercial license:

1. **Activate License**:
   ```bash
   # Direct terminal activation
   acs activate <your-license-key>

   # Or log in via authorized GitHub account
   acs login
   ```

2. **Initialize Workspace & Verify System Health**:
   ```bash
   # Setup workspace, tools & rules
   acs setup

   # Run health checks and auto-repair
   acs doctor --fix
   ```

3. **Start the Stack & Local Cockpit**:
   ```bash
   acs start
   ```
   *Dashboard cockpit launches at `http://127.0.0.1:20130`.*

---

### 🛡️ Enterprise Privacy & Local Sovereignty

- **Commercial License Protection**: Valid license required for operation. Seamless validation designed for enterprise privacy and offline stability.
- **Local Data Sovereignty**: All prompt histories, project metrics, and configurations stay 100% on your local machine. Zero external data sharing.
- **Silent Background Operation**: Services and background tools run completely in the background without intrusive terminal popups or desktop interruptions.
- **Resilient Service Architecture**: Dashboard and proxy services run with independent lifecycles to ensure continuous uptime during maintenance.

---

### 💻 Modern CLI Command Reference

All operations are unified under the modern `acs` command:

#### Core Operations
| Command | Description |
|---|---|
| `acs activate <key>` | Activate commercial license key on workstation |
| `acs login` | Authenticate and claim license via GitHub OAuth |
| `acs status` | Display service health, ports, and license validity |
| `acs start` | Start ACS background services and local Cockpit (`:20130`) |
| `acs stop` | Gracefully shut down ACS services |
| `acs restart` | Perform zero-downtime hot restart of ACS services |
| `acs doctor [--fix]` | Run environment diagnosis with self-healing repairs |
| `acs update` | Check and install latest version from Sovereign CDN |
| `acs lang [id\|en]` | Switch CLI language between Indonesian and English |
| `acs uninstall` | Cleanly remove ACS, services, and associated path links |
| `acs env [info\|check]` | Inspect toolchain environment, paths, and isolated devtools audit |

#### Service & Infrastructure
| Command | Description |
|---|---|
| `acs service [start\|stop\|status]` | Manage OS background service |
| `acs dashboard` | Dashboard Web UI manager (`:20130`) |
| `acs scheduler` | Autonomous task scheduler & auto-heal watchdog |
| `acs gateway` | Manage multi-account AI gateways |
| `acs router` | Control multi-provider load-balancing proxy |
| `acs setup` | Re-initialize workspace environments and agent rules |

#### Agentic Ecosystem & Tools
| Command | Description |
|---|---|
| `acs kanban` | Local visual task management and PRD Blueprint tracker |
| `acs mcp [list\|add\|remove\|serve]` | Manage Model Context Protocol (MCP) servers and tools |
| `acs accounts` | Manage provider accounts and quota allocations |
| `acs articles` | Query offline synthesized research and knowledge base |
| `acs sessions` | Inspect and manage active agent execution sessions |
| `acs logs` | Tail real-time service logs |
| `acs bug-hunter` | Standalone autonomous bug hunter agent and security auditor |
| `acs rules compile-roles` | Compile Gonja Jinja2 role templates into unified agent rules |
| `acs memory [status\|prune]` | Inspect synaptic memory status and prune evicted or expired records |

---

### ✨ Architectural Pillars

1. **Native Model Context Protocol (MCP)**: Zero-friction integration with filesystem, browser automation, code intelligence, and research tools via 27 consolidated core tools and stdio JSON-RPC 2.0 server harness.
2. **Zero-Idle-Token Architecture**: Dynamic skill injection cuts baseline token consumption by up to 89%, freeing reasoning headroom for actual code generation.
3. **Anti-Freeze Smart Circuit Breakers**: Flapping detection and cold-boot grace periods guarantee continuous uptime.
4. **Autonomous Quota Relay (EDF)**: Smart scheduler prioritizes expiring AI provider quotas to maximize usage efficiency.
5. **Universal Project Auto-Discovery**: Automatically recognizes existing workspaces and surfaces active PRD blueprints in the Kanban cockpit.
6. **Interactive Kanban & Visual Governance**: Direct card URL resolver, interactive pan-zoom Mermaid diagram engine, commit inspection, dual verification badges, and multi-
7. **SessionBus Sovereign Orchestration**: Single active CEO per project with claim API, CEO register gates, 23 persona roster with on-demand spawn, PM-only discovery, and decision queue escalation.
8. **Virtual Office Command Deck**: Org structure tree, persona catalog grid with dossier modal, multi-persona chat dock, workspace selector, terminal modal, and 3D desk matrix.
9. **Expanded Core Tooling**: 37 Go-native MCP tools with kanban_summary and memory_summary, LSP handlers, response clamp ceilings, and offline fallback.
10. **Memory Sovereign Pipeline**: Unified ingestion with tiered dedupe and contradiction engine, handoff helpers, and physical markdown unwire.
11. **HookEngine Permission Governance**: In-memory permission cache with persistence, ancestry detection, dangerously-skip-permissions banner, and kanban reconciler.
12. **CLI Sovereign Expansion**: acs sessionbus register, org whois, kanban summary/create/card/artifacts, memory status summary alias, and persona slash commands.
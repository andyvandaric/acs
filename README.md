# ACS: Agnostic Config Suites
*(The Local Sovereign Operating System & Control Cockpit for Autonomous AI Agents)*

<div align="center">
<img src="https://dl.uikode.com/logo.svg" width="160" alt="ACS Logo">

![ACS](https://img.shields.io/badge/ACS-Agnostic_Config_Suites-blue?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.35.0-orange?style=for-the-badge)
![License](https://img.shields.io/badge/License-Proprietary-red.svg?style=for-the-badge)
![Status](https://img.shields.io/badge/Stack-Production_Ready-brightgreen?style=for-the-badge)
[![Website](https://img.shields.io/badge/Official_Website-uikode.com%2Facs-6366f1?style=for-the-badge&logo=googlechrome&logoColor=white)](https://uikode.com/acs)

**Stop burning tokens. Stop freezing terminals. Take back sovereign control.**<br>
*(Berhenti membakar token. Berhenti mengalami terminal freeze. Ambil kembali kendali berdaulat.)*

[English](#english) | [Bahasa Indonesia](README.id.md)

🌐 **Official Website & Commercial Portal:** [uikode.com/acs](https://uikode.com/acs)
</div>

---

<a id="english"></a>
## 🇺🇸 English

### 📖 About
**The AI Coding Revolution Needs a Sovereign Foundation**

You run AI coding agents to ship world-class software, not to waste hours untangling fragile configurations or watching your context window vanish before writing line 1.

**Agnostic Config Suites (ACS)** is a high-performance **Local Sovereign Operating System**. It turns unpredictable AI coding assistants into an unbreakable, deterministic, cost-optimized engineering powerhouse.

Learn more on the [Official Product Website](https://uikode.com/acs) — [ACS Core](https://uikode.com/acs) unifies CLI, dashboard cockpit, and multi-agent swarm in one sovereign binary.

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

ACS is protected by a proprietary commercial license. Purchase and manage licenses at the [Commercial License Portal](https://uikode.com/acs):

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
| `acs adopt` | Fastest repository adoption with AI profiler, guardrails, and animated GUI |
| `acs bug-hunter` | Standalone autonomous bug hunter agent and security auditor |
| `acs rules compile-roles` | Compile Gonja Jinja2 role templates into unified agent rules |
| `acs memory [status\|prune]` | Inspect synaptic memory status and prune evicted or expired records |

---

### ✨ Architectural Pillars

1. **Native Model Context Protocol (MCP)**: Zero-friction integration with filesystem, browser automation, code intelligence, and research tools via 45 Built-In Core Stdio MCP Tools + 80 CloakBrowser Stealth Sub-Tools over a stdio JSON-RPC 2.0 server harness.
2. **Zero-Idle-Token Architecture**: Dynamic skill injection cuts baseline token consumption by up to 89%, freeing reasoning headroom for actual code generation.
3. **Anti-Freeze Smart Circuit Breakers**: Flapping detection and cold-boot grace periods guarantee continuous uptime.
4. **Autonomous Quota Relay (EDF)**: Smart scheduler prioritizes expiring AI provider quotas to maximize usage efficiency.
5. **Universal Project Auto-Discovery**: Automatically recognizes existing workspaces and surfaces active PRD blueprints in the Kanban cockpit. Run `acs adopt` for the fastest repository adoption with AI profiler and guardrails.
6. **Interactive Kanban & Visual Governance**: Direct card URL resolver, interactive pan-zoom Mermaid diagram engine, commit inspection, dual verification badges, and multi-wave execution tracking.
7. **Anke Command Center & Sovereign Session Bus**: Centralized orchestrator gateway with Anke CEO persona contracts, dual-dispatcher sinks, in-place PTY modal workspaces, and unified `acs:core` namespace management. Powered by 28 Role Personas based on Jinja2 SSOT (CEO Anke, Architect, Executor, Verifier, Bug Hunter, and more) with strict tool masking.
8. **Autonomous Dispatch DAG & Security Attestation**: Watchdog-driven DAG unblocker, strict verifier-stamp gates, fail-closed card claims, SLSA provenance tracking, and Sigstore-backed integrity defenses.
9. **Sovereign Second Brain**: Sub-10ms Contentless Trigram Code Search (<0.5% disk, zero API vector cost) paired with a SQLite FTS5 Memory Engine for instant recall of decisions and milestones.
10. **Windows Zero-Console Flash Invariant**: All subprocesses run fully hidden via `internal/executil` (`CREATE_NO_WINDOW | DETACHED_PROCESS`) plus Win32 API `SW_HIDE` — no terminal popups, ever.
11. **SolidJS Web Dashboard**: 22-route local cockpit with 4-Tab Kanban SSOT and Virtual Office (Anke Chat bi-directional IPC full-duplex via SSE) at `http://127.0.0.1:20130`.

---

<div align="center">
<b>Built for high-velocity software engineers.</b><br>
🌐 Official Website & Commercial Portal: <a href="https://uikode.com/acs">https://uikode.com/acs</a><br>
Purchase and manage your license on [ACS Core](https://uikode.com/acs) via the [Official Product Website](https://uikode.com/acs).
</div>
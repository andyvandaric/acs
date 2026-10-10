# ACS: Agnostic Config Suites
*(The Local Sovereign Operating System & Control Cockpit for Autonomous AI Agents)*

<div align="center">
<img src="https://dl.uikode.com/logo.svg" width="160" alt="ACS Logo">

![ACS](https://img.shields.io/badge/ACS-Agnostic_Config_Suites-blue?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.32.0-orange?style=for-the-badge)
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
7. **Sovereign Kanban Lifecycle & Provenance Governance (v1.32.0)**: phase-tagged commits with checklist auto-tick, canonical blueprint-path matching with claimable duplicate gate, auto-claim on executor approved gate, provenance audit trail with hash, presence binding with live-window helpers, persona badges and modal provenance panel, dynamic phase badge/filter bar, FTS reader, reconciler single-write sync path with broadcast emit, subagent correlator and git auto-associate, legit promoter evaluator/sweep tick/counters, 45-tool stdio MCP parity.
8. **SessionBus Deterministic Identity & Resilience (v1.32.0)**: centralized TTL constants, ResolveSessionID helper with env-before-pid fallback, 120s sweeper task, ReapExpiredCEOs demotion, deregister + lock release on session end, deterministic PM discovery/claiming engine, list/claim subcommands with auto-claim on CEO activation, recipient column + bidirectional chat history, relaxed discovery filters with unified acs project slug normalization.
9. **Feedback Turnstile Shield & Hub (v1.32.0)**: turnstile bot shield with migrations 36-39 and anti-spam gate, remote forwarder with retry engine, anti-cycle flusher task with 120s wire-up, frontend widget with live sync badges + sync-now action, manual sync endpoint with async flush, E2E turnstile sync suite, dedicated hub page with webp compression & rate limiting, local queue + submission route.
10. **Chat Gateway & Virtual Office Bridge (v1.32.0)**: Telegram webhook secret-token gate, inbound types + command parser, chat gateway service with security gating + nonce pairing, webhook/nonce/topic routing endpoints, public inbound auth exemption, dual dispatcher + command handlers, JSONL transcript parser/watcher/tailer, skill extraction pipeline, task queue with adaptive concurrency, headless runner with worktree isolation, session state manager with resume/memory reconciler, ThreeJS force-graph foundation, realtime pulses + memory broadcast, chat dock clear/SSE resilience/roster, Telegram setup wizard + forum topic mapper, gateways lazy route + sidebar item, 3D second brain hologram + tide ws graph.
11. **Containerized Browser E2E Pipeline & Fast-Track Release (v1.32.0)**: fast-track CDN release matching sites/uikode standard, Gate 6b runner definition + registration + verification flag, headless multi-route assertion engine, Podman Linux runner, in-container Playwright sweep, cross-OS justfile recipes, per-product deploy isolation, per-prefix acs/vpsease mirror + cdn-rollback, PRODUCT-param bash/PowerShell installers.
12. **Low-Core Adaptive Daemon & Hook Fastpath (v1.32.0)**: CPU-aware scheduler concurrency with staggered boot jitter, relaxed hot-poller intervals, 15s low-core deadlock sweeper cutoff, WAL mtime fastpath + dispatcher throttle, cold-boot grace + circuit breaker with DashboardCreationTime helper, in-process POST /api/hooks/exec, DaemonClient ExecHook fail-open probe, CLI IPC fastpath switch, antigravity toggle awareness + proxy sync, triple-track autostart with watchdog cold-boot recovery.
13. **Blueprint SSOT & Manager Guardrails (v1.32.0)**: frontmatter SSOT contract + parser with markdown fallback, unique blueprint per project, read-only approval check + CLI writer, blueprint_path tool contract, canonical normalizer + resilient gate lookup with expanded regex, kanban lifecycle state machine + auto-transition hooks + shims + e2e harness, realtime auto-sync + in-process commit attach, flexible time scanner with sqlite resilience, manager role guard with zero direct coding, Jinja2 SSOT roles with tool masking, calibrated prd-workflow-gate anti-bypass, zero-second reflex matrix with shell inspection guard, windows shell invariants across 25 personas.
14. **Sovereign Runtime Hardening (v1.32.0)**: resilient PATH persistence + dual-track autostart, cross-OS cascading claude resolver, 7-tier WD inheritance cascade, detached ConPTY supervisor with background drain + replay, 64kb circular replay ring, 4h persistent idle timeout with client caching, claude slug decoder with greedy tree walk, synaptic prompt hook engine + phase snapshot hook, strict blacklist filter + vacuum compaction, prune-code CLI with dynamic project-matching guard, orchestrator watchdog sync, durable license status gating (Wave A/B), persona deploy dispatch, mcpacs binary-search clamping, AnkeChatDock history rehydration + identity normalization, marketing backlink/directory network, license identity binding + experimental banner/modal upgrades.
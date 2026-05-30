# ACS — Agnostic Config Suites

> **🌐 Bahasa:** [English](README.md) | [Bahasa Indonesia](README.id.md)

Stack agentic coding yang bikin AI kerja buat kamu — bukan sebaliknya.

---

## Kenapa ACS?

**Agent Capability System** — single binary yang mengubah AI coding agent manapun jadi tim engineering lengkap:

- **Multi-model routing** — 9router proxy menghubungkan semua provider (OpenAI, Anthropic, Google, local) dalam satu endpoint, auto-fallback kalau satu provider down
- **Agent gateway** — deploy AI agent ke Telegram, jalankan 24/7, terima task dari chat kapanpun
- **30+ battle-tested skills** — spec writing, architecture, TDD, security review, git workflow — semua otomatis aktif sesuai konteks
- **Web dashboard** — monitor semua agent, gateway, model usage, health status dari browser
- **Self-healing** — auto-detect stale processes, restart crashed gateways, sweep dead locks
- **Auto-update** — binary update otomatis tanpa downtime, rollback kalau gagal
- **Zero config routing** — setup sekali, semua agent (Claude Code, Hermes, Kiro, Codex) langsung konek ke model pool yang sama

Kompatibel dengan Claude Code, Hermes, Kiro, Codex, dan agent MCP-compatible lainnya. Tool-agnostic by design.

---

## Release Terbaru

- ACS CLI: `0.18.0`
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

Installer otomatis:
- Deteksi platform (Windows/macOS/Linux, amd64/arm64)
- Download binary (~33MB) dari private repo via GitHub auth
- Verifikasi SHA-256
- Install ke `~/.acs/bin/`
- Register sebagai persistent service (auto-start saat login)

## Yang Terinstall

- **acs-cli** — single binary, semua platform, semua fitur
- **9router** — LLM proxy dengan multi-provider routing + combo fallback
- **30+ agent skills** — architecture, security, TDD, release, marketing, dan lainnya
- **Web dashboard** — monitoring + management UI (port 20130)
- **Scheduler** — background tasks: health check, auto-update, gateway monitoring
- **Gateway manager** — deploy agent ke Telegram dalam hitungan detik

## Setup

```bash
# Setup lengkap (semua komponen)
acs-cli setup

# Dengan Telegram bot (opsional)
acs-cli setup --telegram-token <BOT_TOKEN> --telegram-users <USER_IDS>
```

Setup bersifat **idempotent** — aman dijalankan berulang kali. Yang dikonfigurasi:

| Step | Fungsi |
|------|--------|
| prerequisites | Cek & install tools (git, bun, python) |
| 9router | Install LLM proxy + seed model database + generate API key |
| claude-code | Deploy config + MCP servers + hooks |
| hermes-agent | Deploy profiles + SOUL + automation |
| gateway | Setup Telegram bot gateway (jika token disediakan) |
| shared-skills | Deploy 30+ agent skills |
| mcp-servers | Konfigurasi MCP tool servers |
| automation | Deploy hooks + scheduled tasks |

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
│  Multi-model    Telegram bot      Web UI +          │
│  routing +      deploy +          monitoring        │
│  fallback       24/7 agent                          │
│                                                     │
│  ┌──────────┐  ┌──────────┐  ┌──────────────────┐  │
│  │Scheduler │  │  Skills  │  │   Auto-Update    │  │
│  │(background)│ │  (30+)   │  │   (6h check)     │  │
│  └──────────┘  └──────────┘  └──────────────────┘  │
│                                                     │
└─────────────────────────────────────────────────────┘
         ↕                ↕                ↕
   OpenAI / Anthropic   Telegram      Claude Code
   Google / Local       Bot API       Hermes / Kiro
```

## Agent Capability System

Skills aktif otomatis berdasarkan konteks task. Tidak perlu invokasi manual.

| Kategori | Skills |
|----------|--------|
| **Dev Workflow** | spec-writer, architecture-blueprint, code-review, tdd-regression-guard, git-workflow, parallel-orchestration |
| **Security** | security-review (OWASP, secrets, input validation, auth/authz) |
| **Quality** | runtime-validation, markdown-autofix, tooling-bootstrap, investigation-protocol |
| **Frontend** | frontend-ui-ux (styling, a11y, responsive, dark/light mode) |
| **Business** | pitch-deck, funnel-builder, gtm-launch, technical-copy-seo, product-marketing, seo-audit, outbound-sequence, cro-audit, dx-onboarding |

Setiap skill mencakup: trigger conditions, step-by-step execution, context requirements, dan quality gates.

## Dashboard

```bash
acs-cli service start    # Start semua (9router + gateway + dashboard + scheduler)
```

Buka `http://localhost:20130` — fitur dashboard:

- **Gateway Manager** — start/stop/create/delete agent gateway, lihat status real-time
- **Model Routing** — lihat combo aktif, provider status, usage metrics
- **Health Monitor** — warning system untuk duplicate tokens, stale locks, process issues
- **Agent Sessions** — history percakapan agent
- **Settings** — API keys, preferences, theme (dark/light)

## Gateway: AI Agent via Telegram

Deploy agent yang bisa diajak chat 24/7:

```bash
# Buat gateway baru
acs-cli gateway create --name my-agent --telegram-token <TOKEN> --allowed-users <USER_ID>

# Start
acs-cli gateway start my-agent

# Lihat semua gateway
acs-cli gateway list
```

Setiap gateway = 1 Telegram bot = 1 AI agent dengan personality dan skills sendiri.

## Auto-Update

ACS CLI cek update otomatis setiap 6 jam. Untuk update manual:

```bash
acs-cli update
```

Update flow: download binary baru → verify SHA-256 → swap binary → restart service. Zero downtime.

## Uninstall

### Safe (simpan skills, configs, data)

```bash
# macOS / Linux
curl -fsSL https://raw.githubusercontent.com/andyvandaric/acs/main/uninstall.sh | bash

# Windows
irm https://raw.githubusercontent.com/andyvandaric/acs/main/uninstall.ps1 | iex
```

### Full Purge (hapus semua)

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

## Persyaratan

- Git
- Koneksi internet
- Akun GitHub dengan akses private repo (diberikan setelah pembelian)

## Setelah Install

```bash
acs-cli setup          # Konfigurasi semua komponen
acs-cli doctor         # Verifikasi instalasi
acs-cli service start  # Start background service
```

Buka dashboard: `http://localhost:20130`

## Troubleshooting

```bash
acs-cli doctor         # Diagnosa masalah
acs-cli doctor --fix   # Auto-repair masalah umum
```

---

## Belum punya akses?

ACS didistribusikan via private repository. Setiap buyer mendapat akses collaborator + lifetime updates.

<p align="center">
  <a href="https://wa.me/6281289731212?text=Mau%20order%20ACS%20nya%2C%20mohon%20infonya%20ya">
    <img src="https://img.shields.io/badge/Order%20Sekarang-WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white" alt="Order via WhatsApp">
  </a>
</p>

<p align="center">
  <em>Sekali bayar. Update selamanya. Tanpa langganan.</em>
</p>

---

## Lisensi

Proprietary. Akses diberikan per-user via private repository.

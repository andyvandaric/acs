# ACS — Agnostic Config Suites

> **🌐 Bahasa:** [English](README.md) | [Bahasa Indonesia](README.id.md)

Stack agentic coding yang bikin AI kerja buat kamu — bukan sebaliknya.

---

## Kenapa ACS?

**Agent Capability System** — 25+ skill teruji yang mengubah AI coding agent manapun jadi senior engineer:

- **Spec-driven development** — fitur dimulai dari spec, bukan tebak-tebakan
- **Architecture blueprints** — perubahan multi-file direncanakan sebelum eksekusi
- **TDD regression guards** — bug tertangkap sebelum deploy
- **Security review** — OWASP top 10 dicek di setiap perubahan sensitif
- **Git workflow orchestration** — parallel agents, atomic commits, history bersih
- **Runtime validation** — installer dan deploy diverifikasi di environment live
- **Self-learning** — agent meningkatkan skill-nya sendiri setelah setiap task

Kompatibel dengan Claude Code, Hermes, Kiro, Codex, dan agent MCP-compatible lainnya. Tool-agnostic by design.

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

## Yang Terinstall

- **acs-cli** — single binary, semua platform (Windows/macOS/Linux, amd64/arm64)
- **25+ agent skills** — architecture, security, TDD, release, marketing, dan lainnya
- Auto-register sebagai service (jalan otomatis saat login)

## Setup

```bash
# Setup dasar (semua komponen)
acs-cli setup

# Dengan Telegram bot + Exa search
acs-cli setup --telegram-token <BOT_TOKEN> --telegram-users <USER_IDS> --exa-key <EXA_KEY>
```

Setup menginstall dan mengkonfigurasi:
- 9router (AI model routing + multi-provider fallback)
- Claude Code CLI (+ plugins + hooks)
- Hermes Agent (+ Telegram gateway + automation)
- Agent Capability System (25+ skills, auto-deploy)
- API key auto-generate dan register

## Agent Capability System

Skills aktif otomatis berdasarkan konteks task. Tidak perlu invokasi manual.

| Kategori | Skills |
|----------|--------|
| **Dev Workflow** | spec-writer, architecture-blueprint, code-review, tdd-regression-guard, git-workflow, parallel-orchestration |
| **Security** | security-review (OWASP, secrets, input validation, auth/authz) |
| **Quality** | runtime-validation, markdown-autofix, tooling-bootstrap |
| **Frontend** | frontend-ui-ux (styling, a11y, responsive) |
| **Business** | pitch-deck, funnel-builder, gtm-launch, technical-copy-seo, product-marketing, seo-audit, outbound-sequence, cro-audit, dx-onboarding |

Setiap skill mencakup: trigger conditions, step-by-step execution, context requirements, dan quality gates.

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
| Kanban DB (di-backup dulu) | — | ✓ |
| Binary + PATH | — | ✓ |

## Persyaratan

- Git
- Koneksi internet
- Akun GitHub dengan akses private repo

## Setelah Install

```bash
acs-cli setup          # Konfigurasi semua
acs-cli doctor         # Verifikasi instalasi
acs-cli service start  # Start background service
```

## Troubleshooting

```bash
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

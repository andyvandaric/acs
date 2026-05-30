---
title: "Changelog"
description: "Semua perubahan penting pada ACS"
---

<!-- markdownlint-disable MD025 -->

# Changelog

Semua perubahan penting pada proyek ini didokumentasikan di file ini.

Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
Versioning: [Semantic Versioning](https://semver.org/spec/v2.0.0.html)

## [Unreleased]

## [0.7.0] - 2026-05-22

### Ditambahkan
- Intent capture endpoint (POST /api/intent)
- **cli:** label prioritas P0-P3 dengan color badge
- **cli:** deteksi stale + heartbeat + session sweep
- **cli:** subcommand acs-cli setup — installer idempotent
- **cli:** detail task yang diperkaya + Recent Activity yang bisa diklik
- **cli:** ganti polling HTTP 9router dengan direct SQLite read
- **cli:** watchdog cron (setiap 5 menit) — monitor 9router, acs-cli, gateway, task stale, expired lock, zombie worker

### Diperbaiki
- **cli:** badge assignee — strip prefix acs-, konsistensi warna
- **cli:** sembunyikan subprocess window di Windows (stop terminal flicker)
- **cli:** crash sidebar detail task + cache header
- **cli:** sidebar detail task infinite loading
- **cli:** WS flicker + path traversal security + transisi event kanban
- **cli:** sort kanban board — task terbaru di atas tiap kolom
- **cli:** mapping status kolom kanban board
- **cli:** deteksi gateway — respect HERMES_HOME untuk path pid file
- **cli:** recentKanban dashboard hilang saat load

### Dokumentasi
- **cli:** tandai Phase 5.1 + 5.4 partial done di plan
- **cli:** update plan — phase 0-8 done, 5/10 planned

## [0.5.0] - 2026-05-22

### Ditambahkan
- **acs-cli:** 9router cache layer + composite WebSocket snapshot (Phase 3.6.1-2)
- **acs-cli:** tambah subcommand service (start|stop|restart|status|install|uninstall)
- **acs-cli:** complete API parity + service scaffolding
- **acs:** rename TDD RGR regression guard skill
- **acs:** tambah prod build pipeline — minify, obfuscate, hash, strip sourcemap
- **acs:** Phase 8 — docs automation (changelog, semver, readme-sync)
- **acs:** Phase 3 — server mode dengan API routes + WebSocket (v0.3.0)
- **acs:** Phase 2 — own SQLite DB + exa commands (v0.2.0)
- **acs:** Phase 1 — Go CLI skeleton + doctor (16 health check)
- **acs:** integrasi OMP skill:// protocol — convert skill ke format dir/SKILL.md, update semua template
- **acs:** refactor installer — tambah constants loading, skills deploy, global rules, OMP config, global tools install
- **acs:** tambah build-acs-tarball.sh, fix hermes-soul automation-watchdog trigger, gitignore dist/
- **acs:** tambah OMP template (models.yml, mcp.json, AGENTS.md) + update hermes-soul template dengan intent-based skills
- **acs:** shared skills dir (~/.acs/skills/) + CLAUDE.md template + update constants dan plan
- **acs:** tambah acs-automation-watchdog skill + automation layer di plan
- **acs:** tambah acs-tooling-bootstrap skill dengan detectBy patterns di constants.json
- **acs:** tambah biome, golangci-lint, shellcheck, gh ke global tools
- **acs:** tambah global dev tools (marksman, markdownlint-cli2) ke constants dan plan, update markdown-autofix skill
- **acs:** tambah Tier 3 skills — outbound-sequence, cro-audit, git-workflow, dx-onboarding
- **acs:** tambah Tier 2 skills — pitch-deck, funnel-builder, gtm-launch
- **acs:** tambah Tier 1 skills — spec-writer, architecture-blueprint, code-review
- **acs:** tambah 10 universal skills untuk ACS stack
- **acs:** bootstrap apps/acs dengan installer, template, dan constants

### Diperbaiki
- **acs-cli:** path versi docs + changelog scoped ke apps/acs saja
- **acs-cli:** selaraskan WS snapshot dengan shape yang diharapkan frontend
- **acs-cli:** auto-reclaim port dari proses acs-cli yang stale
- **acs:** Phase 3 audit — validasi auth, single gateway model, role derivation
- **acs:** tambah Boundary section ke 4 skill yang overlap dengan native TUI capabilities
- **acs:** semua skill sekarang intent-based trigger, tanpa manual load — update global-rules dan skills-matrix

### Diubah
- **acs-cli:** hapus command serve, gunakan service sebagai satu-satunya entry point
- **acs:** migrasi docs site ke Bun (hapus node/npm)
- **acs:** bump versi ke 0.4.0, update CHANGELOG
- **acs:** bump versi ke 0.3.1, update CHANGELOG dengan semver release
- **acs:** persempit trigger test-regression-guard, update referensi skill di global-rules
- **acs:** merge coding-standards ke global-rules, tambah skills-matrix untuk conditional deployment

### Dokumentasi
- **plan:** merge dashboard sync plan ke main acs-cli-go-backend.md
- **acs:** update dokumentasi TDD guard
- **acs:** restrukturisasi plan + tambah docs automation system

## [0.4.0] - 2026-05-22

### Ditambahkan
- Docs automation: suite command `acs-cli docs` (init, sync, changelog, version, readme-sync, status)
- Changelog parser: conventional commits → format Keep a Changelog (SHA dedup, section grouping)
- Semantic versioning: auto-bump berdasarkan tipe commit (feat→minor, fix→patch, feat!→major)
- README protected zone: marker `<!-- acs:manual-start -->` / `<!-- acs:auto-start -->`
- Post-commit hook installer dengan recursion guard (`ACS_DOCS_SKIP`)
- Deteksi project: walk-up file marker `.acs-docs.json`
- Flag global `--quiet`, `--dry-run`, `--project` untuk command docs
- Testing Policy section di plan (TDD mandate, requirement per-phase)
- 38 test baru untuk package docs (changelog 8, semver 17, readme 13)

## [0.3.1] - 2026-05-22

### Diperbaiki
- Validasi auth: `validateToken` sekarang cek field `requireLogin` di response 9router (sebelumnya menerima status 200 apapun, memungkinkan akses tanpa autentikasi ke endpoint yang dilindungi)
- Doctor: panic `checkEnvVar` pada API key yang lebih pendek dari 4 karakter (slice bounds out of range)
- Deteksi gateway: API + WebSocket sekarang melaporkan arsitektur single-gateway dengan benar (hanya acs-default yang jalan sebagai proses)
- Role derivation: `acs-default` di-map ke "orchestrator" (sebelumnya salah default ke "coder"), prefix `acs-*` di-strip dengan benar

### Ditambahkan
- Test suite: 58 test di 7 package (server, doctor, db, cliconfig, exa, metrics, version)
- CI guard script (`scripts/ci-guard.sh`): build + vet + test + frontend dist check
- Endpoint `GET /api/roles` dengan 7 definisi role (termasuk orchestrator)
- Filter task berbasis role: query param `?role=` dan `?status=` di `/api/tasks`
- `GET /api/hermes/profiles` sekarang menyertakan role + boolean gateway per profile
- Package `internal/metrics`: command `acs-cli metrics [--role <role>]`
- Frontend scaffold (SolidJS): halaman Dashboard, Kanban, Accounts, Sessions, Settings
- `//go:embed all:frontend/dist` — production frontend embedded di binary

### Diubah
- `GET /api/hermes/gateways` mengembalikan single gateway object dengan field `note` yang menjelaskan arsitektur
- WebSocket collector menggunakan `getActiveGateway()` alih-alih scan semua profile
- `handleProfiles` membedakan gateway (status: running/stopped) vs worker (status: worker)

## [0.3.0] - 2026-05-22

### Ditambahkan
- Server mode (`acs-cli serve`): Fiber v2 HTTP server di port 20130
- Auth: cookie-based, proxy validation ke 9router `/api/auth/status`
- API routes: `/api/tasks`, `/api/task/:id`, `/api/stats`, `/api/graph`
- Hermes routes: `/api/hermes/gateways`, `/profiles`, `/crons/summary`, `/crons`, `/kanban/recent`
- 9router proxy: `/api/9r/usage/stats`, `/api/9r/providers`, DELETE, PATCH/GET fallback
- Kiro OAuth stubs: `/api/accounts/kiro/*` (Phase 6)
- WebSocket: diff-gated composite snapshot (dual-tick: 3s kanban, 9s 9router)
- Health endpoint: `/api/health` (uptime, version, timestamp)
- Flag `--port` dan `--dev` untuk command serve
- Graceful shutdown (SIGINT/SIGTERM)

## [0.2.0] - 2026-05-22

### Ditambahkan
- Own SQLite database (`%APPDATA%/acs-cli/data.sqlite`)
- Schema: install_history, health_checks, config_state, deployed_skills, docs_sync_log
- Integrasi Exa: `acs-cli exa setup --api-key <key>` + `acs-cli exa check`
- Config state upsert (key/value store di DB)
- Deduplikasi docs sync (unique index pada project+commit+type)

## [0.1.0] - 2026-05-22

### Ditambahkan
- Go CLI skeleton (`acs-cli`) dengan raw os.Args dispatch
- 16 health check (`acs-cli doctor [--fix]`)
- Resolusi config platform-aware (constants.json → path Windows/Linux/macOS)
- Check: Go runtime, 9router (binary + running + DB + combo), Hermes (binary + config + profiles + gateway), Claude Code (binary + settings), OMP, env var (OPENAI_API_KEY, EXA_API_KEY), skills deployed

---

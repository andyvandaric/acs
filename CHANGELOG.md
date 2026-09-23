# Changelog

## [v1.15.1] - 2026-09-23

### Highlights

v1.15.1 delivers the full ACS Knowledge Base architecture with bilingual content (EN/ID), interactive rich-text and Mermaid rendering, persistent headed browser sessions, automated setup and autostart diagnostics, and dynamic guides CMS integration.

### Added

- **Bilingual Knowledge Base (Waves 1-8)**:
  - Local SQLite FTS5 persistence foundation with composite primary key `(slug, lang)` and migration support (`seedUserVersion = 2`).
  - Curated 7-topic bilingual corpus (EN + ID) with automatic fallback and canonical path resolution.
  - Interactive GUI at `/knowledge` featuring instant debounced search (150ms) and markdown-stripped card excerpts.
  - Semantic HTML rendering via `ArticleBody` with interactive Mermaid diagram generation.
  - Segmented `[Rendered | Markdown]` view toggle and responsive EN | ID language switcher.
- **Persistent Headed Browser Automation**:
  - Browser control endpoint `POST /api/mcp/browser/mode` supporting headed execution and profile directory selection.
  - Runtime environment toggles (`ACS_BROWSER_HEADED`) with automated warm-up and idle reaper exemption.
- **Dynamic Content & Guides CMS**:
  - Decoupled hardcoded assets into dynamic seeding and unified public guides CMS.
- **Setup & Runtime Hardening**:
  - Automated dashboard autostart guidance, URL hints, and inline doctor diagnostics.
  - Headroom cold-boot grace throttling and inference probe streaming fallbacks.
  - Kanban single-write reconcilers and done-gate atomicity.

### Fixed

- Whitelisted internal SSOT resolvers and adjusted stopped headroom diagnostics status to warning.
- Resolved SQLite driver resolution and path synchronization in headroom 9router integration.
- Fixed sidebar footer layout wrapping for smooth multi-button responsiveness on `/knowledge`.
- Hardened E2E test endpoint timeouts for heavy parallel query sweeps.
- Decoupled npm and PyPI wrapper versions from the core ACS release tag.

### Changed

- Bumped version to 1.15.1.

## [v1.14.0] - 2026-09-22
### Highlights

v1.14.0 delivers Architectural Blindspots Remediation Suite across phase-01 to phase-04, including Kanban URL resolver, PID liveness reaper, AST verification gate, and SQLite write mutex. Release engineering hardens Gate 13 failure handling, Winget verification, and portal version decoupling. Governance docs add markdownlint gates, English normalization, and PRD freshness guards.

**BREAKING CHANGES:** None.

### Added

- Added Unified Kanban Direct Card URL Resolver for phase-04.
- Added Stale Claims PID Liveness Reaper and Garbage Collection for phase-03.
- Added AST Verification Gate and Anti-Silent-Fallback Protocol for phase-02.
- Added SQLite Concurrency Write Mutex and DSN Normalization for phase-01.
- Added Architectural Blindspots Remediation Suite Master PRD for phase-01.
- Added `just fmt-md` alias for markdown auto-formatting.
- Added `just lint-md` and `just fix-md` commands for governance docs.

### Changed

- Bumped version to 1.14.0.
- Bumped version to 0.18.2.
- Added scoped markdownlint gate for governance docs.
- Added `AGENTS.md.tmpl` as canonical source for hermes agent rules.

### Fixed

- Decoupled portal versions from ACS release sync.
- Synced portal changelog, JSON-LD, and nested repo push automatically on release.
- Failed Gate 13 loudly on `gh` release errors.
- Added Winget version gate, binary verification, testable flags, and terminal experimental gate.
- Aligned hooks template and added WezTerm regression guards.
- Propagated 8-pillar ACS philosophy to deployed hooks.
- Hardened task deduplication and updated embedded stage assets.
- Overhauled responsive layout for 1280px viewports and eliminated card creation redundancy.
- Restored `--wezterm` flag to `RunWezTerm` and decoupled it from `--terminal`.

### Documentation

- Added Blindspots Remediation Suite feature bullet.
- Pointed Official Distribution backlink to uikode.com/acs portal.
- Backfilled Last Updated on phase-01 and phase-03.
- Stripped internal stack from acs-knowledge corpus in anti-stack revision.
- Added wall-clock freshness guard against hallucinated PRD timestamps.
- Added Phase 05 Knowledge Base GUI and 2 residual fixes.
- Reconciled acs-knowledge PRD blueprint to HG1B ACCEPT.
- Reconciled runtime-harness-and-kanban-gateway-hardening PRD blueprint to certified.
- Translated all Indonesian content to English in rulesets and templates.
- Overhauled v1.13.0 release notes with backward compatibility guarantees.

## [v1.13.0] - 2026-09-21

### Overview
ACS v1.13.0 brings major stability, container reliability, and workflow enhancements across all supported platforms (Windows, macOS, Linux). Fully backward-compatible with legacy tooling and automation scripts.

### Backward Compatibility & Deprecation Policy
- **Zero Breaking Invocations**: Legacy binary name `acs-cli` is fully supported via automatic shims, aliases, and symlinks. Existing agentic daemons, OMC workflows, and custom scripts continue to function without modification.
- Updater health checks accept either `acs` or `acs-cli` in version output (compat-read); modern `acs-<os>-<arch>` assets are matched alongside legacy `acs-cli-<os>-<arch>`.
- MCP entries self-heal stale `acs-cli` references to the canonical `acs` binary at runtime.
- No breaking API, CLI flag, or config schema changes in this release.

### Key Features
- **Unified Kanban Direct Card URL Resolver**: 4-tab card models, cross-tenant URL resolution, Git commit inspection API, and interactive 2D pan-zoom Mermaid diagram lightbox.
- **ResolveAuthEnv SSOT Engine**: Centralized authentication, endpoint, and token discovery for 9router and external gateways with user-level singleton lock.
- **Sovereign Single-Binary CDN Distribution**: High-speed multi-platform downloads via dl.uikode.com with SHA-256 integrity verification.
- Subagent stagnation gate featuring heartbeat persistence, fast-path checks, and execution halt bands.
- Git commit inspection service, backend Go handler, and frontend `GitCommitDetailModal`.
- Surgical uninstaller engines for Go, PowerShell, and POSIX shell with `.acs` local directory purge capabilities.
- Windows integration tooling including Zero-UAC broker, terminal step orchestrator, and AST terminal patchers.
- Embeds for 15 OMC subagent personas, dual-verification badge indicators, and P9 micro-chunk verification gates.

### Changed
- Modularized `ACSKanbanBoard` into dedicated components featuring P0-P3 priority sorting and 5-column lifecycle states.
- Modernized `install.ps1` and build toolchains to deploy single-binary artifacts.
- Updated blueprint preview modal TOC parser to use `matchAll` regex with zero lint warnings.
- Migrated operational backup storage paths from Hermes to the ACS data directory.
- Canonical `acs` binary resolution via `ResolveACSBinary` across MCP definitions, templates, automation shims, and installers.

### Critical Bug Fixes
- **macOS BSD awk Installer Error**: Resolved syntax error on macOS (`awk: syntax error at source line 1`) during download size calculation using POSIX parameter passing.
- **Doctor Silent Crash (Exit Code 2)**: Resolved runtime panic in `acs doctor` on fresh/minimal environments using `cliconfig.LoadOrDefault()` fallback.
- **Dashboard Status False-Negative**: Fixed `acs status` erroneously reporting dashboard stopped in minimal containers lacking `lsof`/`ss` by adding TCP and HTTP health probes.
- **Accounts Page SQL Logic Error**: Handled missing `providerConnections` table gracefully on fresh installs by returning empty list instead of HTTP 503 toast error.
- **Token Usage Infinite Shimmer**: Decoupled loading state from data presence in `TokenUsageChart.tsx` and returned zeroed bucket metrics on fresh installs.
- **Stack Updates Floating Dock Progress**: Added `defer/recover` finally block guaranteeing terminal `done 100%` event broadcast and auto-dismissal of completed cards.
- Calibrated test connection probe latencies, raised `max_tokens` floor above provider minimums, and handled `in_progress` stream states.
- Normalized localhost endpoints and hardened 64KB response parsing to fix false UI unauthorized states.
- Preserved PowerShell profile variable strings during regex substitution passes.
- Eliminated Windows AV false positives by omitting `-tiny` compilation flags and binding `ShowWindow` to `user32.dll`.
- Fixed multi-project workspace git root resolution for blueprint tree scanning and direct commit inspection.
- Threaded verified git commit authors into Kanban task attachment records.
- Resolved 129 Biome lint diagnostics across frontend packages.

## [v1.12.0] - 2026-09-18 05:45 (UTC+7)

### Breaking Changes
- Hard gate 3 now strictly enforces a clean working tree and registered commit hash before wave progression.
- Deployment in `installer-sync` now requires passing strict 4-gate local testing (Windows AST + POSIX + Podman) before VPS CDN distribution.

### Added
- ACS Service Resilience & Process Decoupling: targeted single-PID termination (`taskkill /F /PID <pid>`), preventing 9router from being terminated when stopping or restarting ACS dashboard.
- Unified 360° Observability: Fiber HTTP access log middleware logging method, path, status, latency, and client IP directly to `acs.log`.
- Centralized log streaming: 9router stdout/stderr redirected to rotating `~/.acs/logs/9router.log` (20MB cap, 3 backups).
- Real log registry: `dashboard-service.log`, `daemon-service.log`, and `9router.log` registered in UI log viewer.
- SafeGo panic recovery wrapper (`server.SafeGo`) with stack trace logging across all background goroutines.
- Resilient Auto-Heal & Anti-Flapping: HTTP health probe timeout increased to 8s with 2x retry buffer, 45s cold-boot grace period, and persistent `watchdog.RestartTracker` (circuit breaker capped at 3 restarts per 15 minutes).
- Automated Phase Commit Enforcer hook (`prd-phase-commit-enforcer.mjs`) executing atomic local commits immediately upon sub-phase completion (`✅ Done`).
- Zero-friction Git Onboarding Core (`git-onboarding-lib.mjs`) with automatic GitHub CLI (`gh api user`) identity resolution and non-TTY safe fallback.
- Dedicated ACS Project Hub & Workspace Manager modal on `/kanban` route with first-class Native MCP Tools (`kanban_list`, `kanban_create`, `kanban_update`, `kanban_artifacts`, `kanban_claim_files`) and interactive CLI.
- Standardized local timezone and dynamic UTC offset formatting `YYYY-MM-DD HH:MM (UTC±X)` across CHANGELOG and PRD templates.
- Explicit "Lead Orchestrator Command Map" section and 6 Authoritative Governance Pillars embedded into Master PRD template and watchdog rulesets.

### Fixed
- SQLite connection churn: eliminated all premature `defer db.Close()` on singleton pool `global9rDB`, resolving `sql: database is closed` errors and use-after-free panics.
- WebSocket data race: guarded `conn.WriteMessage` with per-connection `writeMu sync.Mutex`.
- Resource leaks: fixed unclosed HTTP response bodies on non-200 statuses, closed parent file descriptor handles on Windows service spawn, and bound cache loop to `sync.Once`.
- Zero console window: enforced Win32 `STARTUPINFO(SW_HIDE)` and `windowsHide` configurations across Python build tools, runners, and scripts to eliminate terminal flash.
- Rebranded legacy "Antigravity Project Hub" and "Antigravity Project Manager" hardcoded strings in Kanban UI components.
- Form task creation empty state by adding `blueprint_path` and `files` inputs in `AntigravityTaskModal.tsx`.
- Updated hardcoded fallback models from legacy `1st_combo` to active `gemini-3.8-flash-max` and `muse`.

## [v1.6.1] - 2026-09-17


### Added
- auto-publish CHANGELOG to CDN, sync installer repo docs, and update gate tests
- integrate default project mcp provisioning with append dedupe and fix bundle root
- implement ai rules localizer, mode persistence, and status reactivity
- auto-upload installer scripts and update versions.json during release
- add sovereign VPS binary deployment engine and automated installer-sync
- implement dedicated /api/workflow/update-only endpoint and wire live UI update buttons
- eliminate hardcoded fallback paths and implement in-memory embedded bundle fallback
- improve unified diff hunk trailing context and upgrade contrast to WCAG AAA
- implement target repository UI gating for zero premature errors (Phase 05)
- implement WCAG AA IDE-standard unified diff viewer (Phase 06)
- implement target-gated estimate and status endpoints with zero premature errors (Phase 03)
- add creator bypass for Andy Vandaric in proprietary IP protection hook
- standardize rulesets to 100% English and deduplicate instructions (Phase 01)
- add orchestrator watchdog rules and mandatory KPI PRD standard (Phase 02)
- universal multi-agent awareness and rules sync (Phase 03)
- wire --mode lean|full flag to acs adopt command
- blueprint scanner and dedicated /api/kanban routes (Phase 02A)
- dedicated /kanban page, sidebar top-level and tab reorder (Phase 02B)
- blueprint schema fields and tab hierarchy contract (Phase 01)
- endpoint estimasi dan gui lean adopt toggle (Phase 03)
- generator mode lean dan adopt option wiring (Phase 02)
- kontrak pointer lean + estimasi token (Phase 01)
- guard freshness ensureProjectMCP skip tanpa fetch
- Phase 03 GREEN - Frontend intake + route/nav + cabut board + identitas
- Phase 02 GREEN - UpdateTaskFiles + IntakeBlueprintTask + 2 route files/intake-blueprint
- Phase 07 SubmitProposal Go client + plan DONE
- Phase 05-hook stamp-aware SessionStart + pre-edit guard
- Phase 04 API status/diff + doctor version-aware
- Phase 03 decision engine + state store
- Phase 02 bundle stamping + incremental writer
- freeze stamp format + canonical checksum + version source
- workflow awareness SessionStart + version endpoint + bundle fix
- tambah R8 stash recovery via branch isolasi, larang checkout-buta
- wajib auto-commit lokal tiap phase DONE tanpa approval (R7)
- fix cross-session task-scope false positives + R7 rules adendum (Wave 3a P04)
- add PreToolUse git-guard blocking destructive git on ACTIVE claims (Wave 2 P03)
- implement cross-session claim lib, session-start display, and session-end auto-release (Wave 1)
- enforce multi-session worktree concurrency rules (R1-R6)
- SessionStart MCP auto-provision + Contract-First waves in PRD standard
- explicit project_dirs in POST /api/mcp/agent/sync
- fan-out SyncToAllAgents to all known project .mcp.json

### Fixed
- add SSH compression and keepalive options for reliable binary uploads
- bypass pre-push guard in automated release push
- standardize lean pointer topic labels to 100% English (persona delegation & adopt template)
- prevent stamp accumulation and ensure clean up-to-date verdict on single-file updates
- remove browse button, sanitize placeholder, and enhance monorepo manifest detection
- switch Windows folder picker to FolderBrowserDialog and default targetPath to empty on mount
- align diff orientation (local - to bundle +) and fix dry-run preview root resolution
- sanitize staging domain in license-pipeline to prevent binary leaks
- eliminate dev path leaks in bundle and adjust hardening thresholds
- Phase 02 verifier remediation Wave 2a
- scope stop hook per sesi, cegah false-positive lintas sesi
- probe staging before prod in MCP auto-provision order
- purge ALL acs-* from global, env-scoped port, no cross-env detect
- env-scoped port in sanitizeURLForAgent (no cross-env detect)
- deterministic midnight fallback via QuerySessionSavedTokensAt + anchored fixtures
- active-status account filter + 25s catalog timeout for /api/9r/models

### Changed
- bump version to 0.18.2
- reconcile origin/main PR #5 squash merge into local main
- ignore linux binaries and stage kanban integration plan
- ignore workflow adopt runtime state .acs and backup files
- remove orphaned root python scripts and enforce clean root monorepo (Phase 04)
- bump version to 1.6.1 and update docs changelog
- adopsi WIP sesi 5398afbe sebagai basis P03 kanban
- bump version to 1.6.0
- per-project .mcp.json SSOT, global ~/.claude.json purge-only
- SSOT gates + gap-closure (handoff/skills/reaper) — v1.3.0 → staging (#5)

### Documentation
- complete universal installer and sovereign cdn distribution suite
- reconcile system watchdog and wcag diff blueprint to COMPLETED (Final Gate PASS)
- remediate phase-06 air-gap and expand phase-07 verification scope
- add adaptive PRD language rule and strict English delegation policy
- add KPI 6 for workflow english adoption and generator english template spec
- align sub-phase filenames to 7-phase sequence
- finalize complete 7-phase master blueprint with exact mapping and KPIs
- clean up legacy embedded fallback phase in favor of target gated backend
- add comprehensive system watchdog, target gating, and wcag diff blueprint
- remediate audit findings (align Gate 9, path fallback, and leak table)
- add comprehensive production hardening and release blueprint
- Phase 01-04 completed and verified for kanban-workflow-hub
- sync format timestamp lokal ke agentic-stack prd templates
- Phase 04 DONE — final gate E2E parity lean adopt COMPLETED
- update hash commit phase 03 di phase-03-lean-surfaces.md
- Phase 02 DONE — generator lean mode dan adopt option wiring 32eae7c6
- terapkan kebijakan timestamp lokal +0700 massal (Phase 05)
- Phase 01 DONE — stamp kontrak lean pointer 2842ef12
- koreksi stamp index lean ke format lokal +0700
- remediasi 7 temuan + re-audit 97 APPROVE Wave 1 lean adopt
- tambah Phase 05 timestamp policy + koreksi stamp (W0-docs)
- lean adopt on-demand blueprint, Hard Gate 1 CLEAR 98 persen
- tambah R10 MCP JSON runtime artifact governance
- sinkron baris P01 DONE RED 049b3686 di index kanban
- phase-04 E2E terisolasi + claim-scopes + COMPLETED
- phase-03 implementation reference hash ce6ec1dd
- kanban standalone ACS client blueprint, Hard Gate 1 CLEAR 98 persen
- Phase 05-frontend DONE + index baris P05
- Phase 04 DONE stamp 08664bcd
- Phase 03 stamp hash commit dfd119fe
- remediate Wave 1 verifier gaps P01
- bekukan regex pola stamp-leak P06 (F5 susulan)
- remediasi audit F1-F6, skor 98 persen layak APPROVE Wave 1
- tambah Phase 07 community submissions Opsi B terminal
- workflow versioning control blueprint + team audit remediation
- tambah Final Live E2E Gate dan Session Isolation Boundary
- split §6 boundary contracts into universal principles + per-stack appendix
- Wave 1 blocking checklist + runtime boundary contracts (§6)
- add Duration field (Completed minus Created) to PRD header
- PRD datetime WIB (YYYY-MM-DD HH:MM WIB) for Created/Completed/Updated


## [v1.6.1] - 2026-09-16

### Added
- **Lean Adopt On-Demand Engine**: Mode `--mode lean` pada `acs adopt` menghasilkan `CLAUDE.md` ramping (~2 KB index pointer) dengan injeksi on-demand dinamis 16 KB per prompt match.
- **Workflow Context Estimation Endpoint**: `GET /api/workflow/estimate` untuk kalkulasi perbandingan konteks full (~143.6 KB) vs lean (~2.09 KB) secara real-time.
- **Dedicated Kanban Workflow Hub**: Arsitektur Kanban terdedikasi di `/kanban`, scanning blueprint otomatis, tab hierarchy contract, dan schema fields terintegrasi.
- **Enterprise Production Hardening Blueprint**: Panduan komprehensif Garble obfuscation (`-tiny -seed=random`), UPX compression, Gate 5 leak scanner (0x leaks), dan cryptographic Ed25519 anti-tamper.
- **SolidJS GUI LeanAdoptPanel**: Komponen switch mode Full vs Lean di halaman `/workflow` berstandar W3C design tokens dan 8pt grid.

### Changed
- **Timestamp Policy Standardization**: Standardisasi penulisan timestamp PRD ke waktu lokal penulis eksplisit offset `YYYY-MM-DD HH:MM ±HHMM` (menghapus label zona `WIB`).
- **Binary Hardening & Leak Elimination**: Mengeliminasi path developer lokal `source-private` dan domain staging dari biner rilis produksi.
- **CLI Adopt Mode Wiring**: Menghubungkan flag `--mode <lean|full>` ke CLI commands `acs adopt` dan `acs workflow adopt`.

### Security
- **Gate 5 Zero-Leak Guarantee**: Pemindaian biner 6 platform terhadap dev paths, internal staging URLs, dan hardcoded secrets mencapai tingkat kelulusan 100%.
- **Cryptographic License Enforcement**: Pengikatan biner ke public key Ed25519 dengan verifikasi SHA256 integrity hash dan live device fingerprinting terhadap Jakarta VPS SQLite WAL.

## [v1.4.0] - 2026-09-11


### Added
- adopt ACS-SCF and ACS-DNC copywriting frameworks and harden prod endpoints
- prioritize draining 5h-exhausted weekly accounts to 5% before rolling accounts
- complete sanitization of all remaining acs-cli occurrences to acs
- sanitize all log prefixes and command errors from acs-cli to acs
- update justfile and build pipeline to use acs executable
- single-binary acs, bilingual cli, and pipeline modernization
- universal shared rules, dedicated python venv isolation, and bilingual copywriting governance

### Fixed
- widen Antigravity imminent reset window from 30m to 90m

### Changed
- bump version to 1.4.0 and add post-release workstation sync
- ignore references directory in root repo
- ignore screenshot artifacts in root repo
- ignore .wrangler directories across subrepos

### Documentation
- author Master PRD for Cloudflare email routing, AI auto-reply, and minimalist VPS stack via VPSEase
- update master PRD header metadata to reflect 5/8 completed phases
- update CLI modernization blueprint progress to 5/8 phases completed


## [v1.3.0] - 2026-09-10


### Added
- add virtual memory management and pagefile custom sizing
- sync release binaries and manifest to Cloudflare R2 bucket acs-dist
- elevate Proxy Pool to dedicated top-level /proxy page
- add per-page pagination (50, 100, 200, 500) and align test target with 9router
- add idle auto-sleep lifecycle and clamp default node heap limit
- add interactive switch toggles for auto-manage accounts and 9router proxy manager
- add virtual memory commit check and adaptive memory diagnostics
- add acs-sys-tune skill for virtual memory and pagefile diagnostics
- add Auto Manage & 9router proxy toggles, 35m health check, and one-to-one rotate
- implement Sticky EDF with dual-threshold hysteresis
- turn 1 autonomous on-demand ruleset decompose with race condition guard (task-1788724921254491800)
- smart ruleset decomposer & AI merge fallback
- shift depletion logic to maxPct and implement PrimaryDepleted prioritization
- map IDE models to fallback combos
- auto-inject fallback combos to 9router DB
- add disk/net tracking and per-microservice component breakdown
- integrate e2e testing for dev and staging binaries
- add dedicated Resource Metrics page to Admin Special sidebar (task-1788681768212264200)
- Integrasi Go pprof & gopsutil resource endpoint (task-1788681768212264200)
- Unifikasi MCP Catalogue (task-1788681640297242300)
- implement comprehensive anti-leak strategy (task-1788675925362611200)
- implement proper confirm dialogs and cancel mechanism for updates/rollbacks

### Fixed
- enhance proxy health check resilience and clarify Antigravity auto-manage toggle
- add Windows staging quarantine, sanitize errors, and fix retry button state
- resolve cross-OS test failures and suppress Node 20 deprecation warning
- auto-reconcile docking update progress to done and default target format to .mcp.json
- enforce safe working directory for boot auto-start and wire OS installer
- checkout Tide dependency, purge broker references, and isolate cross-OS tests
- bypass WriteTimeout via SSE hijack, harden auth, and isolate test state
- normalize global setup contract, redesign UI, and harden test runner
- persist active preset to sqlite and smart merge settings
- default disable acs-marketing and purge on sync
- eliminate terminal spawn flicker via executil and PE version probe
- migrate SSE streams to Hijack to bypass WriteTimeout (task-1788759750185859400)
- sync fallback combos into 9router kv table on setup and boot
- display next scheduled check time in local timezone
- resolve combos schema error and protect user customizations
- cap max wait duration to prevent blackout when priority1 depleted (task-1788690782402722600)
- add missing backend endpoint for resource history and include auth credentials in fetch
- remove admin requirement from metrics page and fetch env status
- define missing isAdmin and env exports in auth store
- add explicit anti-leak assertion for installer repo
- implement dynamic concurrency using memory library
- implement dynamic concurrency using memory library
- resolve SQLITE_BUSY in tests and tidy go.mod
- hide verbose file list in antigravity-config log
- update expected step count in TestRunDryRun to 14
- hide verbose logs in acs-cli setup

### Changed
- bump version to 1.3.0
- bump version to 1.2.1
- format hooks.json via setup sync
- align biome schema to v2.5.10, harden vitest runner, and update docs
- unwire curator and overhaul scheduler
- hapus sisa skrip python fix_*.py
- thread context.Context for robust cancellation and patch file descriptor leaks
- implement TTL and bounded pseudo-random eviction across state stores
- implement O(1) two-tier priority & zero-poll standby for quota optimizer
- unwire tool profiles from setup, CLI, and mark as deprecated across frontend/backend
- remove cc-launcher, hermes mcp step, and obsolete 9router sql seeding

### Documentation
- add comprehensive OOM virtual memory and MASD assessment report
- update backend and mcp governance rules for memory and stdio lifecycle
- replace oh-my-openagent badge with oh-my-claudecode 5.3.0
- add AST-driven automated refactoring protocol
- tambahkan poin MCP catalogue ke Bento Grid
- finalisasi Hero Section sales page pakai FSP
- tambahkan story The Silent Burn ke section kalkulator
- pertajam Headline Hero pakai kata sensorik (hangus/halu) sesuai FSP
- ganti kata 'terminal' jadi 'agen' di sales page final
- rombak Hero Section pakai hook '56% Otak Agen Hilang'
- buat draf final sales page terstruktur Golden Flow (AKENHAG)
- rewrite blok wireframe landing page pakai formula FSP AKENHAG
- revisi sudut pandang 3 lebih direct dan konsisten pakai kata Router AI
- ubah bagian 2 positioning dan sudut pandang jadi simple awam
- update poin 8 decomposer sesuai real case Turn-1 hook dan dual sync
- samarkan trik EDF jadi Smart Relay bikin penasaran
- ganti hook jadul dengan headline 56 persen otak hilang
- rapikan format .md poin 7 dan 8 siap salepage
- rewrite workspace decomposer poin 8 FSP + konsep animasi
- rewrite top 7 ACS core features into FSP conversational framework
- inject FSP-compliant 6 Pain Points section into new Sales_Copy_ACS.md file
- rewrite header and executive summary of marketing blueprint to comply with anti-slop guidelines
- update AKENHAG example to use installer execution instead of dev commands
- provide explicit example and breakdown for AKENHAG structural anatomy
- provide detailed breakdown and solutions for AI slop patterns to accommodate lower-tier models
- expand AI slop definitions to prevent ChatGPT-like bullet points, em-dash abuse, and fake empathy
- refactor C3H templates to include detailed philosophy and smoothing instructions
- extract and append 17 C3H headline formulas into headline governance
- complete C3H nuance extraction including ghosting logic and vocabulary filtering
- create C3H headline governance for stop-scroll, curious, and filtering tasks
- restore full detail for FSP copywriting governance while keeping categorized structure
- refactor FSP copywriting governance structure to explicitly map all 18 formulas
- finalize complete FSP extraction including formulas 0, 13, and 16
- expand copywriting governance with FSP UI/UX layout and AKENHAG structure
- complete FSP formula extraction including typo, wikipedia, and pricing rules
- integrate FSP framework into indonesian copywriting governance
- add FSP Blueprint as copywriting reference material
- add indonesian anti-slop copywriting governance
- revise bullet points to emphasize idle bloat, team agents, stateless MCP, and confidence success
- refine intro analogy emphasizing workflow and fuel dependency
- document antigravity account manager architecture and schema
- rewrite executive summary analogies for wider audience appeal
- revise blueprint tone and natively integrate 3-day audit features
- add comprehensive 3-day integration audit report
- enforce mandatory anti-leak compliance via pipeline guardian skill


## [v1.2.1] - 2026-09-09

### Added
- Prominent interactive toggle switch for Auto-Manage Antigravity Accounts directly in `/accounts` overview toolbar.
- Dedicated 9router Proxy Automation panel in `/mcp/proxy` with Auto-Manage toggle switch and "Sync & 1:1 Rotate to 9router" trigger.
- Automated dead proxy purging in 9router SQLite database and One-to-One proxy rotation across active Antigravity provider connections.
- Interactive 3-choice uninstallation workflow (`Keep Data`, `Full Purge`, `Cancel`) for `acs-cli uninstall`.

### Fixed
- Stabilized stop-chain hook auto-continue lifecycle and cleared stale task state.
- Resolved missing visual switch toggles across dashboard account and proxy management views.

### Changed
- Bump version to 1.2.1.

## [v1.2.0] - 2026-09-09

### Added
- Sticky EDF quota scheduler with hysteresis to prevent account flapping and preserve prompt caching
- Safety confirmation modal and W3C design tokens compliance on Global Setup page
- AST-driven refactoring protocol with tree-sitter pattern replacement and LSP semantic rename
- Comprehensive regression test suites for quota management, SSE stream hijack, and preset persistence

### Fixed
- Vitest worker memory exhaustion on Windows via adaptive concurrency and isolated heap
- Biome linter schema drift and code consistency across frontend modules
- Persistent model preset and MCP server states across service and system reboots
- MCP SSE stream timeout bypass via connection hijacking
- Default disable admin-only marketing MCP and auto-purge inactive servers from runtime config

### Changed
- Bump version to 1.2.0
- Refactor frontend test parallelism for deterministic local and CI test runs

## [v1.1.0] - 2026-09-06


### Added
- redesign commands for parity with dashboard, remove exa

### Fixed
- build prod binaries instead of dev

### Changed
- add none bump option
- bump version to 1.1.0
- unwire hermes.go and remove gateway step

### Documentation
- update README with full CLI command parity
- update main README with MCP highlight and CLI parity
- fix broken logo path


## [v1.0.1] - 2026-09-05


### Added
- support initializationOptions and strict leak guards

### Fixed
- prevent garble concurrency race conditions during cross-compilation
- limit garble concurrency to 2 and increase timeout to prevent CPU starvation

### Changed
- bump version to 1.0.1
- parallelize garble build and upx compression in release pipeline

### Documentation
- rewrite README & fix auth bypass vulnerability


## [v1.0.0] - 2026-09-05


### Added
- cache JWT secret to prevent repeated DB lookups
- update antigravity preset to medium & fix kanban optimistic UI revert on audit fail (task-1788606916892785500)
- setup ACS MCP server integrations & dependencies (task-4)
- implement LLM Semantic Plan Verifier for Kanban tasks (task-1788532089450781500)
- implement MCP antigravity catalog interactivity and global setup (task-1788429328644276600)
- add tooltip and hint to headroom config for manual restart requirement
- implement antigravity auto-execution policies and artifact review mode
- implement LLM Semantic Plan Verifier for Kanban tasks (task-1788532089450781500)
- auto-advance tasks on commit and auto-supersede stale in_progress cards
- implement global article dock progress indicator and reactive list refresh
- implement adaptive content format and intent-driven outlines (task-1788521014979794800)
- implement content-aware semantic related articles engine (task-1788519628030197500)
- fix ToC heading navigation and add regression guards (task-1788517670620700000)
- add multimodal vision, URL pre-fetch fallback and research taxonomy
- enhance Antigravity task lifecycle and manager dashboard
- adopt global CLAUDE.md standards into universal agnostic backend engineering rule
- bundle modular on-demand rules in agentic-stack and auto-deploy during setup/sync
- map all 9 acs-search sub-tools and update tool counts
- add on-demand MCP governance matrix and lazy-loading rules
- add accessible tooltips across Agentic Claude configuration panel
- modularize Antigravity ruleset to 100% on-demand model_decision rules
- make Antigravity MCP catalog interactive and enforce 100% on-demand skills
- auto-sync dynamic MCP port on server boot
- sync Antigravity MCP port on startup and unwire legacy Hermes settings
- verify global skills and bin paths in diagnostics
- add 9router MITM auto-mapping and interception status
- add project filter, workspace detection hub, and proxy auto-fallback
- complete total audit of GUI, network, security, and kanban agent/worker connectivity
- integrate Antigravity Suite, auto-approve MCP, on-demand skills & Kanban project discovery
- add native mcp_config.json support for Antigravity Desktop and agent sync
- connect official acs mcp servers and harmonize browser automation
- enable admin system preset updates and route to Cloudflare acs-api.uikode.com
- add antigravity manager, sidebar integration, and dedicated mcp tab routing
- add proxy resilience, instant auto-disable, 3x circuit breaker, and 9router import dedupe
- implement multi-tier preset distribution, cloudflare D1 registry sync, and admin publish modal
- add antigravity agentic stack templates, ~/.gemini auto-sync, and setup step
- sync dev database, remove obsolete exa env keys, and add mcp key pool doctor inspection
- integrate headroom atomic mutex lock, process tree cleanup, and global venv linking
- add empty tasklist stop guard and update HUD pipeline
- introduce global shared Python venv and doctor caching
- atomic 9router startup mutex and zero-leak process lifecycle
- centralize zero-window CLI execution and OS-level PID locking
- standardize cloud industry tiering, zero-window CLI, and settings diagnostics
- implement ACS Agent Manager with dynamic gateway model routing and article synthesizer integration
- add per-project Claude model presets and tier routing manager
- integrate context compression proxy, auto-setup, and 9router settings bridge
- add ACS Agent Manager and project MCP workspace integration
- enhance Claude config panel, HUD scripts, and agentic routes
- add article task tracking and research articles page enhancements
- add MCP registry management, project workspace, and article synthesis improvements
- improve log streaming, level filtering, and UI display
- add model tiers resolution and health check probe
- add staged model preset selection and remove combo system preset
- update scheduler config, mesh deliver, kanban reconciler, and task wrappers
- update MCP server agent sync, migration, and frontend components
- update gateway manager, profiles, and dashboard components
- add default password seeding (12345678) and password-status endpoint
- add dev/prod DB sync commands with build-tag gating
- add license gate flow for staging
- add enowxai adapter, API key sync, and health monitoring
- add dev/staging/prod environment separation system
- add startup gate, encrypted cache, and security hardening
- add license validation system (Phases 0-4)
- consolidate 9router model routing, dynamic presets, and active model discovery
- add title regeneration button and collapsible user prompt toggle
- add query distillation for research handlers and persist updated queries
- query npm registry directly for upstream versions and remove hermes from stack
- extract shared AI client and enhance What's New with agentic changelog audit
- optimize acs-search immediate digest and harden stdio browser stability
- remove enowxai and enowxai-adapter from stack manager and updater
- cleanup deprecated settings, streamline navigation, and redesign logs view
- standardize acs logs registry, directory isolation, and 1MB rotation limit
- add original_query tracking and dual-query lookup in article cache
- integrate OMC v5.0.2 hook chaining, circuit breaker, and orchestrator protocol
- add live-over-cache and anti-stale investigation rules
- integrate OMC v5.0.2 with 4-tier model hierarchy
- add per-article rebuild, instant ToC and URL state persistence
- enhance knowledge synthesis, semantic backlink graph, and references sync
- calibrate semantic scoring and add rebuild related API
- add quality gate to filter trivial queries from knowledge base
- add CLI model preset command for Claude and OpenCode
- add interactive raw markdown editor and article update API
- add 1-click copy raw markdown url button to article header
- multi-agent research modal with custom outline and intent support
- wire agentic research route and background scheduler
- AI intent planner, Jinja2 prompt templates, and multi-MCP agentic dispatcher
- semantic relatedness scoring and mismatched backlink pruning
- instant search, blog reader layout and high-contrast code theme
- cache-first search, bidirectional internal linking and semantic taxonomy
- blog-style article reader, sticky table of contents, instant search, and light mode contrast
- cache-first interception in exa search handlers and category filter api
- add article cache store, semantic categorization and taxonomy normalizer
- task deduplication & anti-loop state tracker hardening
- integrate devtools-optimizer agent and skills hooks
- integrate Research Articles UI view in dashboard
- implement multi-source AI research article synthesis and validation
- article templates engine with 8 Jinja2 templates (Phase 1)
- register skill-detector in manifest + test fixtures
- skill library core — detector hook, discovery lib, index generator
- BackupFile hardening + on-demand skills deployment
- unwire rute kanban dari dashboard
- unwire command kanban & install-backup
- kanban dihapus dari runtime go — server/daemon/service/setup
- unwire kanban embedded assets
- acs-researcher PoC-validated output standard
- acs-researcher 7 Exa tools + per-tool guidance + regression guard
- daemon restart true-replace — ACS_DAEMON_RESTART=1 takeover on force
- single-instance + true-replace lifecycle for MCP bridge/daemon/gateway
- add bundled MCP agent definitions
- add local fallback CLI (list/call/health/fallback/serve)
- update hooks, hud tracking, and session settings
- wire auto-install + NpmShimNodeExec into bridge (Phase 2-3)
- auto-install + window-hide for acs-browser (Phase 1-2)
- add auto-continue Stop hook + task list enforcement
- researcher-agent stack — Go installer + agent/skill/config definitions
- add Node.js prerequisite via fnm
- route-layer semaphore + session safety + log purge + rate limiter cap (Fase 3/5/6)
- per-request proxy tracking + async logger + bounded concurrency
- add OMC component update logic and tests
- add restart endpoint to MCP API routes
- add MCP respawn daemon task with 60s periodic check
- add crash auto-restart with cooldown and hang detection
- self-hiding console via --hidden-window
- buffered publishDiagnostics + didOpen priming
- add acs-lsp server icon and browser-local tool labels in UI
- server routing for LSP tools, ownership API, and websocket integration
- browser-local OCR/PDF handlers, ownership guards, and LSP adapter
- route binary resolution, register wiring, and server lifecycle integration
- ownership-guarded tree reaping + orphan integration tests (F4)
- Windows Job Object tree-guard (KILL_ON_JOB_CLOSE) (F3)
- reap orphan children on crash + tree-reaping stop (F2)
- PID markers + startup sweeper for orphan cleanup (F1)
- cross-platform process-tree cleanup helpers (F0)
- ship auto-heal deploy artifacts (bundled mirror + settings wire)
- MCP tools on-demand + usage metrics (gold TDD)
- lifecycle manager + stdio client (gold TDD + race-safe)
- registry manifest + detect/install (gold TDD)
- deploy bundled hooks + sync template to manifest
- track hasil deep research .claude/research di git
- acs sync pipeline to ~/.claude/hooks (OMC-safe, dedupe dual-settings)
- migrate 12 hook sources + gold TDD tests + manifest
- PoC obfuscation pipeline (bundle+obfuscate+run)
- sub-endpoints /mcp/search & /mcp/browser + SSE streaming
- 9router user-stopped marker — respawn & heal skip saat user stop
- Phase 3 - Agent SDKs and documentation
- Phase 2 - VPS/Remote support with MCP bridge
- Phase 1 - Remove hardcoded token, add cross-platform env vars
- disable per-backend proxy toggles when proxy pool is off
- Stack update panel and API improvements
- Core infrastructure enhancements
- ACS Route management feature
- MCP proxy improvements
- API token management overhaul
- API token management overhaul — pagination, test, bulk revoke
- frontend API token integration + bug fixes
- auto-generate API token on first install
- API token management endpoints + comprehensive tests
- add CSRF protection middleware
- add error handler to prevent info leakage
- add input validation middleware
- add audit logging integrated with existing log registry
- add security headers middleware
- dual-auth system + JWT signature fix + rate limiting
- separate remove-failed/remove-disabled, precise auto-disable threshold, sticky rotation, route all MCP tools through proxy
- StreamableHTTP endpoint, external tool routing, acs-browser request logging
- track direct vs proxy routing in request logs with Proxy column
- auto-disable failed proxies, remove-failed button, toggle on/off, response column, status color fix (alive=green), sticky count config
- dedicated proxy pool independent from 9router with single/bulk input, import from 9router, concurrent health testing (concurrency 3), ConfirmDialog for delete, test all with bounded workers, health status tracking
- dedicated Key Pool — remove 9router dependency, direct Exa API calls
- config editor tab with presets
- task monitoring and progress tracking
- selective profile upgrade to standard config
- new standard config — 1M context, ACS MCP, delegation fix
- edit profile, clone gateway, reactive state, conditional guides
- enable all servers by default, fix agent sync path on Windows
- wire metrics for external tools — StatsTracker, LogRequest, server-level aggregation
- add acs-fastcontext-pattern exploration skill (v2.2.0)
- fix external tool test buttons, add CallHTTPTool, MCP architecture docs
- Clone Gateway UI — modal, card button, page wiring
- editable Profile tab in GatewayDetailModal
- add cloneGateway API function
- add Clone endpoint with TDD (8 test cases)
- frontend MCP Servers tab, toggle UX, connecting state
- backend servers API, bridge, config, tool test with real queries
- CloakBrowser bridge, MCP Servers tab, Agent Sync, maskKey fix
- enable skill_curator task (10min interval)
- add Skill Curator dashboard page
- add curator dashboard API routes
- add skill curator daemon package
- extend supervisor to respawn 9router and dashboard
- add explicit daemon stop/start/restart/status commands
- add CREATE_BREAKAWAY_FROM_JOB for true process independence
- add zero-AI stack detection for project analysis
- anthropic SSE fallback conversion + claude config UI improvements
- auto-restart hermes gateway after consumer tools update
- add provider filter to enowX AI account table
- redesign Consumers tab — grouped tabs + bulk sync panel
- sync enowxai key to config.yaml (not just .env)
- mcp-install seeds consumer tool configs in DB
- frontend proxy CRUD + sync feedback UI
- proxy add/delete/push routes + key sync on config save
- bidirectional key sync + proxy pool CRUD backend
- add enowxai sync verification endpoint
- add enowxai API key auto-sync on update/install
- add enowxai key sync engine
- add enowxai key detection and DB definition
- acs-cli mcp-install auto-registers MCP server
- proxy pool sync from 9router + MCP server stdio transport
- multi-key Exa pool with round-robin rotation
- dashboard log viewer with accordion + tool card stats
- MCP request logging with payload/response capture
- add profile sync indicator with auto-sync on mutations
- add entry animations and responsive polish
- add pagination + status filter + search to EnowAccountTable
- add install button for uninstalled enowxai
- add enowxai install endpoint
- wire enowxai update apply with progress
- add enowxai to component updater registry
- persistent recovery storage with blacklist and retry tracking
- wire enow health sidebar navigation and WS integration
- add EnowHealth page with pool status and recovery controls
- add enow health types and store
- add /api/enow/health routes for account pool management
- add enow account health auto-recovery task
- add health check client methods (warmup-single, fix-errors, accounts-list)
- add MCP Tools page with full backend API
- add acs-longrun-execution skill for buyer Hermes profiles
- add exa migrate command for MCP endpoint migration
- add MCP search server with 7 Exa tools
- add orphan gateway scan patch for --replace race condition
- restructure into acs-pipeline package (Section 11)
- include ACS skills (30) in token breakdown calculation
- add just agents-sync automation via 9router
- add distributed AGENTS.md per directory
- rewrite NAMING.md + refactor root AGENTS.md into lean index
- per-profile ACS skill selection in Config Manager
- show ACS skills source path in Claude CLI card
- add ACS skills to token calculator
- OMC bridge for ACS skills
- extend tooling-status API with ACS skills metadata
- boot reconciliation — stale PID cleanup, crashed gateway resume, restart lock clear
- scheduler task tracking, graceful stop reason, crash detection on boot
- atomic PID file writes (tmp+rename) for crash-safe state persistence
- graceful stop process (CTRL_BREAK → wait → force kill) for all service lifecycle paths
- token estimation calculator with per-category breakdown
- auto-inject ~/.acs/skills into legacy gateway profiles on patch
- skill version tracking via content hash
- force-update for ACS-managed skills on install
- router health check + auto-detection
- config locking per router profile
- router selector in Config Manager UI
- router switch API endpoint
- add router profile data model + storage
- frontend cost display for enowxai + all modes
- integrate cost calculation into enowxai proxy + unified chart
- add Go pricing engine (model table + pattern matching + calculator)
- add RouterSelector + stacked chart + Usage page router support
- add enowX AI backend routes with caching + unified chart endpoint
- populate Claude CLI model dropdowns from enowxai-adapter
- add claude-opus-4.7-1m to enowxai-adapter
- per-profile reset to ACS defaults
- enowXai + enowxai-adapter dashboard integration
- Phase 8 — polish (hideWindow, EnsureConfig, build tags)
- Phase 7 — stack integration
- Phase 5-6 — routes, handlers, server, PID management
- Phase 1-4 foundation — config, alias, sanitize, streaming
- model alias resolution + /v1/models endpoint
- real SSE streaming + error handling for OpenAI route
- real SSE streaming for OpenAI route in proxy v14
- v13 multi-model routing (gemini/kimi via chat/completions)

### Fixed
- commit leftover changes from agent
- use os.Executable() to resolve acs-cli path for auto-fixes
- resolve LookPath caching and hanging probes
- set WaitDelay for antigravity/mcp subprocesses
- set WaitDelay for claude version probe
- set WaitDelay for antigravity version probe
- clean up hardcoded paths and workspace names, optimize windows process check
- resolve Linux compilation errors for SysProcAttr by using cross-platform executil helpers
- frontend redirect and localhost callback port
- update acs-lsp configuration for force eager tools and skip prefix (task-1788606916892785500)
- use adaptive dynamic port for OAuth callback (task-1788606916892785500)
- bypass auth check in tests to prevent flaky rate limits and build failures
- resolve claude config test leak and ai audit empty plan type error
- standalone SSE MCP stream handshake & zero-task filter (task-1788430858203061000)
- correct omc version comparison and rename source to acs-hud
- increase startup timeout for Kompress optimizer
- correct OMC version update display logic to prevent downgrade prompts
- inject headroom to stack components payload so UI renders its ComponentCard
- resolve executable path to avoid invalid python module execution
- add headroom to service start and improve error messaging
- implement true update abort and make docking indicator draggable
- add tailscale status endpoint and windows discovery with serve detection
- prevent false positives in reconciliation with heartbeat and blank title guards
- persist article dock progress across route navigation
- clarify standby status labeling and prevent misleading depleted deletion (task-1788523569737389900)
- dynamic port awareness, strict TDD RGR rule, and expand acs-search to 9 core tools
- resolve diagnostic steps vertical layout, proxy tracking for codesearch and docs, and build runner path separator
- fix Antigravity quota auto-sleep, auto-awake and EDF relay controller
- resolve camoufox and seleniumbase execution and stdio reachability probe
- normalize MCP catalog display name and add testid for toggle switch
- use absolute URI file scheme for markdown preview images
- sync router profile, model engine config, and pipeline test guards
- eliminate zero-task projects from Project Hub and Kanban filter
- resolve standalone SSE stream retry timeout and route sub-server messages
- align research articles skeleton loading with multi-column grid
- filter antigravity projects to only load workspaces with active tasks
- add persistent server-side update tasks, reconciliation, and quick rollback
- add dedicated tab persistence and SPA direct fallback on refresh
- harden loopback auth check and prevent non-mcp auth bypass
- enforce 9router port 20128 and sanitize legacy acs-route references
- eliminate search false positives by stripping backlink footers in FTS5 and fix instant search reactivity
- isolate auth test auto-seeding, CSRF ports, and log cleanup
- dynamic user home and working directory resolution for project workspace
- allow oc and opencode free models in 9router models filter
- resolve staging signature verification and enhance activation UX
- replace && with ; in justfile staging recipe for PowerShell compat
- clean up ClaudeModelRouting, Sidebar, and dashboard pages
- improve MCP health check, install flow, and route handling
- audit stop-chain + auto-continue — 3 bugs fixed, 12 tests added
- rewrite precompact-context-save, fix wiki-save bugs, fix state corruption
- remove misleading 9router offline warnings and default to first combo
- fix acs-route service lifecycle and process tree kill
- improve service lifecycle, instant reactivity and hidden background spawning
- force npm CLI install for claude-code and improve update robustness
- improve update streaming, version detection, and toast deduplication
- mark ninerouter user stopped during full stop to prevent auto-respawn
- auto-rebuild related backlinks on article creation
- instant reactivity on refresh sources and SPA return_to persistence
- allow SPA routing on /mcp/articles and redirect HTML API requests
- sanitize footer placeholders and format related research links
- implement dual-layer cache and reactive markdown editor
- improve MCP server handler robustness and agent sync
- fetch full article payload to render raw markdown view
- silent background process execution flags
- refactor research articles theme styles to prevent light mode leakage
- add windowsHide to subprocess spawns on windows
- deploySkillsIndex read path — hooks/skills-index.json
- acs-researcher resolve project root via CWD, bukan hardcoded path
- dev build -trimpath + HUD deterministik + e2e unwire
- UTF-8 console reconfig in utils — Windows cp1252 crashed embed-stage message
- acs-researcher JSON serialization hardening — unescaped Windows backslashes
- self-heal ~/.acs/bin in persistent user PATH
- auto-register watchdog/backup tasks on daemon start
- HUD MCP count + raw-splice agent sync + setup skill
- assign ClaudeStackDir from TemplatesDir so deployAgents() finds bundled agents
- server field in request log + overview stats for all sub-servers
- route acs-browser restart to stdio path + surface bridge errors
- skip auth middleware for localhost connections
- add NpmShimNodeExec stub for non-Windows platforms
- bridge anti-drop — true-down restart only (Fase 4)
- wire uptime/lastTest to server list + fix handler imports
- resolve npm binary paths for Windows nvm environments
- change formatUptime to accept seconds instead of milliseconds
- wire uptime and lastTest to server list API
- hardening pass — clamp positions, normalize no-identifier, severity filter, usage clear-on-success
- remove hardcoded LSP test paths from frontend
- MCP servers running status + in-process server management
- WAL pragma, atomicwrite mutex, env persistence guard, setup cleanup
- acs-browser backend via gateway internal stdio -> streamable HTTP multi-session
- single-instance guarantee + auto-recovery stack
- harden pipeline against silent-stale failures
- self-prune config.BackupFile to DefaultKeep
- cap all backup patterns to 3 (agentic, config, pre-migrate)
- prune .acs-bak backups in migrate + rollback paths
- acs-browser tools tampil di GUI + multi-session verified
- restore acs-browser ke streamable HTTP + self-heal registry
- hapus acs-browser dari expected MCP servers — sudah tidak di-generate
- update enabledPlugins — hapus caveman + context-mode, tambah rust-analyzer-lsp
- hermes update — stop scheduler + kill hermes processes sebelum pip install
- stop 9router sebelum npm install + fix hermes pip fallback
- SetMaxOpenConns(1) cegah SQLITE_BUSY di TestTestToken_Revoked
- 9router check versi pakai npmjs (utama) + GitHub fallback
- state-based findExistingAPIKey + timeout; dedup key by name
- jangan bocorkan 9router key ke GitHub API
- /agentic page instant load via sessionStorage cache
- MCP page load 8s→instant + TS errors 217→0
- hide terminal windows across all runtime packages
- prevent terminal window spawning on Windows
- route builtin tool HTTP calls through proxy pool
- respect global proxy pool setting
- Windows 9router update reliability
- API tokens panel UI/UX improvements
- bypass EBUSY update corruption, add version detection, auto-repair on startup
- Claude Code MCP sync: command field for HTTP servers, full sync with cleanup
- normalize plain ip:port:user:pass format to http://user:pass@ip:port/, support plain ip:port without auth
- normalize plain ip:port:user:pass format to http://user:pass@ip:port/, support plain ip:port without auth, normalize before storage to prevent duplicate detection errors
- input validation and duplicate prevention — require http:// or socks5:// scheme, pre-check duplicate before insert, bulk import skips invalid/duplicate with count
- replace window.confirm with ConfirmDialog in McpKeyPool, ConfigEditor, GatewayConfigPanel
- api key column with masked display, eye toggle, click-to-copy, hover tooltip; backend sends full key, frontend handles masking; dedup via UNIQUE constraint
- stats persistence + auto-start external servers after restart
- complete all 25 browser tool test args, fix names, add HTTP server tools
- show all configured servers in Overview cards, use config toolCount
- update tide_release for new SSE endpoint
- read LLM config from .env.release instead of hardcoded values
- switch LLM endpoint from 9router to SSE endpoint
- wire WebSocket push handler to update gateway list
- instant state sync via WS + await refresh before unlock
- register missing restart route
- tide pause/resume to prevent polling race during lifecycle ops
- ensure minimum busy duration for loading overlay visibility
- proper lifecycle animation — locked card with spinner until PID confirmed
- fast restart path for dashboard — no slow graceful drain
- race condition guard between ACS self-heal and Hermes lifecycle
- graceful restart via StopGateway+StartGateway
- context_length 256k standard + silent gateway spawning
- acs-search test returns toolsCount from AllTools()
- graceful Windows gateway stop — prevent ghost hermes.exe
- toggle wiring — isOn() uses toolsCount, backend updates Status, skip builtin servers
- agent_research_exa - remove stale Exa-Beta header, add key pool rotation
- minor type fixes in TokenBreakdown and ToolProfilesPanel
- detect gateway crash loops + auto-repair hermes venv
- add frontend build + gateway recovery to install flow
- hide taskkill terminal flash on stop
- reliable start/stop with verified status
- stop via direct PID kill instead of CLI (bypasses anti-loop block)
- add hideWindow to prevent terminal flash on key detection
- strip duplicate keys from .env before writing managed block
- recovery history logs per-account email instead of generic bulk-fix
- replace non-existent theme tokens across remaining components
- exhausted accounts show 0/limit to avoid misleading credit display
- show credit labels, remove useless Enabled column, gray inactive bars
- CreditBar shows remaining credits, gray for inactive accounts
- pool stats count all providers, not just codebuddy
- prefer health store over dashboard cache for enowxai stats
- recovery history field mapping + fix-errors log to history
- enow components use correct theme tokens for dark mode
- StatusPill support 'ok' and 'active' as success tones
- all handlers use key pool instead of hardcoded cfg.ExaKey
- enowxai stats fallback from health store + fix last_recovery shape
- conditional section rendering by router tab
- accounts/stats reads real provider count from 9router DB
- update enow health route tests for DB-backed history
- fetch latest version even when component not installed
- remove standalone enow-health route and sidebar entry — embedded in Accounts
- restore EnowHealthSection component and wire into Accounts page
- return null instead of zero-time for last_recovery when never recovered
- include accounts and last_recovery in /api/enow/health/status response
- token_estimate uses breakdown.total (includes ACS skills)
- resolve remaining test failures across packages
- resolve test isolation for kanban DB env var priority
- prevent test hangs from exec.Command in server package
- expand E2E endpoint sweep from 11 to 91 endpoints
- robust auth token resolution with edge case handling
- RestartAllModal NaN display + defensive number coercion
- recover full stack after force-kill during install, graceful path only restarts dashboard+scheduler
- dev install stops only dashboard+scheduler, not entire stack
- loading spinner on router switch + fix stale refetch error
- auth token switching per router + pills spacing
- auto-refresh config after router switch + add tooltips
- add hermes patch 009 — resume-pending tz align
- register hermes patches 007 (stuck-loop) and 008 (budget-cap)
- remove hardcoded context_length from config template
- change preset toast from misleading 'Applied' to 'loaded — click Save'
- unwrap sections envelope in profile config PUT handler
- quote {ACS_HOME} placeholders in config-template.yaml
- add patch 006 for hermes anthropic None content crash
- precise PID + uptime for enowxai cards (PowerShell-based detection)
- hide terminal window in getPortPID (prevent flicker on WS tick)
- force headless mode for cloakbrowser MCP in all profiles
- update alias routing — sonnet→gemini-3.1-pro, haiku→gemini-2.5-pro
- keep Environment + Session-specific guidance in system prompt
- remove double-sanitize in proxy v14 OpenAI route
- patch Hermes session.py timezone bug via patchmgmt
- patch Hermes session.py timezone bug via patchmgmt
- release pipeline smart bump — skip if version already exceeds last tag

### Changed
- format and finalize test fixes
- remove personal developer paths from agentic tooling and LSP skill to satisfy pipeline hardening check
- auto-update README and handle fallback changelog
- prepare v1.0.0 release notes
- bump version to 1.0.0
- ignore emdash and repos sub-directories
- remove aggressive gateway recovery loop and update cli command mapping
- add atomic binary rename on Windows install to prevent file lock error
- unwire skill curator from sidebar navigation
- sync dashboard port resolution, preset atomic caching, and key pool invalidation
- deprecate and remove acs-route module across backend and frontend
- update local dev tools and root mcp configuration
- update daemon reconcile, scheduler, and service stack lifecycle
- remove broker/hermes/mesh/workflow routes, cleanup MCP and setup
- update App routing, Dashboard, API clients, and MCP install
- update dependency resolution, health checks, and automation runtime
- update session-end and stop-chain hooks, skills-index
- remove broker package and dashboard components
- remove 9router bidirectional password sync
- fix whitespace in meta routes
- update justfile, pipeline, and env detection for multi-env support
- update automation asset manifest, skill definition, and AGENTS.md
- update docsengine scanner, license test, and pipeline utils
- update db schema, pricing calculator, service stack, and updater components
- remove enowxai components and update stores/layout
- update routes for enowxai removal and router profiles
- remove ACS Skills section from ClaudeConfigPanel
- update Claude tool profiles and OpenCode model configs
- update agentic stack config, SEO isolation, and pipeline fixes
- add .dev.vars to gitignore
- single source of truth — relocate to repo-root agentic-stack/ + embed staging
- checkpoint audit + MCP on-demand fallback hardening
- rebuild obfuscated bundled hooks
- bridge buffer, HUD deploy, path refresh, auth test, OMC HUD MCP count, revert updater hardcoded path
- enhance bridge robustness, agent sync, and service setup
- restructure claude-stack ke directory terpisah + hermes-stack separation + hooks bundled fix + auto-continue stop hook
- add robustness load test script + plans
- add bundled hooks package.json template
- add depscan.py dependency scanner + baseline commit
- update comments referencing old mcpsearch package name
- update imports in 11 external files
- rename mcpsearch → mcpacs, split into 6 subpackages
- add depscan.py dependency scanner + baseline commit
- drop checkpoint tool hooks — checkpoint is server-side only
- remove project settings + add verify runner
- prune ACS backups cap 3 + remove caveman/context-mode legacy
- remove redundant builtin searchGitHub tool
- cleanup legacy + update MCP config
- MCP agent sync UI + API client cleanup
- simplify resolution + HTTP gateway URLs
- MCP config ke settings.json + .claude.json
- AgentSyncer interface + dual-file Claude sync
- hapus emoji dari log output service + ignore runtime DB backups
- remove exa MCP, replace with acs-search
- Update pnpm lockfile; remove stale internal/ directory
- add Biome lint + format, format all source files
- update .gitignore for nested repos, add untracked ACS files
- decouple daemon from StopStack kill sequence
- ignore packages/lycia/ (separate repo)
- add packages/tide-ui/ to gitignore (separate repo)
- go mod tidy
- extract AddAccountModal + OAuthFlows from Accounts page
- extract AccountsOverview with stats and router selector
- extract ProviderTable with responsive mobile cards
- replace PoC with deprecation shim → acs-pipeline
- consolidate AGENTS.md — single canonical at root
- clean up .gitignore + untrack nested repos
- move scripts/pre-commit-go-first.sh → .githooks/
- archive tools/skills-matrix.json (unused)
- consolidate changelogs — keep root CHANGELOG.md only
- remove docs-site/ from git tracking
- move bench-real/poc → packages/tide/bench/
- remove archive/ and .sisyphus/ from git tracking
- consolidate skills to src/skills/, remove obsolete root skills/
- gitignore proxy debug output

### Documentation
- update README title and logo to ACS
- update agent governance, kanban rules and backend engineering standards
- sanitize buyer-facing output descriptions for acs-search sub-tools
- add 3-stage empirical table and high-converting marketing analysis
- embed visual before-and-after proof for 88.4% idle token savings
- add Idle Context Tax case study and 82.6% token savings metrics
- mandate Kanban lifecycle sync for Antigravity Desktop and IDE
- add ACS ultimate advantage and marketing blueprint
- add system preset cloud distribution and admin push architecture plan
- mark global shared runtime and leak-free architecture as DONE
- add global shared runtime architecture and AWS deployment missions
- add adaptive stack, doctor settings, and AWS deployment plans
- update CLI reference, MCP architecture, config reference, and member setup guide
- save research and implementation plans for stateless REST and on-demand skills
- update agent documentation, changelog, and handoff guides
- update modular research engine, multi-agent modal, and search plans
- document resilient 3-tier search and knowledge protocol
- extend mcp article templates wireframes
- add 9router integration hardening plan with strict TDD
- align tool selection decision matrix with acs-lsp and grep
- commit work product riset MCP, web-scraping, Claude Code skills
- tandai kanban unwired + hapus index skills stale
- add MCP local fallback and docsgen plans
- update skill definitions and documentation
- add Robustness & Concurrency section to acs-search
- add MCP auto-heal plan and update setup configuration
- acs-lsp tools test matrix + inventory + tool registry (8/8 real-tested)
- commit deep research reports, stack audit, and runtime state ignores
- commit plans, specs, task records, and ignore browser-session assets
- add threads login page screenshot asset
- add acs-browser evidence assets and ignore sensitive artifacts
- finalize 26-tool acs-browser deep-research (all variants COMPLETE)
- reflect mcp-pre-tool auto-heal in README (13 hooks)
- revisi laporan LSP — koreksi istilah + ramah pemula
- setup, usage, rollback, lifecycle
- update Claude Code & OpenCode stack references + remove OCS legacy
- add skill_curator to CLI reference + CHANGELOG
- add tool-profiles guide to member docs


## [v1.0.0] - 2026-09-05


### Added
- update antigravity preset to medium & fix kanban optimistic UI revert on audit fail (task-1788606916892785500)
- setup ACS MCP server integrations & dependencies (task-4)
- implement LLM Semantic Plan Verifier for Kanban tasks (task-1788532089450781500)
- implement MCP antigravity catalog interactivity and global setup (task-1788429328644276600)
- add tooltip and hint to headroom config for manual restart requirement
- implement antigravity auto-execution policies and artifact review mode
- implement LLM Semantic Plan Verifier for Kanban tasks (task-1788532089450781500)
- auto-advance tasks on commit and auto-supersede stale in_progress cards
- implement global article dock progress indicator and reactive list refresh
- implement adaptive content format and intent-driven outlines (task-1788521014979794800)
- implement content-aware semantic related articles engine (task-1788519628030197500)
- fix ToC heading navigation and add regression guards (task-1788517670620700000)
- add multimodal vision, URL pre-fetch fallback and research taxonomy
- enhance Antigravity task lifecycle and manager dashboard
- adopt global CLAUDE.md standards into universal agnostic backend engineering rule
- bundle modular on-demand rules in agentic-stack and auto-deploy during setup/sync
- map all 9 acs-search sub-tools and update tool counts
- add on-demand MCP governance matrix and lazy-loading rules
- add accessible tooltips across Agentic Claude configuration panel
- modularize Antigravity ruleset to 100% on-demand model_decision rules
- make Antigravity MCP catalog interactive and enforce 100% on-demand skills
- auto-sync dynamic MCP port on server boot
- sync Antigravity MCP port on startup and unwire legacy Hermes settings
- verify global skills and bin paths in diagnostics
- add 9router MITM auto-mapping and interception status
- add project filter, workspace detection hub, and proxy auto-fallback
- complete total audit of GUI, network, security, and kanban agent/worker connectivity
- integrate Antigravity Suite, auto-approve MCP, on-demand skills & Kanban project discovery
- add native mcp_config.json support for Antigravity Desktop and agent sync
- connect official acs mcp servers and harmonize browser automation
- enable admin system preset updates and route to Cloudflare acs-api.uikode.com
- add antigravity manager, sidebar integration, and dedicated mcp tab routing
- add proxy resilience, instant auto-disable, 3x circuit breaker, and 9router import dedupe
- implement multi-tier preset distribution, cloudflare D1 registry sync, and admin publish modal
- add antigravity agentic stack templates, ~/.gemini auto-sync, and setup step
- sync dev database, remove obsolete exa env keys, and add mcp key pool doctor inspection
- integrate headroom atomic mutex lock, process tree cleanup, and global venv linking
- add empty tasklist stop guard and update HUD pipeline
- introduce global shared Python venv and doctor caching
- atomic 9router startup mutex and zero-leak process lifecycle
- centralize zero-window CLI execution and OS-level PID locking
- standardize cloud industry tiering, zero-window CLI, and settings diagnostics
- implement ACS Agent Manager with dynamic gateway model routing and article synthesizer integration
- add per-project Claude model presets and tier routing manager
- integrate context compression proxy, auto-setup, and 9router settings bridge
- add ACS Agent Manager and project MCP workspace integration
- enhance Claude config panel, HUD scripts, and agentic routes
- add article task tracking and research articles page enhancements
- add MCP registry management, project workspace, and article synthesis improvements
- improve log streaming, level filtering, and UI display
- add model tiers resolution and health check probe
- add staged model preset selection and remove combo system preset
- update scheduler config, mesh deliver, kanban reconciler, and task wrappers
- update MCP server agent sync, migration, and frontend components
- update gateway manager, profiles, and dashboard components
- add default password seeding (12345678) and password-status endpoint
- add dev/prod DB sync commands with build-tag gating
- add license gate flow for staging
- add enowxai adapter, API key sync, and health monitoring
- add dev/staging/prod environment separation system
- add startup gate, encrypted cache, and security hardening
- add license validation system (Phases 0-4)
- consolidate 9router model routing, dynamic presets, and active model discovery
- add title regeneration button and collapsible user prompt toggle
- add query distillation for research handlers and persist updated queries
- query npm registry directly for upstream versions and remove hermes from stack
- extract shared AI client and enhance What's New with agentic changelog audit
- optimize acs-search immediate digest and harden stdio browser stability
- remove enowxai and enowxai-adapter from stack manager and updater
- cleanup deprecated settings, streamline navigation, and redesign logs view
- standardize acs logs registry, directory isolation, and 1MB rotation limit
- add original_query tracking and dual-query lookup in article cache
- integrate OMC v5.0.2 hook chaining, circuit breaker, and orchestrator protocol
- add live-over-cache and anti-stale investigation rules
- integrate OMC v5.0.2 with 4-tier model hierarchy
- add per-article rebuild, instant ToC and URL state persistence
- enhance knowledge synthesis, semantic backlink graph, and references sync
- calibrate semantic scoring and add rebuild related API
- add quality gate to filter trivial queries from knowledge base
- add CLI model preset command for Claude and OpenCode
- add interactive raw markdown editor and article update API
- add 1-click copy raw markdown url button to article header
- multi-agent research modal with custom outline and intent support
- wire agentic research route and background scheduler
- AI intent planner, Jinja2 prompt templates, and multi-MCP agentic dispatcher
- semantic relatedness scoring and mismatched backlink pruning
- instant search, blog reader layout and high-contrast code theme
- cache-first search, bidirectional internal linking and semantic taxonomy
- blog-style article reader, sticky table of contents, instant search, and light mode contrast
- cache-first interception in exa search handlers and category filter api
- add article cache store, semantic categorization and taxonomy normalizer
- task deduplication & anti-loop state tracker hardening
- integrate devtools-optimizer agent and skills hooks
- integrate Research Articles UI view in dashboard
- implement multi-source AI research article synthesis and validation
- article templates engine with 8 Jinja2 templates (Phase 1)
- register skill-detector in manifest + test fixtures
- skill library core — detector hook, discovery lib, index generator
- BackupFile hardening + on-demand skills deployment
- unwire rute kanban dari dashboard
- unwire command kanban & install-backup
- kanban dihapus dari runtime go — server/daemon/service/setup
- unwire kanban embedded assets
- acs-researcher PoC-validated output standard
- acs-researcher 7 Exa tools + per-tool guidance + regression guard
- daemon restart true-replace — ACS_DAEMON_RESTART=1 takeover on force
- single-instance + true-replace lifecycle for MCP bridge/daemon/gateway
- add bundled MCP agent definitions
- add local fallback CLI (list/call/health/fallback/serve)
- update hooks, hud tracking, and session settings
- wire auto-install + NpmShimNodeExec into bridge (Phase 2-3)
- auto-install + window-hide for acs-browser (Phase 1-2)
- add auto-continue Stop hook + task list enforcement
- researcher-agent stack — Go installer + agent/skill/config definitions
- add Node.js prerequisite via fnm
- route-layer semaphore + session safety + log purge + rate limiter cap (Fase 3/5/6)
- per-request proxy tracking + async logger + bounded concurrency
- add OMC component update logic and tests
- add restart endpoint to MCP API routes
- add MCP respawn daemon task with 60s periodic check
- add crash auto-restart with cooldown and hang detection
- self-hiding console via --hidden-window
- buffered publishDiagnostics + didOpen priming
- add acs-lsp server icon and browser-local tool labels in UI
- server routing for LSP tools, ownership API, and websocket integration
- browser-local OCR/PDF handlers, ownership guards, and LSP adapter
- route binary resolution, register wiring, and server lifecycle integration
- ownership-guarded tree reaping + orphan integration tests (F4)
- Windows Job Object tree-guard (KILL_ON_JOB_CLOSE) (F3)
- reap orphan children on crash + tree-reaping stop (F2)
- PID markers + startup sweeper for orphan cleanup (F1)
- cross-platform process-tree cleanup helpers (F0)
- ship auto-heal deploy artifacts (bundled mirror + settings wire)
- MCP tools on-demand + usage metrics (gold TDD)
- lifecycle manager + stdio client (gold TDD + race-safe)
- registry manifest + detect/install (gold TDD)
- deploy bundled hooks + sync template to manifest
- track hasil deep research .claude/research di git
- acs sync pipeline to ~/.claude/hooks (OMC-safe, dedupe dual-settings)
- migrate 12 hook sources + gold TDD tests + manifest
- PoC obfuscation pipeline (bundle+obfuscate+run)
- sub-endpoints /mcp/search & /mcp/browser + SSE streaming
- 9router user-stopped marker — respawn & heal skip saat user stop
- Phase 3 - Agent SDKs and documentation
- Phase 2 - VPS/Remote support with MCP bridge
- Phase 1 - Remove hardcoded token, add cross-platform env vars
- disable per-backend proxy toggles when proxy pool is off
- Stack update panel and API improvements
- Core infrastructure enhancements
- ACS Route management feature
- MCP proxy improvements
- API token management overhaul
- API token management overhaul — pagination, test, bulk revoke
- frontend API token integration + bug fixes
- auto-generate API token on first install
- API token management endpoints + comprehensive tests
- add CSRF protection middleware
- add error handler to prevent info leakage
- add input validation middleware
- add audit logging integrated with existing log registry
- add security headers middleware
- dual-auth system + JWT signature fix + rate limiting
- separate remove-failed/remove-disabled, precise auto-disable threshold, sticky rotation, route all MCP tools through proxy
- StreamableHTTP endpoint, external tool routing, acs-browser request logging
- track direct vs proxy routing in request logs with Proxy column
- auto-disable failed proxies, remove-failed button, toggle on/off, response column, status color fix (alive=green), sticky count config
- dedicated proxy pool independent from 9router with single/bulk input, import from 9router, concurrent health testing (concurrency 3), ConfirmDialog for delete, test all with bounded workers, health status tracking
- dedicated Key Pool — remove 9router dependency, direct Exa API calls
- config editor tab with presets
- task monitoring and progress tracking
- selective profile upgrade to standard config
- new standard config — 1M context, ACS MCP, delegation fix
- edit profile, clone gateway, reactive state, conditional guides
- enable all servers by default, fix agent sync path on Windows
- wire metrics for external tools — StatsTracker, LogRequest, server-level aggregation
- add acs-fastcontext-pattern exploration skill (v2.2.0)
- fix external tool test buttons, add CallHTTPTool, MCP architecture docs
- Clone Gateway UI — modal, card button, page wiring
- editable Profile tab in GatewayDetailModal
- add cloneGateway API function
- add Clone endpoint with TDD (8 test cases)
- frontend MCP Servers tab, toggle UX, connecting state
- backend servers API, bridge, config, tool test with real queries
- CloakBrowser bridge, MCP Servers tab, Agent Sync, maskKey fix
- enable skill_curator task (10min interval)
- add Skill Curator dashboard page
- add curator dashboard API routes
- add skill curator daemon package
- extend supervisor to respawn 9router and dashboard
- add explicit daemon stop/start/restart/status commands
- add CREATE_BREAKAWAY_FROM_JOB for true process independence
- add zero-AI stack detection for project analysis
- anthropic SSE fallback conversion + claude config UI improvements
- auto-restart hermes gateway after consumer tools update
- add provider filter to enowX AI account table
- redesign Consumers tab — grouped tabs + bulk sync panel
- sync enowxai key to config.yaml (not just .env)
- mcp-install seeds consumer tool configs in DB
- frontend proxy CRUD + sync feedback UI
- proxy add/delete/push routes + key sync on config save
- bidirectional key sync + proxy pool CRUD backend
- add enowxai sync verification endpoint
- add enowxai API key auto-sync on update/install
- add enowxai key sync engine
- add enowxai key detection and DB definition
- acs-cli mcp-install auto-registers MCP server
- proxy pool sync from 9router + MCP server stdio transport
- multi-key Exa pool with round-robin rotation
- dashboard log viewer with accordion + tool card stats
- MCP request logging with payload/response capture
- add profile sync indicator with auto-sync on mutations
- add entry animations and responsive polish
- add pagination + status filter + search to EnowAccountTable
- add install button for uninstalled enowxai
- add enowxai install endpoint
- wire enowxai update apply with progress
- add enowxai to component updater registry
- persistent recovery storage with blacklist and retry tracking
- wire enow health sidebar navigation and WS integration
- add EnowHealth page with pool status and recovery controls
- add enow health types and store
- add /api/enow/health routes for account pool management
- add enow account health auto-recovery task
- add health check client methods (warmup-single, fix-errors, accounts-list)
- add MCP Tools page with full backend API
- add acs-longrun-execution skill for buyer Hermes profiles
- add exa migrate command for MCP endpoint migration
- add MCP search server with 7 Exa tools
- add orphan gateway scan patch for --replace race condition
- restructure into acs-pipeline package (Section 11)
- include ACS skills (30) in token breakdown calculation
- add just agents-sync automation via 9router
- add distributed AGENTS.md per directory
- rewrite NAMING.md + refactor root AGENTS.md into lean index
- per-profile ACS skill selection in Config Manager
- show ACS skills source path in Claude CLI card
- add ACS skills to token calculator
- OMC bridge for ACS skills
- extend tooling-status API with ACS skills metadata
- boot reconciliation — stale PID cleanup, crashed gateway resume, restart lock clear
- scheduler task tracking, graceful stop reason, crash detection on boot
- atomic PID file writes (tmp+rename) for crash-safe state persistence
- graceful stop process (CTRL_BREAK → wait → force kill) for all service lifecycle paths
- token estimation calculator with per-category breakdown
- auto-inject ~/.acs/skills into legacy gateway profiles on patch
- skill version tracking via content hash
- force-update for ACS-managed skills on install
- router health check + auto-detection
- config locking per router profile
- router selector in Config Manager UI
- router switch API endpoint
- add router profile data model + storage
- frontend cost display for enowxai + all modes
- integrate cost calculation into enowxai proxy + unified chart
- add Go pricing engine (model table + pattern matching + calculator)
- add RouterSelector + stacked chart + Usage page router support
- add enowX AI backend routes with caching + unified chart endpoint
- populate Claude CLI model dropdowns from enowxai-adapter
- add claude-opus-4.7-1m to enowxai-adapter
- per-profile reset to ACS defaults
- enowXai + enowxai-adapter dashboard integration
- Phase 8 — polish (hideWindow, EnsureConfig, build tags)
- Phase 7 — stack integration
- Phase 5-6 — routes, handlers, server, PID management
- Phase 1-4 foundation — config, alias, sanitize, streaming
- model alias resolution + /v1/models endpoint
- real SSE streaming + error handling for OpenAI route
- real SSE streaming for OpenAI route in proxy v14
- v13 multi-model routing (gemini/kimi via chat/completions)

### Fixed
- resolve Linux compilation errors for SysProcAttr by using cross-platform executil helpers
- frontend redirect and localhost callback port
- update acs-lsp configuration for force eager tools and skip prefix (task-1788606916892785500)
- use adaptive dynamic port for OAuth callback (task-1788606916892785500)
- bypass auth check in tests to prevent flaky rate limits and build failures
- resolve claude config test leak and ai audit empty plan type error
- standalone SSE MCP stream handshake & zero-task filter (task-1788430858203061000)
- correct omc version comparison and rename source to acs-hud
- increase startup timeout for Kompress optimizer
- correct OMC version update display logic to prevent downgrade prompts
- inject headroom to stack components payload so UI renders its ComponentCard
- resolve executable path to avoid invalid python module execution
- add headroom to service start and improve error messaging
- implement true update abort and make docking indicator draggable
- add tailscale status endpoint and windows discovery with serve detection
- prevent false positives in reconciliation with heartbeat and blank title guards
- persist article dock progress across route navigation
- clarify standby status labeling and prevent misleading depleted deletion (task-1788523569737389900)
- dynamic port awareness, strict TDD RGR rule, and expand acs-search to 9 core tools
- resolve diagnostic steps vertical layout, proxy tracking for codesearch and docs, and build runner path separator
- fix Antigravity quota auto-sleep, auto-awake and EDF relay controller
- resolve camoufox and seleniumbase execution and stdio reachability probe
- normalize MCP catalog display name and add testid for toggle switch
- use absolute URI file scheme for markdown preview images
- sync router profile, model engine config, and pipeline test guards
- eliminate zero-task projects from Project Hub and Kanban filter
- resolve standalone SSE stream retry timeout and route sub-server messages
- align research articles skeleton loading with multi-column grid
- filter antigravity projects to only load workspaces with active tasks
- add persistent server-side update tasks, reconciliation, and quick rollback
- add dedicated tab persistence and SPA direct fallback on refresh
- harden loopback auth check and prevent non-mcp auth bypass
- enforce 9router port 20128 and sanitize legacy acs-route references
- eliminate search false positives by stripping backlink footers in FTS5 and fix instant search reactivity
- isolate auth test auto-seeding, CSRF ports, and log cleanup
- dynamic user home and working directory resolution for project workspace
- allow oc and opencode free models in 9router models filter
- resolve staging signature verification and enhance activation UX
- replace && with ; in justfile staging recipe for PowerShell compat
- clean up ClaudeModelRouting, Sidebar, and dashboard pages
- improve MCP health check, install flow, and route handling
- audit stop-chain + auto-continue — 3 bugs fixed, 12 tests added
- rewrite precompact-context-save, fix wiki-save bugs, fix state corruption
- remove misleading 9router offline warnings and default to first combo
- fix acs-route service lifecycle and process tree kill
- improve service lifecycle, instant reactivity and hidden background spawning
- force npm CLI install for claude-code and improve update robustness
- improve update streaming, version detection, and toast deduplication
- mark ninerouter user stopped during full stop to prevent auto-respawn
- auto-rebuild related backlinks on article creation
- instant reactivity on refresh sources and SPA return_to persistence
- allow SPA routing on /mcp/articles and redirect HTML API requests
- sanitize footer placeholders and format related research links
- implement dual-layer cache and reactive markdown editor
- improve MCP server handler robustness and agent sync
- fetch full article payload to render raw markdown view
- silent background process execution flags
- refactor research articles theme styles to prevent light mode leakage
- add windowsHide to subprocess spawns on windows
- deploySkillsIndex read path — hooks/skills-index.json
- acs-researcher resolve project root via CWD, bukan hardcoded path
- dev build -trimpath + HUD deterministik + e2e unwire
- UTF-8 console reconfig in utils — Windows cp1252 crashed embed-stage message
- acs-researcher JSON serialization hardening — unescaped Windows backslashes
- self-heal ~/.acs/bin in persistent user PATH
- auto-register watchdog/backup tasks on daemon start
- HUD MCP count + raw-splice agent sync + setup skill
- assign ClaudeStackDir from TemplatesDir so deployAgents() finds bundled agents
- server field in request log + overview stats for all sub-servers
- route acs-browser restart to stdio path + surface bridge errors
- skip auth middleware for localhost connections
- add NpmShimNodeExec stub for non-Windows platforms
- bridge anti-drop — true-down restart only (Fase 4)
- wire uptime/lastTest to server list + fix handler imports
- resolve npm binary paths for Windows nvm environments
- change formatUptime to accept seconds instead of milliseconds
- wire uptime and lastTest to server list API
- hardening pass — clamp positions, normalize no-identifier, severity filter, usage clear-on-success
- remove hardcoded LSP test paths from frontend
- MCP servers running status + in-process server management
- WAL pragma, atomicwrite mutex, env persistence guard, setup cleanup
- acs-browser backend via gateway internal stdio -> streamable HTTP multi-session
- single-instance guarantee + auto-recovery stack
- harden pipeline against silent-stale failures
- self-prune config.BackupFile to DefaultKeep
- cap all backup patterns to 3 (agentic, config, pre-migrate)
- prune .acs-bak backups in migrate + rollback paths
- acs-browser tools tampil di GUI + multi-session verified
- restore acs-browser ke streamable HTTP + self-heal registry
- hapus acs-browser dari expected MCP servers — sudah tidak di-generate
- update enabledPlugins — hapus caveman + context-mode, tambah rust-analyzer-lsp
- hermes update — stop scheduler + kill hermes processes sebelum pip install
- stop 9router sebelum npm install + fix hermes pip fallback
- SetMaxOpenConns(1) cegah SQLITE_BUSY di TestTestToken_Revoked
- 9router check versi pakai npmjs (utama) + GitHub fallback
- state-based findExistingAPIKey + timeout; dedup key by name
- jangan bocorkan 9router key ke GitHub API
- /agentic page instant load via sessionStorage cache
- MCP page load 8s→instant + TS errors 217→0
- hide terminal windows across all runtime packages
- prevent terminal window spawning on Windows
- route builtin tool HTTP calls through proxy pool
- respect global proxy pool setting
- Windows 9router update reliability
- API tokens panel UI/UX improvements
- bypass EBUSY update corruption, add version detection, auto-repair on startup
- Claude Code MCP sync: command field for HTTP servers, full sync with cleanup
- normalize plain ip:port:user:pass format to http://user:pass@ip:port/, support plain ip:port without auth
- normalize plain ip:port:user:pass format to http://user:pass@ip:port/, support plain ip:port without auth, normalize before storage to prevent duplicate detection errors
- input validation and duplicate prevention — require http:// or socks5:// scheme, pre-check duplicate before insert, bulk import skips invalid/duplicate with count
- replace window.confirm with ConfirmDialog in McpKeyPool, ConfigEditor, GatewayConfigPanel
- api key column with masked display, eye toggle, click-to-copy, hover tooltip; backend sends full key, frontend handles masking; dedup via UNIQUE constraint
- stats persistence + auto-start external servers after restart
- complete all 25 browser tool test args, fix names, add HTTP server tools
- show all configured servers in Overview cards, use config toolCount
- update tide_release for new SSE endpoint
- read LLM config from .env.release instead of hardcoded values
- switch LLM endpoint from 9router to SSE endpoint
- wire WebSocket push handler to update gateway list
- instant state sync via WS + await refresh before unlock
- register missing restart route
- tide pause/resume to prevent polling race during lifecycle ops
- ensure minimum busy duration for loading overlay visibility
- proper lifecycle animation — locked card with spinner until PID confirmed
- fast restart path for dashboard — no slow graceful drain
- race condition guard between ACS self-heal and Hermes lifecycle
- graceful restart via StopGateway+StartGateway
- context_length 256k standard + silent gateway spawning
- acs-search test returns toolsCount from AllTools()
- graceful Windows gateway stop — prevent ghost hermes.exe
- toggle wiring — isOn() uses toolsCount, backend updates Status, skip builtin servers
- agent_research_exa - remove stale Exa-Beta header, add key pool rotation
- minor type fixes in TokenBreakdown and ToolProfilesPanel
- detect gateway crash loops + auto-repair hermes venv
- add frontend build + gateway recovery to install flow
- hide taskkill terminal flash on stop
- reliable start/stop with verified status
- stop via direct PID kill instead of CLI (bypasses anti-loop block)
- add hideWindow to prevent terminal flash on key detection
- strip duplicate keys from .env before writing managed block
- recovery history logs per-account email instead of generic bulk-fix
- replace non-existent theme tokens across remaining components
- exhausted accounts show 0/limit to avoid misleading credit display
- show credit labels, remove useless Enabled column, gray inactive bars
- CreditBar shows remaining credits, gray for inactive accounts
- pool stats count all providers, not just codebuddy
- prefer health store over dashboard cache for enowxai stats
- recovery history field mapping + fix-errors log to history
- enow components use correct theme tokens for dark mode
- StatusPill support 'ok' and 'active' as success tones
- all handlers use key pool instead of hardcoded cfg.ExaKey
- enowxai stats fallback from health store + fix last_recovery shape
- conditional section rendering by router tab
- accounts/stats reads real provider count from 9router DB
- update enow health route tests for DB-backed history
- fetch latest version even when component not installed
- remove standalone enow-health route and sidebar entry — embedded in Accounts
- restore EnowHealthSection component and wire into Accounts page
- return null instead of zero-time for last_recovery when never recovered
- include accounts and last_recovery in /api/enow/health/status response
- token_estimate uses breakdown.total (includes ACS skills)
- resolve remaining test failures across packages
- resolve test isolation for kanban DB env var priority
- prevent test hangs from exec.Command in server package
- expand E2E endpoint sweep from 11 to 91 endpoints
- robust auth token resolution with edge case handling
- RestartAllModal NaN display + defensive number coercion
- recover full stack after force-kill during install, graceful path only restarts dashboard+scheduler
- dev install stops only dashboard+scheduler, not entire stack
- loading spinner on router switch + fix stale refetch error
- auth token switching per router + pills spacing
- auto-refresh config after router switch + add tooltips
- add hermes patch 009 — resume-pending tz align
- register hermes patches 007 (stuck-loop) and 008 (budget-cap)
- remove hardcoded context_length from config template
- change preset toast from misleading 'Applied' to 'loaded — click Save'
- unwrap sections envelope in profile config PUT handler
- quote {ACS_HOME} placeholders in config-template.yaml
- add patch 006 for hermes anthropic None content crash
- precise PID + uptime for enowxai cards (PowerShell-based detection)
- hide terminal window in getPortPID (prevent flicker on WS tick)
- force headless mode for cloakbrowser MCP in all profiles
- update alias routing — sonnet→gemini-3.1-pro, haiku→gemini-2.5-pro
- keep Environment + Session-specific guidance in system prompt
- remove double-sanitize in proxy v14 OpenAI route
- patch Hermes session.py timezone bug via patchmgmt
- patch Hermes session.py timezone bug via patchmgmt
- release pipeline smart bump — skip if version already exceeds last tag

### Changed
- prepare v1.0.0 release notes
- bump version to 1.0.0
- ignore emdash and repos sub-directories
- remove aggressive gateway recovery loop and update cli command mapping
- add atomic binary rename on Windows install to prevent file lock error
- unwire skill curator from sidebar navigation
- sync dashboard port resolution, preset atomic caching, and key pool invalidation
- deprecate and remove acs-route module across backend and frontend
- update local dev tools and root mcp configuration
- update daemon reconcile, scheduler, and service stack lifecycle
- remove broker/hermes/mesh/workflow routes, cleanup MCP and setup
- update App routing, Dashboard, API clients, and MCP install
- update dependency resolution, health checks, and automation runtime
- update session-end and stop-chain hooks, skills-index
- remove broker package and dashboard components
- remove 9router bidirectional password sync
- fix whitespace in meta routes
- update justfile, pipeline, and env detection for multi-env support
- update automation asset manifest, skill definition, and AGENTS.md
- update docsengine scanner, license test, and pipeline utils
- update db schema, pricing calculator, service stack, and updater components
- remove enowxai components and update stores/layout
- update routes for enowxai removal and router profiles
- remove ACS Skills section from ClaudeConfigPanel
- update Claude tool profiles and OpenCode model configs
- update agentic stack config, SEO isolation, and pipeline fixes
- add .dev.vars to gitignore
- single source of truth — relocate to repo-root agentic-stack/ + embed staging
- checkpoint audit + MCP on-demand fallback hardening
- rebuild obfuscated bundled hooks
- bridge buffer, HUD deploy, path refresh, auth test, OMC HUD MCP count, revert updater hardcoded path
- enhance bridge robustness, agent sync, and service setup
- restructure claude-stack ke directory terpisah + hermes-stack separation + hooks bundled fix + auto-continue stop hook
- add robustness load test script + plans
- add bundled hooks package.json template
- add depscan.py dependency scanner + baseline commit
- update comments referencing old mcpsearch package name
- update imports in 11 external files
- rename mcpsearch → mcpacs, split into 6 subpackages
- add depscan.py dependency scanner + baseline commit
- drop checkpoint tool hooks — checkpoint is server-side only
- remove project settings + add verify runner
- prune ACS backups cap 3 + remove caveman/context-mode legacy
- remove redundant builtin searchGitHub tool
- cleanup legacy + update MCP config
- MCP agent sync UI + API client cleanup
- simplify resolution + HTTP gateway URLs
- MCP config ke settings.json + .claude.json
- AgentSyncer interface + dual-file Claude sync
- hapus emoji dari log output service + ignore runtime DB backups
- remove exa MCP, replace with acs-search
- Update pnpm lockfile; remove stale internal/ directory
- add Biome lint + format, format all source files
- update .gitignore for nested repos, add untracked ACS files
- decouple daemon from StopStack kill sequence
- ignore packages/lycia/ (separate repo)
- add packages/tide-ui/ to gitignore (separate repo)
- go mod tidy
- extract AddAccountModal + OAuthFlows from Accounts page
- extract AccountsOverview with stats and router selector
- extract ProviderTable with responsive mobile cards
- replace PoC with deprecation shim → acs-pipeline
- consolidate AGENTS.md — single canonical at root
- clean up .gitignore + untrack nested repos
- move scripts/pre-commit-go-first.sh → .githooks/
- archive tools/skills-matrix.json (unused)
- consolidate changelogs — keep root CHANGELOG.md only
- remove docs-site/ from git tracking
- move bench-real/poc → packages/tide/bench/
- remove archive/ and .sisyphus/ from git tracking
- consolidate skills to src/skills/, remove obsolete root skills/
- gitignore proxy debug output

### Documentation
- update agent governance, kanban rules and backend engineering standards
- sanitize buyer-facing output descriptions for acs-search sub-tools
- add 3-stage empirical table and high-converting marketing analysis
- embed visual before-and-after proof for 88.4% idle token savings
- add Idle Context Tax case study and 82.6% token savings metrics
- mandate Kanban lifecycle sync for Antigravity Desktop and IDE
- add ACS ultimate advantage and marketing blueprint
- add system preset cloud distribution and admin push architecture plan
- mark global shared runtime and leak-free architecture as DONE
- add global shared runtime architecture and AWS deployment missions
- add adaptive stack, doctor settings, and AWS deployment plans
- update CLI reference, MCP architecture, config reference, and member setup guide
- save research and implementation plans for stateless REST and on-demand skills
- update agent documentation, changelog, and handoff guides
- update modular research engine, multi-agent modal, and search plans
- document resilient 3-tier search and knowledge protocol
- extend mcp article templates wireframes
- add 9router integration hardening plan with strict TDD
- align tool selection decision matrix with acs-lsp and grep
- commit work product riset MCP, web-scraping, Claude Code skills
- tandai kanban unwired + hapus index skills stale
- add MCP local fallback and docsgen plans
- update skill definitions and documentation
- add Robustness & Concurrency section to acs-search
- add MCP auto-heal plan and update setup configuration
- acs-lsp tools test matrix + inventory + tool registry (8/8 real-tested)
- commit deep research reports, stack audit, and runtime state ignores
- commit plans, specs, task records, and ignore browser-session assets
- add threads login page screenshot asset
- add acs-browser evidence assets and ignore sensitive artifacts
- finalize 26-tool acs-browser deep-research (all variants COMPLETE)
- reflect mcp-pre-tool auto-heal in README (13 hooks)
- revisi laporan LSP — koreksi istilah + ramah pemula
- setup, usage, rollback, lifecycle
- update Claude Code & OpenCode stack references + remove OCS legacy
- add skill_curator to CLI reference + CHANGELOG
- add tool-profiles guide to member docs


## [v1.0.0] - 2026-09-05


### Added
- update antigravity preset to medium & fix kanban optimistic UI revert on audit fail (task-1788606916892785500)
- setup ACS MCP server integrations & dependencies (task-4)
- implement LLM Semantic Plan Verifier for Kanban tasks (task-1788532089450781500)
- implement MCP antigravity catalog interactivity and global setup (task-1788429328644276600)
- add tooltip and hint to headroom config for manual restart requirement
- implement antigravity auto-execution policies and artifact review mode
- implement LLM Semantic Plan Verifier for Kanban tasks (task-1788532089450781500)
- auto-advance tasks on commit and auto-supersede stale in_progress cards
- implement global article dock progress indicator and reactive list refresh
- implement adaptive content format and intent-driven outlines (task-1788521014979794800)
- implement content-aware semantic related articles engine (task-1788519628030197500)
- fix ToC heading navigation and add regression guards (task-1788517670620700000)
- add multimodal vision, URL pre-fetch fallback and research taxonomy
- enhance Antigravity task lifecycle and manager dashboard
- adopt global CLAUDE.md standards into universal agnostic backend engineering rule
- bundle modular on-demand rules in agentic-stack and auto-deploy during setup/sync
- map all 9 acs-search sub-tools and update tool counts
- add on-demand MCP governance matrix and lazy-loading rules
- add accessible tooltips across Agentic Claude configuration panel
- modularize Antigravity ruleset to 100% on-demand model_decision rules
- make Antigravity MCP catalog interactive and enforce 100% on-demand skills
- auto-sync dynamic MCP port on server boot
- sync Antigravity MCP port on startup and unwire legacy Hermes settings
- verify global skills and bin paths in diagnostics
- add 9router MITM auto-mapping and interception status
- add project filter, workspace detection hub, and proxy auto-fallback
- complete total audit of GUI, network, security, and kanban agent/worker connectivity
- integrate Antigravity Suite, auto-approve MCP, on-demand skills & Kanban project discovery
- add native mcp_config.json support for Antigravity Desktop and agent sync
- connect official acs mcp servers and harmonize browser automation
- enable admin system preset updates and route to Cloudflare acs-api.uikode.com
- add antigravity manager, sidebar integration, and dedicated mcp tab routing
- add proxy resilience, instant auto-disable, 3x circuit breaker, and 9router import dedupe
- implement multi-tier preset distribution, cloudflare D1 registry sync, and admin publish modal
- add antigravity agentic stack templates, ~/.gemini auto-sync, and setup step
- sync dev database, remove obsolete exa env keys, and add mcp key pool doctor inspection
- integrate headroom atomic mutex lock, process tree cleanup, and global venv linking
- add empty tasklist stop guard and update HUD pipeline
- introduce global shared Python venv and doctor caching
- atomic 9router startup mutex and zero-leak process lifecycle
- centralize zero-window CLI execution and OS-level PID locking
- standardize cloud industry tiering, zero-window CLI, and settings diagnostics
- implement ACS Agent Manager with dynamic gateway model routing and article synthesizer integration
- add per-project Claude model presets and tier routing manager
- integrate context compression proxy, auto-setup, and 9router settings bridge
- add ACS Agent Manager and project MCP workspace integration
- enhance Claude config panel, HUD scripts, and agentic routes
- add article task tracking and research articles page enhancements
- add MCP registry management, project workspace, and article synthesis improvements
- improve log streaming, level filtering, and UI display
- add model tiers resolution and health check probe
- add staged model preset selection and remove combo system preset
- update scheduler config, mesh deliver, kanban reconciler, and task wrappers
- update MCP server agent sync, migration, and frontend components
- update gateway manager, profiles, and dashboard components
- add default password seeding (12345678) and password-status endpoint
- add dev/prod DB sync commands with build-tag gating
- add license gate flow for staging
- add enowxai adapter, API key sync, and health monitoring
- add dev/staging/prod environment separation system
- add startup gate, encrypted cache, and security hardening
- add license validation system (Phases 0-4)
- consolidate 9router model routing, dynamic presets, and active model discovery
- add title regeneration button and collapsible user prompt toggle
- add query distillation for research handlers and persist updated queries
- query npm registry directly for upstream versions and remove hermes from stack
- extract shared AI client and enhance What's New with agentic changelog audit
- optimize acs-search immediate digest and harden stdio browser stability
- remove enowxai and enowxai-adapter from stack manager and updater
- cleanup deprecated settings, streamline navigation, and redesign logs view
- standardize acs logs registry, directory isolation, and 1MB rotation limit
- add original_query tracking and dual-query lookup in article cache
- integrate OMC v5.0.2 hook chaining, circuit breaker, and orchestrator protocol
- add live-over-cache and anti-stale investigation rules
- integrate OMC v5.0.2 with 4-tier model hierarchy
- add per-article rebuild, instant ToC and URL state persistence
- enhance knowledge synthesis, semantic backlink graph, and references sync
- calibrate semantic scoring and add rebuild related API
- add quality gate to filter trivial queries from knowledge base
- add CLI model preset command for Claude and OpenCode
- add interactive raw markdown editor and article update API
- add 1-click copy raw markdown url button to article header
- multi-agent research modal with custom outline and intent support
- wire agentic research route and background scheduler
- AI intent planner, Jinja2 prompt templates, and multi-MCP agentic dispatcher
- semantic relatedness scoring and mismatched backlink pruning
- instant search, blog reader layout and high-contrast code theme
- cache-first search, bidirectional internal linking and semantic taxonomy
- blog-style article reader, sticky table of contents, instant search, and light mode contrast
- cache-first interception in exa search handlers and category filter api
- add article cache store, semantic categorization and taxonomy normalizer
- task deduplication & anti-loop state tracker hardening
- integrate devtools-optimizer agent and skills hooks
- integrate Research Articles UI view in dashboard
- implement multi-source AI research article synthesis and validation
- article templates engine with 8 Jinja2 templates (Phase 1)
- register skill-detector in manifest + test fixtures
- skill library core — detector hook, discovery lib, index generator
- BackupFile hardening + on-demand skills deployment
- unwire rute kanban dari dashboard
- unwire command kanban & install-backup
- kanban dihapus dari runtime go — server/daemon/service/setup
- unwire kanban embedded assets
- acs-researcher PoC-validated output standard
- acs-researcher 7 Exa tools + per-tool guidance + regression guard
- daemon restart true-replace — ACS_DAEMON_RESTART=1 takeover on force
- single-instance + true-replace lifecycle for MCP bridge/daemon/gateway
- add bundled MCP agent definitions
- add local fallback CLI (list/call/health/fallback/serve)
- update hooks, hud tracking, and session settings
- wire auto-install + NpmShimNodeExec into bridge (Phase 2-3)
- auto-install + window-hide for acs-browser (Phase 1-2)
- add auto-continue Stop hook + task list enforcement
- researcher-agent stack — Go installer + agent/skill/config definitions
- add Node.js prerequisite via fnm
- route-layer semaphore + session safety + log purge + rate limiter cap (Fase 3/5/6)
- per-request proxy tracking + async logger + bounded concurrency
- add OMC component update logic and tests
- add restart endpoint to MCP API routes
- add MCP respawn daemon task with 60s periodic check
- add crash auto-restart with cooldown and hang detection
- self-hiding console via --hidden-window
- buffered publishDiagnostics + didOpen priming
- add acs-lsp server icon and browser-local tool labels in UI
- server routing for LSP tools, ownership API, and websocket integration
- browser-local OCR/PDF handlers, ownership guards, and LSP adapter
- route binary resolution, register wiring, and server lifecycle integration
- ownership-guarded tree reaping + orphan integration tests (F4)
- Windows Job Object tree-guard (KILL_ON_JOB_CLOSE) (F3)
- reap orphan children on crash + tree-reaping stop (F2)
- PID markers + startup sweeper for orphan cleanup (F1)
- cross-platform process-tree cleanup helpers (F0)
- ship auto-heal deploy artifacts (bundled mirror + settings wire)
- MCP tools on-demand + usage metrics (gold TDD)
- lifecycle manager + stdio client (gold TDD + race-safe)
- registry manifest + detect/install (gold TDD)
- deploy bundled hooks + sync template to manifest
- track hasil deep research .claude/research di git
- acs sync pipeline to ~/.claude/hooks (OMC-safe, dedupe dual-settings)
- migrate 12 hook sources + gold TDD tests + manifest
- PoC obfuscation pipeline (bundle+obfuscate+run)
- sub-endpoints /mcp/search & /mcp/browser + SSE streaming
- 9router user-stopped marker — respawn & heal skip saat user stop
- Phase 3 - Agent SDKs and documentation
- Phase 2 - VPS/Remote support with MCP bridge
- Phase 1 - Remove hardcoded token, add cross-platform env vars
- disable per-backend proxy toggles when proxy pool is off
- Stack update panel and API improvements
- Core infrastructure enhancements
- ACS Route management feature
- MCP proxy improvements
- API token management overhaul
- API token management overhaul — pagination, test, bulk revoke
- frontend API token integration + bug fixes
- auto-generate API token on first install
- API token management endpoints + comprehensive tests
- add CSRF protection middleware
- add error handler to prevent info leakage
- add input validation middleware
- add audit logging integrated with existing log registry
- add security headers middleware
- dual-auth system + JWT signature fix + rate limiting
- separate remove-failed/remove-disabled, precise auto-disable threshold, sticky rotation, route all MCP tools through proxy
- StreamableHTTP endpoint, external tool routing, acs-browser request logging
- track direct vs proxy routing in request logs with Proxy column
- auto-disable failed proxies, remove-failed button, toggle on/off, response column, status color fix (alive=green), sticky count config
- dedicated proxy pool independent from 9router with single/bulk input, import from 9router, concurrent health testing (concurrency 3), ConfirmDialog for delete, test all with bounded workers, health status tracking
- dedicated Key Pool — remove 9router dependency, direct Exa API calls
- config editor tab with presets
- task monitoring and progress tracking
- selective profile upgrade to standard config
- new standard config — 1M context, ACS MCP, delegation fix
- edit profile, clone gateway, reactive state, conditional guides
- enable all servers by default, fix agent sync path on Windows
- wire metrics for external tools — StatsTracker, LogRequest, server-level aggregation
- add acs-fastcontext-pattern exploration skill (v2.2.0)
- fix external tool test buttons, add CallHTTPTool, MCP architecture docs
- Clone Gateway UI — modal, card button, page wiring
- editable Profile tab in GatewayDetailModal
- add cloneGateway API function
- add Clone endpoint with TDD (8 test cases)
- frontend MCP Servers tab, toggle UX, connecting state
- backend servers API, bridge, config, tool test with real queries
- CloakBrowser bridge, MCP Servers tab, Agent Sync, maskKey fix
- enable skill_curator task (10min interval)
- add Skill Curator dashboard page
- add curator dashboard API routes
- add skill curator daemon package
- extend supervisor to respawn 9router and dashboard
- add explicit daemon stop/start/restart/status commands
- add CREATE_BREAKAWAY_FROM_JOB for true process independence
- add zero-AI stack detection for project analysis
- anthropic SSE fallback conversion + claude config UI improvements
- auto-restart hermes gateway after consumer tools update
- add provider filter to enowX AI account table
- redesign Consumers tab — grouped tabs + bulk sync panel
- sync enowxai key to config.yaml (not just .env)
- mcp-install seeds consumer tool configs in DB
- frontend proxy CRUD + sync feedback UI
- proxy add/delete/push routes + key sync on config save
- bidirectional key sync + proxy pool CRUD backend
- add enowxai sync verification endpoint
- add enowxai API key auto-sync on update/install
- add enowxai key sync engine
- add enowxai key detection and DB definition
- acs-cli mcp-install auto-registers MCP server
- proxy pool sync from 9router + MCP server stdio transport
- multi-key Exa pool with round-robin rotation
- dashboard log viewer with accordion + tool card stats
- MCP request logging with payload/response capture
- add profile sync indicator with auto-sync on mutations
- add entry animations and responsive polish
- add pagination + status filter + search to EnowAccountTable
- add install button for uninstalled enowxai
- add enowxai install endpoint
- wire enowxai update apply with progress
- add enowxai to component updater registry
- persistent recovery storage with blacklist and retry tracking
- wire enow health sidebar navigation and WS integration
- add EnowHealth page with pool status and recovery controls
- add enow health types and store
- add /api/enow/health routes for account pool management
- add enow account health auto-recovery task
- add health check client methods (warmup-single, fix-errors, accounts-list)
- add MCP Tools page with full backend API
- add acs-longrun-execution skill for buyer Hermes profiles
- add exa migrate command for MCP endpoint migration
- add MCP search server with 7 Exa tools
- add orphan gateway scan patch for --replace race condition
- restructure into acs-pipeline package (Section 11)
- include ACS skills (30) in token breakdown calculation
- add just agents-sync automation via 9router
- add distributed AGENTS.md per directory
- rewrite NAMING.md + refactor root AGENTS.md into lean index
- per-profile ACS skill selection in Config Manager
- show ACS skills source path in Claude CLI card
- add ACS skills to token calculator
- OMC bridge for ACS skills
- extend tooling-status API with ACS skills metadata
- boot reconciliation — stale PID cleanup, crashed gateway resume, restart lock clear
- scheduler task tracking, graceful stop reason, crash detection on boot
- atomic PID file writes (tmp+rename) for crash-safe state persistence
- graceful stop process (CTRL_BREAK → wait → force kill) for all service lifecycle paths
- token estimation calculator with per-category breakdown
- auto-inject ~/.acs/skills into legacy gateway profiles on patch
- skill version tracking via content hash
- force-update for ACS-managed skills on install
- router health check + auto-detection
- config locking per router profile
- router selector in Config Manager UI
- router switch API endpoint
- add router profile data model + storage
- frontend cost display for enowxai + all modes
- integrate cost calculation into enowxai proxy + unified chart
- add Go pricing engine (model table + pattern matching + calculator)
- add RouterSelector + stacked chart + Usage page router support
- add enowX AI backend routes with caching + unified chart endpoint
- populate Claude CLI model dropdowns from enowxai-adapter
- add claude-opus-4.7-1m to enowxai-adapter
- per-profile reset to ACS defaults
- enowXai + enowxai-adapter dashboard integration
- Phase 8 — polish (hideWindow, EnsureConfig, build tags)
- Phase 7 — stack integration
- Phase 5-6 — routes, handlers, server, PID management
- Phase 1-4 foundation — config, alias, sanitize, streaming
- model alias resolution + /v1/models endpoint
- real SSE streaming + error handling for OpenAI route
- real SSE streaming for OpenAI route in proxy v14
- v13 multi-model routing (gemini/kimi via chat/completions)

### Fixed
- resolve Linux compilation errors for SysProcAttr by using cross-platform executil helpers
- frontend redirect and localhost callback port
- update acs-lsp configuration for force eager tools and skip prefix (task-1788606916892785500)
- use adaptive dynamic port for OAuth callback (task-1788606916892785500)
- bypass auth check in tests to prevent flaky rate limits and build failures
- resolve claude config test leak and ai audit empty plan type error
- standalone SSE MCP stream handshake & zero-task filter (task-1788430858203061000)
- correct omc version comparison and rename source to acs-hud
- increase startup timeout for Kompress optimizer
- correct OMC version update display logic to prevent downgrade prompts
- inject headroom to stack components payload so UI renders its ComponentCard
- resolve executable path to avoid invalid python module execution
- add headroom to service start and improve error messaging
- implement true update abort and make docking indicator draggable
- add tailscale status endpoint and windows discovery with serve detection
- prevent false positives in reconciliation with heartbeat and blank title guards
- persist article dock progress across route navigation
- clarify standby status labeling and prevent misleading depleted deletion (task-1788523569737389900)
- dynamic port awareness, strict TDD RGR rule, and expand acs-search to 9 core tools
- resolve diagnostic steps vertical layout, proxy tracking for codesearch and docs, and build runner path separator
- fix Antigravity quota auto-sleep, auto-awake and EDF relay controller
- resolve camoufox and seleniumbase execution and stdio reachability probe
- normalize MCP catalog display name and add testid for toggle switch
- use absolute URI file scheme for markdown preview images
- sync router profile, model engine config, and pipeline test guards
- eliminate zero-task projects from Project Hub and Kanban filter
- resolve standalone SSE stream retry timeout and route sub-server messages
- align research articles skeleton loading with multi-column grid
- filter antigravity projects to only load workspaces with active tasks
- add persistent server-side update tasks, reconciliation, and quick rollback
- add dedicated tab persistence and SPA direct fallback on refresh
- harden loopback auth check and prevent non-mcp auth bypass
- enforce 9router port 20128 and sanitize legacy acs-route references
- eliminate search false positives by stripping backlink footers in FTS5 and fix instant search reactivity
- isolate auth test auto-seeding, CSRF ports, and log cleanup
- dynamic user home and working directory resolution for project workspace
- allow oc and opencode free models in 9router models filter
- resolve staging signature verification and enhance activation UX
- replace && with ; in justfile staging recipe for PowerShell compat
- clean up ClaudeModelRouting, Sidebar, and dashboard pages
- improve MCP health check, install flow, and route handling
- audit stop-chain + auto-continue — 3 bugs fixed, 12 tests added
- rewrite precompact-context-save, fix wiki-save bugs, fix state corruption
- remove misleading 9router offline warnings and default to first combo
- fix acs-route service lifecycle and process tree kill
- improve service lifecycle, instant reactivity and hidden background spawning
- force npm CLI install for claude-code and improve update robustness
- improve update streaming, version detection, and toast deduplication
- mark ninerouter user stopped during full stop to prevent auto-respawn
- auto-rebuild related backlinks on article creation
- instant reactivity on refresh sources and SPA return_to persistence
- allow SPA routing on /mcp/articles and redirect HTML API requests
- sanitize footer placeholders and format related research links
- implement dual-layer cache and reactive markdown editor
- improve MCP server handler robustness and agent sync
- fetch full article payload to render raw markdown view
- silent background process execution flags
- refactor research articles theme styles to prevent light mode leakage
- add windowsHide to subprocess spawns on windows
- deploySkillsIndex read path — hooks/skills-index.json
- acs-researcher resolve project root via CWD, bukan hardcoded path
- dev build -trimpath + HUD deterministik + e2e unwire
- UTF-8 console reconfig in utils — Windows cp1252 crashed embed-stage message
- acs-researcher JSON serialization hardening — unescaped Windows backslashes
- self-heal ~/.acs/bin in persistent user PATH
- auto-register watchdog/backup tasks on daemon start
- HUD MCP count + raw-splice agent sync + setup skill
- assign ClaudeStackDir from TemplatesDir so deployAgents() finds bundled agents
- server field in request log + overview stats for all sub-servers
- route acs-browser restart to stdio path + surface bridge errors
- skip auth middleware for localhost connections
- add NpmShimNodeExec stub for non-Windows platforms
- bridge anti-drop — true-down restart only (Fase 4)
- wire uptime/lastTest to server list + fix handler imports
- resolve npm binary paths for Windows nvm environments
- change formatUptime to accept seconds instead of milliseconds
- wire uptime and lastTest to server list API
- hardening pass — clamp positions, normalize no-identifier, severity filter, usage clear-on-success
- remove hardcoded LSP test paths from frontend
- MCP servers running status + in-process server management
- WAL pragma, atomicwrite mutex, env persistence guard, setup cleanup
- acs-browser backend via gateway internal stdio -> streamable HTTP multi-session
- single-instance guarantee + auto-recovery stack
- harden pipeline against silent-stale failures
- self-prune config.BackupFile to DefaultKeep
- cap all backup patterns to 3 (agentic, config, pre-migrate)
- prune .acs-bak backups in migrate + rollback paths
- acs-browser tools tampil di GUI + multi-session verified
- restore acs-browser ke streamable HTTP + self-heal registry
- hapus acs-browser dari expected MCP servers — sudah tidak di-generate
- update enabledPlugins — hapus caveman + context-mode, tambah rust-analyzer-lsp
- hermes update — stop scheduler + kill hermes processes sebelum pip install
- stop 9router sebelum npm install + fix hermes pip fallback
- SetMaxOpenConns(1) cegah SQLITE_BUSY di TestTestToken_Revoked
- 9router check versi pakai npmjs (utama) + GitHub fallback
- state-based findExistingAPIKey + timeout; dedup key by name
- jangan bocorkan 9router key ke GitHub API
- /agentic page instant load via sessionStorage cache
- MCP page load 8s→instant + TS errors 217→0
- hide terminal windows across all runtime packages
- prevent terminal window spawning on Windows
- route builtin tool HTTP calls through proxy pool
- respect global proxy pool setting
- Windows 9router update reliability
- API tokens panel UI/UX improvements
- bypass EBUSY update corruption, add version detection, auto-repair on startup
- Claude Code MCP sync: command field for HTTP servers, full sync with cleanup
- normalize plain ip:port:user:pass format to http://user:pass@ip:port/, support plain ip:port without auth
- normalize plain ip:port:user:pass format to http://user:pass@ip:port/, support plain ip:port without auth, normalize before storage to prevent duplicate detection errors
- input validation and duplicate prevention — require http:// or socks5:// scheme, pre-check duplicate before insert, bulk import skips invalid/duplicate with count
- replace window.confirm with ConfirmDialog in McpKeyPool, ConfigEditor, GatewayConfigPanel
- api key column with masked display, eye toggle, click-to-copy, hover tooltip; backend sends full key, frontend handles masking; dedup via UNIQUE constraint
- stats persistence + auto-start external servers after restart
- complete all 25 browser tool test args, fix names, add HTTP server tools
- show all configured servers in Overview cards, use config toolCount
- update tide_release for new SSE endpoint
- read LLM config from .env.release instead of hardcoded values
- switch LLM endpoint from 9router to SSE endpoint
- wire WebSocket push handler to update gateway list
- instant state sync via WS + await refresh before unlock
- register missing restart route
- tide pause/resume to prevent polling race during lifecycle ops
- ensure minimum busy duration for loading overlay visibility
- proper lifecycle animation — locked card with spinner until PID confirmed
- fast restart path for dashboard — no slow graceful drain
- race condition guard between ACS self-heal and Hermes lifecycle
- graceful restart via StopGateway+StartGateway
- context_length 256k standard + silent gateway spawning
- acs-search test returns toolsCount from AllTools()
- graceful Windows gateway stop — prevent ghost hermes.exe
- toggle wiring — isOn() uses toolsCount, backend updates Status, skip builtin servers
- agent_research_exa - remove stale Exa-Beta header, add key pool rotation
- minor type fixes in TokenBreakdown and ToolProfilesPanel
- detect gateway crash loops + auto-repair hermes venv
- add frontend build + gateway recovery to install flow
- hide taskkill terminal flash on stop
- reliable start/stop with verified status
- stop via direct PID kill instead of CLI (bypasses anti-loop block)
- add hideWindow to prevent terminal flash on key detection
- strip duplicate keys from .env before writing managed block
- recovery history logs per-account email instead of generic bulk-fix
- replace non-existent theme tokens across remaining components
- exhausted accounts show 0/limit to avoid misleading credit display
- show credit labels, remove useless Enabled column, gray inactive bars
- CreditBar shows remaining credits, gray for inactive accounts
- pool stats count all providers, not just codebuddy
- prefer health store over dashboard cache for enowxai stats
- recovery history field mapping + fix-errors log to history
- enow components use correct theme tokens for dark mode
- StatusPill support 'ok' and 'active' as success tones
- all handlers use key pool instead of hardcoded cfg.ExaKey
- enowxai stats fallback from health store + fix last_recovery shape
- conditional section rendering by router tab
- accounts/stats reads real provider count from 9router DB
- update enow health route tests for DB-backed history
- fetch latest version even when component not installed
- remove standalone enow-health route and sidebar entry — embedded in Accounts
- restore EnowHealthSection component and wire into Accounts page
- return null instead of zero-time for last_recovery when never recovered
- include accounts and last_recovery in /api/enow/health/status response
- token_estimate uses breakdown.total (includes ACS skills)
- resolve remaining test failures across packages
- resolve test isolation for kanban DB env var priority
- prevent test hangs from exec.Command in server package
- expand E2E endpoint sweep from 11 to 91 endpoints
- robust auth token resolution with edge case handling
- RestartAllModal NaN display + defensive number coercion
- recover full stack after force-kill during install, graceful path only restarts dashboard+scheduler
- dev install stops only dashboard+scheduler, not entire stack
- loading spinner on router switch + fix stale refetch error
- auth token switching per router + pills spacing
- auto-refresh config after router switch + add tooltips
- add hermes patch 009 — resume-pending tz align
- register hermes patches 007 (stuck-loop) and 008 (budget-cap)
- remove hardcoded context_length from config template
- change preset toast from misleading 'Applied' to 'loaded — click Save'
- unwrap sections envelope in profile config PUT handler
- quote {ACS_HOME} placeholders in config-template.yaml
- add patch 006 for hermes anthropic None content crash
- precise PID + uptime for enowxai cards (PowerShell-based detection)
- hide terminal window in getPortPID (prevent flicker on WS tick)
- force headless mode for cloakbrowser MCP in all profiles
- update alias routing — sonnet→gemini-3.1-pro, haiku→gemini-2.5-pro
- keep Environment + Session-specific guidance in system prompt
- remove double-sanitize in proxy v14 OpenAI route
- patch Hermes session.py timezone bug via patchmgmt
- patch Hermes session.py timezone bug via patchmgmt
- release pipeline smart bump — skip if version already exceeds last tag

### Changed
- bump version to 1.0.0
- ignore emdash and repos sub-directories
- remove aggressive gateway recovery loop and update cli command mapping
- add atomic binary rename on Windows install to prevent file lock error
- unwire skill curator from sidebar navigation
- sync dashboard port resolution, preset atomic caching, and key pool invalidation
- deprecate and remove acs-route module across backend and frontend
- update local dev tools and root mcp configuration
- update daemon reconcile, scheduler, and service stack lifecycle
- remove broker/hermes/mesh/workflow routes, cleanup MCP and setup
- update App routing, Dashboard, API clients, and MCP install
- update dependency resolution, health checks, and automation runtime
- update session-end and stop-chain hooks, skills-index
- remove broker package and dashboard components
- remove 9router bidirectional password sync
- fix whitespace in meta routes
- update justfile, pipeline, and env detection for multi-env support
- update automation asset manifest, skill definition, and AGENTS.md
- update docsengine scanner, license test, and pipeline utils
- update db schema, pricing calculator, service stack, and updater components
- remove enowxai components and update stores/layout
- update routes for enowxai removal and router profiles
- remove ACS Skills section from ClaudeConfigPanel
- update Claude tool profiles and OpenCode model configs
- update agentic stack config, SEO isolation, and pipeline fixes
- add .dev.vars to gitignore
- single source of truth — relocate to repo-root agentic-stack/ + embed staging
- checkpoint audit + MCP on-demand fallback hardening
- rebuild obfuscated bundled hooks
- bridge buffer, HUD deploy, path refresh, auth test, OMC HUD MCP count, revert updater hardcoded path
- enhance bridge robustness, agent sync, and service setup
- restructure claude-stack ke directory terpisah + hermes-stack separation + hooks bundled fix + auto-continue stop hook
- add robustness load test script + plans
- add bundled hooks package.json template
- add depscan.py dependency scanner + baseline commit
- update comments referencing old mcpsearch package name
- update imports in 11 external files
- rename mcpsearch → mcpacs, split into 6 subpackages
- add depscan.py dependency scanner + baseline commit
- drop checkpoint tool hooks — checkpoint is server-side only
- remove project settings + add verify runner
- prune ACS backups cap 3 + remove caveman/context-mode legacy
- remove redundant builtin searchGitHub tool
- cleanup legacy + update MCP config
- MCP agent sync UI + API client cleanup
- simplify resolution + HTTP gateway URLs
- MCP config ke settings.json + .claude.json
- AgentSyncer interface + dual-file Claude sync
- hapus emoji dari log output service + ignore runtime DB backups
- remove exa MCP, replace with acs-search
- Update pnpm lockfile; remove stale internal/ directory
- add Biome lint + format, format all source files
- update .gitignore for nested repos, add untracked ACS files
- decouple daemon from StopStack kill sequence
- ignore packages/lycia/ (separate repo)
- add packages/tide-ui/ to gitignore (separate repo)
- go mod tidy
- extract AddAccountModal + OAuthFlows from Accounts page
- extract AccountsOverview with stats and router selector
- extract ProviderTable with responsive mobile cards
- replace PoC with deprecation shim → acs-pipeline
- consolidate AGENTS.md — single canonical at root
- clean up .gitignore + untrack nested repos
- move scripts/pre-commit-go-first.sh → .githooks/
- archive tools/skills-matrix.json (unused)
- consolidate changelogs — keep root CHANGELOG.md only
- remove docs-site/ from git tracking
- move bench-real/poc → packages/tide/bench/
- remove archive/ and .sisyphus/ from git tracking
- consolidate skills to src/skills/, remove obsolete root skills/
- gitignore proxy debug output

### Documentation
- update agent governance, kanban rules and backend engineering standards
- sanitize buyer-facing output descriptions for acs-search sub-tools
- add 3-stage empirical table and high-converting marketing analysis
- embed visual before-and-after proof for 88.4% idle token savings
- add Idle Context Tax case study and 82.6% token savings metrics
- mandate Kanban lifecycle sync for Antigravity Desktop and IDE
- add ACS ultimate advantage and marketing blueprint
- add system preset cloud distribution and admin push architecture plan
- mark global shared runtime and leak-free architecture as DONE
- add global shared runtime architecture and AWS deployment missions
- add adaptive stack, doctor settings, and AWS deployment plans
- update CLI reference, MCP architecture, config reference, and member setup guide
- save research and implementation plans for stateless REST and on-demand skills
- update agent documentation, changelog, and handoff guides
- update modular research engine, multi-agent modal, and search plans
- document resilient 3-tier search and knowledge protocol
- extend mcp article templates wireframes
- add 9router integration hardening plan with strict TDD
- align tool selection decision matrix with acs-lsp and grep
- commit work product riset MCP, web-scraping, Claude Code skills
- tandai kanban unwired + hapus index skills stale
- add MCP local fallback and docsgen plans
- update skill definitions and documentation
- add Robustness & Concurrency section to acs-search
- add MCP auto-heal plan and update setup configuration
- acs-lsp tools test matrix + inventory + tool registry (8/8 real-tested)
- commit deep research reports, stack audit, and runtime state ignores
- commit plans, specs, task records, and ignore browser-session assets
- add threads login page screenshot asset
- add acs-browser evidence assets and ignore sensitive artifacts
- finalize 26-tool acs-browser deep-research (all variants COMPLETE)
- reflect mcp-pre-tool auto-heal in README (13 hooks)
- revisi laporan LSP — koreksi istilah + ramah pemula
- setup, usage, rollback, lifecycle
- update Claude Code & OpenCode stack references + remove OCS legacy
- add skill_curator to CLI reference + CHANGELOG
- add tool-profiles guide to member docs


## [Unreleased]

### Added
- Skill Curator daemon task — AI-driven skill propagation engine (10min interval)
  - Detects new/changed skills across profiles
  - Evaluates relevance per gateway using confidence bands (propagate/review/skip/reject)
  - Safety checks: dry-run, rollback, hard rules, conflict detection
  - Dashboard page (`/curator`) with stats, history, pending changes
  - API endpoints: `/api/curator/{stats,history,changes,skills,trigger,resolve,rollback}`
  - Config: `~/.acs/data/skill-curator-rules.yaml`
  - SQLite database: `~/.acs/data/curator.db`

## [v0.28.0] - 2026-06-14

### Added
- Implement kelola feature adoption phases 0-6
- Chart bar hover tooltip with per-hour breakdown
- Clickable patch health card with detail panel
- Wire patch system production + dashboard health indicators
- Tide release automation

### Changed
- Archive 9router open-sse patches
- Untrack packages/tide (moved to its own git repo)
- Gitignore CLAUDE.md (dynamic per-profile injection)

### Fixed
- Sync Usage stats with 9Router — use usageDaily for 7D/30D/All + dynamic version
- Token usage chart — local time, full hour fill, skeleton loading
- Return accurate totals for all chart periods (24h/7d/30d)
- Chart period tabs — rename 1D→24H, default to Today, split today/24h logic
- Usage page — dedup double-logged rows, fix provider tokens field, period-aware filters
- Usage page period tabs — switch from createTide to createResource
- Chart Today summary uses usageDaily totals (match top card)
- Use local time for today usageDaily lookup (matches 9Router dateKey convention)
- 24H stats remove dedup to match 9Router
- StatCard AnimatedNumber always rounds to integer
- Resolve reactive key cache corruption on key switch
- Dashboard UX — remove duplicate update alert, enhance token chart, remove Kiro health card
- Stack Updates — Claude CLI self-update, cache invalidation, toast dedup, What's New AI, pipeline CHANGELOG sync
- Cloakbrowser MCP binary name + escalation command
- Improve uv install UX — fallback paths, verify post-install, actionable errors
- Isolate gateway lifecycle and smart restart tests from real processes
- Test suite — patchmgmt skip guards + server UTC→local time consistency
- Update patches.json hashes — 002/004 now verified as applied

## [v0.26.0] - 2026-06-11

### Added
- Warm dashboard cache on login — instant first render via Tide SWR
- Stack spinner component + progress animation + toast ordering fix
- Watchdog install/uninstall from dashboard GUI
- Ship ACS skills + config template + MCP servers to buyers
- Ship full Claude settings to buyers (permissions, plugins, marketplaces, MCP)
- Independent ACS auth + password sync with 9router

### Changed
- Migrate dashboard + UpdateBanner WS to @uikode/tide
- Use Index instead of For in Stack page for stable keying

### Fixed
- Eliminate terminal flash on boot — use VBS wrapper for service start
- Scheduled tasks run hidden via VBS wrapper (no terminal flash)
- Dashboard API — PID verification + race-safe gateway stop + enriched stack
- Auth sync — SHA256 marker from DB value + detect bcrypt prefix
- Watchdog + self-heal race prevention
- Service lifecycle race conditions + improved process detection
- Replace internal skills with buyer-safe skills (leak prevention)
- Show Stop/Restart buttons during start action (disabled until running)
- Resolve enterprise profileArn from 9router DB instead of hardcode
- Bash(acs-cli:*) → Bash(acs-cli *) permission syntax for buyers
- Add context_length + compression to gateway configs (prevents context pressure)
- Prevent test from killing live 9router — use isolateHermes in StopGateway tests
- Prevent E2E from killing live stack in release mode
- Add strict mypy type annotations to all pipeline scripts
- Type annotations in release.py + limit test parallelism (-p 4) to prevent resource spike
- Release pipeline commits version bump immediately + add pipeline rules to AGENTS

### Documentation
- Add release pipeline rules — no kill/stop/restart allowed
- Clarify no-visible-terminal rule (hideCommandWindow mandatory)
- Add data handling & leak prevention rules to AGENTS.md

## [v0.25.0] - 2026-06-09

### ⚠️ Breaking Changes
- Buyers are now automatically migrated off the legacy auto-start mechanism, with generalized cleanup that may perform elevated removal. Existing legacy auto-start configurations will be removed during upgrade.

### Added
- Auto-migrate buyers off legacy auto-start.
- Generalized legacy auto-start cleanup with elevated removal.
- Add `platform_toolsets`, `lsp`, and `acs` MCP server to templates.
- Bundle 30 ACS skills for buyer deployment.
- Add oh-my-claudecode to Stack Manager registry (updatable from dashboard).
- Add persistent file-based cache for the What's New AI.
- Wire Stack Updates UI with WebSocket progress and loading states.
- Add `StopNineRouterFull` and process tree kill for update safety.
- Implement safe Hermes upgrade mechanism (stop gateways, pin skills, git-based).
- Pass enterprise credentials to 9router for permanent auto-refresh.
- Wire mesh workflow CRUD routes to existing stores.

### Changed
- Migrate Gateway Manager from manual fetch to @uikode/tide.
- Add Tier-1 bundle benchmark harness and pre-registration.
- Add package metadata files (README, CHANGELOG, lockfile, gitignore).
- Ignore E2E login response artifacts.
- Untrack and ignore the `.hermes` internal planning directory.
- Ignore `sites/` standalone repo from root tracking.
- Ignore `.omc` tooling cache.

### Fixed
- Tolerate WSL cold-start in the cross-env E2E availability check.
- Use fast PID-based gateway status instead of spawning Hermes.
- Resolve Hermes via a robust resolver in binary and gateway checks.
- Resolve Hermes binary robustly, independent of PATH.
- Resolve upx via `~/.acs/bin` in the compress gate.
- Resolve go-installed tools via `GOPATH/bin` in the garble gate.
- Surface real `go test` failures in the test gate.
- Build Hermes version-probe candidates deterministically.
- Correct OS boot service registration and status.
- Run 9router fully in the background with no terminal window.
- Parallel async gateway stop to prevent request hang.
- Gateway card shows running count and dynamic buttons; user-initiated stop suppresses auto-heal.
- Wire Stack Manager buttons with toast notifications and fix component name mismatch.
- Prevent gateway respawn from killing booting instances.

### Documentation
- Add 9router subcommand reference to the CLI docs.
- Update tide web plans with real benchmark data and execution status.

## [v0.24.0] - 2026-06-07

### Added
- Kiro Enterprise authentication: `acs-cli auth enterprise` subcommand, IAM Identity Center SSO backend, and Enterprise card/flow UI in Accounts page
- Resume command with session ID support across CLI, API, and frontend store
- Tool profile system with cc launcher, dashboard API, and escalation
- Metadata computation module (tool counts, token estimates)
- Multi-auth codex implementation with stack/omc updates
- Component registry with version detection and per-component update routes
- StackUpdatePanel with version matrix and AI What's New summaries
- AI What's New endpoint for stack components
- Claude CLI surfaced in stack status

### Changed
- Migrate frontend to @uikode/tide design pattern (Broker Mesh page, StackUpdatePanel)
- Cache What's New responses per component+version pair
- Archive deprecated caveman-activate hook (replaced by marketplace plugin)
- Rename accordion heading to Profile Launcher
- Rename section to Tooling System; add resume buttons to header
- Bump grid breakpoint to `xl` for iPad Pro compatibility
- Enhance ComponentCard and swap UpdatePanel → StackUpdatePanel

### Fixed
- Remove dead MCP entries and hermes MCP from Claude settings (hermes runs standalone)
- Fix OMC bridge path; add debugger profile
- Fix API client URLs for per-component update routes
- Wire ToolProfilesPanel into Agentic page as 'profiles' tab
- Move ToolProfilesPanel into ClaudeToolingPanel per plan
- 9router: use gh-release from decolua/9router + release notes

### Documentation
- Add hermes plans and archive pricing draft
- Sync all 8 profiles and resume command in ruleset
- Add @uikode/tide mandatory rule to CLAUDE.md

## [v0.23.0] - 2026-06-05

### Added
- WezTerm integration with skills path fix and improved test isolation
- Extract @uikode/tide to packages/tide as a standalone package

### Fixed
- Gate 13 tag conflict handling and associated test fix

### Changed
- Increase test timeout from 120s to 180s

## [v0.20.1] - 2026-06-04

### Added
- Auto-create GitHub Releases on all repos (gate 13)

### Fixed
- Handle unicode in Windows console (cp1252 → utf-8)
- Increase E2E timeout 10s → 30s (service status needs time)
- Stack manager button wiring + manifest key

## [v0.20.0] - 2026-06-04

### Added
- Phase 1–7 of @uikode/tide frontend framework — createTide core, cache, WebSocket, retry, prefetch, skeleton components, TideProvider, Dashboard/Stack Manager/Scheduler migration, and polish (prefetch on hover, remove Loading text)
- Phase 5+6 backend APIs for stack, daemon, announcements, and WebSocket snapshot extension
- Phase 6a — command center redesign with summary cards, announcements, and experimental banners
- Phase 6b — stack manager page, scheduler page, stores, API libs, and sidebar navigation
- Snapshot Browser + Quick Undo UI (Phase 5 frontend) and snapshot restore API endpoints (Phase 5 backend)
- Post-sync overlap detection (Phase 4) and pre-sync snapshot backup + profile-ahead safety + progress streaming
- Self-healing skill system + tooling-status/toggle/fix endpoints
- OS scheduler for periodic tasks with goroutine-based task runner
- Auto-restart 9router with backoff (3 per 15min) and gateway_respawn task
- Stack auto-start config with per-component toggle
- AI-powered release gates 9–13 and e2e release gates + cross-env harness
- Legacy script migration engine — registry, detection, setup/doctor wiring (Phases 1–3)
- Claude tab with tooling system, overlap detection, and responsive grid layout
- Codex multi-auth account management
- Topic-based WebSocket subscriptions for realtime page updates
- Kanban reconciler — git commit to card sync
- Mesh deliver — broker event delivery to profiles
- Board backup and restore
- Model auto-detection and priority engine
- Role-specific SOUL templates with auto-detect + role-aware presets + toolset availability API
- Git-credential step — provision .gitconfig per Hermes profile
- Hermes post-update patch system
- CloakBrowser MCP server config
- Shared ACS Python REPL runtime + instant cached status
- Graceful shutdown + PID precision — prevent stale lock false detection
- Realtime progress bar + hidden window on Windows
- Restart cooldown + Telegram notification on auto-heal
- 3-column layout + PaginatedCard + MobilePaginator (2 cards per swipe)
- Mobile sidebar auto-expand + auto-hide 10s idle
- Show version dynamically in sidebar header
- Add 9router subcommand + wire kanban + fix completion --help
- Add --verify smoke test to dev build
- Add 'dashboard' top-level subcommand + update help text
- Add soul deploy + setup migrate
- Rebrand all 8 soul templates with ACS identity

### Changed
- Server-side cache for /api/gateways — 1828ms → 2ms
- Server-side snapshot cache — API 9s → 2ms
- Serve /api/stack/status from WS broadcast cache
- Parallel loading + ETag + WebSocket realtime updates
- Replace startup folder scripts with silent daemon auto-start
- Daemon→scheduler, acs-dashboard→dashboard, add NAMING.md convention
- Restructure repo — apps/acs/cli → src/ with CI + pre-commit path migration
- Consolidate into 3-tier structure (public/member/dev)
- Archive JS/TS artifacts — root is now pure Go project
- Remove caveman plugin from setup
- Add justfile for dev/release shortcuts
- Pre-release cleanup — drop garble -literals, test fixes
- Trim soul profiles, remove gateway-safety template
- Move 32 completed/superseded plans to done/
- Gitignore __pycache__ and remove tracked bytecode
- Bump version to 0.20.0

### Fixed
- Prevent .env credential wipe from silent read errors and full-overwrite
- Prevent credential loss + auto-inject 9router API key
- Handle 401 auth error — redirect to login instead of stuck skeleton
- Prevent infinite loop on 401 — stopped flag halts all activity
- Synchronous cache hydration — instant render before first paint
- Daemon status reads state file instead of locked PID file
- Null-guard all WS data access to prevent crash on partial data
- Stack/scheduler store data extraction + null guards
- Null-guard Board tasks + kanban store improvements
- Null-guard builtin_tools and skills arrays in ClaudeToolingPanel
- Unwrap API response in SkillDiffModal + fix WebSocket URL
- Telegram disconnected false positive — 60s grace period for connecting state
- Eliminate false-positive unresponsive detection for idle gateways
- Raise unresponsive threshold to 20min for long LLM reasoning
- Auto Sync All mode fix + response shape + progress display
- Preflight before version bump + buyer repo isolation rules
- Preflight ignores untracked files (-uno)
- Make AI review advisory (non-blocking)
- Allow buyer repo URL in hardening check (agnostic-config max 2)
- SummaryCards responsive — 2-col mobile, 3-col tablet, 4-col desktop
- AnnouncementCard responsive + API data parsing
- Gateway cards full-width mobile layout
- Sidebar nav order + ComponentCard upgrade + SkillSyncDrawer stability
- Glob all profile kanban DBs instead of hardcoded acs-default
- Add credentials to skill diff fetch request
- Simplify UI — remove toggle, keep auto-fix only, restore MCP
- Restore toggle for all tools, fix circle offset, auto-fix on enable
- Only show toggle for MCP servers, fix toggle button sizing
- Resolve .mcp.json path in toggle handler using resolveProjectDir
- Hide terminal window for npm list check in detectOMCTools
- Prevent terminal spawn by wrapping commands in cmd.exe /c on Windows
- Hide terminal windows from daemon/broker exec.Command calls
- Remove ETag caching from tooling-status for realtime updates
- Proper cache invalidation for auto-fix status refresh
- Resolve full binary paths and invalidate cache after auto-fix
- Hide terminal window for auto-fix commands on Windows
- Garble debugdir conflicts, frontend auto-build, linting
- Move ClaudeToolingPanel into configs sub-tab replacing old ClaudeConfigPanel
- Resolve MCP servers from project dirs with ETag caching
- Use PowerShell Get-CimInstance instead of deprecated wmic
- API-enrichment deploy uses acs:deploy-enrichment handler
- Clear stale dismissed flag when current version > dismissed version
- DocsEngine pathToSlug handles src/ and apps/acs/cli/ paths
- Gateway display name singular (gateways → gateway)
- Rename daemon→scheduler in status, auto-start when gateways running
- upsertEnvVars preserves managed block and empty lines
- Add StartSchedulerDaemon/StopSchedulerDaemon stubs for unix
- Update BuyerRepo constant + install scripts for repo rename
- Remove all source-revealing paths from binary
- Minor route fixes for agentic and config batch
- Align daemon PID path with actual daemon lock file location
- Restart button now polls and reloads page
- Replace pipe-based download with file-stat progress tracking
- Check config.yaml as token fallback, not just .env
- Auto-heal kills stale process + mobile UI polish
- Uniform toolsets for all roles — only disable no-account toolsets
- Filter builtin names from custom presets list
- API resilience — force sync param, service stop, EXA validation
- Concurrency and reliability hardening across broker/daemon/automation
- Replace hardcoded path with dynamic cliconfig.DataDir()
- Pass all linters strict — mypy, ruff, bandit
- Remove shadowed shutil imports in gates.py
- Theme-aware scrollbars + gitignore .venv/.mcp.json
- Hardening gate, auto-bump, encoding, arm64 skip
- Test reliability — Fiber timeout, flaky skip, lenient cleanup
- Add TestMain to all sqlite-using packages (Windows goroutine leak)

### Documentation
- UIKode.com infrastructure — VPS + Cloudflare + Astro
- @uikode/tide production benchmark, origin story, strategy, marketing, grant roadmap
- @uikode/tide framework spec — 98% confidence, reference study complete
- Restructure @uikode/tide for agent long-run execution
- Update all plan references to uikode/tide (from andyvandaric/tide)
- Add server-side cache convention to architecture spec
- Mark 9router plan complete (all phases verified)
- Skill sync manager fix-all — Phase 0–5 with restore UX
- Update CLAUDE.md command table + AGENTS.md + justfile shortcuts
- Add dev integration workflow to CLAUDE.md
- Migrate all path references from apps/acs/cli/ to src/
- Add proxy premium setup section
- Rewrite instalasi.md — full post-install guide + panduan lengkap untuk member
- Structured help text + complete CLI command tree in NAMING.md
- Rewrite AGENTS.md + expand NAMING.md with full project conventions
- Add pre-release distribution flow + repo roles + release checklist
- Add docs/sites architecture + license server v3 plan
- ACS infrastructure — fully audited, verified decisions
- Binary hardening plan — garble + UPX
- Add kanban/plans/sessions to exclusion list
- Audit and update full-stack shipping plan with current state
- Update kanban hardening gaps + add proxy plugin plan
- Add dashboard-api skill, meta route tests, and audit plan
- AGENTS.md rules 6a/6b/6c — TestMain, Fiber timeout, env-skip

All notable changes to this project are documented in this file.

> Temporary distribution policy: until `.sisyphus/plans/openai-core-path-convergence-plan.md` is fully ready, `v3.0.0` is the local-plugin lane and `v3.1.0` is the direct-core lane. All non-OpenAI-path features are intended to remain in parity between those temporary lanes.

## [3.1.0] - 2026-05-06
### Added

- Added per-project CocoIndex wrapper recovery so new project sessions can scaffold local `.cocoindex_code/settings.yml` without requiring setup-time global `ccc init`.
- Added stricter cross-OS RTK/Caveman parity coverage across Windows, Unix/XDG, and WSL runtime/setup paths.
- Added stale-shell RTK doctor messaging that distinguishes an unrefreshed current shell from a truly missing native RTK install.

### Changed

- Updated setup/runtime asset sync so installed WSL/manual paths receive the `ocs` runtime files needed by the managed wrapper entrypoints.
- Hardened CocoIndex shim repair on POSIX/WSL to prefer the pipx CocoIndex venv Python over system Python during recursive `ccc` shim recovery.
- Expanded OpenAI overflow auto-compact behavior and compression-proof request telemetry in the bundled multi-auth plugin.

### Fixed

- Fixed Windows RTK/Caveman setup and doctor parity so stale shell warnings, fresh-shell verification, and managed PATH detection now agree on truthful runtime state.
- Fixed Unix/XDG RTK and Caveman parity so runtime markers, managed RTK fallback, and dynamic compression sidecars resolve from the correct config roots.
- Fixed WSL/manual-install CocoIndex packaging so the installed `ocs` wrapper can reach runtime entrypoints and `cocoindex-code` can reconnect from the managed `ccc mcp` path.

### Automated Release Summary
<!-- OCS_AUTO_SUMMARY_START -->
- Commit window: `v3.0.0..v3.1.0`
- Added: 4
- Fixed: 23
- Changed: 2
- Docs: 16
- Chore/Build/CI: 1
- Other: 1
<!-- OCS_AUTO_SUMMARY_END -->

### Commit Coverage (auto-generated)
<!-- OCS_COMMIT_COVERAGE_START -->
- `eb7a000` docs(changelog): auto-sync v3.1.0 commit coverage
- `6e21baf` fix(setup): avoid cocoindex false reinstall
- `43d28b3` docs(changelog): auto-sync v3.1.0 commit coverage
- `db04c84` fix(installer): tighten final runtime checks
- `eb06aec` fix(setup): preserve lightweight profile switching
- `3ec6d0d` docs(changelog): auto-sync v3.1.0 commit coverage
- `4e6132e` fix(release): bundle cocoindex mcp bridge
- `a9eee7b` docs(changelog): auto-sync v3.1.0 commit coverage
- `6e8a9cb` fix(installer): harden gh auth stdin handling
- `cf48b27` docs(changelog): auto-sync v3.1.0 commit coverage
- `e3c377d` fix(setup): sync cocoindex mcp bridge asset
- `0c8690a` docs(changelog): auto-sync v3.1.0 commit coverage
- `1b2c18e` docs(plan): capture installer follow-up plans
- `2c1b3f1` docs(dev): add installer surface audit
- `4f1c1ce` fix(installer): improve WSL auth and wrapper flow
- `72a3e82` fix(setup): refine installer runtime checks
- `8cf3854` fix(index): harden cocoindex runtime recovery
- `1092d92` docs(changelog): auto-sync v3.1.0 commit coverage
- `9ab1006` fix(installer): align WSL runtime wrapper checks
- `5c34b97` fix(setup): refine cocoindex installer runtime checks
- `a2e3d05` fix(index): repair cocoindex runtime shim resolution
- `6261dcf` fix(installer): restore plugin-scoped setup path
- `b61446f` docs(release): point to canonical workflow
- `9f3aeda` fix(release): resolve buyer repo defaults
- `97eb12e` docs(changelog): auto-sync v3.1.0 commit coverage
- `9fe8f46` feat(release): route through lane publish flow
- `02994e0` fix(release): align buyer repo defaults
- `8cabedf` fix(release): preserve buyer asset history
- `1b78e3e` fix(release): preserve buyer asset history
- `d78944a` docs(release): update installer v3.1.0 notes
- `a4e6dd5` docs(changelog): add v3.1.0 release notes
- `fbb3030` Merge remote-tracking branch 'origin/main'
- `64d2d94` chore(release): bump suite and plugin version to 3.1.0
- `dc6a99f` test(plugin): expand compression proof request telemetry
- `b3d6d39` feat(plugin): handle OpenAI overflow auto-compact
- `e1db501` fix(setup): align runtime asset and CocoIndex repair paths
- `fb3e4bb` fix(index): initialize CocoIndex per project
- `46a6a89` fix(runtime): clarify stale RTK shell warning
- `8991e8b` feat(plugin): export OpenAI OAuth plugin
- `70caf77` fix(runtime): align RTK parity across doctor paths
- `c49306f` docs(dev): add installer runtime telemetry proof guide
- `4895b36` test(plugin): cover compression proof telemetry
- `8541e40` feat(plugin): emit runtime compression proof metadata
- `80b6198` docs(changelog): auto-sync v3.0.0 commit coverage
- `c4963f9` docs(changelog): auto-sync v3.0.0 commit coverage
- `0c47733` fix(installer): verify adjunct runtime readiness
- `6b99353` fix(installer): harden stdin-safe shell entry
<!-- OCS_COMMIT_COVERAGE_END -->
## [3.0.0] - 2026-05-05
### Added

- Added native-first RTK and Caveman bootstrap paths to setup/runtime flows so the installer can reconcile adjunct runtime dependencies into OpenCode-managed target state instead of leaving them as policy-only routes.
- Added stronger native runtime verification coverage, including isolated Windows native proof and isolated WSL native proof for DCP, RTK, and Caveman target-state markers and `ocs doctor` health checks.
- Added `ocs-product-marketing-context` as a bundled buyer-facing context skill for product, audience, positioning, proof, objections, and customer language.
- Added `ocs-seo-audit` as a bundled buyer-facing audit skill for technical product SEO diagnosis, including AI-search-readiness concerns in the same audit lane.
- Added `docs/oh-my-opencode-skills-ownership-matrix.md` as the developer-facing source of truth for installer ownership, upstream-attached skills, runtime owners, and verification boundaries.
- Added installer regression coverage for shell-profile edge cases and Node-manager PATH recovery, including native NVM discovery in Unix-like environments.

### Changed

- Expanded the bundled buyer-facing skill set from 9 to 11 skills and reorganized the public architecture into Routing, Context, Execution, Audit, Verification, and Modifier lanes.
- Renamed `ocs-installer-copy-seo` to `ocs-technical-copy-seo` so the built-in copy lane now matches its real scope across install, onboarding, setup, docs, and landing surfaces.
- Folded AI-search / AEO / GEO / LLM-visibility concerns into `ocs-seo-audit` instead of creating a separate bundled `ocs-ai-seo` lane.
- Updated buyer-facing docs, quick-start flows, and integration guidance to reflect the new context/copy/SEO ownership split and the expanded built-in bundle.
- Hardened `install.sh` for macOS default zsh, legacy bash compatibility, unknown-shell fallback, multi-profile PATH persistence, and repeated-install idempotency instead of treating “upgrade Bash first” as the main solution.
- Updated release-facing version pins, installer examples, and template release surfaces to the `3.0.0` wave on the `main` lane.

### Fixed

- Fixed Windows native RTK/Caveman setup so target proof homes no longer leak runtime markers into the real user home during isolated installer validation.
- Fixed WSL/Linux installer bootstrap so Bun, Node, npm, pnpm, and other user-managed runtime tools remain discoverable in noninteractive shells during real local-bundle installs.
- Fixed noninteractive Caveman attach handling by using the full skills-selection command and syncing the resulting `caveman` skill into the target OpenCode skills directory.
- Fixed runtime status projection and doctor reporting so DCP, RTK, and Caveman now report truthful `managed`/`missing` state based on verified target-side markers instead of stale `deferred-unmanaged` or WSL-biased assumptions.
- Fixed shell-profile PATH source dedupe so repeated installer runs no longer duplicate semantically equivalent source lines across zsh/bash profile files.

### Automated Release Summary
<!-- OCS_AUTO_SUMMARY_START -->
- Commit window: `v2.3.6..HEAD`
- Added: 3
- Fixed: 4
- Changed: 2
- Docs: 11
- Chore/Build/CI: 2
- Other: 0
<!-- OCS_AUTO_SUMMARY_END -->

### Commit Coverage (auto-generated)
<!-- OCS_COMMIT_COVERAGE_START -->
- `c4963f9` docs(changelog): auto-sync v3.0.0 commit coverage
- `0c47733` fix(installer): verify adjunct runtime readiness
- `6b99353` fix(installer): harden stdin-safe shell entry
- `3087301` docs(changelog): auto-sync v3.0.0 commit coverage
- `783589a` fix(release): attach managed assets to GitHub releases
- `da69197` docs(changelog): auto-sync v3.0.0 commit coverage
- `1ea94b4` docs(plugin): expand 3.0.0 plugin release notes
- `e182bd2` docs(changelog): expand 3.0.0 release notes
- `d5e87db` docs(plugin): add 3.0.0 plugin release note
- `17a56bf` docs(release): seed public installer changelog for 3.0.0
- `32bbd4d` docs(release): align pinned install version references
- `948fd0c` chore(plugin): bump multi-auth plugin version to 3.0.0
- `591da33` chore(release): bump suite version to 3.0.0
- `132a6d9` docs(dev): add skills ownership matrix and refresh redesign plan
- `bd35302` docs(skills): align buyer-facing skill architecture
- `adfb2b7` feat(skills): redesign bundled buyer-facing skill set
- `a3eceed` docs(installer): update shell guidance and native runtime notes
- `22af32d` fix(installer): harden shell and node runtime path recovery
- `b1c9e8b` test(cli): cover native adjunct doctor and remediation flow
- `81000d0` test(setup): cover native adjunct bootstrap and projection
- `1ac3e75` feat(cli): report native RTK and Caveman runtime health
- `9bbb200` feat(setup): manage native RTK and Caveman bootstrap
<!-- OCS_COMMIT_COVERAGE_END -->
## [2.3.6] - 2026-05-04

### Added

- Added a managed compression control plane under `ocs.compression`, including `ocs compress show|explain|engine|intent` and a generated `compression-routing.json` projection file.
- Added deterministic route-selection guards that keep DCP as the live compact engine while exposing RTK for command-path policy and Caveman for prose/doc policy.

### Changed

- Narrowed the shipped built-in skill surface to agnostic end-user skills by archiving internal-only governance/auth/release skills and generalizing the remaining prompts.
- Restored the canonical root runtime payload, removed the misleading root `oh-my-openagent.json`, archived inactive provider profiles, and made `codex-5.3-token-saver` the default setup profile.
- Switched managed installer/release automation to the `main` lane and fixed changelog coverage windows so release sections stop at the tagged version instead of absorbing later work.

### Fixed

- Setup now preserves exact compatible plugin versions and always rewrites the bundled local `opencode-multi-auth` plugin into installed runtime config across Windows, macOS, and Linux.
- Provider modality metadata now matches the current supported surface: Gemini text models accept video, `qwen3.5-plus` exposes image/video input, and `glm-5` / `glm-5.1` are clamped back to text-only.
- Added broader regression coverage for setup projection, release orchestration, compression routing, and plugin modality synchronization.

## [2.3.5] - 2026-04-20
- Rename profile to gemini-3.1-pro-gpt-oss.json to properly reflect the orchestrator and heavy execution mapping.
- Extract CocoIndex verification into dedicated ocs-cocoindex-gate skill.
- Expand domain coverage in ocs-delegation-gate skill with validation examples.

### Automated Release Summary
<!-- OCS_AUTO_SUMMARY_START -->
- Commit window: `HEAD`
- Added: 153
- Fixed: 167
- Changed: 48
- Docs: 164
- Chore/Build/CI: 90
- Other: 11
<!-- OCS_AUTO_SUMMARY_END -->

### Commit Coverage (auto-generated)
<!-- OCS_COMMIT_COVERAGE_START -->
- `2214d99` docs(release): align release instructions to main
- `839505c` docs(release): update 2.3.5 install examples
- `0643a84` docs(changelog): sync 2.3.5 release notes
- `8076826` chore(release): bump plugin version to 2.3.5
- `459f336` chore(release): bump root suite version to 2.3.5
- `0d65146` fix(plugin): keep OpenAI account state synced
- `8183794` chore(config): update suite config catalogs
- `3a9d712` chore(plans): archive remaining plan notes
- `ae45824` chore(plans): archive strategy plans
- `35b0506` chore(plans): archive server planning docs
- `240d114` chore(plans): archive proxy design plans
- `9e2390f` chore(plans): archive proxy follow-up plans
- `6a5a38a` chore(plans): archive proxy implementation plans
- `fc2d702` chore(plans): archive completed reference docs
- `05eeda4` chore(plans): move plan state updates
- `46da842` test(throttle): expand adaptive throttle coverage
- `c6618e7` test(serversync): add sync coverage
- `220f25c` test(serverconfig): add config coverage
- `3cf4ecb` test(admin): add session handler coverage
- `f0381d8` test(dashboard): add login guard and totp coverage
- `20f8070` test(middleware): add auth and envelope coverage
- `5fc38fa` test(ocs-server): add proxy handler nil db coverage
- `a35ee81` test(antiabuse): add nil db admin coverage
- `10b01cb` test(misc): add nil db proxy coverage
- `7ee7e36` test(usage): add nil db coverage
- `b5dc669` test(dashboard): add auth and 2fa coverage
- `e9bb5b5` feat(ocs-server): admin security — TOTP 2FA, brute force protection, IP ban, adaptive throttle
- `0524cc1` fix: rate limit rework, anti-abuse thresholds, license tracking, per-account rotation
- `4026576` feat: cross-provider hardening — fallback ladder, proxy manager, anti-abuse, rate limiter, request hardening
- `aba59e7` feat(enowxai-extract): add GoReSym v3.3 symbols step to pipeline for Go 1.26+ binaries
- `84efcb6` feat(ocs-proxy): v0.9.14 parity — transient retry, proxy pool, warmup, concurrency limiter, credit system, dashboard redesign
- `ea5352c` feat(ocs-proxy): CodeBuddy provider rewrite, auto-refresh, built-in filters, modular architecture
- `dde0f91` fix(ocs-proxy): CodeBuddy provider routing, credential validation, and batch add fixes
- `77fdca0` fix(ocs-proxy): fix credential mapping, add bulk manual endpoint, and bulk textarea UI
- `d4afdab` docs: add batch account engine and batcher refactor plans
- `fc0d0de` feat(ocs-proxy): add 2-step add account modal with provider registry and manual add support
- `6cc471e` feat(ocs-proxy): add batch account engine with provider registry and Python automation bridge
- `33400bc` feat(enowxai-extract): run extraction pipeline on v0.9.0 binary
- `bcc81ad` feat: streamline checkout flow — GitHub-only auth, session-aware form, mock payment mode
- `376327c` fix: auth flow — postgres.js driver, import.meta.env, Better Auth POST sign-in
- `4ef7197` feat: complete P1 (profile + social), P3 (admin), P4 (UI polish + light/dark mode)
- `39814c7` feat: implement P0 (Google OAuth + license provisioning) and P2 (device binding + management)
- `c839952` docs: update handoff context for session continuation
- `0dc809e` chore: remove tracked SQLite DB and add *.db to gitignore
- `4522533` docs: add session handoff document for RE project continuity
- `a45f238` docs: add OCS master plan, VIP tier system, and user management plans
- `24b1ed7` feat(ocs-landing): update pricing to 5-tier system with strike-through and affiliate rates
- `91ef5c4` refactor(ocs-proxy): remove final ENOWX traces from config migration and handlers
- `1d82665` refactor(ocs-server): migrate from SQLite to PostgreSQL with pgx driver
- `2c7e573` chore(benchmark): add yep-all profile to catalog
- `429602d` chore: replace multi-provider config with unified enowX Labs provider
- `291be83` feat(benchmark): add tier-based model filtering and convert CSS to UnoCSS utilities
- `0d04c1f` fix(ocs-proxy): add last_synced_at and sync_error to dashboard stats for v0.8.4 parity
- `c79d1de` feat(enowxai-extract): run extraction pipeline on v0.8.4 binary
- `49b33f5` docs: comprehensive README rewrites for ocs-proxy, ocs-server, and RE report
- `0af7543` style(ocs-server): fix dashboard formatting, provider tabs, theme init, and empty states
- `2c95fad` fix(ocs-proxy): fix credit formatting, charts, active nav, and pagination
- `1ba31d0` fix(ocs-proxy): fix dashboard formatting, usage periods, filter toggles, and account sync merge
- `5c7602b` docs(ocs-server): add CLI plan with Oracle + Metis review amendments
- `b5743dc` feat(ocs-server): add full CLI with start/stop/restart/status/setup/sync commands
- `33246d5` feat(ocs-server): extract sync.go into reusable serversync package
- `8516d0b` feat(ocs-server): add serverconfig and serverdaemon packages for CLI foundation
- `7707697` docs: capture real enowxai v0.8.4 dashboard API contract (23 endpoints)
- `881f008` style(ocs-server): fix 10 visual issues — responsive sidebar, token consistency, table overflow, spacing
- `4d02828` feat(ocs-proxy): add 6 missing CLI commands for v0.8.4 parity (restart, start --host, proxy clear, mitm)
- `b2b0671` feat(ocs-server): add admin logs, models, and tempmail endpoints for full parity
- `280c641` chore: remove gpt-5.1-codex-max from all configs, docs, and data files
- `1131007` chore(benchmark): sync pure-css tiers.json
- `4871935` docs: add inspect-ai benchmark report
- `2dc0490` chore(benchmark): update test results and model registry
- `8cb7bf1` docs(ocs-server): add dashboard gap fix plan with Oracle + Momus review
- `81f5c4c` feat(ocs-server): add admin dashboard with 31 endpoints and SolidJS SPA
- `d198d4c` docs(ocs-server): apply Oracle + Metis amendments to dashboard plan
- `882e36a` feat(ocs-server): add 13 missing routes for full parity with real enowxai server
- `deb5da9` feat(ocs-proxy): add Temp Mail page and responsive sidebar for v0.8.4 parity
- `ac0de74` fix(ocs-proxy): fix CSS tokens, sidebar layout, theme toggle, charts, and accounts page
- `99c8a48` fix(ocs-proxy): fix account validation, dashboard data pipeline, and pool stats
- `a29635d` feat(benchmark): update RACIK algorithm and paper catalog
- `c239c50` docs: add gap adoption plan, server dashboard plan, and internal-only rules
- `c096c60` feat(enowxai-extract): add full route extraction, servermap, and v0.8.0 diff
- `1570ed9` feat(ocs-server): add v0.8.0 schema, telemetry, and new endpoints
- `cde439f` feat(ocs-proxy): update to v0.8.0 parity with 183 models and 6 provider tiers
- `9d15bf5` feat(ocs-proxy): add Anthropic, Responses, Chat backend, MITM, tools, and image handlers
- `3434c88` chore: clean stale drafts and fix minor typos
- `4903b94` docs(benchmark): update RACIK algorithm plan with Phase O and all hotfixes
- `9519613` chore(benchmark): remove deepseek-v3-2-volc from all data files
- `62a8c2f` fix(benchmark): fix speedtest display, progress bar, and latency chart alignment
- `d4f42b8` feat(benchmark): add RACIK pin UI with modal popup and similarity filter
- `9a7a29a` feat(benchmark): rewrite AI Wizard with direct proxy API call
- `06473a4` feat(benchmark): add models/available endpoint and AI Wizard post-processing
- `3800ee6` feat(benchmark): add pin resolution, auto-fallback, and fallback chain generation
- `8a61f4f` fix(benchmark): improve reliability scoring with success-ratio and routing model metadata
- `80c1106` feat(benchmark): add multi-run speedtest with retry and token estimation
- `15e2c49` feat(benchmark): add multi-run speedtest prompts and constants
- `d76fc43` feat(benchmark): add pin types and auto-fallback interfaces
- `d7dad97` data(enowxai-extract): add extracted artifacts for v0.6.3 and v0.7.4
- `64e5503` feat(enowxai-extract): add Go extraction pipeline with 63 tests
- `ea66fb4` style(ocs-proxy): replace hardcoded colors with design system tokens
- `8f05548` docs(ocs-proxy,ocs-server): rewrite READMEs for renamed projects
- `2708436` feat(ocs-proxy): add auto-migration from ~/.enowx-client/ to ~/.ocs-proxy/
- `ec00ed8` refactor(ocs-proxy): remove all enowx/enowxlabs branding traces
- `8b72cef` feat(ocs-proxy): wire all 17 SPA pages to real dashboard API
- `5afae8a` chore(ocs-proxy): remove duplicate .jsx files in favor of .tsx
- `c5a805a` feat(ocs-proxy): add frontend dashboard scaffold
- `6ae7991` refactor(ocs-proxy): update dashboard server routing and main entry
- `dce90cb` chore: share .sisyphus/ plans and docs for team collaboration
- `ebe05fc` fix(benchmark): fix progress bar, tok/s display, and history detail rendering
- `7545e9a` fix(benchmark): add system message, retry, and token estimation to speedtest runner
- `737f915` fix(benchmark): reliability protection, auto-create thinking variants, and history import
- `a89775e` feat(benchmark): remove leaderboard from UI and refresh pipeline
- `b2bffc0` refactor(ocs-proxy): rename enowx-client to ocs-proxy
- `e934b11` refactor(ocs-server): rename enowxai-replica to ocs-server
- `78717aa` feat(benchmark): add thinking variant scores to community baselines
- `8435698` chore(benchmark): add data/*.txt to gitignore
- `670e18f` feat(benchmark): add pure-css v2 snapshot as reference implementation
- `72e90b6` docs: add config source-of-truth policy for Windows vs WSL
- `9177860` docs(benchmark): update README and benchmark report with scoring methodology
- `c0ac2fc` docs(benchmark): add capability testing docs and scoring methodology
- `594723a` feat(benchmark): update research-based scores for 26 base models
- `ec9c4a4` feat(benchmark): add source protection for capability-test in registry
- `d628114` feat(benchmark): add capability test runner and importer
- `77c5b63` fix(benchmark): fix deselect-all regression in speedtest, benchmark, and history tabs
- `42dc1c1` feat(benchmark): add AI Wizard glossary terms and fix ModelDetail source badge overlap
- `665cbf8` feat(benchmark): add tier proportion slider and AI Wizard button to RACIK panel
- `59b10a6` feat(benchmark): add AI Wizard backend with opencode CLI integration
- `b296852` feat(benchmark): add tier proportion slider and role priority allocation to RACIK engine
- `8725787` feat(benchmark): wire model selection from LatencyChart through RACIK preview pipeline
- `1effef3` feat(benchmark): add model selection checkboxes and tier badges to LatencyChart
- `5561075` fix(benchmark): rewrite RACIK algorithm with exponential diversity, round-robin processing, and multimodal data
- `78f572c` feat(benchmark): add refresh progress steps, mutual exclusion, and routing model badges to registry UI
- `b360377` feat(benchmark): add per-source error isolation and progress tracking to refresh handler
- `944c707` feat(benchmark): add routing model exclusion and 7 missing role requirements to RACIK engine
- `0487498` fix(benchmark): fix rankPercentile returning 0 when all values are equal or single element
- `3d3df07` feat(benchmark): add leaderboard checkbox to refresh widget with glossary terms
- `d398911` test(benchmark): add 26 leaderboard import tests covering aliases, fetcher, normalizer, and importer
- `c1923ec` feat(benchmark): add leaderboard import pipeline from Artificial Analysis via GitHub mirror
- `1a5b158` fix(benchmark): align RACIK Profile button height with badge cards via children prop
- `cbbb235` fix(benchmark): sidebar cleanup, chart bar animation, emoji rendering, and scrollbar hiding
- `aeff4ea` docs(benchmark): update README and CHANGELOG for v0.3.0 Tailwind migration
- `d898758` refactor(benchmark): delete app.css and add merge-ready BenchmarkPage export
- `33172b1` refactor(benchmark): migrate 13 tab and feature components from CSS to Tailwind utilities
- `19b17f5` refactor(benchmark): migrate 9 common components from CSS to Tailwind utilities
- `0e9eba5` feat(benchmark): add collapsible sidebar navigation with dark/light theme toggle
- `f32b166` feat(benchmark): add TailwindCSS v4 with dark/light theme token system
- `37b03b6` chore(benchmark): add lock files for reproducible installs
- `c8390d5` feat(ocs-proxy-preview): add utility pages (Logs, Settings, Tools, Docs, Donate, About)
- `531cc44` feat(ocs-proxy-preview): add proxy management pages (ApiKey, Proxy, Filters, Integrations, ManualConfig)
- `f72d3ac` feat(ocs-proxy-preview): add core dashboard pages (Login, Dashboard, Accounts, Models)
- `bdadfaa` feat(ocs-proxy-preview): add shared UI components, stores, and API client
- `f2162de` feat(ocs-proxy-preview): scaffold SolidJS dashboard with Vite and TailwindCSS
- `8e00339` docs(enowxai): add dashboard screenshots and accessibility snapshots
- `9c92dc0` chore: remove stale root artifacts from research phase
- `174a8e8` fix(benchmark): minor test adjustments for runner and stats
- `470871a` feat(benchmark): add glossary terms and CSS for refresh widget
- `ab40d17` feat(benchmark): add registry API client functions and type exports
- `e25bd8e` feat(benchmark): add refresh widget for multi-source registry data collection
- `1b2c2bf` feat(benchmark): add registry refresh and status API routes
- `f99afc1` feat(benchmark): add community baselines data and multi-source import pipelines
- `553b67c` chore: archive enowx-client and enowxai-replica pre-rebrand snapshots
- `6cf518d` feat(enowx-client): add rebuilt proxy client with Kiro/CodeBuddy/Wavespeed providers
- `c746831` feat(enowxai-replica): add replica license server with 37 API endpoints
- `693fb71` docs(enowxai): add opencode config reference for integration analysis
- `08a140d` docs(enowxai): add OmniRoute Kiro protocol reference extraction
- `6d64b53` docs(enowxai): add reverse engineering report, account analysis, and server plan
- `30f9f28` chore: exclude playwright-mcp state and sqlite databases from tracking
- `771ddc1` style(benchmark): add registry and dimension CSS styles
- `f581d5c` docs(benchmark): sync whitepaper and paper catalog with RACIK v2 and 8 research gaps
- `1bafb35` feat(benchmark): add registry tab with model detail panel and star rating
- `5244b5d` feat(benchmark): rewrite RACIK engine with 11-dim scoring and diversity enforcement
- `9674da8` feat(benchmark): add model registry with 11-dimension capability tracking
- `7a0bd2b` refactor(benchmark): rename all internal cook/Cook references to racik/Racik
- `abdae4e` docs(benchmark): add RACIK algorithm whitepaper and academic paper catalog
- `ffd369c` refactor(benchmark): rename apps/benchmark to apps/ocs-benchmark and rebrand Cook to RACIK
- `0a49af8` fix(lint): resolve markdown lint warnings in gemini rules
- `f2ee9c3` chore(benchmark): add package.json, changelog, readme, and project metadata
- `0608ceb` feat(benchmark): rewrite frontend with tabs, chart, history, and cook UI
- `55eaf35` test(benchmark): add 178 tests covering all backend modules and regression guards
- `5def374` feat(benchmark): add speedtest, SQLite persistence, tier system, and cook algorithm
- `f65d1c8` test(benchmark): add test infrastructure with vitest config, tsconfig, and fixtures
- `c15c5ad` fix(installer): detect missing curl.exe and use PowerShell native download for Bun install
- `e6bf785` test(setup): add profile model integrity checks and dual-file snapshot regression tests
- `da1cd5f` fix(providers): add zai and qwen providers with all referenced models
- `2b4e51b` fix(setup): read both oh-my-openagent.json and oh-my-opencode.json for config snapshot
- `d982f87` fix(providers): add missing gpt-5.4-mini model to openai provider
- `119a522` chore: update vitest workspace configuration
- `f5fd188` docs(release): update onboarding and troubleshooting guides
- `28db4d2` chore(multi-auth): update gemini rules and troubleshooting docs
- `b93e048` docs: update config audit and deep-dive documentation
- `3e897f9` chore(gemini): update coding rules and workflow policies
- `e5cf5f5` Merge pull request #3 from andyvandaric/fix/v2.3.4
- `a8f5bdc` test(setup): add 48 regression tests for config merge and existing v2.3.4 features
- `a721e3e` fix(setup): add config merge to preserve user providers, agents, plugins, and MCPs on profile switch
- `41a0fbc` Merge pull request #2 from andyvandaric/feat/ocs-benchmark
- `09b650f` refactor(benchmark): move from scripts/ to apps/ directory
- `a9d3364` docs(benchmark): add benchmark results and analysis report
- `fd40f07` feat(benchmark): add package.json scripts, hono dependency, and README
- `7702bd9` feat(benchmark): add SolidJS web dashboard with dark theme and sortable results
- `4876312` feat(benchmark): add Hono API server and entry point with pre-flight proxy check
- `6256a15` feat(benchmark): add sequential benchmark runner engine
- `a65fe2d` feat(benchmark): add type definitions, config reader, stats module, and prompt definitions
- `25d0a42` chore(docs): update installer URL to use main in README and rules
- `1d994b5` docs(changelog): auto-sync v2.3.4 commit coverage
- `f57e30c` docs: fix quick-start guides to target main branch installer instead of staging
- `bf88edf` docs: sync version numbers to 2.3.4 in quick-start guides
- `a160806` docs(changelog): auto-sync v2.3.4 commit coverage
- `04b6257` docs(installer): update public changelog for v2.3.4
- `933fa3d` docs(plugin): document shared claude fallback cascade
- `95f8ea6` test(plugin): cover shared claude fallback cascade and guards
- `33df3b3` fix(plugin): cascade shared claude quota exhaustion to gemini models
- `dcde894` refactor(plugin): add canonical fallback policy layer
- `7a03058` fix(auth): increase stream timeouts for stability
- `8569426` fix(installer): skip pull if remote branch does not exist during sync
- `f171f38` Merge branch 'staging/v2.3.3' into staging/v2.3.4
- `13e69fe` fix(plugin): implement gradual jitter and auto account rotation on capacity exhausted
- `d9dbbb0` docs(changelog): auto-sync v2.3.4 commit coverage
- `1a0a895` fix(plugin): remove retry limit for capacity exhausted to keep trying and shorten jitter delay
- `77ef23b` chore(release): bump version to 2.3.4
- `e92cdc2` feat(configs): replace gpt-oss lead profile with gemini-3-hybrid
- `f1af431` docs(changelog): auto-sync v2.3.3 commit coverage
- `d6c3868` feat(plugin): increase max oauth accounts to 30 to support larger active pools
- `7f9e338` docs(changelog): auto-sync v2.3.3 commit coverage
- `e1bfc8d` docs(changelog): auto-sync v2.3.3 commit coverage
- `6558db3` docs(changelog): auto-sync v2.3.3 commit coverage
- `873a5f6` docs(changelog): auto-sync v2.3.3 commit coverage
- `a90d13b` chore(release): bump version to 2.3.3
- `38be921` fix: call applyToolPairingFixes universally in request payload fallback to resolve Antigravity array-format ID rejections
- `75ff2a2` fix: disable non-Claude guard in tool pairing to support Antigravity models
- `8e10a52` docs(changelog): auto-sync v2.3.2 commit coverage
- `2207974` docs(changelog): auto-sync v2.3.2 commit coverage
- `e06331f` docs: update changelog for v2.3.2 release
- `6305ef1` chore(release): update lockfiles for v2.3.2
- `99caab7` fix(gemini): strip all string numeric constraints instead of casting to pass strict antigravity validation
- `2ed8f97` chore(release): bump version to 2.3.2
- `3d8b6f2` feat(config): add gpt-oss-120b-lead profile using Antigravity GPT-OSS 120B as orchestrator
- `c9c32ea` docs(installer): update installer README template to main and v2.3.1
- `12aeb77` fix(gemini): ensure all schemas pass through toGeminiSchema sanitization hook
- `7068cd7` docs(skills): update delegation gates to reference cocoindex playbook and add impeccable-style trigger rules
- `61a2020` feat(config): switch explore agent to antigravity gpt-oss-120b-medium model
- `0e70669` fix(plugin): cast string numeric constraints to integers for strict gemini schema validation
- `2aa72a2` fix(plugin): send LINUX platform metadata in WSL environments
- `662a50e` fix(installer): resolve missing ocs index script path and remove empty prefix path array bug
- `3b432c8` docs(workflow): enforce main-oriented patch publication order
- `91df4b3` fix(setup): preserve account state and harden profile runtime checks
- `c2efcb4` fix(setup): keep profile apply fast and deterministic across WSL parity
- `63b5af3` fix(installer): default latest branch hint to main
- `01926fc` chore(governance): enforce release execution policy and impeccable overrides
- `de4f889` Merge remote-tracking branch 'origin/main'
- `c37ed9c` Merge branch 'feat/stable-andyvand-2.3.1'
- `9096ea5` docs: update beta README for Stable v2.3.1
- `972aac3` docs: align beta README with v2.3.1 lane
- `3f4129a` docs(changelog): add v2.3.1 cold-start and installer fix notes
- `07c0681` docs(changelog): add v2.3.1 cold-start and installer fix notes
- `2c1f0f8` fix(installer): default version-pinned branch to staging lane
- `2a9fff1` fix(plugin): harden cold-start persistence and split provider regressions
- `c1c2d6b` fix(installer): default version-pinned branch to staging lane
- `9f3840b` fix(plugin): harden cold-start persistence and split provider regressions
- `ab7e852` docs(changelog): auto-sync v2.3.0 commit coverage
- `ff2cc08` fix(plugin): flush auth-menu persistence and split provider save routes
- `afd7ea2` docs(wsl): require WSL validation for runtime-affecting changes
- `e4c35fe` fix(doctor): resolve plugin runtime markers from direct install root
- `1632371` fix(plugin): persist antigravity account state and sticky defaults
- `2746cb0` fix(installer): reset runtime plugin directory before setup
- `20dc2ae` docs(changelog): auto-sync v2.3.1 commit coverage
- `7b2ca17` docs(ops): codify monorepo source-of-truth and quick profile switching
- `02e61ba` fix(plugin): stabilize auth routing and antigravity response parsing
- `26929d7` fix(setup): harden installer sync, doctor remediation, and monorepo config flow
- `327c049` chore(configs): refresh profile catalog and schema endpoints for v2.3.1
- `61bfddb` merge: integrate staging/v2.3.1-patch into staging/v2.3.1
- `44d97db` docs(installer): add windows path divergence triage
- `67644d3` fix(installer): classify safe home paths as resolved
- `3d545ce` test(installer): add failing empty-path regression cases
- `50fde8b` docs(changelog): auto-sync v2.3.1 commit coverage
- `0e1bcb4` chore(plugin): align multi-auth version to 2.3.1
- `c43a1af` docs(changelog): auto-sync v2.3.1 commit coverage
- `a0814b8` docs(changelog): auto-sync v2.3.1 commit coverage
- `a28067a` docs(installer): add v2.3.1 release section
- `3fbf35e` docs(changelog): auto-sync v2.3.1 commit coverage
- `b2b9c0a` chore(release): bump suite version to 2.3.1
- `0b8576a` fix(release): make installer sync branch-aware
- `8df7143` feat(skills): integrate impeccable-style governance into OCS
- `140bcd8` fix(plugin): restore antigravity version resolution fallback chain
- `ed9844c` fix(installer): harden cross-platform install and doctor flows
- `0d48221` Merge branch 'beta'
- `70f2bfe` fix(installer): harden linux package install sudo fallback
- `e82ee2c` fix(installer): avoid assoc array for path dedup
- `bff4dfd` docs(changelog): auto-sync v2.3.0 commit coverage
- `e59ef44` docs(changelog): auto-sync v2.3.0 commit coverage
- `5f7ab6a` docs(changelog): auto-sync v2.3.0 commit coverage
- `8d01fab` docs(changelog): auto-sync v2.3.0 commit coverage
- `83b3e7d` docs(changelog): auto-sync v2.3.0 commit coverage
- `be39b1a` docs(changelog): auto-sync v2.3.0 commit coverage
- `3403e6b` chore(release): prep staging v2.3.0 lane
- `126f946` docs(changelog): auto-sync v2.2.1 commit coverage
- `46b32c2` docs(changelog): auto-sync v2.2.1 commit coverage
- `2a0e950` fix(plugin): avoid mass OpenAI quarantine on non-rotation refresh errors
- `ab83093` docs(changelog): auto-sync v2.2.1 commit coverage
- `7ab9362` docs(changelog): auto-sync v2.2.1 commit coverage
- `7a7a54b` fix(plugin): null-safe OpenAI model routing in account selection
- `ae8be92` fix(plugin): harden OpenAI soft-quota failover for single-account mode
- `2b4884c` docs(changelog): auto-sync v2.2.1 commit coverage
- `109faaf` fix(installer): align fallback branch hint to staging v2.2.1
- `f566f73` fix(installer): call Ensure-PnpmRuntime in staging script
- `ddd63de` docs(changelog): auto-sync v2.2.1 commit coverage
- `5c717dd` chore(release): finalize staging v2.2.1 runtime and installer parity
- `a89e924` docs(changelog): auto-sync v2.2.1 commit coverage
- `cc89f86` merge(release): staging v2.2.1 into main
- `414419f` docs(changelog): auto-sync v2.2.1 commit coverage
- `bba1986` chore(governance): gate release docs snippet alignment
- `1049b23` docs(release): require installer command alignment checks
- `209b7e1` docs(installer): align v2.2.1 branch and pin snippets
- `a637aeb` docs(changelog): auto-sync v2.2.1 commit coverage
- `549a261` docs(changelog): auto-sync v2.2.1 commit coverage
- `fa12232` docs(installer): add v2.2.1 public changelog section
- `43e5978` docs(changelog): auto-sync v2.2.1 commit coverage
- `d59ebba` docs(changelog): add v2.2.1 release section
- `01a9d0e` chore(release): bump suite and plugin versions to 2.2.1
- `74151fd` docs(changelog): auto-sync v2.2.0 commit coverage
- `f64bfa8` docs(changelog): auto-sync v2.2.0 commit coverage
- `a4ae79a` docs(installer): add copy SEO playbook and skill references
- `7341e86` feat(skills): add installer copywriting SEO runtime skill
- `a1b7eef` feat(governance): add installer copywriting and SEO skill gates
- `df49af9` fix(plugin): harden OpenAI loader and auth state handling
- `d97cbf4` feat(setup): activate cocoindex-code via ccc and MCP sync
- `4465841` docs(changelog): auto-sync v2.2.0 commit coverage
- `f412dcf` docs(changelog): auto-sync v2.2.0 commit coverage
- `08c2ac8` docs(release): enforce cross-repo tag and release-note propagation
- `9e336ef` docs(changelog): auto-sync v2.2.0 commit coverage
- `f1c88ca` docs(changelog): auto-sync v2.2.0 commit coverage
- `8d9083b` docs(skills): add adaptive integration guide and markdown workflow references
- `fe22578` feat(skills): add markdown autofix skill and adaptive loading governance
- `2c20353` chore(markdown): align lint rules and add autofix scripts
- `0eb4bca` feat(setup): resolve cocoindex command paths and seed extensions scaffold
- `1ec5b8e` fix(plugin): harden openai quota probe fallback paths
- `b66e374` docs(changelog): auto-sync v2.2.0 commit coverage
- `db70273` fix(runtime): harden openai rotation and local install resilience
- `10f6f46` docs(changelog): auto-sync v2.2.0 commit coverage
- `49086bc` docs(readme): restore advanced EXA setup in private guide
- `83b02f9` docs(changelog): auto-sync v2.2.0 commit coverage
- `544127d` docs(installer): refactor public README for soft-selling flow
- `14a753c` docs(changelog): auto-sync v2.2.0 commit coverage
- `a19f549` docs(changelog): auto-sync v2.2.0 commit coverage
- `abb628c` docs(profiles): align v2.2 recommendations and onboarding parity
- `b381bbf` docs(release): update v2.2.0 session stability notes
- `9240834` fix(openai): improve session trigger robustness and durability
- `faa32c3` fix(runtime): harden openai sessions and installer shim reliability
- `5aae294` feat(setup): bootstrap CocoIndex and align staging v2.2.0
- `6fb26ad` chore(governance): tighten delegation and release validation guardrails
- `9c6b1b3` fix(setup): auto-repair legacy dcp config keys
- `0998b4b` docs(changelog): auto-sync v2.1.15 commit coverage
- `2a87536` docs(changelog): auto-sync v2.1.15 commit coverage
- `339f7e9` docs(changelog): auto-sync v2.1.15 commit coverage
- `8ca8570` fix(staging): harden openai on-demand refresh and align v2.1.15 lanes
- `477eb56` docs(changelog): auto-sync v2.1.14 commit coverage
- `2885974` fix(plugin): add lockfile no-op fallback for runtime interop
- `fba969e` docs(changelog): auto-sync v2.1.14 commit coverage
- `9cdcb13` fix(plugin): normalize proper-lockfile interop for account toggles
- `f0aaca0` docs(changelog): auto-sync v2.1.14 commit coverage
- `a47302b` fix(plugin): prevent proper-lockfile import crash in runtime
- `ede70bb` docs(changelog): auto-sync v2.1.14 commit coverage
- `228f712` fix(installer): align v2.1.14 bundle versions and auth plugin precedence
- `f3e9330` docs(changelog): auto-sync v2.1.14 commit coverage
- `426ab66` fix(staging): align installer lane to v2.1.14 and harden openai auth flow
- `48bc2b7` docs(changelog): auto-sync v2.1.14 commit coverage
- `be35ff0` docs(installer): add v2.1.14 release notes template
- `4c61215` docs(changelog): auto-sync v2.1.14 commit coverage
- `c4afaeb` fix(auth): restore manage/check flows and schema-safe credential restore
- `6d3a6dd` docs(changelog): auto-sync v2.1.13 commit coverage
- `f12e504` fix(release): enforce fresh multi-auth bundle and runtime credential safety
- `18572af` fix(setup): preserve runtime API credentials on reinstall
- `af37a05` docs(changelog): auto-sync v2.1.13 commit coverage
- `5450c77` feat(setup): align MCP defaults and profile parity for staging
- `08459e2` docs(changelog): record OCS skills sync rollout
- `a7d7834` docs(skills): establish OCS skills governance model
- `3b1fdd8` fix(installer): preserve hidden bundle directories
- `654fd76` feat(skills): add managed OCS skills sync pipeline
- `872bd0f` docs(rules): mandate tarball integrity SOP
- `651a1ea` feat(release): enforce provenance and parity guardrails
- `89f3e83` docs(changelog): record openai menu activation fix
- `8c80c82` fix(setup): use loader-safe local plugin specs
- `455dfd1` feat(release): bundle openai auth wrapper plugin
- `8015f85` docs(changelog): record realtime quota check behavior
- `34475b4` fix(quota): force realtime openai check output
- `2a6ca9b` docs(changelog): record exa schema compatibility fix
- `aa38bb9` fix(exa): enforce schema-safe setup output
- `97f9a56` fix(mcp): normalize exa header schema tokens
- `8bd44c1` docs(changelog): document installer lane resolution fix
- `3e1442a` fix(installer): infer source lane and align fallback branch
- `dd2bce8` docs(readme): align staging installer URLs to v2.1.13
- `487a608` docs(release): record v2.1.13 exa parity updates
- `142159f` docs(installer): expand exa onboarding and changelog continuity
- `38afc57` feat(cli): add exa setup and check commands
- `7c047ea` feat(mcp): add exa wiring and setup utility
- `5078492` docs(release): document multi-lane orchestration flow
- `891fac0` feat(release): add lane orchestration command
- `e237102` feat(installer): support explicit target branch sync
- `bd57d49` docs(release): complete v2.1.13 changelog coverage
- `c47938e` feat(openai): add accounts sanity-check command and docs
- `b1d0b18` fix(openai): persist rotated auth and clarify refresh failures
- `d2f0cb5` docs(security): enforce openai auth-state safety boundaries
- `4b41f36` docs(release): record latest openai patch notes in v2.1.13
- `52f3785` fix(openai): prevent add-account overwrite across identities
- `68917fd` fix(openai): strip unsupported codex output-token params
- `cc65969` docs(release): restore 2.1.12-2.1.5 changelog continuity
- `8a7341a` feat(staging): cut v2.1.13 with configurable openai buffer
- `65d1ffc` fix(plugin): route session auth requests through codex surface
- `8f1e361` fix(plugin): stabilize openai post-login refresh state
- `1b338a4` fix(plugin): re-enable openai account after reauth
- `63cd15d` fix(plugin): surface concrete openai auth-unavailable reasons
- `b2fd07d` fix(openai): inject codex instructions for web ui requests
- `6c38af1` fix(plugin): harden openai oauth fallback and switch policy
- `d11219f` chore(release): restore suite version to 2.1.12
- `f3c0606` fix(setup): prevent plugin self-delete during installer mode
- `0289d17` docs(staging): add v2.1.12 e2e checklist and tidy plugin changelog
- `0b26f6f` docs(plugin): restore full 2.1.11-2.1.4 changelog chain
- `2b578b2` chore(plugin): sync changelog to v2.1.12 parity
- `87c1700` fix(app): stabilize staging diagnostics and API test placement
- `1869690` chore(release): sync v2.1.12 version pins and changelog history
- `dfcc77a` feat(plugin): enforce cli-first quota refresh parity defaults
- `98b22cd` merge(chore): integrate remaining f75f release fixes into main
- `e9efb4f` merge(feat): integrate ecf4 latest implementation into main
- `bb07338` fix(plugin): avoid ambiguous OpenAI account upsert collisions
- `6e0e86b` chore(repo): remove oc-chatgpt reference mirror
- `b07f899` chore(plugin): align package version to 2.1.12
- `4240cd0` feat(plugin): tighten quota refresh defaults and ttl bounds
- `43da28a` feat(plugin): harden OpenAI multi-account parity flow
- `95653c3` fix(testing): stabilize feat-ecf4 gate validation lanes
- `a9ebb83` chore(flowcrate): capture batch-3 commit continuity sha
- `10d0047` feat(flowcrate): execute feat-ecf4 release-handoff evidence runbook
- `e907394` chore(tmp): add local workspace and runtime snapshots
- `411d734` chore(meta): track sisyphus planning and continuation state
- `0a095f1` feat(plugin): strengthen streaming transformer event handling
- `e5d81ca` feat(plugin): refine auth menu selection and ansi rendering
- `33874a7` feat(plugin): harden quota fallback and refresh queue logic
- `c21416b` test(plugin): expand openai provider and probe coverage
- `b5bb369` feat(plugin): improve account lifecycle and auth state handling
- `f2f7d70` feat(plugin): sync setup flow and schema documentation
- `9de30eb` chore(config): update root tooling and profile configuration
- `746820f` docs(landing): refresh docs and marketing content
- `d70d4c2` test(plugin): add probe and refresh hardening suites
- `a22b89a` test(plugin): cover thinking recovery regression boundaries
- `adfbc1f` test(resilience): add deterministic invariant hardening sweeps
- `3b8c73e` chore(plugin): remove orphaned opencode-openai-auth package
- `3439a4c` test(plugin): add resilience decomposition and orchestration coverage
- `0de23d8` feat(plugin): decompose resilience orchestration into focused modules
- `7e00291` test(plugin): stabilize audit and storage verification tests
- `adc0bba` feat(plugin): wire runtime audit emitter and tests
- `2e5dd3a` feat(plugin): emit audit events in auto-update checker
- `d07c603` feat(plugin): add audit sinks for logger and debug
- `26d829e` feat(plugin): add audit config and env controls
- `6ef1c89` test(plugin): add phase0 fixture guardrails baseline
- `1ec1430` docs(installer): sync templates and changelog to 2.1.3
- `e5426d7` docs(installer): bump root install examples to 2.1.3
- `a4d042f` docs(installer): enforce pwsh install command on Windows
- `4dc0298` feat(plugin): probe openai session quota with usage fallback
- `45431e1` feat(plugin): add openai login method menu actions
- `32c7ac4` fix(plugin): harden openai oauth callback listener flow
- `c8e8f1b` chore(release): align beta with 2.1.3 release line
- `4d69b80` docs(release): align package publish instructions
- `5bfeefd` docs(release): update buyer beta publish guidance
- `21fce31` chore(installer): sync LF enforcement and public installer docs
- `e196ce0` fix(installer): harden shell bootstrap and oauth guard
- `1a44dd2` fix(setup): refresh bundled multi-auth staging
- `ccd9250` fix(setup): stabilize local plugin tarball packing
- `9728fa7` feat(plugin): persist openai identity metadata
- `c43c984` feat(plugin): add openai browser and headless auth
- `18bed6d` feat(plugin): finish openai account lifecycle parity
- `f32d1be` fix(plugin): store openai accounts separately
- `a2105d5` feat(plugin): add openai auth wrapper package
- `4fe308b` fix(setup): load plugin-owned openai auth wrapper
- `867c85d` chore(installer): sync public installer templates for 2.1.3
- `d44fd6a` docs(installer): sync install guides to 2.1.3
- `7fefcc1` docs(release): add 2.1.3 oauth visibility notes
- `86a913b` chore(release): bump suite and plugin to 2.1.3
- `2396b81` fix(setup): prefer bundled package fallback for multi-auth
- `b6537f7` fix(installer): align auto setup defaults with installer profile
- `72c20e7` feat(plugin): add openai account menu parity
- `a683f96` fix(release): track antigravity backup template for clean packaging
- `831f8b7` chore(installer): sync public installer templates to 2.1.2
- `26235e6` docs(installer): sync version examples to 2.1.2
- `96054d6` docs(release): add 2.1.2 release notes
- `7ab0e64` chore(release): bump suite and plugin to 2.1.2
- `2e8258f` docs(plugin): document codex multi-auth runtime path
- `faf27ab` feat(plugin): add codex session safety guards
- `a37fe57` feat(plugin): add openai provider routing primitives
- `c28ddf7` feat(plugin): add codex shared-core account state
- `cf0e5c4` chore(installer): restore public installer sync inputs
- `8678464` fix(installer): restore source installer scripts in main repo
- `67f708e` docs(plugin): add 2.1.1 changelog entry
- `8b42615` fix(setup): pin oauth-compatible plugin stack at deploy time
- `092d4a8` docs(quick-start): add version-pin install examples in Indonesian guide
- `d02e899` chore(release): bump suite and plugin version to 2.1.0
- `3614c23` docs(installer): update public installer copy for 2.1.0
- `5a71b0c` chore(runtime): update default GPT-5.4 stack and plugin channels
- `6c25a37` docs(models): add pass-model mapping and GPT-5.4 notes
- `c9968e8` feat(config): add hephaestus to codex 5.4 profiles
- `fd8c41b` docs(troubleshooting): add doctor and path recovery guidance
- `460b6f7` feat(cli): add ocs doctor and docs for version pin
- `b576270` fix(setup): fallback invalid resource mode and document version pin
- `ddb4148` chore(release): bump suite and plugin to 2.0.15
- `e6154d7` fix(installer): restore README copywriting and CTA
- `1ee818e` docs(release): announce gpt-5.4 setup profiles
- `04c6b47` feat(profile): add codex-5.4 setup profiles
- `b9ef079` fix(release): enforce suite artifact naming and v2.0.14 changelog
- `ee4775f` fix(release): keep installer template bundle naming in sync
- `a29203c` chore(release): cut v2.0.14 and align installer topology
- `17bf768` fix(installer): resolve suite bundle names in shell and powershell
- `8215fbb` fix(installer): resolve suite bundle names in shell and powershell
- `1f91073` chore(repo): ignore local release clone workdirs
- `900ceb6` chore(repo): ignore local release clone workdirs
- `0eeec4d` fix(installer): prefer https auth flow and beta semver labels
- `78537cb` fix(installer): prefer https auth flow and beta semver labels
- `2348bd5` docs(release): add v2.0.13 changelog entries
- `3ae10de` fix(installer): use OAuth-first auth and quiet installer setup logs
- `72e5708` chore(repo): checkpoint pending docs, scripts, and flowcrate updates before refactor-4b3f
- `80030cc` fix(auth): restore google oauth flow after reinstall
- `021d1b7` fix(installer): enforce oauth guard across plugin reinstall paths
- `05ea6fb` chore(release): cut v2.0.10 with latest auth/setup fixes
- `401f3c6` chore(release): bump v2.0.9 metadata and add missing v2.0.8 notes
- `b59a7ff` fix(installer): repair ocs shim and enforce auth guard after setup
- `67d3306` fix(setup): harden multi-auth resolution and enforce oauth guard
- `601163d` docs(readme): expose v2.0.8 changes and patched legacy issues
- `fc0f2f2` fix(release): sync root README to releases repo
- `454c945` fix(release): sync full docs to releases repository
- `6c540eb` chore(release): bump plugin version to v2.0.8
- `d411430` fix(release): handle untracked managed paths in repo sync
- `c8850d3` docs: align web-ui guidance and relocate developer docs
- `425f877` chore(release): remove legacy root checksum artifact
- `52b63b5` feat(release): add managed sync pipeline and artifact layout
- `d49a7bf` fix(plugin): harden account persistence on storage load errors
- `0f33118` docs(changelog): add v2.0.7 root release notes
- `5657d6f` chore(release): bump plugin to v2.0.7 and refresh checksums
- `77a9ff5` docs(plugin): add preset selection guide and 5-minute checklist
- `efe0619` test(plugin): cover dynamic routing modes and capability behavior
- `d66a25c` feat(plugin): add dynamic cli-first routing and capability-aware fallback
- `020a85d` fix(installer): keep hybrid auto-setup and simplify next steps
- `21c080c` fix(setup): self-heal bun global duplicate lock corruption
- `544b206` fix(prefs): harden schema loading and restore gemini oauth hybrid flow
- `a734cf3` fix(release): restore antigravity oauth login in installer deployments
- `f0ee9c9` chore(release): cut v2.0.3 with setup CLI fix
- `d838837` fix(cli): restore interactive setup default and add update aliases
- `172c993` fix(installer): enforce bun-only dependency retries
- `7878958` chore(release): finalize 2.0.2 changelog metadata
- `ebd5c79` chore(changelog): finalize released sections
- `2e9a5b9` build(release): include changelogs in bundled artifacts
- `da47524` chore(release): finalize 2.0.1 notes and metadata
- `03d72b7` refactor(plugin): remove manual verify-account menu flow
- `32354da` docs(plugin): record unreleased wave-2 commit trail
- `cbdfa6e` feat(plugin): enforce status floors in cooldown backoff
- `3ff6130` feat(plugin): add adaptive 5xx retry and switching path
- `81a00b9` feat(plugin): add 401 escalation and 404 cooldown routing
- `b1a451b` feat(plugin): harden storage migration and save coordination
- `7ab7e15` feat(plugin): add rest-until-full soft quota lock flow
- `0362157` feat(plugin): normalize model-family cooldown lock keys
- `42fc708` test(plugin): add 429 dedup storm coverage
- `f510011` feat(plugin): extend cooldown duration fallback parsing
- `96302de` feat(plugin): harden phase-1 retry and quota classification
- `b25c385` feat(plugin): add phase-0 policy rollout guardrails
- `120c6a9` docs(prefs): document strict validation apply behavior
- `dae1057` feat(prefs): enforce strict schema validation in wizard
- `1d5800a` fix(release): make bundle copy reliable on Windows
- `b92e68e` fix(installer): enforce bun-only ocs shims and stable install path
- `bc984f7` fix(installer): make ocs bootstrap deterministic on Windows
- `e9693b3` feat(release): automate installer sync and private ocs bootstrap
- `2cc68f4` fix(installer): auto-repair ocs command on Windows
- `c4049b5` fix(release): publish checksum asset with tarball
- `4db11f3` chore(gitignore): ignore local antigravity config file
- `a66fbe3` chore(release): prepare v2 changelog and plugin version
- `1d9e448` docs(scripts): document antigravity fallback behavior
- `2b49027` fix(setup): seed antigravity config from template fallback
- `19fef61` feat(landing): refresh hero section and add hero lab page
- `5cc69bc` docs(multi-auth): add sonnet opus 400 vs 403 triage playbook
- `a3f3d9b` test(multi-auth): add regression coverage for sonnet opus payload edges
- `de9553f` fix(multi-auth): harden claude payload normalization and thinking guards
- `ad3ed96` feat(cli): add global ocs dispatcher and prefs wizard
- `3904771` feat(multi-auth): align CLI quota fallback and image model routing
- `aedcabb` feat(setup): default to hybrid profile and performance mode
- `ee0a386` docs(installer): standardize pwsh cache-buster command
- `33dda63` feat(branding): add final pro hybrid logo system
- `d1ccf00` fix(installer): default to codex hybrid performance
- `7c7ba91` chore(installer): refine next-steps guidance text
- `28c9458` fix(installer): enforce bun-only dependency retries
- `11a42b9` fix(installer): harden dependency install retries and fallback
- `d886420` fix(installer): resolve relative plugin path during bun install
- `b7d8513` fix(installer): continue in current shell when pwsh relaunch fails
- `5d0e2a7` fix(installer): harden ps7 relaunch and bun retry diagnostics
- `1246c2c` fix(installer): normalize COMSPEC before setup execution
- `608e71c` fix(installer): avoid false local-source detection and use plugin setup path
- `b001538` fix(installer): prefer system tar.exe and normalize extraction paths
- `709b036` fix(installer): make windows tar extraction fail-fast and compatible
- `2a21f68` fix(installer): prevent token output pollution and enforce access gate
- `3770ae3` feat(plugin): add profile configs and stabilize plugin test scaffolding
- `8923a8b` chore(runtime): update setup flow and archive legacy cli entry
- `77bc2e0` docs: organize guidance and repository workflow references
- `61798eb` docs(workflow): clarify multi-remote push model and ignore noise
- `46ebc6a` refactor(structure): migrate ocs app and archive legacy web paths
- `6c068d0` fix(installer): avoid false handoff short-circuit in ps5
- `84f07c3` fix(installer): keep terminal open after pwsh handoff
- `450be68` fix(installer): persist bun path and improve access-denied flow
- `0bb5631` fix(installer): add resilient token and gh dependency fallbacks
- `c91d2a9` feat(installer): enhance auth flow with gh CLI auto-login (feat-6164)
- `724ecb8` chore(test): add powershell linting utility
- `2cc362b` chore(assets): remove deprecated dark mode section assets
- `6c59e57` docs(quickstart): sync indonesian guide with recent changes [feat-6164]
- `9c6734a` fix(installer): rewrite powershell plugin installer for syntax stability
- `26e94ef` docs(quickstart): sync english guide with indonesian updates [feat-6164]
- `90cdb91` docs(quickstart): update Google Cloud API enablement flow (feat-6164)
- `aad33bf` docs(quickstart): update recommended tool to OpenCode Web UI
- `4c1d3d3` fix(api): refactor pakasir webhook logic and update tests
- `150b9c3` fix(api): add graceful error handling for missing env vars in create-order
- `3e1bc9d` fix(test): resolve syntax errors and cleanup orphaned blocks in pakasir tests (feat-6164)
- `5639587` fix(ui): remove duplicated button layouts in hero and cta (feat-6164)
- `2dc425d` fix(api): cleanup unused test cases in pakasir webhook tests
- `0fbaee5` fix(ui): improve contrast for badges and primary buttons (feat-6164)
- `53ff07b` fix(api): refactor pakasir webhook and update tests
- `d66d6c9` fix(ocs): improve checkout form validation and logic
- `ed652f2` fix(ocs): update page components for tailwind compatibility
- `0ecce41` fix(ocs): refine web redesign layout and spacing
- `6bdd9d5` fix(ui): resolve tailwind v4 dark mode class conflicts
- `67c1520` feat(ocs): add modular validation and DB-backed rate limiter
- `7e9ef1c` feat(ocs): implement web redesign and admin dashboard (feat-6164)
- `a63aa6a` chore(test): update root vitest workspace
- `6a7fea3` chore(test): configure vitest for ocs and plugin compatibility
- `b0969ba` test(ocs): add integration tests for auth and webhooks (feat-6164)
- `1c96f64` feat(ocs): close distribution architecture gaps (feat-6164)
- `9be294e` docs: add distribution-architecture.md for paid member delivery system
- `3f4ad02` fix(build): switch plugin build from bun build to tsc
- `4ec8bb2` fix(config): remove @latest tag from opencode-multi-auth plugin ref
- `fd48a13` feat(build): add bun prod build pipeline + release packager + SolidJS order portal
- `d729f39` feat(web): rebuild order portal with SolidJS + TailwindCSS v4, Pakasir QRIS integration
- `f4d44a9` chore(test): fix vitest workspace to scope only plugin tests, exclude bun cache
- `7fdca77` chore(test): setup vitest workspace at root for paired 1:1 test coverage
- `73046e9` feat: add opencode-multi-auth as internal plugin, replace opencode-ag-auth dep
- `a585ace` chore: initial setup from andyvand-opencode-config
<!-- OCS_COMMIT_COVERAGE_END -->
## [2.3.3] - 2026-04-20
- Fix tool pairing ID extraction bug for Google/Gemini/Antigravity models inside generic payload translation block.
- Allow generic OpenCode API wrapper tools to work properly with Antigravity models.

### Automated Release Summary
<!-- OCS_AUTO_SUMMARY_START -->
- Commit window: `HEAD`
- Added: 72
- Fixed: 136
- Changed: 14
- Docs: 123
- Chore/Build/CI: 59
- Other: 7
<!-- OCS_AUTO_SUMMARY_END -->

### Commit Coverage (auto-generated)
<!-- OCS_COMMIT_COVERAGE_START -->
- `1a0a895` fix(plugin): remove retry limit for capacity exhausted to keep trying and shorten jitter delay
- `77ef23b` chore(release): bump version to 2.3.4
- `a90d13b` chore(release): bump version to 2.3.3
- `38be921` fix: call applyToolPairingFixes universally in request payload fallback to resolve Antigravity array-format ID rejections
- `75ff2a2` fix: disable non-Claude guard in tool pairing to support Antigravity models
- `8e10a52` docs(changelog): auto-sync v2.3.2 commit coverage
- `2207974` docs(changelog): auto-sync v2.3.2 commit coverage
- `e06331f` docs: update changelog for v2.3.2 release
- `6305ef1` chore(release): update lockfiles for v2.3.2
- `99caab7` fix(gemini): strip all string numeric constraints instead of casting to pass strict antigravity validation
- `2ed8f97` chore(release): bump version to 2.3.2
- `3d8b6f2` feat(config): add gpt-oss-120b-lead profile using Antigravity GPT-OSS 120B as orchestrator
- `c9c32ea` docs(installer): update installer README template to main and v2.3.1
- `12aeb77` fix(gemini): ensure all schemas pass through toGeminiSchema sanitization hook
- `7068cd7` docs(skills): update delegation gates to reference cocoindex playbook and add impeccable-style trigger rules
- `61a2020` feat(config): switch explore agent to antigravity gpt-oss-120b-medium model
- `0e70669` fix(plugin): cast string numeric constraints to integers for strict gemini schema validation
- `2aa72a2` fix(plugin): send LINUX platform metadata in WSL environments
- `662a50e` fix(installer): resolve missing ocs index script path and remove empty prefix path array bug
- `3b432c8` docs(workflow): enforce main-oriented patch publication order
- `91df4b3` fix(setup): preserve account state and harden profile runtime checks
- `c2efcb4` fix(setup): keep profile apply fast and deterministic across WSL parity
- `63b5af3` fix(installer): default latest branch hint to main
- `01926fc` chore(governance): enforce release execution policy and impeccable overrides
- `de4f889` Merge remote-tracking branch 'origin/main'
- `c37ed9c` Merge branch 'feat/stable-andyvand-2.3.1'
- `9096ea5` docs: update beta README for Stable v2.3.1
- `972aac3` docs: align beta README with v2.3.1 lane
- `3f4129a` docs(changelog): add v2.3.1 cold-start and installer fix notes
- `07c0681` docs(changelog): add v2.3.1 cold-start and installer fix notes
- `2c1f0f8` fix(installer): default version-pinned branch to staging lane
- `2a9fff1` fix(plugin): harden cold-start persistence and split provider regressions
- `c1c2d6b` fix(installer): default version-pinned branch to staging lane
- `9f3840b` fix(plugin): harden cold-start persistence and split provider regressions
- `ab7e852` docs(changelog): auto-sync v2.3.0 commit coverage
- `ff2cc08` fix(plugin): flush auth-menu persistence and split provider save routes
- `afd7ea2` docs(wsl): require WSL validation for runtime-affecting changes
- `e4c35fe` fix(doctor): resolve plugin runtime markers from direct install root
- `1632371` fix(plugin): persist antigravity account state and sticky defaults
- `2746cb0` fix(installer): reset runtime plugin directory before setup
- `20dc2ae` docs(changelog): auto-sync v2.3.1 commit coverage
- `7b2ca17` docs(ops): codify monorepo source-of-truth and quick profile switching
- `02e61ba` fix(plugin): stabilize auth routing and antigravity response parsing
- `26929d7` fix(setup): harden installer sync, doctor remediation, and monorepo config flow
- `327c049` chore(configs): refresh profile catalog and schema endpoints for v2.3.1
- `61bfddb` merge: integrate staging/v2.3.1-patch into staging/v2.3.1
- `44d97db` docs(installer): add windows path divergence triage
- `67644d3` fix(installer): classify safe home paths as resolved
- `3d545ce` test(installer): add failing empty-path regression cases
- `50fde8b` docs(changelog): auto-sync v2.3.1 commit coverage
- `0e1bcb4` chore(plugin): align multi-auth version to 2.3.1
- `c43a1af` docs(changelog): auto-sync v2.3.1 commit coverage
- `a0814b8` docs(changelog): auto-sync v2.3.1 commit coverage
- `a28067a` docs(installer): add v2.3.1 release section
- `3fbf35e` docs(changelog): auto-sync v2.3.1 commit coverage
- `b2b9c0a` chore(release): bump suite version to 2.3.1
- `0b8576a` fix(release): make installer sync branch-aware
- `8df7143` feat(skills): integrate impeccable-style governance into OCS
- `140bcd8` fix(plugin): restore antigravity version resolution fallback chain
- `ed9844c` fix(installer): harden cross-platform install and doctor flows
- `0d48221` Merge branch 'beta'
- `70f2bfe` fix(installer): harden linux package install sudo fallback
- `e82ee2c` fix(installer): avoid assoc array for path dedup
- `bff4dfd` docs(changelog): auto-sync v2.3.0 commit coverage
- `e59ef44` docs(changelog): auto-sync v2.3.0 commit coverage
- `5f7ab6a` docs(changelog): auto-sync v2.3.0 commit coverage
- `8d01fab` docs(changelog): auto-sync v2.3.0 commit coverage
- `83b3e7d` docs(changelog): auto-sync v2.3.0 commit coverage
- `be39b1a` docs(changelog): auto-sync v2.3.0 commit coverage
- `3403e6b` chore(release): prep staging v2.3.0 lane
- `126f946` docs(changelog): auto-sync v2.2.1 commit coverage
- `46b32c2` docs(changelog): auto-sync v2.2.1 commit coverage
- `2a0e950` fix(plugin): avoid mass OpenAI quarantine on non-rotation refresh errors
- `ab83093` docs(changelog): auto-sync v2.2.1 commit coverage
- `7ab9362` docs(changelog): auto-sync v2.2.1 commit coverage
- `7a7a54b` fix(plugin): null-safe OpenAI model routing in account selection
- `ae8be92` fix(plugin): harden OpenAI soft-quota failover for single-account mode
- `2b4884c` docs(changelog): auto-sync v2.2.1 commit coverage
- `109faaf` fix(installer): align fallback branch hint to staging v2.2.1
- `f566f73` fix(installer): call Ensure-PnpmRuntime in staging script
- `ddd63de` docs(changelog): auto-sync v2.2.1 commit coverage
- `5c717dd` chore(release): finalize staging v2.2.1 runtime and installer parity
- `a89e924` docs(changelog): auto-sync v2.2.1 commit coverage
- `cc89f86` merge(release): staging v2.2.1 into main
- `414419f` docs(changelog): auto-sync v2.2.1 commit coverage
- `bba1986` chore(governance): gate release docs snippet alignment
- `1049b23` docs(release): require installer command alignment checks
- `209b7e1` docs(installer): align v2.2.1 branch and pin snippets
- `a637aeb` docs(changelog): auto-sync v2.2.1 commit coverage
- `549a261` docs(changelog): auto-sync v2.2.1 commit coverage
- `fa12232` docs(installer): add v2.2.1 public changelog section
- `43e5978` docs(changelog): auto-sync v2.2.1 commit coverage
- `d59ebba` docs(changelog): add v2.2.1 release section
- `01a9d0e` chore(release): bump suite and plugin versions to 2.2.1
- `74151fd` docs(changelog): auto-sync v2.2.0 commit coverage
- `f64bfa8` docs(changelog): auto-sync v2.2.0 commit coverage
- `a4ae79a` docs(installer): add copy SEO playbook and skill references
- `7341e86` feat(skills): add installer copywriting SEO runtime skill
- `a1b7eef` feat(governance): add installer copywriting and SEO skill gates
- `df49af9` fix(plugin): harden OpenAI loader and auth state handling
- `d97cbf4` feat(setup): activate cocoindex-code via ccc and MCP sync
- `4465841` docs(changelog): auto-sync v2.2.0 commit coverage
- `f412dcf` docs(changelog): auto-sync v2.2.0 commit coverage
- `08c2ac8` docs(release): enforce cross-repo tag and release-note propagation
- `9e336ef` docs(changelog): auto-sync v2.2.0 commit coverage
- `f1c88ca` docs(changelog): auto-sync v2.2.0 commit coverage
- `8d9083b` docs(skills): add adaptive integration guide and markdown workflow references
- `fe22578` feat(skills): add markdown autofix skill and adaptive loading governance
- `2c20353` chore(markdown): align lint rules and add autofix scripts
- `0eb4bca` feat(setup): resolve cocoindex command paths and seed extensions scaffold
- `1ec5b8e` fix(plugin): harden openai quota probe fallback paths
- `b66e374` docs(changelog): auto-sync v2.2.0 commit coverage
- `db70273` fix(runtime): harden openai rotation and local install resilience
- `10f6f46` docs(changelog): auto-sync v2.2.0 commit coverage
- `49086bc` docs(readme): restore advanced EXA setup in private guide
- `83b02f9` docs(changelog): auto-sync v2.2.0 commit coverage
- `544127d` docs(installer): refactor public README for soft-selling flow
- `14a753c` docs(changelog): auto-sync v2.2.0 commit coverage
- `a19f549` docs(changelog): auto-sync v2.2.0 commit coverage
- `abb628c` docs(profiles): align v2.2 recommendations and onboarding parity
- `b381bbf` docs(release): update v2.2.0 session stability notes
- `9240834` fix(openai): improve session trigger robustness and durability
- `faa32c3` fix(runtime): harden openai sessions and installer shim reliability
- `5aae294` feat(setup): bootstrap CocoIndex and align staging v2.2.0
- `6fb26ad` chore(governance): tighten delegation and release validation guardrails
- `9c6b1b3` fix(setup): auto-repair legacy dcp config keys
- `0998b4b` docs(changelog): auto-sync v2.1.15 commit coverage
- `2a87536` docs(changelog): auto-sync v2.1.15 commit coverage
- `339f7e9` docs(changelog): auto-sync v2.1.15 commit coverage
- `8ca8570` fix(staging): harden openai on-demand refresh and align v2.1.15 lanes
- `477eb56` docs(changelog): auto-sync v2.1.14 commit coverage
- `2885974` fix(plugin): add lockfile no-op fallback for runtime interop
- `fba969e` docs(changelog): auto-sync v2.1.14 commit coverage
- `9cdcb13` fix(plugin): normalize proper-lockfile interop for account toggles
- `f0aaca0` docs(changelog): auto-sync v2.1.14 commit coverage
- `a47302b` fix(plugin): prevent proper-lockfile import crash in runtime
- `ede70bb` docs(changelog): auto-sync v2.1.14 commit coverage
- `228f712` fix(installer): align v2.1.14 bundle versions and auth plugin precedence
- `f3e9330` docs(changelog): auto-sync v2.1.14 commit coverage
- `426ab66` fix(staging): align installer lane to v2.1.14 and harden openai auth flow
- `48bc2b7` docs(changelog): auto-sync v2.1.14 commit coverage
- `be35ff0` docs(installer): add v2.1.14 release notes template
- `4c61215` docs(changelog): auto-sync v2.1.14 commit coverage
- `c4afaeb` fix(auth): restore manage/check flows and schema-safe credential restore
- `6d3a6dd` docs(changelog): auto-sync v2.1.13 commit coverage
- `f12e504` fix(release): enforce fresh multi-auth bundle and runtime credential safety
- `18572af` fix(setup): preserve runtime API credentials on reinstall
- `af37a05` docs(changelog): auto-sync v2.1.13 commit coverage
- `5450c77` feat(setup): align MCP defaults and profile parity for staging
- `08459e2` docs(changelog): record OCS skills sync rollout
- `a7d7834` docs(skills): establish OCS skills governance model
- `3b1fdd8` fix(installer): preserve hidden bundle directories
- `654fd76` feat(skills): add managed OCS skills sync pipeline
- `872bd0f` docs(rules): mandate tarball integrity SOP
- `651a1ea` feat(release): enforce provenance and parity guardrails
- `89f3e83` docs(changelog): record openai menu activation fix
- `8c80c82` fix(setup): use loader-safe local plugin specs
- `455dfd1` feat(release): bundle openai auth wrapper plugin
- `8015f85` docs(changelog): record realtime quota check behavior
- `34475b4` fix(quota): force realtime openai check output
- `2a6ca9b` docs(changelog): record exa schema compatibility fix
- `aa38bb9` fix(exa): enforce schema-safe setup output
- `97f9a56` fix(mcp): normalize exa header schema tokens
- `8bd44c1` docs(changelog): document installer lane resolution fix
- `3e1442a` fix(installer): infer source lane and align fallback branch
- `dd2bce8` docs(readme): align staging installer URLs to v2.1.13
- `487a608` docs(release): record v2.1.13 exa parity updates
- `142159f` docs(installer): expand exa onboarding and changelog continuity
- `38afc57` feat(cli): add exa setup and check commands
- `7c047ea` feat(mcp): add exa wiring and setup utility
- `5078492` docs(release): document multi-lane orchestration flow
- `891fac0` feat(release): add lane orchestration command
- `e237102` feat(installer): support explicit target branch sync
- `bd57d49` docs(release): complete v2.1.13 changelog coverage
- `c47938e` feat(openai): add accounts sanity-check command and docs
- `b1d0b18` fix(openai): persist rotated auth and clarify refresh failures
- `d2f0cb5` docs(security): enforce openai auth-state safety boundaries
- `4b41f36` docs(release): record latest openai patch notes in v2.1.13
- `52f3785` fix(openai): prevent add-account overwrite across identities
- `68917fd` fix(openai): strip unsupported codex output-token params
- `cc65969` docs(release): restore 2.1.12-2.1.5 changelog continuity
- `8a7341a` feat(staging): cut v2.1.13 with configurable openai buffer
- `65d1ffc` fix(plugin): route session auth requests through codex surface
- `8f1e361` fix(plugin): stabilize openai post-login refresh state
- `1b338a4` fix(plugin): re-enable openai account after reauth
- `63cd15d` fix(plugin): surface concrete openai auth-unavailable reasons
- `b2fd07d` fix(openai): inject codex instructions for web ui requests
- `6c38af1` fix(plugin): harden openai oauth fallback and switch policy
- `d11219f` chore(release): restore suite version to 2.1.12
- `f3c0606` fix(setup): prevent plugin self-delete during installer mode
- `0289d17` docs(staging): add v2.1.12 e2e checklist and tidy plugin changelog
- `0b26f6f` docs(plugin): restore full 2.1.11-2.1.4 changelog chain
- `2b578b2` chore(plugin): sync changelog to v2.1.12 parity
- `87c1700` fix(app): stabilize staging diagnostics and API test placement
- `1869690` chore(release): sync v2.1.12 version pins and changelog history
- `dfcc77a` feat(plugin): enforce cli-first quota refresh parity defaults
- `98b22cd` merge(chore): integrate remaining f75f release fixes into main
- `e9efb4f` merge(feat): integrate ecf4 latest implementation into main
- `bb07338` fix(plugin): avoid ambiguous OpenAI account upsert collisions
- `6e0e86b` chore(repo): remove oc-chatgpt reference mirror
- `b07f899` chore(plugin): align package version to 2.1.12
- `4240cd0` feat(plugin): tighten quota refresh defaults and ttl bounds
- `43da28a` feat(plugin): harden OpenAI multi-account parity flow
- `95653c3` fix(testing): stabilize feat-ecf4 gate validation lanes
- `a9ebb83` chore(flowcrate): capture batch-3 commit continuity sha
- `10d0047` feat(flowcrate): execute feat-ecf4 release-handoff evidence runbook
- `e907394` chore(tmp): add local workspace and runtime snapshots
- `411d734` chore(meta): track sisyphus planning and continuation state
- `0a095f1` feat(plugin): strengthen streaming transformer event handling
- `e5d81ca` feat(plugin): refine auth menu selection and ansi rendering
- `33874a7` feat(plugin): harden quota fallback and refresh queue logic
- `c21416b` test(plugin): expand openai provider and probe coverage
- `b5bb369` feat(plugin): improve account lifecycle and auth state handling
- `f2f7d70` feat(plugin): sync setup flow and schema documentation
- `9de30eb` chore(config): update root tooling and profile configuration
- `746820f` docs(landing): refresh docs and marketing content
- `d70d4c2` test(plugin): add probe and refresh hardening suites
- `a22b89a` test(plugin): cover thinking recovery regression boundaries
- `adfbc1f` test(resilience): add deterministic invariant hardening sweeps
- `3b8c73e` chore(plugin): remove orphaned opencode-openai-auth package
- `3439a4c` test(plugin): add resilience decomposition and orchestration coverage
- `0de23d8` feat(plugin): decompose resilience orchestration into focused modules
- `7e00291` test(plugin): stabilize audit and storage verification tests
- `adc0bba` feat(plugin): wire runtime audit emitter and tests
- `2e5dd3a` feat(plugin): emit audit events in auto-update checker
- `d07c603` feat(plugin): add audit sinks for logger and debug
- `26d829e` feat(plugin): add audit config and env controls
- `6ef1c89` test(plugin): add phase0 fixture guardrails baseline
- `1ec1430` docs(installer): sync templates and changelog to 2.1.3
- `e5426d7` docs(installer): bump root install examples to 2.1.3
- `a4d042f` docs(installer): enforce pwsh install command on Windows
- `4dc0298` feat(plugin): probe openai session quota with usage fallback
- `45431e1` feat(plugin): add openai login method menu actions
- `32c7ac4` fix(plugin): harden openai oauth callback listener flow
- `c8e8f1b` chore(release): align beta with 2.1.3 release line
- `4d69b80` docs(release): align package publish instructions
- `5bfeefd` docs(release): update buyer beta publish guidance
- `21fce31` chore(installer): sync LF enforcement and public installer docs
- `e196ce0` fix(installer): harden shell bootstrap and oauth guard
- `1a44dd2` fix(setup): refresh bundled multi-auth staging
- `ccd9250` fix(setup): stabilize local plugin tarball packing
- `9728fa7` feat(plugin): persist openai identity metadata
- `c43c984` feat(plugin): add openai browser and headless auth
- `18bed6d` feat(plugin): finish openai account lifecycle parity
- `f32d1be` fix(plugin): store openai accounts separately
- `a2105d5` feat(plugin): add openai auth wrapper package
- `4fe308b` fix(setup): load plugin-owned openai auth wrapper
- `867c85d` chore(installer): sync public installer templates for 2.1.3
- `d44fd6a` docs(installer): sync install guides to 2.1.3
- `7fefcc1` docs(release): add 2.1.3 oauth visibility notes
- `86a913b` chore(release): bump suite and plugin to 2.1.3
- `2396b81` fix(setup): prefer bundled package fallback for multi-auth
- `b6537f7` fix(installer): align auto setup defaults with installer profile
- `72c20e7` feat(plugin): add openai account menu parity
- `a683f96` fix(release): track antigravity backup template for clean packaging
- `831f8b7` chore(installer): sync public installer templates to 2.1.2
- `26235e6` docs(installer): sync version examples to 2.1.2
- `96054d6` docs(release): add 2.1.2 release notes
- `7ab0e64` chore(release): bump suite and plugin to 2.1.2
- `2e8258f` docs(plugin): document codex multi-auth runtime path
- `faf27ab` feat(plugin): add codex session safety guards
- `a37fe57` feat(plugin): add openai provider routing primitives
- `c28ddf7` feat(plugin): add codex shared-core account state
- `cf0e5c4` chore(installer): restore public installer sync inputs
- `8678464` fix(installer): restore source installer scripts in main repo
- `67f708e` docs(plugin): add 2.1.1 changelog entry
- `8b42615` fix(setup): pin oauth-compatible plugin stack at deploy time
- `092d4a8` docs(quick-start): add version-pin install examples in Indonesian guide
- `d02e899` chore(release): bump suite and plugin version to 2.1.0
- `3614c23` docs(installer): update public installer copy for 2.1.0
- `5a71b0c` chore(runtime): update default GPT-5.4 stack and plugin channels
- `6c25a37` docs(models): add pass-model mapping and GPT-5.4 notes
- `c9968e8` feat(config): add hephaestus to codex 5.4 profiles
- `fd8c41b` docs(troubleshooting): add doctor and path recovery guidance
- `460b6f7` feat(cli): add ocs doctor and docs for version pin
- `b576270` fix(setup): fallback invalid resource mode and document version pin
- `ddb4148` chore(release): bump suite and plugin to 2.0.15
- `e6154d7` fix(installer): restore README copywriting and CTA
- `1ee818e` docs(release): announce gpt-5.4 setup profiles
- `04c6b47` feat(profile): add codex-5.4 setup profiles
- `b9ef079` fix(release): enforce suite artifact naming and v2.0.14 changelog
- `ee4775f` fix(release): keep installer template bundle naming in sync
- `a29203c` chore(release): cut v2.0.14 and align installer topology
- `17bf768` fix(installer): resolve suite bundle names in shell and powershell
- `8215fbb` fix(installer): resolve suite bundle names in shell and powershell
- `1f91073` chore(repo): ignore local release clone workdirs
- `900ceb6` chore(repo): ignore local release clone workdirs
- `0eeec4d` fix(installer): prefer https auth flow and beta semver labels
- `78537cb` fix(installer): prefer https auth flow and beta semver labels
- `2348bd5` docs(release): add v2.0.13 changelog entries
- `3ae10de` fix(installer): use OAuth-first auth and quiet installer setup logs
- `72e5708` chore(repo): checkpoint pending docs, scripts, and flowcrate updates before refactor-4b3f
- `80030cc` fix(auth): restore google oauth flow after reinstall
- `021d1b7` fix(installer): enforce oauth guard across plugin reinstall paths
- `05ea6fb` chore(release): cut v2.0.10 with latest auth/setup fixes
- `401f3c6` chore(release): bump v2.0.9 metadata and add missing v2.0.8 notes
- `b59a7ff` fix(installer): repair ocs shim and enforce auth guard after setup
- `67d3306` fix(setup): harden multi-auth resolution and enforce oauth guard
- `601163d` docs(readme): expose v2.0.8 changes and patched legacy issues
- `fc0f2f2` fix(release): sync root README to releases repo
- `454c945` fix(release): sync full docs to releases repository
- `6c540eb` chore(release): bump plugin version to v2.0.8
- `d411430` fix(release): handle untracked managed paths in repo sync
- `c8850d3` docs: align web-ui guidance and relocate developer docs
- `425f877` chore(release): remove legacy root checksum artifact
- `52b63b5` feat(release): add managed sync pipeline and artifact layout
- `d49a7bf` fix(plugin): harden account persistence on storage load errors
- `0f33118` docs(changelog): add v2.0.7 root release notes
- `5657d6f` chore(release): bump plugin to v2.0.7 and refresh checksums
- `77a9ff5` docs(plugin): add preset selection guide and 5-minute checklist
- `efe0619` test(plugin): cover dynamic routing modes and capability behavior
- `d66a25c` feat(plugin): add dynamic cli-first routing and capability-aware fallback
- `020a85d` fix(installer): keep hybrid auto-setup and simplify next steps
- `21c080c` fix(setup): self-heal bun global duplicate lock corruption
- `544b206` fix(prefs): harden schema loading and restore gemini oauth hybrid flow
- `a734cf3` fix(release): restore antigravity oauth login in installer deployments
- `f0ee9c9` chore(release): cut v2.0.3 with setup CLI fix
- `d838837` fix(cli): restore interactive setup default and add update aliases
- `172c993` fix(installer): enforce bun-only dependency retries
- `7878958` chore(release): finalize 2.0.2 changelog metadata
- `ebd5c79` chore(changelog): finalize released sections
- `2e9a5b9` build(release): include changelogs in bundled artifacts
- `da47524` chore(release): finalize 2.0.1 notes and metadata
- `03d72b7` refactor(plugin): remove manual verify-account menu flow
- `32354da` docs(plugin): record unreleased wave-2 commit trail
- `cbdfa6e` feat(plugin): enforce status floors in cooldown backoff
- `3ff6130` feat(plugin): add adaptive 5xx retry and switching path
- `81a00b9` feat(plugin): add 401 escalation and 404 cooldown routing
- `b1a451b` feat(plugin): harden storage migration and save coordination
- `7ab7e15` feat(plugin): add rest-until-full soft quota lock flow
- `0362157` feat(plugin): normalize model-family cooldown lock keys
- `42fc708` test(plugin): add 429 dedup storm coverage
- `f510011` feat(plugin): extend cooldown duration fallback parsing
- `96302de` feat(plugin): harden phase-1 retry and quota classification
- `b25c385` feat(plugin): add phase-0 policy rollout guardrails
- `120c6a9` docs(prefs): document strict validation apply behavior
- `dae1057` feat(prefs): enforce strict schema validation in wizard
- `1d5800a` fix(release): make bundle copy reliable on Windows
- `b92e68e` fix(installer): enforce bun-only ocs shims and stable install path
- `bc984f7` fix(installer): make ocs bootstrap deterministic on Windows
- `e9693b3` feat(release): automate installer sync and private ocs bootstrap
- `2cc68f4` fix(installer): auto-repair ocs command on Windows
- `c4049b5` fix(release): publish checksum asset with tarball
- `4db11f3` chore(gitignore): ignore local antigravity config file
- `a66fbe3` chore(release): prepare v2 changelog and plugin version
- `1d9e448` docs(scripts): document antigravity fallback behavior
- `2b49027` fix(setup): seed antigravity config from template fallback
- `19fef61` feat(landing): refresh hero section and add hero lab page
- `5cc69bc` docs(multi-auth): add sonnet opus 400 vs 403 triage playbook
- `a3f3d9b` test(multi-auth): add regression coverage for sonnet opus payload edges
- `de9553f` fix(multi-auth): harden claude payload normalization and thinking guards
- `ad3ed96` feat(cli): add global ocs dispatcher and prefs wizard
- `3904771` feat(multi-auth): align CLI quota fallback and image model routing
- `aedcabb` feat(setup): default to hybrid profile and performance mode
- `ee0a386` docs(installer): standardize pwsh cache-buster command
- `33dda63` feat(branding): add final pro hybrid logo system
- `d1ccf00` fix(installer): default to codex hybrid performance
- `7c7ba91` chore(installer): refine next-steps guidance text
- `28c9458` fix(installer): enforce bun-only dependency retries
- `11a42b9` fix(installer): harden dependency install retries and fallback
- `d886420` fix(installer): resolve relative plugin path during bun install
- `b7d8513` fix(installer): continue in current shell when pwsh relaunch fails
- `5d0e2a7` fix(installer): harden ps7 relaunch and bun retry diagnostics
- `1246c2c` fix(installer): normalize COMSPEC before setup execution
- `608e71c` fix(installer): avoid false local-source detection and use plugin setup path
- `b001538` fix(installer): prefer system tar.exe and normalize extraction paths
- `709b036` fix(installer): make windows tar extraction fail-fast and compatible
- `2a21f68` fix(installer): prevent token output pollution and enforce access gate
- `3770ae3` feat(plugin): add profile configs and stabilize plugin test scaffolding
- `8923a8b` chore(runtime): update setup flow and archive legacy cli entry
- `77bc2e0` docs: organize guidance and repository workflow references
- `61798eb` docs(workflow): clarify multi-remote push model and ignore noise
- `46ebc6a` refactor(structure): migrate ocs app and archive legacy web paths
- `6c068d0` fix(installer): avoid false handoff short-circuit in ps5
- `84f07c3` fix(installer): keep terminal open after pwsh handoff
- `450be68` fix(installer): persist bun path and improve access-denied flow
- `0bb5631` fix(installer): add resilient token and gh dependency fallbacks
- `c91d2a9` feat(installer): enhance auth flow with gh CLI auto-login (feat-6164)
- `724ecb8` chore(test): add powershell linting utility
- `2cc362b` chore(assets): remove deprecated dark mode section assets
- `6c59e57` docs(quickstart): sync indonesian guide with recent changes [feat-6164]
- `9c6734a` fix(installer): rewrite powershell plugin installer for syntax stability
- `26e94ef` docs(quickstart): sync english guide with indonesian updates [feat-6164]
- `90cdb91` docs(quickstart): update Google Cloud API enablement flow (feat-6164)
- `aad33bf` docs(quickstart): update recommended tool to OpenCode Web UI
- `4c1d3d3` fix(api): refactor pakasir webhook logic and update tests
- `150b9c3` fix(api): add graceful error handling for missing env vars in create-order
- `3e1bc9d` fix(test): resolve syntax errors and cleanup orphaned blocks in pakasir tests (feat-6164)
- `5639587` fix(ui): remove duplicated button layouts in hero and cta (feat-6164)
- `2dc425d` fix(api): cleanup unused test cases in pakasir webhook tests
- `0fbaee5` fix(ui): improve contrast for badges and primary buttons (feat-6164)
- `53ff07b` fix(api): refactor pakasir webhook and update tests
- `d66d6c9` fix(ocs): improve checkout form validation and logic
- `ed652f2` fix(ocs): update page components for tailwind compatibility
- `0ecce41` fix(ocs): refine web redesign layout and spacing
- `6bdd9d5` fix(ui): resolve tailwind v4 dark mode class conflicts
- `67c1520` feat(ocs): add modular validation and DB-backed rate limiter
- `7e9ef1c` feat(ocs): implement web redesign and admin dashboard (feat-6164)
- `a63aa6a` chore(test): update root vitest workspace
- `6a7fea3` chore(test): configure vitest for ocs and plugin compatibility
- `b0969ba` test(ocs): add integration tests for auth and webhooks (feat-6164)
- `1c96f64` feat(ocs): close distribution architecture gaps (feat-6164)
- `9be294e` docs: add distribution-architecture.md for paid member delivery system
- `3f4ad02` fix(build): switch plugin build from bun build to tsc
- `4ec8bb2` fix(config): remove @latest tag from opencode-multi-auth plugin ref
- `fd48a13` feat(build): add bun prod build pipeline + release packager + SolidJS order portal
- `d729f39` feat(web): rebuild order portal with SolidJS + TailwindCSS v4, Pakasir QRIS integration
- `f4d44a9` chore(test): fix vitest workspace to scope only plugin tests, exclude bun cache
- `7fdca77` chore(test): setup vitest workspace at root for paired 1:1 test coverage
- `73046e9` feat: add opencode-multi-auth as internal plugin, replace opencode-ag-auth dep
- `a585ace` chore: initial setup from andyvand-opencode-config
<!-- OCS_COMMIT_COVERAGE_END -->
## [2.3.3] - 2026-04-20
- Fix tool pairing ID extraction bug for Google/Gemini/Antigravity models inside generic payload translation block.
- Allow generic OpenCode API wrapper tools to work properly with Antigravity models.

### Automated Release Summary
<!-- OCS_AUTO_SUMMARY_START -->
- Commit window: `HEAD`
- Added: 73
- Fixed: 135
- Changed: 14
- Docs: 127
- Chore/Build/CI: 58
- Other: 7
<!-- OCS_AUTO_SUMMARY_END -->

### Commit Coverage (auto-generated)
<!-- OCS_COMMIT_COVERAGE_START -->
- `d6c3868` feat(plugin): increase max oauth accounts to 30 to support larger active pools
- `7f9e338` docs(changelog): auto-sync v2.3.3 commit coverage
- `e1bfc8d` docs(changelog): auto-sync v2.3.3 commit coverage
- `6558db3` docs(changelog): auto-sync v2.3.3 commit coverage
- `873a5f6` docs(changelog): auto-sync v2.3.3 commit coverage
- `a90d13b` chore(release): bump version to 2.3.3
- `38be921` fix: call applyToolPairingFixes universally in request payload fallback to resolve Antigravity array-format ID rejections
- `75ff2a2` fix: disable non-Claude guard in tool pairing to support Antigravity models
- `8e10a52` docs(changelog): auto-sync v2.3.2 commit coverage
- `2207974` docs(changelog): auto-sync v2.3.2 commit coverage
- `e06331f` docs: update changelog for v2.3.2 release
- `6305ef1` chore(release): update lockfiles for v2.3.2
- `99caab7` fix(gemini): strip all string numeric constraints instead of casting to pass strict antigravity validation
- `2ed8f97` chore(release): bump version to 2.3.2
- `3d8b6f2` feat(config): add gpt-oss-120b-lead profile using Antigravity GPT-OSS 120B as orchestrator
- `c9c32ea` docs(installer): update installer README template to main and v2.3.1
- `12aeb77` fix(gemini): ensure all schemas pass through toGeminiSchema sanitization hook
- `7068cd7` docs(skills): update delegation gates to reference cocoindex playbook and add impeccable-style trigger rules
- `61a2020` feat(config): switch explore agent to antigravity gpt-oss-120b-medium model
- `0e70669` fix(plugin): cast string numeric constraints to integers for strict gemini schema validation
- `2aa72a2` fix(plugin): send LINUX platform metadata in WSL environments
- `662a50e` fix(installer): resolve missing ocs index script path and remove empty prefix path array bug
- `3b432c8` docs(workflow): enforce main-oriented patch publication order
- `91df4b3` fix(setup): preserve account state and harden profile runtime checks
- `c2efcb4` fix(setup): keep profile apply fast and deterministic across WSL parity
- `63b5af3` fix(installer): default latest branch hint to main
- `01926fc` chore(governance): enforce release execution policy and impeccable overrides
- `de4f889` Merge remote-tracking branch 'origin/main'
- `c37ed9c` Merge branch 'feat/stable-andyvand-2.3.1'
- `9096ea5` docs: update beta README for Stable v2.3.1
- `972aac3` docs: align beta README with v2.3.1 lane
- `3f4129a` docs(changelog): add v2.3.1 cold-start and installer fix notes
- `07c0681` docs(changelog): add v2.3.1 cold-start and installer fix notes
- `2c1f0f8` fix(installer): default version-pinned branch to staging lane
- `2a9fff1` fix(plugin): harden cold-start persistence and split provider regressions
- `c1c2d6b` fix(installer): default version-pinned branch to staging lane
- `9f3840b` fix(plugin): harden cold-start persistence and split provider regressions
- `ab7e852` docs(changelog): auto-sync v2.3.0 commit coverage
- `ff2cc08` fix(plugin): flush auth-menu persistence and split provider save routes
- `afd7ea2` docs(wsl): require WSL validation for runtime-affecting changes
- `e4c35fe` fix(doctor): resolve plugin runtime markers from direct install root
- `1632371` fix(plugin): persist antigravity account state and sticky defaults
- `2746cb0` fix(installer): reset runtime plugin directory before setup
- `20dc2ae` docs(changelog): auto-sync v2.3.1 commit coverage
- `7b2ca17` docs(ops): codify monorepo source-of-truth and quick profile switching
- `02e61ba` fix(plugin): stabilize auth routing and antigravity response parsing
- `26929d7` fix(setup): harden installer sync, doctor remediation, and monorepo config flow
- `327c049` chore(configs): refresh profile catalog and schema endpoints for v2.3.1
- `61bfddb` merge: integrate staging/v2.3.1-patch into staging/v2.3.1
- `44d97db` docs(installer): add windows path divergence triage
- `67644d3` fix(installer): classify safe home paths as resolved
- `3d545ce` test(installer): add failing empty-path regression cases
- `50fde8b` docs(changelog): auto-sync v2.3.1 commit coverage
- `0e1bcb4` chore(plugin): align multi-auth version to 2.3.1
- `c43a1af` docs(changelog): auto-sync v2.3.1 commit coverage
- `a0814b8` docs(changelog): auto-sync v2.3.1 commit coverage
- `a28067a` docs(installer): add v2.3.1 release section
- `3fbf35e` docs(changelog): auto-sync v2.3.1 commit coverage
- `b2b9c0a` chore(release): bump suite version to 2.3.1
- `0b8576a` fix(release): make installer sync branch-aware
- `8df7143` feat(skills): integrate impeccable-style governance into OCS
- `140bcd8` fix(plugin): restore antigravity version resolution fallback chain
- `ed9844c` fix(installer): harden cross-platform install and doctor flows
- `0d48221` Merge branch 'beta'
- `70f2bfe` fix(installer): harden linux package install sudo fallback
- `e82ee2c` fix(installer): avoid assoc array for path dedup
- `bff4dfd` docs(changelog): auto-sync v2.3.0 commit coverage
- `e59ef44` docs(changelog): auto-sync v2.3.0 commit coverage
- `5f7ab6a` docs(changelog): auto-sync v2.3.0 commit coverage
- `8d01fab` docs(changelog): auto-sync v2.3.0 commit coverage
- `83b3e7d` docs(changelog): auto-sync v2.3.0 commit coverage
- `be39b1a` docs(changelog): auto-sync v2.3.0 commit coverage
- `3403e6b` chore(release): prep staging v2.3.0 lane
- `126f946` docs(changelog): auto-sync v2.2.1 commit coverage
- `46b32c2` docs(changelog): auto-sync v2.2.1 commit coverage
- `2a0e950` fix(plugin): avoid mass OpenAI quarantine on non-rotation refresh errors
- `ab83093` docs(changelog): auto-sync v2.2.1 commit coverage
- `7ab9362` docs(changelog): auto-sync v2.2.1 commit coverage
- `7a7a54b` fix(plugin): null-safe OpenAI model routing in account selection
- `ae8be92` fix(plugin): harden OpenAI soft-quota failover for single-account mode
- `2b4884c` docs(changelog): auto-sync v2.2.1 commit coverage
- `109faaf` fix(installer): align fallback branch hint to staging v2.2.1
- `f566f73` fix(installer): call Ensure-PnpmRuntime in staging script
- `ddd63de` docs(changelog): auto-sync v2.2.1 commit coverage
- `5c717dd` chore(release): finalize staging v2.2.1 runtime and installer parity
- `a89e924` docs(changelog): auto-sync v2.2.1 commit coverage
- `cc89f86` merge(release): staging v2.2.1 into main
- `414419f` docs(changelog): auto-sync v2.2.1 commit coverage
- `bba1986` chore(governance): gate release docs snippet alignment
- `1049b23` docs(release): require installer command alignment checks
- `209b7e1` docs(installer): align v2.2.1 branch and pin snippets
- `a637aeb` docs(changelog): auto-sync v2.2.1 commit coverage
- `549a261` docs(changelog): auto-sync v2.2.1 commit coverage
- `fa12232` docs(installer): add v2.2.1 public changelog section
- `43e5978` docs(changelog): auto-sync v2.2.1 commit coverage
- `d59ebba` docs(changelog): add v2.2.1 release section
- `01a9d0e` chore(release): bump suite and plugin versions to 2.2.1
- `74151fd` docs(changelog): auto-sync v2.2.0 commit coverage
- `f64bfa8` docs(changelog): auto-sync v2.2.0 commit coverage
- `a4ae79a` docs(installer): add copy SEO playbook and skill references
- `7341e86` feat(skills): add installer copywriting SEO runtime skill
- `a1b7eef` feat(governance): add installer copywriting and SEO skill gates
- `df49af9` fix(plugin): harden OpenAI loader and auth state handling
- `d97cbf4` feat(setup): activate cocoindex-code via ccc and MCP sync
- `4465841` docs(changelog): auto-sync v2.2.0 commit coverage
- `f412dcf` docs(changelog): auto-sync v2.2.0 commit coverage
- `08c2ac8` docs(release): enforce cross-repo tag and release-note propagation
- `9e336ef` docs(changelog): auto-sync v2.2.0 commit coverage
- `f1c88ca` docs(changelog): auto-sync v2.2.0 commit coverage
- `8d9083b` docs(skills): add adaptive integration guide and markdown workflow references
- `fe22578` feat(skills): add markdown autofix skill and adaptive loading governance
- `2c20353` chore(markdown): align lint rules and add autofix scripts
- `0eb4bca` feat(setup): resolve cocoindex command paths and seed extensions scaffold
- `1ec5b8e` fix(plugin): harden openai quota probe fallback paths
- `b66e374` docs(changelog): auto-sync v2.2.0 commit coverage
- `db70273` fix(runtime): harden openai rotation and local install resilience
- `10f6f46` docs(changelog): auto-sync v2.2.0 commit coverage
- `49086bc` docs(readme): restore advanced EXA setup in private guide
- `83b02f9` docs(changelog): auto-sync v2.2.0 commit coverage
- `544127d` docs(installer): refactor public README for soft-selling flow
- `14a753c` docs(changelog): auto-sync v2.2.0 commit coverage
- `a19f549` docs(changelog): auto-sync v2.2.0 commit coverage
- `abb628c` docs(profiles): align v2.2 recommendations and onboarding parity
- `b381bbf` docs(release): update v2.2.0 session stability notes
- `9240834` fix(openai): improve session trigger robustness and durability
- `faa32c3` fix(runtime): harden openai sessions and installer shim reliability
- `5aae294` feat(setup): bootstrap CocoIndex and align staging v2.2.0
- `6fb26ad` chore(governance): tighten delegation and release validation guardrails
- `9c6b1b3` fix(setup): auto-repair legacy dcp config keys
- `0998b4b` docs(changelog): auto-sync v2.1.15 commit coverage
- `2a87536` docs(changelog): auto-sync v2.1.15 commit coverage
- `339f7e9` docs(changelog): auto-sync v2.1.15 commit coverage
- `8ca8570` fix(staging): harden openai on-demand refresh and align v2.1.15 lanes
- `477eb56` docs(changelog): auto-sync v2.1.14 commit coverage
- `2885974` fix(plugin): add lockfile no-op fallback for runtime interop
- `fba969e` docs(changelog): auto-sync v2.1.14 commit coverage
- `9cdcb13` fix(plugin): normalize proper-lockfile interop for account toggles
- `f0aaca0` docs(changelog): auto-sync v2.1.14 commit coverage
- `a47302b` fix(plugin): prevent proper-lockfile import crash in runtime
- `ede70bb` docs(changelog): auto-sync v2.1.14 commit coverage
- `228f712` fix(installer): align v2.1.14 bundle versions and auth plugin precedence
- `f3e9330` docs(changelog): auto-sync v2.1.14 commit coverage
- `426ab66` fix(staging): align installer lane to v2.1.14 and harden openai auth flow
- `48bc2b7` docs(changelog): auto-sync v2.1.14 commit coverage
- `be35ff0` docs(installer): add v2.1.14 release notes template
- `4c61215` docs(changelog): auto-sync v2.1.14 commit coverage
- `c4afaeb` fix(auth): restore manage/check flows and schema-safe credential restore
- `6d3a6dd` docs(changelog): auto-sync v2.1.13 commit coverage
- `f12e504` fix(release): enforce fresh multi-auth bundle and runtime credential safety
- `18572af` fix(setup): preserve runtime API credentials on reinstall
- `af37a05` docs(changelog): auto-sync v2.1.13 commit coverage
- `5450c77` feat(setup): align MCP defaults and profile parity for staging
- `08459e2` docs(changelog): record OCS skills sync rollout
- `a7d7834` docs(skills): establish OCS skills governance model
- `3b1fdd8` fix(installer): preserve hidden bundle directories
- `654fd76` feat(skills): add managed OCS skills sync pipeline
- `872bd0f` docs(rules): mandate tarball integrity SOP
- `651a1ea` feat(release): enforce provenance and parity guardrails
- `89f3e83` docs(changelog): record openai menu activation fix
- `8c80c82` fix(setup): use loader-safe local plugin specs
- `455dfd1` feat(release): bundle openai auth wrapper plugin
- `8015f85` docs(changelog): record realtime quota check behavior
- `34475b4` fix(quota): force realtime openai check output
- `2a6ca9b` docs(changelog): record exa schema compatibility fix
- `aa38bb9` fix(exa): enforce schema-safe setup output
- `97f9a56` fix(mcp): normalize exa header schema tokens
- `8bd44c1` docs(changelog): document installer lane resolution fix
- `3e1442a` fix(installer): infer source lane and align fallback branch
- `dd2bce8` docs(readme): align staging installer URLs to v2.1.13
- `487a608` docs(release): record v2.1.13 exa parity updates
- `142159f` docs(installer): expand exa onboarding and changelog continuity
- `38afc57` feat(cli): add exa setup and check commands
- `7c047ea` feat(mcp): add exa wiring and setup utility
- `5078492` docs(release): document multi-lane orchestration flow
- `891fac0` feat(release): add lane orchestration command
- `e237102` feat(installer): support explicit target branch sync
- `bd57d49` docs(release): complete v2.1.13 changelog coverage
- `c47938e` feat(openai): add accounts sanity-check command and docs
- `b1d0b18` fix(openai): persist rotated auth and clarify refresh failures
- `d2f0cb5` docs(security): enforce openai auth-state safety boundaries
- `4b41f36` docs(release): record latest openai patch notes in v2.1.13
- `52f3785` fix(openai): prevent add-account overwrite across identities
- `68917fd` fix(openai): strip unsupported codex output-token params
- `cc65969` docs(release): restore 2.1.12-2.1.5 changelog continuity
- `8a7341a` feat(staging): cut v2.1.13 with configurable openai buffer
- `65d1ffc` fix(plugin): route session auth requests through codex surface
- `8f1e361` fix(plugin): stabilize openai post-login refresh state
- `1b338a4` fix(plugin): re-enable openai account after reauth
- `63cd15d` fix(plugin): surface concrete openai auth-unavailable reasons
- `b2fd07d` fix(openai): inject codex instructions for web ui requests
- `6c38af1` fix(plugin): harden openai oauth fallback and switch policy
- `d11219f` chore(release): restore suite version to 2.1.12
- `f3c0606` fix(setup): prevent plugin self-delete during installer mode
- `0289d17` docs(staging): add v2.1.12 e2e checklist and tidy plugin changelog
- `0b26f6f` docs(plugin): restore full 2.1.11-2.1.4 changelog chain
- `2b578b2` chore(plugin): sync changelog to v2.1.12 parity
- `87c1700` fix(app): stabilize staging diagnostics and API test placement
- `1869690` chore(release): sync v2.1.12 version pins and changelog history
- `dfcc77a` feat(plugin): enforce cli-first quota refresh parity defaults
- `98b22cd` merge(chore): integrate remaining f75f release fixes into main
- `e9efb4f` merge(feat): integrate ecf4 latest implementation into main
- `bb07338` fix(plugin): avoid ambiguous OpenAI account upsert collisions
- `6e0e86b` chore(repo): remove oc-chatgpt reference mirror
- `b07f899` chore(plugin): align package version to 2.1.12
- `4240cd0` feat(plugin): tighten quota refresh defaults and ttl bounds
- `43da28a` feat(plugin): harden OpenAI multi-account parity flow
- `95653c3` fix(testing): stabilize feat-ecf4 gate validation lanes
- `a9ebb83` chore(flowcrate): capture batch-3 commit continuity sha
- `10d0047` feat(flowcrate): execute feat-ecf4 release-handoff evidence runbook
- `e907394` chore(tmp): add local workspace and runtime snapshots
- `411d734` chore(meta): track sisyphus planning and continuation state
- `0a095f1` feat(plugin): strengthen streaming transformer event handling
- `e5d81ca` feat(plugin): refine auth menu selection and ansi rendering
- `33874a7` feat(plugin): harden quota fallback and refresh queue logic
- `c21416b` test(plugin): expand openai provider and probe coverage
- `b5bb369` feat(plugin): improve account lifecycle and auth state handling
- `f2f7d70` feat(plugin): sync setup flow and schema documentation
- `9de30eb` chore(config): update root tooling and profile configuration
- `746820f` docs(landing): refresh docs and marketing content
- `d70d4c2` test(plugin): add probe and refresh hardening suites
- `a22b89a` test(plugin): cover thinking recovery regression boundaries
- `adfbc1f` test(resilience): add deterministic invariant hardening sweeps
- `3b8c73e` chore(plugin): remove orphaned opencode-openai-auth package
- `3439a4c` test(plugin): add resilience decomposition and orchestration coverage
- `0de23d8` feat(plugin): decompose resilience orchestration into focused modules
- `7e00291` test(plugin): stabilize audit and storage verification tests
- `adc0bba` feat(plugin): wire runtime audit emitter and tests
- `2e5dd3a` feat(plugin): emit audit events in auto-update checker
- `d07c603` feat(plugin): add audit sinks for logger and debug
- `26d829e` feat(plugin): add audit config and env controls
- `6ef1c89` test(plugin): add phase0 fixture guardrails baseline
- `1ec1430` docs(installer): sync templates and changelog to 2.1.3
- `e5426d7` docs(installer): bump root install examples to 2.1.3
- `a4d042f` docs(installer): enforce pwsh install command on Windows
- `4dc0298` feat(plugin): probe openai session quota with usage fallback
- `45431e1` feat(plugin): add openai login method menu actions
- `32c7ac4` fix(plugin): harden openai oauth callback listener flow
- `c8e8f1b` chore(release): align beta with 2.1.3 release line
- `4d69b80` docs(release): align package publish instructions
- `5bfeefd` docs(release): update buyer beta publish guidance
- `21fce31` chore(installer): sync LF enforcement and public installer docs
- `e196ce0` fix(installer): harden shell bootstrap and oauth guard
- `1a44dd2` fix(setup): refresh bundled multi-auth staging
- `ccd9250` fix(setup): stabilize local plugin tarball packing
- `9728fa7` feat(plugin): persist openai identity metadata
- `c43c984` feat(plugin): add openai browser and headless auth
- `18bed6d` feat(plugin): finish openai account lifecycle parity
- `f32d1be` fix(plugin): store openai accounts separately
- `a2105d5` feat(plugin): add openai auth wrapper package
- `4fe308b` fix(setup): load plugin-owned openai auth wrapper
- `867c85d` chore(installer): sync public installer templates for 2.1.3
- `d44fd6a` docs(installer): sync install guides to 2.1.3
- `7fefcc1` docs(release): add 2.1.3 oauth visibility notes
- `86a913b` chore(release): bump suite and plugin to 2.1.3
- `2396b81` fix(setup): prefer bundled package fallback for multi-auth
- `b6537f7` fix(installer): align auto setup defaults with installer profile
- `72c20e7` feat(plugin): add openai account menu parity
- `a683f96` fix(release): track antigravity backup template for clean packaging
- `831f8b7` chore(installer): sync public installer templates to 2.1.2
- `26235e6` docs(installer): sync version examples to 2.1.2
- `96054d6` docs(release): add 2.1.2 release notes
- `7ab0e64` chore(release): bump suite and plugin to 2.1.2
- `2e8258f` docs(plugin): document codex multi-auth runtime path
- `faf27ab` feat(plugin): add codex session safety guards
- `a37fe57` feat(plugin): add openai provider routing primitives
- `c28ddf7` feat(plugin): add codex shared-core account state
- `cf0e5c4` chore(installer): restore public installer sync inputs
- `8678464` fix(installer): restore source installer scripts in main repo
- `67f708e` docs(plugin): add 2.1.1 changelog entry
- `8b42615` fix(setup): pin oauth-compatible plugin stack at deploy time
- `092d4a8` docs(quick-start): add version-pin install examples in Indonesian guide
- `d02e899` chore(release): bump suite and plugin version to 2.1.0
- `3614c23` docs(installer): update public installer copy for 2.1.0
- `5a71b0c` chore(runtime): update default GPT-5.4 stack and plugin channels
- `6c25a37` docs(models): add pass-model mapping and GPT-5.4 notes
- `c9968e8` feat(config): add hephaestus to codex 5.4 profiles
- `fd8c41b` docs(troubleshooting): add doctor and path recovery guidance
- `460b6f7` feat(cli): add ocs doctor and docs for version pin
- `b576270` fix(setup): fallback invalid resource mode and document version pin
- `ddb4148` chore(release): bump suite and plugin to 2.0.15
- `e6154d7` fix(installer): restore README copywriting and CTA
- `1ee818e` docs(release): announce gpt-5.4 setup profiles
- `04c6b47` feat(profile): add codex-5.4 setup profiles
- `b9ef079` fix(release): enforce suite artifact naming and v2.0.14 changelog
- `ee4775f` fix(release): keep installer template bundle naming in sync
- `a29203c` chore(release): cut v2.0.14 and align installer topology
- `17bf768` fix(installer): resolve suite bundle names in shell and powershell
- `8215fbb` fix(installer): resolve suite bundle names in shell and powershell
- `1f91073` chore(repo): ignore local release clone workdirs
- `900ceb6` chore(repo): ignore local release clone workdirs
- `0eeec4d` fix(installer): prefer https auth flow and beta semver labels
- `78537cb` fix(installer): prefer https auth flow and beta semver labels
- `2348bd5` docs(release): add v2.0.13 changelog entries
- `3ae10de` fix(installer): use OAuth-first auth and quiet installer setup logs
- `72e5708` chore(repo): checkpoint pending docs, scripts, and flowcrate updates before refactor-4b3f
- `80030cc` fix(auth): restore google oauth flow after reinstall
- `021d1b7` fix(installer): enforce oauth guard across plugin reinstall paths
- `05ea6fb` chore(release): cut v2.0.10 with latest auth/setup fixes
- `401f3c6` chore(release): bump v2.0.9 metadata and add missing v2.0.8 notes
- `b59a7ff` fix(installer): repair ocs shim and enforce auth guard after setup
- `67d3306` fix(setup): harden multi-auth resolution and enforce oauth guard
- `601163d` docs(readme): expose v2.0.8 changes and patched legacy issues
- `fc0f2f2` fix(release): sync root README to releases repo
- `454c945` fix(release): sync full docs to releases repository
- `6c540eb` chore(release): bump plugin version to v2.0.8
- `d411430` fix(release): handle untracked managed paths in repo sync
- `c8850d3` docs: align web-ui guidance and relocate developer docs
- `425f877` chore(release): remove legacy root checksum artifact
- `52b63b5` feat(release): add managed sync pipeline and artifact layout
- `d49a7bf` fix(plugin): harden account persistence on storage load errors
- `0f33118` docs(changelog): add v2.0.7 root release notes
- `5657d6f` chore(release): bump plugin to v2.0.7 and refresh checksums
- `77a9ff5` docs(plugin): add preset selection guide and 5-minute checklist
- `efe0619` test(plugin): cover dynamic routing modes and capability behavior
- `d66a25c` feat(plugin): add dynamic cli-first routing and capability-aware fallback
- `020a85d` fix(installer): keep hybrid auto-setup and simplify next steps
- `21c080c` fix(setup): self-heal bun global duplicate lock corruption
- `544b206` fix(prefs): harden schema loading and restore gemini oauth hybrid flow
- `a734cf3` fix(release): restore antigravity oauth login in installer deployments
- `f0ee9c9` chore(release): cut v2.0.3 with setup CLI fix
- `d838837` fix(cli): restore interactive setup default and add update aliases
- `172c993` fix(installer): enforce bun-only dependency retries
- `7878958` chore(release): finalize 2.0.2 changelog metadata
- `ebd5c79` chore(changelog): finalize released sections
- `2e9a5b9` build(release): include changelogs in bundled artifacts
- `da47524` chore(release): finalize 2.0.1 notes and metadata
- `03d72b7` refactor(plugin): remove manual verify-account menu flow
- `32354da` docs(plugin): record unreleased wave-2 commit trail
- `cbdfa6e` feat(plugin): enforce status floors in cooldown backoff
- `3ff6130` feat(plugin): add adaptive 5xx retry and switching path
- `81a00b9` feat(plugin): add 401 escalation and 404 cooldown routing
- `b1a451b` feat(plugin): harden storage migration and save coordination
- `7ab7e15` feat(plugin): add rest-until-full soft quota lock flow
- `0362157` feat(plugin): normalize model-family cooldown lock keys
- `42fc708` test(plugin): add 429 dedup storm coverage
- `f510011` feat(plugin): extend cooldown duration fallback parsing
- `96302de` feat(plugin): harden phase-1 retry and quota classification
- `b25c385` feat(plugin): add phase-0 policy rollout guardrails
- `120c6a9` docs(prefs): document strict validation apply behavior
- `dae1057` feat(prefs): enforce strict schema validation in wizard
- `1d5800a` fix(release): make bundle copy reliable on Windows
- `b92e68e` fix(installer): enforce bun-only ocs shims and stable install path
- `bc984f7` fix(installer): make ocs bootstrap deterministic on Windows
- `e9693b3` feat(release): automate installer sync and private ocs bootstrap
- `2cc68f4` fix(installer): auto-repair ocs command on Windows
- `c4049b5` fix(release): publish checksum asset with tarball
- `4db11f3` chore(gitignore): ignore local antigravity config file
- `a66fbe3` chore(release): prepare v2 changelog and plugin version
- `1d9e448` docs(scripts): document antigravity fallback behavior
- `2b49027` fix(setup): seed antigravity config from template fallback
- `19fef61` feat(landing): refresh hero section and add hero lab page
- `5cc69bc` docs(multi-auth): add sonnet opus 400 vs 403 triage playbook
- `a3f3d9b` test(multi-auth): add regression coverage for sonnet opus payload edges
- `de9553f` fix(multi-auth): harden claude payload normalization and thinking guards
- `ad3ed96` feat(cli): add global ocs dispatcher and prefs wizard
- `3904771` feat(multi-auth): align CLI quota fallback and image model routing
- `aedcabb` feat(setup): default to hybrid profile and performance mode
- `ee0a386` docs(installer): standardize pwsh cache-buster command
- `33dda63` feat(branding): add final pro hybrid logo system
- `d1ccf00` fix(installer): default to codex hybrid performance
- `7c7ba91` chore(installer): refine next-steps guidance text
- `28c9458` fix(installer): enforce bun-only dependency retries
- `11a42b9` fix(installer): harden dependency install retries and fallback
- `d886420` fix(installer): resolve relative plugin path during bun install
- `b7d8513` fix(installer): continue in current shell when pwsh relaunch fails
- `5d0e2a7` fix(installer): harden ps7 relaunch and bun retry diagnostics
- `1246c2c` fix(installer): normalize COMSPEC before setup execution
- `608e71c` fix(installer): avoid false local-source detection and use plugin setup path
- `b001538` fix(installer): prefer system tar.exe and normalize extraction paths
- `709b036` fix(installer): make windows tar extraction fail-fast and compatible
- `2a21f68` fix(installer): prevent token output pollution and enforce access gate
- `3770ae3` feat(plugin): add profile configs and stabilize plugin test scaffolding
- `8923a8b` chore(runtime): update setup flow and archive legacy cli entry
- `77bc2e0` docs: organize guidance and repository workflow references
- `61798eb` docs(workflow): clarify multi-remote push model and ignore noise
- `46ebc6a` refactor(structure): migrate ocs app and archive legacy web paths
- `6c068d0` fix(installer): avoid false handoff short-circuit in ps5
- `84f07c3` fix(installer): keep terminal open after pwsh handoff
- `450be68` fix(installer): persist bun path and improve access-denied flow
- `0bb5631` fix(installer): add resilient token and gh dependency fallbacks
- `c91d2a9` feat(installer): enhance auth flow with gh CLI auto-login (feat-6164)
- `724ecb8` chore(test): add powershell linting utility
- `2cc362b` chore(assets): remove deprecated dark mode section assets
- `6c59e57` docs(quickstart): sync indonesian guide with recent changes [feat-6164]
- `9c6734a` fix(installer): rewrite powershell plugin installer for syntax stability
- `26e94ef` docs(quickstart): sync english guide with indonesian updates [feat-6164]
- `90cdb91` docs(quickstart): update Google Cloud API enablement flow (feat-6164)
- `aad33bf` docs(quickstart): update recommended tool to OpenCode Web UI
- `4c1d3d3` fix(api): refactor pakasir webhook logic and update tests
- `150b9c3` fix(api): add graceful error handling for missing env vars in create-order
- `3e1bc9d` fix(test): resolve syntax errors and cleanup orphaned blocks in pakasir tests (feat-6164)
- `5639587` fix(ui): remove duplicated button layouts in hero and cta (feat-6164)
- `2dc425d` fix(api): cleanup unused test cases in pakasir webhook tests
- `0fbaee5` fix(ui): improve contrast for badges and primary buttons (feat-6164)
- `53ff07b` fix(api): refactor pakasir webhook and update tests
- `d66d6c9` fix(ocs): improve checkout form validation and logic
- `ed652f2` fix(ocs): update page components for tailwind compatibility
- `0ecce41` fix(ocs): refine web redesign layout and spacing
- `6bdd9d5` fix(ui): resolve tailwind v4 dark mode class conflicts
- `67c1520` feat(ocs): add modular validation and DB-backed rate limiter
- `7e9ef1c` feat(ocs): implement web redesign and admin dashboard (feat-6164)
- `a63aa6a` chore(test): update root vitest workspace
- `6a7fea3` chore(test): configure vitest for ocs and plugin compatibility
- `b0969ba` test(ocs): add integration tests for auth and webhooks (feat-6164)
- `1c96f64` feat(ocs): close distribution architecture gaps (feat-6164)
- `9be294e` docs: add distribution-architecture.md for paid member delivery system
- `3f4ad02` fix(build): switch plugin build from bun build to tsc
- `4ec8bb2` fix(config): remove @latest tag from opencode-multi-auth plugin ref
- `fd48a13` feat(build): add bun prod build pipeline + release packager + SolidJS order portal
- `d729f39` feat(web): rebuild order portal with SolidJS + TailwindCSS v4, Pakasir QRIS integration
- `f4d44a9` chore(test): fix vitest workspace to scope only plugin tests, exclude bun cache
- `7fdca77` chore(test): setup vitest workspace at root for paired 1:1 test coverage
- `73046e9` feat: add opencode-multi-auth as internal plugin, replace opencode-ag-auth dep
- `a585ace` chore: initial setup from andyvand-opencode-config
<!-- OCS_COMMIT_COVERAGE_END -->
## [2.3.2] - 2026-04-20
### Added

- Integrated the `GPT-OSS 120B (Medium)` model via Antigravity API and established `configs/gpt-oss-120b-lead.json` as the new optimized performance orchestration profile.
- Created `ocs-cocoindex-gate` skill to extract and centralize CocoIndex background-indexing instructions and evidence ladders, reducing prompt fragmentation.

### Changed

- Expanded the `ocs-delegation-gate` domain mapping from 3 to 7 rows, integrating `impeccable-style` UI/UX triggers and concrete agent verification examples.
- Transformed all CocoIndex workflow instructions in `ocs-runtime-validation` and `ocs-delegation-gate` to pointer references for DRY alignment.

### Fixed

- Resolved a strict JSON schema rejection triggered by Protobuf endpoints by explicitly stripping length/numeric validation constraints (`minLength`, `maxLength`, `minimum`, `maximum`, `minContains`, `maxContains`) from MCP tool schemas before sending them to the Gemini/Antigravity backend.

### Automated Release Summary
<!-- OCS_AUTO_SUMMARY_START -->
- Commit window: `v2.3.1..HEAD`
- Added: 2
- Fixed: 8
- Changed: 0
- Docs: 5
- Chore/Build/CI: 3
- Other: 0
<!-- OCS_AUTO_SUMMARY_END -->

### Commit Coverage (auto-generated)
<!-- OCS_COMMIT_COVERAGE_START -->
- `2207974` docs(changelog): auto-sync v2.3.2 commit coverage
- `e06331f` docs: update changelog for v2.3.2 release
- `6305ef1` chore(release): update lockfiles for v2.3.2
- `99caab7` fix(gemini): strip all string numeric constraints instead of casting to pass strict antigravity validation
- `2ed8f97` chore(release): bump version to 2.3.2
- `3d8b6f2` feat(config): add gpt-oss-120b-lead profile using Antigravity GPT-OSS 120B as orchestrator
- `c9c32ea` docs(installer): update installer README template to main and v2.3.1
- `12aeb77` fix(gemini): ensure all schemas pass through toGeminiSchema sanitization hook
- `7068cd7` docs(skills): update delegation gates to reference cocoindex playbook and add impeccable-style trigger rules
- `61a2020` feat(config): switch explore agent to antigravity gpt-oss-120b-medium model
- `0e70669` fix(plugin): cast string numeric constraints to integers for strict gemini schema validation
- `2aa72a2` fix(plugin): send LINUX platform metadata in WSL environments
- `662a50e` fix(installer): resolve missing ocs index script path and remove empty prefix path array bug
- `3b432c8` docs(workflow): enforce main-oriented patch publication order
- `91df4b3` fix(setup): preserve account state and harden profile runtime checks
- `c2efcb4` fix(setup): keep profile apply fast and deterministic across WSL parity
- `63b5af3` fix(installer): default latest branch hint to main
- `01926fc` chore(governance): enforce release execution policy and impeccable overrides
<!-- OCS_COMMIT_COVERAGE_END -->
## [2.3.1] - 2026-04-19

### Fixed

- Prevented cold-start account collapse in fresh WSL sessions by preserving persisted provider storage when startup reads fail and by skipping unsafe startup auto-save in unreadable-storage states.
- Split persistence/cold-start regression coverage by provider (Antigravity vs OpenAI) so route-specific save behavior is validated independently and safer to extend for future providers.
- Updated installer branch fallback resolution so version-pinned installs default to `staging/v<version>` consistently in both Bash and PowerShell installers.

### Changed

- Added reusable provider test-support scaffolding under non-runtime build paths and excluded it from production build output to keep release tarballs clean.
- Completed WSL-first artifact gate workflow for this patch wave (rebuild tarball, isolated local WSL reinstall smoke, and doctor/runtime proof) before lane propagation.
- Refreshed the staging lane publication so `staging/v2.3.1` resolves `opencode-config-suites-v2.3.1.tar.gz` consistently across source, buyer, and installer sync flow.
- Matured the `frontend-ui-ux` override so visual-engineering delegation consistently routes through `impeccable-style` governance without provider/model hardcoding.
- Added exhaustive script-level validation for the impeccable override workflow (`scripts/impeccable-style-override.test.js`) and kept the assertions provider-agnostic.

### Docs

- Added explicit governance policy that authoritative `git commit/push/tag/release` operations must run from Windows PowerShell with GitHub CLI identity `andyvandaric`, while WSL is reserved for runtime validation/debug/test execution.
- Published the impeccable-style override compliance/runbook and precedence contract docs to codify trigger rules, anti-trigger rules, and completion metadata expectations for visual-engineering tasks.

### Automated Release Summary
<!-- OCS_AUTO_SUMMARY_START -->
- Commit window: `v2.3.0..HEAD`
- Added: 1
- Fixed: 8
- Changed: 1
- Docs: 7
- Chore/Build/CI: 3
- Other: 1
<!-- OCS_AUTO_SUMMARY_END -->

### Commit Coverage (auto-generated)
<!-- OCS_COMMIT_COVERAGE_START -->
- `7b2ca17` docs(ops): codify monorepo source-of-truth and quick profile switching
- `02e61ba` fix(plugin): stabilize auth routing and antigravity response parsing
- `26929d7` fix(setup): harden installer sync, doctor remediation, and monorepo config flow
- `327c049` chore(configs): refresh profile catalog and schema endpoints for v2.3.1
- `61bfddb` merge: integrate staging/v2.3.1-patch into staging/v2.3.1
- `44d97db` docs(installer): add windows path divergence triage
- `67644d3` fix(installer): classify safe home paths as resolved
- `3d545ce` test(installer): add failing empty-path regression cases
- `50fde8b` docs(changelog): auto-sync v2.3.1 commit coverage
- `0e1bcb4` chore(plugin): align multi-auth version to 2.3.1
- `c43a1af` docs(changelog): auto-sync v2.3.1 commit coverage
- `a0814b8` docs(changelog): auto-sync v2.3.1 commit coverage
- `a28067a` docs(installer): add v2.3.1 release section
- `3fbf35e` docs(changelog): auto-sync v2.3.1 commit coverage
- `b2b9c0a` chore(release): bump suite version to 2.3.1
- `0b8576a` fix(release): make installer sync branch-aware
- `8df7143` feat(skills): integrate impeccable-style governance into OCS
- `140bcd8` fix(plugin): restore antigravity version resolution fallback chain
- `ed9844c` fix(installer): harden cross-platform install and doctor flows
- `70f2bfe` fix(installer): harden linux package install sudo fallback
- `e82ee2c` fix(installer): avoid assoc array for path dedup
<!-- OCS_COMMIT_COVERAGE_END -->

## [2.3.0] - 2026-04-07
### Changed

- Hardened the CocoIndex continuation by calling out `ocs index` automation, MCP-ready `ccc` scaffolding, and the full troubleshooting ladder so release readers can follow the live MCP interaction path without guessing.
- Strengthened CCC docs/skill governance (extension scaffolds, adaptive skill loading, workflow-safe placement) while keeping the multilanguage quick-starts and installer assets aligned to the new lane.

### Docs

- Quick-start (EN/ID) and `cocoindex-ops` docs now spell out the MCP fallback commands plus CCC governance expectations that define this wave.

### Automated Release Summary
<!-- OCS_AUTO_SUMMARY_START -->
- Commit window: `v2.2.1..HEAD`
- Added: 0
- Fixed: 2
- Changed: 0
- Docs: 6
- Chore/Build/CI: 1
- Other: 0
<!-- OCS_AUTO_SUMMARY_END -->

### Commit Coverage (auto-generated)
<!-- OCS_COMMIT_COVERAGE_START -->
- `70f2bfe` fix(installer): harden linux package install sudo fallback
- `e82ee2c` fix(installer): avoid assoc array for path dedup
- `bff4dfd` docs(changelog): auto-sync v2.3.0 commit coverage
- `e59ef44` docs(changelog): auto-sync v2.3.0 commit coverage
- `5f7ab6a` docs(changelog): auto-sync v2.3.0 commit coverage
- `8d01fab` docs(changelog): auto-sync v2.3.0 commit coverage
- `83b3e7d` docs(changelog): auto-sync v2.3.0 commit coverage
- `be39b1a` docs(changelog): auto-sync v2.3.0 commit coverage
- `3403e6b` chore(release): prep staging v2.3.0 lane
<!-- OCS_COMMIT_COVERAGE_END -->
## [2.2.1] - 2026-04-05

### Changed

- Activated CocoIndex Code setup path in `scripts/setup.js` with `ccc` readiness/bootstrap (`ccc --help`, `ccc init -f`, `ccc mcp --help`) and idempotent MCP wiring for `cocoindex-code`.
- Added installer/public copywriting + SEO skill governance and runtime playbook (`ocs-installer-copy-seo`) with OCS skill-gate integration.

### Fixed

- Hardened OpenAI auth/runtime robustness in multi-auth plugin loader and quota/account persistence paths, with additional regression coverage.
- Pinned plugin dependency `@opencode-ai/plugin` to `1.3.13` to avoid runtime package export mismatch in Windows install lanes.

### Automated Release Summary

<!-- OCS_AUTO_SUMMARY_START -->

- Commit window: `HEAD`
- Added: 68
- Fixed: 109
- Changed: 13
- Docs: 96
- Chore/Build/CI: 49
- Other: 2
<!-- OCS_AUTO_SUMMARY_END -->

### Commit Coverage (auto-generated)

<!-- OCS_COMMIT_COVERAGE_START -->

- `46b32c2` docs(changelog): auto-sync v2.2.1 commit coverage
- `2a0e950` fix(plugin): avoid mass OpenAI quarantine on non-rotation refresh errors
- `ab83093` docs(changelog): auto-sync v2.2.1 commit coverage
- `7ab9362` docs(changelog): auto-sync v2.2.1 commit coverage
- `7a7a54b` fix(plugin): null-safe OpenAI model routing in account selection
- `ae8be92` fix(plugin): harden OpenAI soft-quota failover for single-account mode
- `2b4884c` docs(changelog): auto-sync v2.2.1 commit coverage
- `109faaf` fix(installer): align fallback branch hint to staging v2.2.1
- `f566f73` fix(installer): call Ensure-PnpmRuntime in staging script
- `ddd63de` docs(changelog): auto-sync v2.2.1 commit coverage
- `5c717dd` chore(release): finalize staging v2.2.1 runtime and installer parity
- `a89e924` docs(changelog): auto-sync v2.2.1 commit coverage
- `414419f` docs(changelog): auto-sync v2.2.1 commit coverage
- `bba1986` chore(governance): gate release docs snippet alignment
- `1049b23` docs(release): require installer command alignment checks
- `209b7e1` docs(installer): align v2.2.1 branch and pin snippets
- `a637aeb` docs(changelog): auto-sync v2.2.1 commit coverage
- `549a261` docs(changelog): auto-sync v2.2.1 commit coverage
- `fa12232` docs(installer): add v2.2.1 public changelog section
- `43e5978` docs(changelog): auto-sync v2.2.1 commit coverage
- `d59ebba` docs(changelog): add v2.2.1 release section
- `01a9d0e` chore(release): bump suite and plugin versions to 2.2.1
- `74151fd` docs(changelog): auto-sync v2.2.0 commit coverage
- `f64bfa8` docs(changelog): auto-sync v2.2.0 commit coverage
- `a4ae79a` docs(installer): add copy SEO playbook and skill references
- `7341e86` feat(skills): add installer copywriting SEO runtime skill
- `a1b7eef` feat(governance): add installer copywriting and SEO skill gates
- `df49af9` fix(plugin): harden OpenAI loader and auth state handling
- `d97cbf4` feat(setup): activate cocoindex-code via ccc and MCP sync
- `4465841` docs(changelog): auto-sync v2.2.0 commit coverage
- `f412dcf` docs(changelog): auto-sync v2.2.0 commit coverage
- `08c2ac8` docs(release): enforce cross-repo tag and release-note propagation
- `9e336ef` docs(changelog): auto-sync v2.2.0 commit coverage
- `f1c88ca` docs(changelog): auto-sync v2.2.0 commit coverage
- `8d9083b` docs(skills): add adaptive integration guide and markdown workflow references
- `fe22578` feat(skills): add markdown autofix skill and adaptive loading governance
- `2c20353` chore(markdown): align lint rules and add autofix scripts
- `0eb4bca` feat(setup): resolve cocoindex command paths and seed extensions scaffold
- `1ec5b8e` fix(plugin): harden openai quota probe fallback paths
- `b66e374` docs(changelog): auto-sync v2.2.0 commit coverage
- `db70273` fix(runtime): harden openai rotation and local install resilience
- `10f6f46` docs(changelog): auto-sync v2.2.0 commit coverage
- `49086bc` docs(readme): restore advanced EXA setup in private guide
- `83b02f9` docs(changelog): auto-sync v2.2.0 commit coverage
- `544127d` docs(installer): refactor public README for soft-selling flow
- `14a753c` docs(changelog): auto-sync v2.2.0 commit coverage
- `a19f549` docs(changelog): auto-sync v2.2.0 commit coverage
- `abb628c` docs(profiles): align v2.2 recommendations and onboarding parity
- `b381bbf` docs(release): update v2.2.0 session stability notes
- `9240834` fix(openai): improve session trigger robustness and durability
- `faa32c3` fix(runtime): harden openai sessions and installer shim reliability
- `5aae294` feat(setup): bootstrap CocoIndex and align staging v2.2.0
- `6fb26ad` chore(governance): tighten delegation and release validation guardrails
- `9c6b1b3` fix(setup): auto-repair legacy dcp config keys
- `0998b4b` docs(changelog): auto-sync v2.1.15 commit coverage
- `2a87536` docs(changelog): auto-sync v2.1.15 commit coverage
- `339f7e9` docs(changelog): auto-sync v2.1.15 commit coverage
- `8ca8570` fix(staging): harden openai on-demand refresh and align v2.1.15 lanes
- `477eb56` docs(changelog): auto-sync v2.1.14 commit coverage
- `2885974` fix(plugin): add lockfile no-op fallback for runtime interop
- `fba969e` docs(changelog): auto-sync v2.1.14 commit coverage
- `9cdcb13` fix(plugin): normalize proper-lockfile interop for account toggles
- `f0aaca0` docs(changelog): auto-sync v2.1.14 commit coverage
- `a47302b` fix(plugin): prevent proper-lockfile import crash in runtime
- `ede70bb` docs(changelog): auto-sync v2.1.14 commit coverage
- `228f712` fix(installer): align v2.1.14 bundle versions and auth plugin precedence
- `f3e9330` docs(changelog): auto-sync v2.1.14 commit coverage
- `426ab66` fix(staging): align installer lane to v2.1.14 and harden openai auth flow
- `48bc2b7` docs(changelog): auto-sync v2.1.14 commit coverage
- `be35ff0` docs(installer): add v2.1.14 release notes template
- `4c61215` docs(changelog): auto-sync v2.1.14 commit coverage
- `c4afaeb` fix(auth): restore manage/check flows and schema-safe credential restore
- `6d3a6dd` docs(changelog): auto-sync v2.1.13 commit coverage
- `f12e504` fix(release): enforce fresh multi-auth bundle and runtime credential safety
- `18572af` fix(setup): preserve runtime API credentials on reinstall
- `af37a05` docs(changelog): auto-sync v2.1.13 commit coverage
- `5450c77` feat(setup): align MCP defaults and profile parity for staging
- `08459e2` docs(changelog): record OCS skills sync rollout
- `a7d7834` docs(skills): establish OCS skills governance model
- `3b1fdd8` fix(installer): preserve hidden bundle directories
- `654fd76` feat(skills): add managed OCS skills sync pipeline
- `872bd0f` docs(rules): mandate tarball integrity SOP
- `651a1ea` feat(release): enforce provenance and parity guardrails
- `89f3e83` docs(changelog): record openai menu activation fix
- `8c80c82` fix(setup): use loader-safe local plugin specs
- `455dfd1` feat(release): bundle openai auth wrapper plugin
- `8015f85` docs(changelog): record realtime quota check behavior
- `34475b4` fix(quota): force realtime openai check output
- `2a6ca9b` docs(changelog): record exa schema compatibility fix
- `aa38bb9` fix(exa): enforce schema-safe setup output
- `97f9a56` fix(mcp): normalize exa header schema tokens
- `8bd44c1` docs(changelog): document installer lane resolution fix
- `3e1442a` fix(installer): infer source lane and align fallback branch
- `dd2bce8` docs(readme): align staging installer URLs to v2.1.13
- `487a608` docs(release): record v2.1.13 exa parity updates
- `142159f` docs(installer): expand exa onboarding and changelog continuity
- `38afc57` feat(cli): add exa setup and check commands
- `7c047ea` feat(mcp): add exa wiring and setup utility
- `5078492` docs(release): document multi-lane orchestration flow
- `891fac0` feat(release): add lane orchestration command
- `e237102` feat(installer): support explicit target branch sync
- `bd57d49` docs(release): complete v2.1.13 changelog coverage
- `c47938e` feat(openai): add accounts sanity-check command and docs
- `b1d0b18` fix(openai): persist rotated auth and clarify refresh failures
- `d2f0cb5` docs(security): enforce openai auth-state safety boundaries
- `4b41f36` docs(release): record latest openai patch notes in v2.1.13
- `52f3785` fix(openai): prevent add-account overwrite across identities
- `68917fd` fix(openai): strip unsupported codex output-token params
- `cc65969` docs(release): restore 2.1.12-2.1.5 changelog continuity
- `8a7341a` feat(staging): cut v2.1.13 with configurable openai buffer
- `65d1ffc` fix(plugin): route session auth requests through codex surface
- `8f1e361` fix(plugin): stabilize openai post-login refresh state
- `1b338a4` fix(plugin): re-enable openai account after reauth
- `63cd15d` fix(plugin): surface concrete openai auth-unavailable reasons
- `b2fd07d` fix(openai): inject codex instructions for web ui requests
- `6c38af1` fix(plugin): harden openai oauth fallback and switch policy
- `d11219f` chore(release): restore suite version to 2.1.12
- `f3c0606` fix(setup): prevent plugin self-delete during installer mode
- `0289d17` docs(staging): add v2.1.12 e2e checklist and tidy plugin changelog
- `0b26f6f` docs(plugin): restore full 2.1.11-2.1.4 changelog chain
- `2b578b2` chore(plugin): sync changelog to v2.1.12 parity
- `87c1700` fix(app): stabilize staging diagnostics and API test placement
- `98b22cd` merge(chore): integrate remaining f75f release fixes into main
- `e9efb4f` merge(feat): integrate ecf4 latest implementation into main
- `bb07338` fix(plugin): avoid ambiguous OpenAI account upsert collisions
- `6e0e86b` chore(repo): remove oc-chatgpt reference mirror
- `b07f899` chore(plugin): align package version to 2.1.12
- `4240cd0` feat(plugin): tighten quota refresh defaults and ttl bounds
- `43da28a` feat(plugin): harden OpenAI multi-account parity flow
- `95653c3` fix(testing): stabilize feat-ecf4 gate validation lanes
- `a9ebb83` chore(flowcrate): capture batch-3 commit continuity sha
- `10d0047` feat(flowcrate): execute feat-ecf4 release-handoff evidence runbook
- `e907394` chore(tmp): add local workspace and runtime snapshots
- `411d734` chore(meta): track sisyphus planning and continuation state
- `0a095f1` feat(plugin): strengthen streaming transformer event handling
- `e5d81ca` feat(plugin): refine auth menu selection and ansi rendering
- `33874a7` feat(plugin): harden quota fallback and refresh queue logic
- `c21416b` test(plugin): expand openai provider and probe coverage
- `b5bb369` feat(plugin): improve account lifecycle and auth state handling
- `f2f7d70` feat(plugin): sync setup flow and schema documentation
- `9de30eb` chore(config): update root tooling and profile configuration
- `746820f` docs(landing): refresh docs and marketing content
- `d70d4c2` test(plugin): add probe and refresh hardening suites
- `a22b89a` test(plugin): cover thinking recovery regression boundaries
- `adfbc1f` test(resilience): add deterministic invariant hardening sweeps
- `3b8c73e` chore(plugin): remove orphaned opencode-openai-auth package
- `3439a4c` test(plugin): add resilience decomposition and orchestration coverage
- `0de23d8` feat(plugin): decompose resilience orchestration into focused modules
- `7e00291` test(plugin): stabilize audit and storage verification tests
- `adc0bba` feat(plugin): wire runtime audit emitter and tests
- `2e5dd3a` feat(plugin): emit audit events in auto-update checker
- `d07c603` feat(plugin): add audit sinks for logger and debug
- `26d829e` feat(plugin): add audit config and env controls
- `6ef1c89` test(plugin): add phase0 fixture guardrails baseline
- `1ec1430` docs(installer): sync templates and changelog to 2.1.3
- `e5426d7` docs(installer): bump root install examples to 2.1.3
- `a4d042f` docs(installer): enforce pwsh install command on Windows
- `4dc0298` feat(plugin): probe openai session quota with usage fallback
- `45431e1` feat(plugin): add openai login method menu actions
- `32c7ac4` fix(plugin): harden openai oauth callback listener flow
- `c8e8f1b` chore(release): align beta with 2.1.3 release line
- `4d69b80` docs(release): align package publish instructions
- `5bfeefd` docs(release): update buyer beta publish guidance
- `21fce31` chore(installer): sync LF enforcement and public installer docs
- `e196ce0` fix(installer): harden shell bootstrap and oauth guard
- `1a44dd2` fix(setup): refresh bundled multi-auth staging
- `ccd9250` fix(setup): stabilize local plugin tarball packing
- `9728fa7` feat(plugin): persist openai identity metadata
- `c43c984` feat(plugin): add openai browser and headless auth
- `18bed6d` feat(plugin): finish openai account lifecycle parity
- `f32d1be` fix(plugin): store openai accounts separately
- `a2105d5` feat(plugin): add openai auth wrapper package
- `4fe308b` fix(setup): load plugin-owned openai auth wrapper
- `867c85d` chore(installer): sync public installer templates for 2.1.3
- `d44fd6a` docs(installer): sync install guides to 2.1.3
- `7fefcc1` docs(release): add 2.1.3 oauth visibility notes
- `86a913b` chore(release): bump suite and plugin to 2.1.3
- `2396b81` fix(setup): prefer bundled package fallback for multi-auth
- `b6537f7` fix(installer): align auto setup defaults with installer profile
- `72c20e7` feat(plugin): add openai account menu parity
- `a683f96` fix(release): track antigravity backup template for clean packaging
- `831f8b7` chore(installer): sync public installer templates to 2.1.2
- `26235e6` docs(installer): sync version examples to 2.1.2
- `96054d6` docs(release): add 2.1.2 release notes
- `7ab0e64` chore(release): bump suite and plugin to 2.1.2
- `2e8258f` docs(plugin): document codex multi-auth runtime path
- `faf27ab` feat(plugin): add codex session safety guards
- `a37fe57` feat(plugin): add openai provider routing primitives
- `c28ddf7` feat(plugin): add codex shared-core account state
- `cf0e5c4` chore(installer): restore public installer sync inputs
- `8678464` fix(installer): restore source installer scripts in main repo
- `67f708e` docs(plugin): add 2.1.1 changelog entry
- `8b42615` fix(setup): pin oauth-compatible plugin stack at deploy time
- `092d4a8` docs(quick-start): add version-pin install examples in Indonesian guide
- `d02e899` chore(release): bump suite and plugin version to 2.1.0
- `3614c23` docs(installer): update public installer copy for 2.1.0
- `5a71b0c` chore(runtime): update default GPT-5.4 stack and plugin channels
- `6c25a37` docs(models): add pass-model mapping and GPT-5.4 notes
- `c9968e8` feat(config): add hephaestus to codex 5.4 profiles
- `fd8c41b` docs(troubleshooting): add doctor and path recovery guidance
- `460b6f7` feat(cli): add ocs doctor and docs for version pin
- `b576270` fix(setup): fallback invalid resource mode and document version pin
- `ddb4148` chore(release): bump suite and plugin to 2.0.15
- `e6154d7` fix(installer): restore README copywriting and CTA
- `1ee818e` docs(release): announce gpt-5.4 setup profiles
- `04c6b47` feat(profile): add codex-5.4 setup profiles
- `b9ef079` fix(release): enforce suite artifact naming and v2.0.14 changelog
- `ee4775f` fix(release): keep installer template bundle naming in sync
- `a29203c` chore(release): cut v2.0.14 and align installer topology
- `17bf768` fix(installer): resolve suite bundle names in shell and powershell
- `8215fbb` fix(installer): resolve suite bundle names in shell and powershell
- `1f91073` chore(repo): ignore local release clone workdirs
- `900ceb6` chore(repo): ignore local release clone workdirs
- `0eeec4d` fix(installer): prefer https auth flow and beta semver labels
- `78537cb` fix(installer): prefer https auth flow and beta semver labels
- `2348bd5` docs(release): add v2.0.13 changelog entries
- `3ae10de` fix(installer): use OAuth-first auth and quiet installer setup logs
- `72e5708` chore(repo): checkpoint pending docs, scripts, and flowcrate updates before refactor-4b3f
- `80030cc` fix(auth): restore google oauth flow after reinstall
- `021d1b7` fix(installer): enforce oauth guard across plugin reinstall paths
- `05ea6fb` chore(release): cut v2.0.10 with latest auth/setup fixes
- `401f3c6` chore(release): bump v2.0.9 metadata and add missing v2.0.8 notes
- `b59a7ff` fix(installer): repair ocs shim and enforce auth guard after setup
- `67d3306` fix(setup): harden multi-auth resolution and enforce oauth guard
- `601163d` docs(readme): expose v2.0.8 changes and patched legacy issues
- `fc0f2f2` fix(release): sync root README to releases repo
- `454c945` fix(release): sync full docs to releases repository
- `6c540eb` chore(release): bump plugin version to v2.0.8
- `d411430` fix(release): handle untracked managed paths in repo sync
- `c8850d3` docs: align web-ui guidance and relocate developer docs
- `425f877` chore(release): remove legacy root checksum artifact
- `52b63b5` feat(release): add managed sync pipeline and artifact layout
- `d49a7bf` fix(plugin): harden account persistence on storage load errors
- `0f33118` docs(changelog): add v2.0.7 root release notes
- `5657d6f` chore(release): bump plugin to v2.0.7 and refresh checksums
- `77a9ff5` docs(plugin): add preset selection guide and 5-minute checklist
- `efe0619` test(plugin): cover dynamic routing modes and capability behavior
- `d66a25c` feat(plugin): add dynamic cli-first routing and capability-aware fallback
- `020a85d` fix(installer): keep hybrid auto-setup and simplify next steps
- `21c080c` fix(setup): self-heal bun global duplicate lock corruption
- `544b206` fix(prefs): harden schema loading and restore gemini oauth hybrid flow
- `a734cf3` fix(release): restore antigravity oauth login in installer deployments
- `f0ee9c9` chore(release): cut v2.0.3 with setup CLI fix
- `d838837` fix(cli): restore interactive setup default and add update aliases
- `172c993` fix(installer): enforce bun-only dependency retries
- `7878958` chore(release): finalize 2.0.2 changelog metadata
- `ebd5c79` chore(changelog): finalize released sections
- `2e9a5b9` build(release): include changelogs in bundled artifacts
- `da47524` chore(release): finalize 2.0.1 notes and metadata
- `03d72b7` refactor(plugin): remove manual verify-account menu flow
- `32354da` docs(plugin): record unreleased wave-2 commit trail
- `cbdfa6e` feat(plugin): enforce status floors in cooldown backoff
- `3ff6130` feat(plugin): add adaptive 5xx retry and switching path
- `81a00b9` feat(plugin): add 401 escalation and 404 cooldown routing
- `b1a451b` feat(plugin): harden storage migration and save coordination
- `7ab7e15` feat(plugin): add rest-until-full soft quota lock flow
- `0362157` feat(plugin): normalize model-family cooldown lock keys
- `42fc708` test(plugin): add 429 dedup storm coverage
- `f510011` feat(plugin): extend cooldown duration fallback parsing
- `96302de` feat(plugin): harden phase-1 retry and quota classification
- `b25c385` feat(plugin): add phase-0 policy rollout guardrails
- `120c6a9` docs(prefs): document strict validation apply behavior
- `dae1057` feat(prefs): enforce strict schema validation in wizard
- `1d5800a` fix(release): make bundle copy reliable on Windows
- `b92e68e` fix(installer): enforce bun-only ocs shims and stable install path
- `bc984f7` fix(installer): make ocs bootstrap deterministic on Windows
- `e9693b3` feat(release): automate installer sync and private ocs bootstrap
- `2cc68f4` fix(installer): auto-repair ocs command on Windows
- `c4049b5` fix(release): publish checksum asset with tarball
- `4db11f3` chore(gitignore): ignore local antigravity config file
- `a66fbe3` chore(release): prepare v2 changelog and plugin version
- `1d9e448` docs(scripts): document antigravity fallback behavior
- `2b49027` fix(setup): seed antigravity config from template fallback
- `19fef61` feat(landing): refresh hero section and add hero lab page
- `5cc69bc` docs(multi-auth): add sonnet opus 400 vs 403 triage playbook
- `a3f3d9b` test(multi-auth): add regression coverage for sonnet opus payload edges
- `de9553f` fix(multi-auth): harden claude payload normalization and thinking guards
- `ad3ed96` feat(cli): add global ocs dispatcher and prefs wizard
- `3904771` feat(multi-auth): align CLI quota fallback and image model routing
- `aedcabb` feat(setup): default to hybrid profile and performance mode
- `ee0a386` docs(installer): standardize pwsh cache-buster command
- `33dda63` feat(branding): add final pro hybrid logo system
- `d1ccf00` fix(installer): default to codex hybrid performance
- `7c7ba91` chore(installer): refine next-steps guidance text
- `28c9458` fix(installer): enforce bun-only dependency retries
- `11a42b9` fix(installer): harden dependency install retries and fallback
- `d886420` fix(installer): resolve relative plugin path during bun install
- `b7d8513` fix(installer): continue in current shell when pwsh relaunch fails
- `5d0e2a7` fix(installer): harden ps7 relaunch and bun retry diagnostics
- `1246c2c` fix(installer): normalize COMSPEC before setup execution
- `608e71c` fix(installer): avoid false local-source detection and use plugin setup path
- `b001538` fix(installer): prefer system tar.exe and normalize extraction paths
- `709b036` fix(installer): make windows tar extraction fail-fast and compatible
- `2a21f68` fix(installer): prevent token output pollution and enforce access gate
- `3770ae3` feat(plugin): add profile configs and stabilize plugin test scaffolding
- `8923a8b` chore(runtime): update setup flow and archive legacy cli entry
- `77bc2e0` docs: organize guidance and repository workflow references
- `61798eb` docs(workflow): clarify multi-remote push model and ignore noise
- `46ebc6a` refactor(structure): migrate ocs app and archive legacy web paths
- `6c068d0` fix(installer): avoid false handoff short-circuit in ps5
- `84f07c3` fix(installer): keep terminal open after pwsh handoff
- `450be68` fix(installer): persist bun path and improve access-denied flow
- `0bb5631` fix(installer): add resilient token and gh dependency fallbacks
- `c91d2a9` feat(installer): enhance auth flow with gh CLI auto-login (feat-6164)
- `724ecb8` chore(test): add powershell linting utility
- `2cc362b` chore(assets): remove deprecated dark mode section assets
- `6c59e57` docs(quickstart): sync indonesian guide with recent changes [feat-6164]
- `9c6734a` fix(installer): rewrite powershell plugin installer for syntax stability
- `26e94ef` docs(quickstart): sync english guide with indonesian updates [feat-6164]
- `90cdb91` docs(quickstart): update Google Cloud API enablement flow (feat-6164)
- `aad33bf` docs(quickstart): update recommended tool to OpenCode Web UI
- `4c1d3d3` fix(api): refactor pakasir webhook logic and update tests
- `150b9c3` fix(api): add graceful error handling for missing env vars in create-order
- `3e1bc9d` fix(test): resolve syntax errors and cleanup orphaned blocks in pakasir tests (feat-6164)
- `5639587` fix(ui): remove duplicated button layouts in hero and cta (feat-6164)
- `2dc425d` fix(api): cleanup unused test cases in pakasir webhook tests
- `0fbaee5` fix(ui): improve contrast for badges and primary buttons (feat-6164)
- `53ff07b` fix(api): refactor pakasir webhook and update tests
- `d66d6c9` fix(ocs): improve checkout form validation and logic
- `ed652f2` fix(ocs): update page components for tailwind compatibility
- `0ecce41` fix(ocs): refine web redesign layout and spacing
- `6bdd9d5` fix(ui): resolve tailwind v4 dark mode class conflicts
- `67c1520` feat(ocs): add modular validation and DB-backed rate limiter
- `7e9ef1c` feat(ocs): implement web redesign and admin dashboard (feat-6164)
- `a63aa6a` chore(test): update root vitest workspace
- `6a7fea3` chore(test): configure vitest for ocs and plugin compatibility
- `b0969ba` test(ocs): add integration tests for auth and webhooks (feat-6164)
- `1c96f64` feat(ocs): close distribution architecture gaps (feat-6164)
- `9be294e` docs: add distribution-architecture.md for paid member delivery system
- `3f4ad02` fix(build): switch plugin build from bun build to tsc
- `4ec8bb2` fix(config): remove @latest tag from opencode-multi-auth plugin ref
- `fd48a13` feat(build): add bun prod build pipeline + release packager + SolidJS order portal
- `d729f39` feat(web): rebuild order portal with SolidJS + TailwindCSS v4, Pakasir QRIS integration
- `f4d44a9` chore(test): fix vitest workspace to scope only plugin tests, exclude bun cache
- `7fdca77` chore(test): setup vitest workspace at root for paired 1:1 test coverage
- `73046e9` feat: add opencode-multi-auth as internal plugin, replace opencode-ag-auth dep
- `a585ace` chore: initial setup from andyvand-opencode-config
<!-- OCS_COMMIT_COVERAGE_END -->

## [2.2.0] - 2026-04-04

### Changed

- Upgraded staging lane dependency baseline for modernization wave:
  - root `@opencode-ai/plugin` -> `1.3.13`
  - root runtime framework package moved from `oh-my-opencode` to `oh-my-openagent` (`^3.14.0`)
  - plugin `@opencode-ai/plugin` -> `^1.3.13`
  - plugin `undici` -> `^7.24.7`
  - plugin `zod` -> `^4.3.6`
- Added installer/headless CocoIndex bootstrap path in setup flow to auto-prepare Python/pip install hooks, managed `.env` defaults, and optional local pgvector compose scaffolding.
- Switched runtime plugin registration in root/plugin `opencode.json` to `oh-my-openagent@latest` while preserving compatibility fallback pins for both `oh-my-openagent` and `oh-my-opencode` in setup.

### Fixed

- Aligned staging installer branch hints and quick-install examples to `staging/v2.2.0` + pinned `2.2.0` across source README and installer README template.
- Bumped suite and plugin package versions to `2.2.0` for lane-consistent release packaging.
- Refreshed setup compatibility pin map to match current stable plugin ecosystem (`oh-my-openagent/oh-my-opencode 3.14.0`, `@tarquinen/opencode-dcp 3.1.7`, `cc-safety-net 0.8.2`, `@ramtinj95/opencode-tokenscope 1.5.2`).
- Restored beta-like OpenAI Codex session durability by removing hard 2-hour session-correlation idle eviction while preserving multi-account account-key isolation and safety block semantics.
- Hardened OpenAI verification/quarantine trigger heuristics to reduce false-positive session blocking (trusted OpenAI host allowlist + stricter challenge classification for verification-required detection).

### Automated Release Summary

<!-- OCS_AUTO_SUMMARY_START -->

- Commit window: `HEAD`
- Added: 68
- Fixed: 104
- Changed: 13
- Docs: 81
- Chore/Build/CI: 46
- Other: 2
<!-- OCS_AUTO_SUMMARY_END -->

### Commit Coverage (auto-generated)

<!-- OCS_COMMIT_COVERAGE_START -->

- `f64bfa8` docs(changelog): auto-sync v2.2.0 commit coverage
- `a4ae79a` docs(installer): add copy SEO playbook and skill references
- `7341e86` feat(skills): add installer copywriting SEO runtime skill
- `a1b7eef` feat(governance): add installer copywriting and SEO skill gates
- `df49af9` fix(plugin): harden OpenAI loader and auth state handling
- `d97cbf4` feat(setup): activate cocoindex-code via ccc and MCP sync
- `4465841` docs(changelog): auto-sync v2.2.0 commit coverage
- `f412dcf` docs(changelog): auto-sync v2.2.0 commit coverage
- `08c2ac8` docs(release): enforce cross-repo tag and release-note propagation
- `9e336ef` docs(changelog): auto-sync v2.2.0 commit coverage
- `f1c88ca` docs(changelog): auto-sync v2.2.0 commit coverage
- `8d9083b` docs(skills): add adaptive integration guide and markdown workflow references
- `fe22578` feat(skills): add markdown autofix skill and adaptive loading governance
- `2c20353` chore(markdown): align lint rules and add autofix scripts
- `0eb4bca` feat(setup): resolve cocoindex command paths and seed extensions scaffold
- `1ec5b8e` fix(plugin): harden openai quota probe fallback paths
- `b66e374` docs(changelog): auto-sync v2.2.0 commit coverage
- `db70273` fix(runtime): harden openai rotation and local install resilience
- `10f6f46` docs(changelog): auto-sync v2.2.0 commit coverage
- `49086bc` docs(readme): restore advanced EXA setup in private guide
- `83b02f9` docs(changelog): auto-sync v2.2.0 commit coverage
- `544127d` docs(installer): refactor public README for soft-selling flow
- `14a753c` docs(changelog): auto-sync v2.2.0 commit coverage
- `a19f549` docs(changelog): auto-sync v2.2.0 commit coverage
- `abb628c` docs(profiles): align v2.2 recommendations and onboarding parity
- `b381bbf` docs(release): update v2.2.0 session stability notes
- `9240834` fix(openai): improve session trigger robustness and durability
- `faa32c3` fix(runtime): harden openai sessions and installer shim reliability
- `5aae294` feat(setup): bootstrap CocoIndex and align staging v2.2.0
- `6fb26ad` chore(governance): tighten delegation and release validation guardrails
- `9c6b1b3` fix(setup): auto-repair legacy dcp config keys
- `0998b4b` docs(changelog): auto-sync v2.1.15 commit coverage
- `2a87536` docs(changelog): auto-sync v2.1.15 commit coverage
- `339f7e9` docs(changelog): auto-sync v2.1.15 commit coverage
- `8ca8570` fix(staging): harden openai on-demand refresh and align v2.1.15 lanes
- `477eb56` docs(changelog): auto-sync v2.1.14 commit coverage
- `2885974` fix(plugin): add lockfile no-op fallback for runtime interop
- `fba969e` docs(changelog): auto-sync v2.1.14 commit coverage
- `9cdcb13` fix(plugin): normalize proper-lockfile interop for account toggles
- `f0aaca0` docs(changelog): auto-sync v2.1.14 commit coverage
- `a47302b` fix(plugin): prevent proper-lockfile import crash in runtime
- `ede70bb` docs(changelog): auto-sync v2.1.14 commit coverage
- `228f712` fix(installer): align v2.1.14 bundle versions and auth plugin precedence
- `f3e9330` docs(changelog): auto-sync v2.1.14 commit coverage
- `426ab66` fix(staging): align installer lane to v2.1.14 and harden openai auth flow
- `48bc2b7` docs(changelog): auto-sync v2.1.14 commit coverage
- `be35ff0` docs(installer): add v2.1.14 release notes template
- `4c61215` docs(changelog): auto-sync v2.1.14 commit coverage
- `c4afaeb` fix(auth): restore manage/check flows and schema-safe credential restore
- `6d3a6dd` docs(changelog): auto-sync v2.1.13 commit coverage
- `f12e504` fix(release): enforce fresh multi-auth bundle and runtime credential safety
- `18572af` fix(setup): preserve runtime API credentials on reinstall
- `af37a05` docs(changelog): auto-sync v2.1.13 commit coverage
- `5450c77` feat(setup): align MCP defaults and profile parity for staging
- `08459e2` docs(changelog): record OCS skills sync rollout
- `a7d7834` docs(skills): establish OCS skills governance model
- `3b1fdd8` fix(installer): preserve hidden bundle directories
- `654fd76` feat(skills): add managed OCS skills sync pipeline
- `872bd0f` docs(rules): mandate tarball integrity SOP
- `651a1ea` feat(release): enforce provenance and parity guardrails
- `89f3e83` docs(changelog): record openai menu activation fix
- `8c80c82` fix(setup): use loader-safe local plugin specs
- `455dfd1` feat(release): bundle openai auth wrapper plugin
- `8015f85` docs(changelog): record realtime quota check behavior
- `34475b4` fix(quota): force realtime openai check output
- `2a6ca9b` docs(changelog): record exa schema compatibility fix
- `aa38bb9` fix(exa): enforce schema-safe setup output
- `97f9a56` fix(mcp): normalize exa header schema tokens
- `8bd44c1` docs(changelog): document installer lane resolution fix
- `3e1442a` fix(installer): infer source lane and align fallback branch
- `dd2bce8` docs(readme): align staging installer URLs to v2.1.13
- `487a608` docs(release): record v2.1.13 exa parity updates
- `142159f` docs(installer): expand exa onboarding and changelog continuity
- `38afc57` feat(cli): add exa setup and check commands
- `7c047ea` feat(mcp): add exa wiring and setup utility
- `5078492` docs(release): document multi-lane orchestration flow
- `891fac0` feat(release): add lane orchestration command
- `e237102` feat(installer): support explicit target branch sync
- `bd57d49` docs(release): complete v2.1.13 changelog coverage
- `c47938e` feat(openai): add accounts sanity-check command and docs
- `b1d0b18` fix(openai): persist rotated auth and clarify refresh failures
- `d2f0cb5` docs(security): enforce openai auth-state safety boundaries
- `4b41f36` docs(release): record latest openai patch notes in v2.1.13
- `52f3785` fix(openai): prevent add-account overwrite across identities
- `68917fd` fix(openai): strip unsupported codex output-token params
- `cc65969` docs(release): restore 2.1.12-2.1.5 changelog continuity
- `8a7341a` feat(staging): cut v2.1.13 with configurable openai buffer
- `65d1ffc` fix(plugin): route session auth requests through codex surface
- `8f1e361` fix(plugin): stabilize openai post-login refresh state
- `1b338a4` fix(plugin): re-enable openai account after reauth
- `63cd15d` fix(plugin): surface concrete openai auth-unavailable reasons
- `b2fd07d` fix(openai): inject codex instructions for web ui requests
- `6c38af1` fix(plugin): harden openai oauth fallback and switch policy
- `d11219f` chore(release): restore suite version to 2.1.12
- `f3c0606` fix(setup): prevent plugin self-delete during installer mode
- `0289d17` docs(staging): add v2.1.12 e2e checklist and tidy plugin changelog
- `0b26f6f` docs(plugin): restore full 2.1.11-2.1.4 changelog chain
- `2b578b2` chore(plugin): sync changelog to v2.1.12 parity
- `87c1700` fix(app): stabilize staging diagnostics and API test placement
- `98b22cd` merge(chore): integrate remaining f75f release fixes into main
- `e9efb4f` merge(feat): integrate ecf4 latest implementation into main
- `bb07338` fix(plugin): avoid ambiguous OpenAI account upsert collisions
- `6e0e86b` chore(repo): remove oc-chatgpt reference mirror
- `b07f899` chore(plugin): align package version to 2.1.12
- `4240cd0` feat(plugin): tighten quota refresh defaults and ttl bounds
- `43da28a` feat(plugin): harden OpenAI multi-account parity flow
- `95653c3` fix(testing): stabilize feat-ecf4 gate validation lanes
- `a9ebb83` chore(flowcrate): capture batch-3 commit continuity sha
- `10d0047` feat(flowcrate): execute feat-ecf4 release-handoff evidence runbook
- `e907394` chore(tmp): add local workspace and runtime snapshots
- `411d734` chore(meta): track sisyphus planning and continuation state
- `0a095f1` feat(plugin): strengthen streaming transformer event handling
- `e5d81ca` feat(plugin): refine auth menu selection and ansi rendering
- `33874a7` feat(plugin): harden quota fallback and refresh queue logic
- `c21416b` test(plugin): expand openai provider and probe coverage
- `b5bb369` feat(plugin): improve account lifecycle and auth state handling
- `f2f7d70` feat(plugin): sync setup flow and schema documentation
- `9de30eb` chore(config): update root tooling and profile configuration
- `746820f` docs(landing): refresh docs and marketing content
- `d70d4c2` test(plugin): add probe and refresh hardening suites
- `a22b89a` test(plugin): cover thinking recovery regression boundaries
- `adfbc1f` test(resilience): add deterministic invariant hardening sweeps
- `3b8c73e` chore(plugin): remove orphaned opencode-openai-auth package
- `3439a4c` test(plugin): add resilience decomposition and orchestration coverage
- `0de23d8` feat(plugin): decompose resilience orchestration into focused modules
- `7e00291` test(plugin): stabilize audit and storage verification tests
- `adc0bba` feat(plugin): wire runtime audit emitter and tests
- `2e5dd3a` feat(plugin): emit audit events in auto-update checker
- `d07c603` feat(plugin): add audit sinks for logger and debug
- `26d829e` feat(plugin): add audit config and env controls
- `6ef1c89` test(plugin): add phase0 fixture guardrails baseline
- `1ec1430` docs(installer): sync templates and changelog to 2.1.3
- `e5426d7` docs(installer): bump root install examples to 2.1.3
- `a4d042f` docs(installer): enforce pwsh install command on Windows
- `4dc0298` feat(plugin): probe openai session quota with usage fallback
- `45431e1` feat(plugin): add openai login method menu actions
- `32c7ac4` fix(plugin): harden openai oauth callback listener flow
- `c8e8f1b` chore(release): align beta with 2.1.3 release line
- `4d69b80` docs(release): align package publish instructions
- `5bfeefd` docs(release): update buyer beta publish guidance
- `21fce31` chore(installer): sync LF enforcement and public installer docs
- `e196ce0` fix(installer): harden shell bootstrap and oauth guard
- `1a44dd2` fix(setup): refresh bundled multi-auth staging
- `ccd9250` fix(setup): stabilize local plugin tarball packing
- `9728fa7` feat(plugin): persist openai identity metadata
- `c43c984` feat(plugin): add openai browser and headless auth
- `18bed6d` feat(plugin): finish openai account lifecycle parity
- `f32d1be` fix(plugin): store openai accounts separately
- `a2105d5` feat(plugin): add openai auth wrapper package
- `4fe308b` fix(setup): load plugin-owned openai auth wrapper
- `867c85d` chore(installer): sync public installer templates for 2.1.3
- `d44fd6a` docs(installer): sync install guides to 2.1.3
- `7fefcc1` docs(release): add 2.1.3 oauth visibility notes
- `86a913b` chore(release): bump suite and plugin to 2.1.3
- `2396b81` fix(setup): prefer bundled package fallback for multi-auth
- `b6537f7` fix(installer): align auto setup defaults with installer profile
- `72c20e7` feat(plugin): add openai account menu parity
- `a683f96` fix(release): track antigravity backup template for clean packaging
- `831f8b7` chore(installer): sync public installer templates to 2.1.2
- `26235e6` docs(installer): sync version examples to 2.1.2
- `96054d6` docs(release): add 2.1.2 release notes
- `7ab0e64` chore(release): bump suite and plugin to 2.1.2
- `2e8258f` docs(plugin): document codex multi-auth runtime path
- `faf27ab` feat(plugin): add codex session safety guards
- `a37fe57` feat(plugin): add openai provider routing primitives
- `c28ddf7` feat(plugin): add codex shared-core account state
- `cf0e5c4` chore(installer): restore public installer sync inputs
- `8678464` fix(installer): restore source installer scripts in main repo
- `67f708e` docs(plugin): add 2.1.1 changelog entry
- `8b42615` fix(setup): pin oauth-compatible plugin stack at deploy time
- `092d4a8` docs(quick-start): add version-pin install examples in Indonesian guide
- `d02e899` chore(release): bump suite and plugin version to 2.1.0
- `3614c23` docs(installer): update public installer copy for 2.1.0
- `5a71b0c` chore(runtime): update default GPT-5.4 stack and plugin channels
- `6c25a37` docs(models): add pass-model mapping and GPT-5.4 notes
- `c9968e8` feat(config): add hephaestus to codex 5.4 profiles
- `fd8c41b` docs(troubleshooting): add doctor and path recovery guidance
- `460b6f7` feat(cli): add ocs doctor and docs for version pin
- `b576270` fix(setup): fallback invalid resource mode and document version pin
- `ddb4148` chore(release): bump suite and plugin to 2.0.15
- `e6154d7` fix(installer): restore README copywriting and CTA
- `1ee818e` docs(release): announce gpt-5.4 setup profiles
- `04c6b47` feat(profile): add codex-5.4 setup profiles
- `b9ef079` fix(release): enforce suite artifact naming and v2.0.14 changelog
- `ee4775f` fix(release): keep installer template bundle naming in sync
- `a29203c` chore(release): cut v2.0.14 and align installer topology
- `17bf768` fix(installer): resolve suite bundle names in shell and powershell
- `8215fbb` fix(installer): resolve suite bundle names in shell and powershell
- `1f91073` chore(repo): ignore local release clone workdirs
- `900ceb6` chore(repo): ignore local release clone workdirs
- `0eeec4d` fix(installer): prefer https auth flow and beta semver labels
- `78537cb` fix(installer): prefer https auth flow and beta semver labels
- `2348bd5` docs(release): add v2.0.13 changelog entries
- `3ae10de` fix(installer): use OAuth-first auth and quiet installer setup logs
- `72e5708` chore(repo): checkpoint pending docs, scripts, and flowcrate updates before refactor-4b3f
- `80030cc` fix(auth): restore google oauth flow after reinstall
- `021d1b7` fix(installer): enforce oauth guard across plugin reinstall paths
- `05ea6fb` chore(release): cut v2.0.10 with latest auth/setup fixes
- `401f3c6` chore(release): bump v2.0.9 metadata and add missing v2.0.8 notes
- `b59a7ff` fix(installer): repair ocs shim and enforce auth guard after setup
- `67d3306` fix(setup): harden multi-auth resolution and enforce oauth guard
- `601163d` docs(readme): expose v2.0.8 changes and patched legacy issues
- `fc0f2f2` fix(release): sync root README to releases repo
- `454c945` fix(release): sync full docs to releases repository
- `6c540eb` chore(release): bump plugin version to v2.0.8
- `d411430` fix(release): handle untracked managed paths in repo sync
- `c8850d3` docs: align web-ui guidance and relocate developer docs
- `425f877` chore(release): remove legacy root checksum artifact
- `52b63b5` feat(release): add managed sync pipeline and artifact layout
- `d49a7bf` fix(plugin): harden account persistence on storage load errors
- `0f33118` docs(changelog): add v2.0.7 root release notes
- `5657d6f` chore(release): bump plugin to v2.0.7 and refresh checksums
- `77a9ff5` docs(plugin): add preset selection guide and 5-minute checklist
- `efe0619` test(plugin): cover dynamic routing modes and capability behavior
- `d66a25c` feat(plugin): add dynamic cli-first routing and capability-aware fallback
- `020a85d` fix(installer): keep hybrid auto-setup and simplify next steps
- `21c080c` fix(setup): self-heal bun global duplicate lock corruption
- `544b206` fix(prefs): harden schema loading and restore gemini oauth hybrid flow
- `a734cf3` fix(release): restore antigravity oauth login in installer deployments
- `f0ee9c9` chore(release): cut v2.0.3 with setup CLI fix
- `d838837` fix(cli): restore interactive setup default and add update aliases
- `172c993` fix(installer): enforce bun-only dependency retries
- `7878958` chore(release): finalize 2.0.2 changelog metadata
- `ebd5c79` chore(changelog): finalize released sections
- `2e9a5b9` build(release): include changelogs in bundled artifacts
- `da47524` chore(release): finalize 2.0.1 notes and metadata
- `03d72b7` refactor(plugin): remove manual verify-account menu flow
- `32354da` docs(plugin): record unreleased wave-2 commit trail
- `cbdfa6e` feat(plugin): enforce status floors in cooldown backoff
- `3ff6130` feat(plugin): add adaptive 5xx retry and switching path
- `81a00b9` feat(plugin): add 401 escalation and 404 cooldown routing
- `b1a451b` feat(plugin): harden storage migration and save coordination
- `7ab7e15` feat(plugin): add rest-until-full soft quota lock flow
- `0362157` feat(plugin): normalize model-family cooldown lock keys
- `42fc708` test(plugin): add 429 dedup storm coverage
- `f510011` feat(plugin): extend cooldown duration fallback parsing
- `96302de` feat(plugin): harden phase-1 retry and quota classification
- `b25c385` feat(plugin): add phase-0 policy rollout guardrails
- `120c6a9` docs(prefs): document strict validation apply behavior
- `dae1057` feat(prefs): enforce strict schema validation in wizard
- `1d5800a` fix(release): make bundle copy reliable on Windows
- `b92e68e` fix(installer): enforce bun-only ocs shims and stable install path
- `bc984f7` fix(installer): make ocs bootstrap deterministic on Windows
- `e9693b3` feat(release): automate installer sync and private ocs bootstrap
- `2cc68f4` fix(installer): auto-repair ocs command on Windows
- `c4049b5` fix(release): publish checksum asset with tarball
- `4db11f3` chore(gitignore): ignore local antigravity config file
- `a66fbe3` chore(release): prepare v2 changelog and plugin version
- `1d9e448` docs(scripts): document antigravity fallback behavior
- `2b49027` fix(setup): seed antigravity config from template fallback
- `19fef61` feat(landing): refresh hero section and add hero lab page
- `5cc69bc` docs(multi-auth): add sonnet opus 400 vs 403 triage playbook
- `a3f3d9b` test(multi-auth): add regression coverage for sonnet opus payload edges
- `de9553f` fix(multi-auth): harden claude payload normalization and thinking guards
- `ad3ed96` feat(cli): add global ocs dispatcher and prefs wizard
- `3904771` feat(multi-auth): align CLI quota fallback and image model routing
- `aedcabb` feat(setup): default to hybrid profile and performance mode
- `ee0a386` docs(installer): standardize pwsh cache-buster command
- `33dda63` feat(branding): add final pro hybrid logo system
- `d1ccf00` fix(installer): default to codex hybrid performance
- `7c7ba91` chore(installer): refine next-steps guidance text
- `28c9458` fix(installer): enforce bun-only dependency retries
- `11a42b9` fix(installer): harden dependency install retries and fallback
- `d886420` fix(installer): resolve relative plugin path during bun install
- `b7d8513` fix(installer): continue in current shell when pwsh relaunch fails
- `5d0e2a7` fix(installer): harden ps7 relaunch and bun retry diagnostics
- `1246c2c` fix(installer): normalize COMSPEC before setup execution
- `608e71c` fix(installer): avoid false local-source detection and use plugin setup path
- `b001538` fix(installer): prefer system tar.exe and normalize extraction paths
- `709b036` fix(installer): make windows tar extraction fail-fast and compatible
- `2a21f68` fix(installer): prevent token output pollution and enforce access gate
- `3770ae3` feat(plugin): add profile configs and stabilize plugin test scaffolding
- `8923a8b` chore(runtime): update setup flow and archive legacy cli entry
- `77bc2e0` docs: organize guidance and repository workflow references
- `61798eb` docs(workflow): clarify multi-remote push model and ignore noise
- `46ebc6a` refactor(structure): migrate ocs app and archive legacy web paths
- `6c068d0` fix(installer): avoid false handoff short-circuit in ps5
- `84f07c3` fix(installer): keep terminal open after pwsh handoff
- `450be68` fix(installer): persist bun path and improve access-denied flow
- `0bb5631` fix(installer): add resilient token and gh dependency fallbacks
- `c91d2a9` feat(installer): enhance auth flow with gh CLI auto-login (feat-6164)
- `724ecb8` chore(test): add powershell linting utility
- `2cc362b` chore(assets): remove deprecated dark mode section assets
- `6c59e57` docs(quickstart): sync indonesian guide with recent changes [feat-6164]
- `9c6734a` fix(installer): rewrite powershell plugin installer for syntax stability
- `26e94ef` docs(quickstart): sync english guide with indonesian updates [feat-6164]
- `90cdb91` docs(quickstart): update Google Cloud API enablement flow (feat-6164)
- `aad33bf` docs(quickstart): update recommended tool to OpenCode Web UI
- `4c1d3d3` fix(api): refactor pakasir webhook logic and update tests
- `150b9c3` fix(api): add graceful error handling for missing env vars in create-order
- `3e1bc9d` fix(test): resolve syntax errors and cleanup orphaned blocks in pakasir tests (feat-6164)
- `5639587` fix(ui): remove duplicated button layouts in hero and cta (feat-6164)
- `2dc425d` fix(api): cleanup unused test cases in pakasir webhook tests
- `0fbaee5` fix(ui): improve contrast for badges and primary buttons (feat-6164)
- `53ff07b` fix(api): refactor pakasir webhook and update tests
- `d66d6c9` fix(ocs): improve checkout form validation and logic
- `ed652f2` fix(ocs): update page components for tailwind compatibility
- `0ecce41` fix(ocs): refine web redesign layout and spacing
- `6bdd9d5` fix(ui): resolve tailwind v4 dark mode class conflicts
- `67c1520` feat(ocs): add modular validation and DB-backed rate limiter
- `7e9ef1c` feat(ocs): implement web redesign and admin dashboard (feat-6164)
- `a63aa6a` chore(test): update root vitest workspace
- `6a7fea3` chore(test): configure vitest for ocs and plugin compatibility
- `b0969ba` test(ocs): add integration tests for auth and webhooks (feat-6164)
- `1c96f64` feat(ocs): close distribution architecture gaps (feat-6164)
- `9be294e` docs: add distribution-architecture.md for paid member delivery system
- `3f4ad02` fix(build): switch plugin build from bun build to tsc
- `4ec8bb2` fix(config): remove @latest tag from opencode-multi-auth plugin ref
- `fd48a13` feat(build): add bun prod build pipeline + release packager + SolidJS order portal
- `d729f39` feat(web): rebuild order portal with SolidJS + TailwindCSS v4, Pakasir QRIS integration
- `f4d44a9` chore(test): fix vitest workspace to scope only plugin tests, exclude bun cache
- `7fdca77` chore(test): setup vitest workspace at root for paired 1:1 test coverage
- `73046e9` feat: add opencode-multi-auth as internal plugin, replace opencode-ag-auth dep
- `a585ace` chore: initial setup from andyvand-opencode-config
<!-- OCS_COMMIT_COVERAGE_END -->

## [2.1.15] - 2026-04-03

### Fixed

- Hardened OpenAI refresh behavior with a CodexSess-like `openai_refresh_mode` (`hybrid`/`on-demand`) so OpenAI can run request-path refresh only while preserving terminal `invalid_grant` re-auth semantics.
- Added regression coverage for invalid `OPENCODE_ANTIGRAVITY_OPENAI_REFRESH_MODE` env fallback and queue-start gating to ensure OpenAI `on-demand` skips proactive queue initialization while non-OpenAI stores keep existing proactive behavior.
- Aligned staging lane defaults/examples to `staging/v2.1.15` across source package versions and installer-facing branch/version references for source/buyer/installer parity.

### Automated Release Summary

<!-- OCS_AUTO_SUMMARY_START -->

- Commit window: `HEAD`
- Added: 62
- Fixed: 98
- Changed: 13
- Docs: 63
- Chore/Build/CI: 44
- Other: 2
<!-- OCS_AUTO_SUMMARY_END -->

### Commit Coverage (auto-generated)

<!-- OCS_COMMIT_COVERAGE_START -->

- `2a87536` docs(changelog): auto-sync v2.1.15 commit coverage
- `339f7e9` docs(changelog): auto-sync v2.1.15 commit coverage
- `8ca8570` fix(staging): harden openai on-demand refresh and align v2.1.15 lanes
- `477eb56` docs(changelog): auto-sync v2.1.14 commit coverage
- `2885974` fix(plugin): add lockfile no-op fallback for runtime interop
- `fba969e` docs(changelog): auto-sync v2.1.14 commit coverage
- `9cdcb13` fix(plugin): normalize proper-lockfile interop for account toggles
- `f0aaca0` docs(changelog): auto-sync v2.1.14 commit coverage
- `a47302b` fix(plugin): prevent proper-lockfile import crash in runtime
- `ede70bb` docs(changelog): auto-sync v2.1.14 commit coverage
- `228f712` fix(installer): align v2.1.14 bundle versions and auth plugin precedence
- `f3e9330` docs(changelog): auto-sync v2.1.14 commit coverage
- `426ab66` fix(staging): align installer lane to v2.1.14 and harden openai auth flow
- `48bc2b7` docs(changelog): auto-sync v2.1.14 commit coverage
- `be35ff0` docs(installer): add v2.1.14 release notes template
- `4c61215` docs(changelog): auto-sync v2.1.14 commit coverage
- `c4afaeb` fix(auth): restore manage/check flows and schema-safe credential restore
- `6d3a6dd` docs(changelog): auto-sync v2.1.13 commit coverage
- `f12e504` fix(release): enforce fresh multi-auth bundle and runtime credential safety
- `18572af` fix(setup): preserve runtime API credentials on reinstall
- `af37a05` docs(changelog): auto-sync v2.1.13 commit coverage
- `5450c77` feat(setup): align MCP defaults and profile parity for staging
- `08459e2` docs(changelog): record OCS skills sync rollout
- `a7d7834` docs(skills): establish OCS skills governance model
- `3b1fdd8` fix(installer): preserve hidden bundle directories
- `654fd76` feat(skills): add managed OCS skills sync pipeline
- `872bd0f` docs(rules): mandate tarball integrity SOP
- `651a1ea` feat(release): enforce provenance and parity guardrails
- `89f3e83` docs(changelog): record openai menu activation fix
- `8c80c82` fix(setup): use loader-safe local plugin specs
- `455dfd1` feat(release): bundle openai auth wrapper plugin
- `8015f85` docs(changelog): record realtime quota check behavior
- `34475b4` fix(quota): force realtime openai check output
- `2a6ca9b` docs(changelog): record exa schema compatibility fix
- `aa38bb9` fix(exa): enforce schema-safe setup output
- `97f9a56` fix(mcp): normalize exa header schema tokens
- `8bd44c1` docs(changelog): document installer lane resolution fix
- `3e1442a` fix(installer): infer source lane and align fallback branch
- `dd2bce8` docs(readme): align staging installer URLs to v2.1.13
- `487a608` docs(release): record v2.1.13 exa parity updates
- `142159f` docs(installer): expand exa onboarding and changelog continuity
- `38afc57` feat(cli): add exa setup and check commands
- `7c047ea` feat(mcp): add exa wiring and setup utility
- `5078492` docs(release): document multi-lane orchestration flow
- `891fac0` feat(release): add lane orchestration command
- `e237102` feat(installer): support explicit target branch sync
- `bd57d49` docs(release): complete v2.1.13 changelog coverage
- `c47938e` feat(openai): add accounts sanity-check command and docs
- `b1d0b18` fix(openai): persist rotated auth and clarify refresh failures
- `d2f0cb5` docs(security): enforce openai auth-state safety boundaries
- `4b41f36` docs(release): record latest openai patch notes in v2.1.13
- `52f3785` fix(openai): prevent add-account overwrite across identities
- `68917fd` fix(openai): strip unsupported codex output-token params
- `cc65969` docs(release): restore 2.1.12-2.1.5 changelog continuity
- `8a7341a` feat(staging): cut v2.1.13 with configurable openai buffer
- `65d1ffc` fix(plugin): route session auth requests through codex surface
- `8f1e361` fix(plugin): stabilize openai post-login refresh state
- `1b338a4` fix(plugin): re-enable openai account after reauth
- `63cd15d` fix(plugin): surface concrete openai auth-unavailable reasons
- `b2fd07d` fix(openai): inject codex instructions for web ui requests
- `6c38af1` fix(plugin): harden openai oauth fallback and switch policy
- `d11219f` chore(release): restore suite version to 2.1.12
- `f3c0606` fix(setup): prevent plugin self-delete during installer mode
- `0289d17` docs(staging): add v2.1.12 e2e checklist and tidy plugin changelog
- `0b26f6f` docs(plugin): restore full 2.1.11-2.1.4 changelog chain
- `2b578b2` chore(plugin): sync changelog to v2.1.12 parity
- `87c1700` fix(app): stabilize staging diagnostics and API test placement
- `98b22cd` merge(chore): integrate remaining f75f release fixes into main
- `e9efb4f` merge(feat): integrate ecf4 latest implementation into main
- `bb07338` fix(plugin): avoid ambiguous OpenAI account upsert collisions
- `6e0e86b` chore(repo): remove oc-chatgpt reference mirror
- `b07f899` chore(plugin): align package version to 2.1.12
- `4240cd0` feat(plugin): tighten quota refresh defaults and ttl bounds
- `43da28a` feat(plugin): harden OpenAI multi-account parity flow
- `95653c3` fix(testing): stabilize feat-ecf4 gate validation lanes
- `a9ebb83` chore(flowcrate): capture batch-3 commit continuity sha
- `10d0047` feat(flowcrate): execute feat-ecf4 release-handoff evidence runbook
- `e907394` chore(tmp): add local workspace and runtime snapshots
- `411d734` chore(meta): track sisyphus planning and continuation state
- `0a095f1` feat(plugin): strengthen streaming transformer event handling
- `e5d81ca` feat(plugin): refine auth menu selection and ansi rendering
- `33874a7` feat(plugin): harden quota fallback and refresh queue logic
- `c21416b` test(plugin): expand openai provider and probe coverage
- `b5bb369` feat(plugin): improve account lifecycle and auth state handling
- `f2f7d70` feat(plugin): sync setup flow and schema documentation
- `9de30eb` chore(config): update root tooling and profile configuration
- `746820f` docs(landing): refresh docs and marketing content
- `d70d4c2` test(plugin): add probe and refresh hardening suites
- `a22b89a` test(plugin): cover thinking recovery regression boundaries
- `adfbc1f` test(resilience): add deterministic invariant hardening sweeps
- `3b8c73e` chore(plugin): remove orphaned opencode-openai-auth package
- `3439a4c` test(plugin): add resilience decomposition and orchestration coverage
- `0de23d8` feat(plugin): decompose resilience orchestration into focused modules
- `7e00291` test(plugin): stabilize audit and storage verification tests
- `adc0bba` feat(plugin): wire runtime audit emitter and tests
- `2e5dd3a` feat(plugin): emit audit events in auto-update checker
- `d07c603` feat(plugin): add audit sinks for logger and debug
- `26d829e` feat(plugin): add audit config and env controls
- `6ef1c89` test(plugin): add phase0 fixture guardrails baseline
- `1ec1430` docs(installer): sync templates and changelog to 2.1.3
- `e5426d7` docs(installer): bump root install examples to 2.1.3
- `a4d042f` docs(installer): enforce pwsh install command on Windows
- `4dc0298` feat(plugin): probe openai session quota with usage fallback
- `45431e1` feat(plugin): add openai login method menu actions
- `32c7ac4` fix(plugin): harden openai oauth callback listener flow
- `c8e8f1b` chore(release): align beta with 2.1.3 release line
- `4d69b80` docs(release): align package publish instructions
- `5bfeefd` docs(release): update buyer beta publish guidance
- `21fce31` chore(installer): sync LF enforcement and public installer docs
- `e196ce0` fix(installer): harden shell bootstrap and oauth guard
- `1a44dd2` fix(setup): refresh bundled multi-auth staging
- `ccd9250` fix(setup): stabilize local plugin tarball packing
- `9728fa7` feat(plugin): persist openai identity metadata
- `c43c984` feat(plugin): add openai browser and headless auth
- `18bed6d` feat(plugin): finish openai account lifecycle parity
- `f32d1be` fix(plugin): store openai accounts separately
- `a2105d5` feat(plugin): add openai auth wrapper package
- `4fe308b` fix(setup): load plugin-owned openai auth wrapper
- `867c85d` chore(installer): sync public installer templates for 2.1.3
- `d44fd6a` docs(installer): sync install guides to 2.1.3
- `7fefcc1` docs(release): add 2.1.3 oauth visibility notes
- `86a913b` chore(release): bump suite and plugin to 2.1.3
- `2396b81` fix(setup): prefer bundled package fallback for multi-auth
- `b6537f7` fix(installer): align auto setup defaults with installer profile
- `72c20e7` feat(plugin): add openai account menu parity
- `a683f96` fix(release): track antigravity backup template for clean packaging
- `831f8b7` chore(installer): sync public installer templates to 2.1.2
- `26235e6` docs(installer): sync version examples to 2.1.2
- `96054d6` docs(release): add 2.1.2 release notes
- `7ab0e64` chore(release): bump suite and plugin to 2.1.2
- `2e8258f` docs(plugin): document codex multi-auth runtime path
- `faf27ab` feat(plugin): add codex session safety guards
- `a37fe57` feat(plugin): add openai provider routing primitives
- `c28ddf7` feat(plugin): add codex shared-core account state
- `cf0e5c4` chore(installer): restore public installer sync inputs
- `8678464` fix(installer): restore source installer scripts in main repo
- `67f708e` docs(plugin): add 2.1.1 changelog entry
- `8b42615` fix(setup): pin oauth-compatible plugin stack at deploy time
- `092d4a8` docs(quick-start): add version-pin install examples in Indonesian guide
- `d02e899` chore(release): bump suite and plugin version to 2.1.0
- `3614c23` docs(installer): update public installer copy for 2.1.0
- `5a71b0c` chore(runtime): update default GPT-5.4 stack and plugin channels
- `6c25a37` docs(models): add pass-model mapping and GPT-5.4 notes
- `c9968e8` feat(config): add hephaestus to codex 5.4 profiles
- `fd8c41b` docs(troubleshooting): add doctor and path recovery guidance
- `460b6f7` feat(cli): add ocs doctor and docs for version pin
- `b576270` fix(setup): fallback invalid resource mode and document version pin
- `ddb4148` chore(release): bump suite and plugin to 2.0.15
- `e6154d7` fix(installer): restore README copywriting and CTA
- `1ee818e` docs(release): announce gpt-5.4 setup profiles
- `04c6b47` feat(profile): add codex-5.4 setup profiles
- `b9ef079` fix(release): enforce suite artifact naming and v2.0.14 changelog
- `ee4775f` fix(release): keep installer template bundle naming in sync
- `a29203c` chore(release): cut v2.0.14 and align installer topology
- `17bf768` fix(installer): resolve suite bundle names in shell and powershell
- `8215fbb` fix(installer): resolve suite bundle names in shell and powershell
- `1f91073` chore(repo): ignore local release clone workdirs
- `900ceb6` chore(repo): ignore local release clone workdirs
- `0eeec4d` fix(installer): prefer https auth flow and beta semver labels
- `78537cb` fix(installer): prefer https auth flow and beta semver labels
- `2348bd5` docs(release): add v2.0.13 changelog entries
- `3ae10de` fix(installer): use OAuth-first auth and quiet installer setup logs
- `72e5708` chore(repo): checkpoint pending docs, scripts, and flowcrate updates before refactor-4b3f
- `80030cc` fix(auth): restore google oauth flow after reinstall
- `021d1b7` fix(installer): enforce oauth guard across plugin reinstall paths
- `05ea6fb` chore(release): cut v2.0.10 with latest auth/setup fixes
- `401f3c6` chore(release): bump v2.0.9 metadata and add missing v2.0.8 notes
- `b59a7ff` fix(installer): repair ocs shim and enforce auth guard after setup
- `67d3306` fix(setup): harden multi-auth resolution and enforce oauth guard
- `601163d` docs(readme): expose v2.0.8 changes and patched legacy issues
- `fc0f2f2` fix(release): sync root README to releases repo
- `454c945` fix(release): sync full docs to releases repository
- `6c540eb` chore(release): bump plugin version to v2.0.8
- `d411430` fix(release): handle untracked managed paths in repo sync
- `c8850d3` docs: align web-ui guidance and relocate developer docs
- `425f877` chore(release): remove legacy root checksum artifact
- `52b63b5` feat(release): add managed sync pipeline and artifact layout
- `d49a7bf` fix(plugin): harden account persistence on storage load errors
- `0f33118` docs(changelog): add v2.0.7 root release notes
- `5657d6f` chore(release): bump plugin to v2.0.7 and refresh checksums
- `77a9ff5` docs(plugin): add preset selection guide and 5-minute checklist
- `efe0619` test(plugin): cover dynamic routing modes and capability behavior
- `d66a25c` feat(plugin): add dynamic cli-first routing and capability-aware fallback
- `020a85d` fix(installer): keep hybrid auto-setup and simplify next steps
- `21c080c` fix(setup): self-heal bun global duplicate lock corruption
- `544b206` fix(prefs): harden schema loading and restore gemini oauth hybrid flow
- `a734cf3` fix(release): restore antigravity oauth login in installer deployments
- `f0ee9c9` chore(release): cut v2.0.3 with setup CLI fix
- `d838837` fix(cli): restore interactive setup default and add update aliases
- `172c993` fix(installer): enforce bun-only dependency retries
- `7878958` chore(release): finalize 2.0.2 changelog metadata
- `ebd5c79` chore(changelog): finalize released sections
- `2e9a5b9` build(release): include changelogs in bundled artifacts
- `da47524` chore(release): finalize 2.0.1 notes and metadata
- `03d72b7` refactor(plugin): remove manual verify-account menu flow
- `32354da` docs(plugin): record unreleased wave-2 commit trail
- `cbdfa6e` feat(plugin): enforce status floors in cooldown backoff
- `3ff6130` feat(plugin): add adaptive 5xx retry and switching path
- `81a00b9` feat(plugin): add 401 escalation and 404 cooldown routing
- `b1a451b` feat(plugin): harden storage migration and save coordination
- `7ab7e15` feat(plugin): add rest-until-full soft quota lock flow
- `0362157` feat(plugin): normalize model-family cooldown lock keys
- `42fc708` test(plugin): add 429 dedup storm coverage
- `f510011` feat(plugin): extend cooldown duration fallback parsing
- `96302de` feat(plugin): harden phase-1 retry and quota classification
- `b25c385` feat(plugin): add phase-0 policy rollout guardrails
- `120c6a9` docs(prefs): document strict validation apply behavior
- `dae1057` feat(prefs): enforce strict schema validation in wizard
- `1d5800a` fix(release): make bundle copy reliable on Windows
- `b92e68e` fix(installer): enforce bun-only ocs shims and stable install path
- `bc984f7` fix(installer): make ocs bootstrap deterministic on Windows
- `e9693b3` feat(release): automate installer sync and private ocs bootstrap
- `2cc68f4` fix(installer): auto-repair ocs command on Windows
- `c4049b5` fix(release): publish checksum asset with tarball
- `4db11f3` chore(gitignore): ignore local antigravity config file
- `a66fbe3` chore(release): prepare v2 changelog and plugin version
- `1d9e448` docs(scripts): document antigravity fallback behavior
- `2b49027` fix(setup): seed antigravity config from template fallback
- `19fef61` feat(landing): refresh hero section and add hero lab page
- `5cc69bc` docs(multi-auth): add sonnet opus 400 vs 403 triage playbook
- `a3f3d9b` test(multi-auth): add regression coverage for sonnet opus payload edges
- `de9553f` fix(multi-auth): harden claude payload normalization and thinking guards
- `ad3ed96` feat(cli): add global ocs dispatcher and prefs wizard
- `3904771` feat(multi-auth): align CLI quota fallback and image model routing
- `aedcabb` feat(setup): default to hybrid profile and performance mode
- `ee0a386` docs(installer): standardize pwsh cache-buster command
- `33dda63` feat(branding): add final pro hybrid logo system
- `d1ccf00` fix(installer): default to codex hybrid performance
- `7c7ba91` chore(installer): refine next-steps guidance text
- `28c9458` fix(installer): enforce bun-only dependency retries
- `11a42b9` fix(installer): harden dependency install retries and fallback
- `d886420` fix(installer): resolve relative plugin path during bun install
- `b7d8513` fix(installer): continue in current shell when pwsh relaunch fails
- `5d0e2a7` fix(installer): harden ps7 relaunch and bun retry diagnostics
- `1246c2c` fix(installer): normalize COMSPEC before setup execution
- `608e71c` fix(installer): avoid false local-source detection and use plugin setup path
- `b001538` fix(installer): prefer system tar.exe and normalize extraction paths
- `709b036` fix(installer): make windows tar extraction fail-fast and compatible
- `2a21f68` fix(installer): prevent token output pollution and enforce access gate
- `3770ae3` feat(plugin): add profile configs and stabilize plugin test scaffolding
- `8923a8b` chore(runtime): update setup flow and archive legacy cli entry
- `77bc2e0` docs: organize guidance and repository workflow references
- `61798eb` docs(workflow): clarify multi-remote push model and ignore noise
- `46ebc6a` refactor(structure): migrate ocs app and archive legacy web paths
- `6c068d0` fix(installer): avoid false handoff short-circuit in ps5
- `84f07c3` fix(installer): keep terminal open after pwsh handoff
- `450be68` fix(installer): persist bun path and improve access-denied flow
- `0bb5631` fix(installer): add resilient token and gh dependency fallbacks
- `c91d2a9` feat(installer): enhance auth flow with gh CLI auto-login (feat-6164)
- `724ecb8` chore(test): add powershell linting utility
- `2cc362b` chore(assets): remove deprecated dark mode section assets
- `6c59e57` docs(quickstart): sync indonesian guide with recent changes [feat-6164]
- `9c6734a` fix(installer): rewrite powershell plugin installer for syntax stability
- `26e94ef` docs(quickstart): sync english guide with indonesian updates [feat-6164]
- `90cdb91` docs(quickstart): update Google Cloud API enablement flow (feat-6164)
- `aad33bf` docs(quickstart): update recommended tool to OpenCode Web UI
- `4c1d3d3` fix(api): refactor pakasir webhook logic and update tests
- `150b9c3` fix(api): add graceful error handling for missing env vars in create-order
- `3e1bc9d` fix(test): resolve syntax errors and cleanup orphaned blocks in pakasir tests (feat-6164)
- `5639587` fix(ui): remove duplicated button layouts in hero and cta (feat-6164)
- `2dc425d` fix(api): cleanup unused test cases in pakasir webhook tests
- `0fbaee5` fix(ui): improve contrast for badges and primary buttons (feat-6164)
- `53ff07b` fix(api): refactor pakasir webhook and update tests
- `d66d6c9` fix(ocs): improve checkout form validation and logic
- `ed652f2` fix(ocs): update page components for tailwind compatibility
- `0ecce41` fix(ocs): refine web redesign layout and spacing
- `6bdd9d5` fix(ui): resolve tailwind v4 dark mode class conflicts
- `67c1520` feat(ocs): add modular validation and DB-backed rate limiter
- `7e9ef1c` feat(ocs): implement web redesign and admin dashboard (feat-6164)
- `a63aa6a` chore(test): update root vitest workspace
- `6a7fea3` chore(test): configure vitest for ocs and plugin compatibility
- `b0969ba` test(ocs): add integration tests for auth and webhooks (feat-6164)
- `1c96f64` feat(ocs): close distribution architecture gaps (feat-6164)
- `9be294e` docs: add distribution-architecture.md for paid member delivery system
- `3f4ad02` fix(build): switch plugin build from bun build to tsc
- `4ec8bb2` fix(config): remove @latest tag from opencode-multi-auth plugin ref
- `fd48a13` feat(build): add bun prod build pipeline + release packager + SolidJS order portal
- `d729f39` feat(web): rebuild order portal with SolidJS + TailwindCSS v4, Pakasir QRIS integration
- `f4d44a9` chore(test): fix vitest workspace to scope only plugin tests, exclude bun cache
- `7fdca77` chore(test): setup vitest workspace at root for paired 1:1 test coverage
- `73046e9` feat: add opencode-multi-auth as internal plugin, replace opencode-ag-auth dep
- `a585ace` chore: initial setup from andyvand-opencode-config
<!-- OCS_COMMIT_COVERAGE_END -->

## [2.1.14] - 2026-04-02

### Fixed

- Fixed setup credential-restore shape so provider runtime secrets are migrated into `provider.<name>.options.*` instead of invalid top-level keys, preserving EXA/z.ai/custom API credentials across reinstall without triggering schema errors.
- Fixed OpenAI non-TTY auth fallback to include `Manage accounts` and `Check quotas` actions (not add-only), restoring multi-account operational parity in terminal/session-capture flows.
- Fixed release/prebuild safety by hard-failing packaging when built auth payload is missing `Manage accounts` marker or wrapper wiring to `../opencode-multi-auth/dist/index.js` is broken.
- Fixed OpenAI authorize flow to force menu-capable runtime path even when host surfaces call authorize without CLI inputs, preventing silent fallback to add-only behavior.
- Fixed installer branch hints/docs to align default staging lane references and quick-install examples to `staging/v2.1.14`.
- Fixed setup plugin rewrite order to register bundled `opencode-multi-auth` and `opencode-openai-auth` after dependency plugins, ensuring local OpenAI multi-account provider takes precedence at runtime.
- Fixed plugin package metadata versions (`opencode-multi-auth`, `opencode-openai-auth`) to `2.1.14`, aligning installer/setup runtime banners with staged tarball version.
- Fixed WSL/runtime plugin loading regression by adding resilient `proper-lockfile` interop normalization (supports both namespace/default export shapes) in multi-auth storage/audit modules, preventing `lockfile.lock is not a function` crashes in Manage-account enable/disable flow.
- Fixed OpenCode-loader edge-case where unresolved `proper-lockfile` export shape could abort plugin initialization by adding safe no-op lock fallback with explicit warning, keeping OpenAI wrapper/menu runtime available.

### Changed

- Tightened OCS runtime/release rulesets and skillsets to enforce WSL reinstall credential-persistence proof, account-storage non-touch guarantees, and explicit Manage-accounts runtime evidence before release sign-off.

### Automated Release Summary

<!-- OCS_AUTO_SUMMARY_START -->

- Commit window: `v2.1.13..HEAD`
- Added: 1
- Fixed: 8
- Changed: 0
- Docs: 9
- Chore/Build/CI: 0
- Other: 0
<!-- OCS_AUTO_SUMMARY_END -->

### Commit Coverage (auto-generated)

<!-- OCS_COMMIT_COVERAGE_START -->

- `2885974` fix(plugin): add lockfile no-op fallback for runtime interop
- `fba969e` docs(changelog): auto-sync v2.1.14 commit coverage
- `9cdcb13` fix(plugin): normalize proper-lockfile interop for account toggles
- `f0aaca0` docs(changelog): auto-sync v2.1.14 commit coverage
- `a47302b` fix(plugin): prevent proper-lockfile import crash in runtime
- `ede70bb` docs(changelog): auto-sync v2.1.14 commit coverage
- `228f712` fix(installer): align v2.1.14 bundle versions and auth plugin precedence
- `f3e9330` docs(changelog): auto-sync v2.1.14 commit coverage
- `426ab66` fix(staging): align installer lane to v2.1.14 and harden openai auth flow
- `48bc2b7` docs(changelog): auto-sync v2.1.14 commit coverage
- `be35ff0` docs(installer): add v2.1.14 release notes template
- `4c61215` docs(changelog): auto-sync v2.1.14 commit coverage
- `c4afaeb` fix(auth): restore manage/check flows and schema-safe credential restore
- `6d3a6dd` docs(changelog): auto-sync v2.1.13 commit coverage
- `f12e504` fix(release): enforce fresh multi-auth bundle and runtime credential safety
- `18572af` fix(setup): preserve runtime API credentials on reinstall
- `af37a05` docs(changelog): auto-sync v2.1.13 commit coverage
- `5450c77` feat(setup): align MCP defaults and profile parity for staging
<!-- OCS_COMMIT_COVERAGE_END -->

## [2.1.13] - 2026-03-30

### Added

- Officially released `opencode-multi-auth` for ChatGPT multi-account usage on the staging `v2.1.13` lane, including account rotation, session reliability hardening, and runtime fallback protections.
- Added configurable OpenAI quota buffer via `openai_quota_buffer_percent` across schema, env override loading, prefs wiring, and docs.
- Added pre-runtime OpenAI account sanity validation script (`sanity:openai-accounts`) to detect malformed payloads, token collisions, and risky duplicate identity/email states before runtime.
- Activated EXA MCP wiring on the `v2.1.13` staging lane (`mcp.exa` in root + plugin config) with schema-compatible `"{env:EXA_API_KEY}"` header token mapping.
- Added `ocs exa setup` / `ocs exa check` command routes (including `exa:setup` and `exa:check` aliases) plus new runtime helper `scripts/exa-setup.js` for MCP setup/health validation.

### Fixed

- Stabilized OpenAI session-auth runtime on staging by improving post-login auth state reliability and session-safe codex routing behavior.
- Stripped unsupported Codex output-token request fields (`max_output_tokens` / `maxOutputTokens`) on OpenAI session-codex paths to prevent `Bad Request` failures.
- Prevented OpenAI multi-account add-flow overwrite across distinct identities by enforcing strict identity+email match guards (including no identity-merge when either email is missing).
- Persisted OpenAI auth refresh updates to disk immediately after in-memory credential rotation, preventing lost refresh-token updates during runtime.
- Improved OpenAI refresh-failure diagnostics by parsing nested error payloads and surfacing explicit `refresh_token_reused` guidance for re-authentication.
- Improved OpenAI quota reset UX by rendering reset time in local timezone with a human-friendly remaining-duration suffix.
- Updated OpenAI quota check output to be realtime-only (no cached quota fallback in check display) and to always show forward-looking remaining duration (`in Xh Ym`) instead of `resetting now`.
- Restored OpenAI multi-account auth menu activation on staging installs by packaging `opencode-openai-auth` wrapper into release artifacts and switching setup plugin spec rewrite to loader-safe local `file://` plugin directory URLs.
- Fixed installer extraction copy logic to include hidden bundle directories (notably `.opencode/skills`), restoring OCS skill sync into `~/.config/opencode/skills` during setup.
- Fixed staging installer lane routing so `curl .../staging/v2.1.13/install.sh | bash` resolves the staging bundle branch by default instead of silently falling back to beta.
- Fixed Windows installer relaunch behavior to reuse the active installer source branch (not hardcoded `main`) and keep branch/fallback logs explicit.
- Fixed EXA MCP config validation failures (`Invalid input mcp.exa`) by enforcing string-only remote header values and removing non-portable EXA oauth config emission in setup/defaults.
- Fixed reinstall profile deploy flow to preserve user runtime API credentials (including EXA and custom provider keys such as z.ai) from existing `~/.config/opencode/opencode.json` while still applying latest bundled defaults; account storage files remain untouched.
- Fixed bundled multi-auth source resolution during setup so installer-mode runs prefer the freshly bundled root `dist/index.js` when target plugin path would otherwise self-resolve and skip refresh.
- Fixed release prebuild safety by enforcing a hard guard that fails packaging when `Manage accounts` is missing from built auth-menu payload or when `opencode-openai-auth` wrapper is not wired to `../opencode-multi-auth/dist/index.js`.
- Fixed runtime provider credential restore shape to migrate top-level provider secrets (`apiKey`/`baseURL` and related credential keys) into `provider.<name>.options.*`, preventing `opencode auth login` schema failures on reinstall while preserving EXA/z.ai/custom API credentials.
- Fixed non-TTY OpenAI auth fallback menu to expose both `Manage accounts` and `Check quotas` actions (not add-only), restoring multi-account operational parity in terminal/session capture environments.

### Changed

- Prepared a new dedicated staging release wave `v2.1.13` for integrated multi-auth hardening and buffer configurability.
- Added explicit security ruleset guidance: never restore stale `openai-accounts.json` snapshots and never share OpenAI token state across Windows and WSL for the same account.
- Added lane-aware release orchestration for `dev` / `staging` / `beta` / `final` with one command path to sync source, buyer, and installer lanes (including branch-targeted installer sync, artifact sync, and release tag/note publishing flow).
- Updated release packaging to include `scripts/exa-setup.js` in suite artifacts and refreshed installer onboarding text (README/install scripts) with EXA setup/check and MCP verification guidance.
- Tightened OCS release/runtime rulesets and skillsets to require pre-release multi-auth dist validation, WSL reinstall credential persistence checks (EXA/custom APIs), and explicit OpenAI `Manage accounts` runtime evidence.

### Automated Release Summary

<!-- OCS_AUTO_SUMMARY_START -->

- Commit window: `HEAD`
- Added: 62
- Fixed: 91
- Changed: 13
- Docs: 52
- Chore/Build/CI: 44
- Other: 2
<!-- OCS_AUTO_SUMMARY_END -->

### Commit Coverage (auto-generated)

<!-- OCS_COMMIT_COVERAGE_START -->

- `f12e504` fix(release): enforce fresh multi-auth bundle and runtime credential safety
- `18572af` fix(setup): preserve runtime API credentials on reinstall
- `af37a05` docs(changelog): auto-sync v2.1.13 commit coverage
- `5450c77` feat(setup): align MCP defaults and profile parity for staging
- `08459e2` docs(changelog): record OCS skills sync rollout
- `a7d7834` docs(skills): establish OCS skills governance model
- `3b1fdd8` fix(installer): preserve hidden bundle directories
- `654fd76` feat(skills): add managed OCS skills sync pipeline
- `872bd0f` docs(rules): mandate tarball integrity SOP
- `651a1ea` feat(release): enforce provenance and parity guardrails
- `89f3e83` docs(changelog): record openai menu activation fix
- `8c80c82` fix(setup): use loader-safe local plugin specs
- `455dfd1` feat(release): bundle openai auth wrapper plugin
- `8015f85` docs(changelog): record realtime quota check behavior
- `34475b4` fix(quota): force realtime openai check output
- `2a6ca9b` docs(changelog): record exa schema compatibility fix
- `aa38bb9` fix(exa): enforce schema-safe setup output
- `97f9a56` fix(mcp): normalize exa header schema tokens
- `8bd44c1` docs(changelog): document installer lane resolution fix
- `3e1442a` fix(installer): infer source lane and align fallback branch
- `dd2bce8` docs(readme): align staging installer URLs to v2.1.13
- `487a608` docs(release): record v2.1.13 exa parity updates
- `142159f` docs(installer): expand exa onboarding and changelog continuity
- `38afc57` feat(cli): add exa setup and check commands
- `7c047ea` feat(mcp): add exa wiring and setup utility
- `5078492` docs(release): document multi-lane orchestration flow
- `891fac0` feat(release): add lane orchestration command
- `e237102` feat(installer): support explicit target branch sync
- `bd57d49` docs(release): complete v2.1.13 changelog coverage
- `c47938e` feat(openai): add accounts sanity-check command and docs
- `b1d0b18` fix(openai): persist rotated auth and clarify refresh failures
- `d2f0cb5` docs(security): enforce openai auth-state safety boundaries
- `4b41f36` docs(release): record latest openai patch notes in v2.1.13
- `52f3785` fix(openai): prevent add-account overwrite across identities
- `68917fd` fix(openai): strip unsupported codex output-token params
- `cc65969` docs(release): restore 2.1.12-2.1.5 changelog continuity
- `8a7341a` feat(staging): cut v2.1.13 with configurable openai buffer
- `65d1ffc` fix(plugin): route session auth requests through codex surface
- `8f1e361` fix(plugin): stabilize openai post-login refresh state
- `1b338a4` fix(plugin): re-enable openai account after reauth
- `63cd15d` fix(plugin): surface concrete openai auth-unavailable reasons
- `b2fd07d` fix(openai): inject codex instructions for web ui requests
- `6c38af1` fix(plugin): harden openai oauth fallback and switch policy
- `d11219f` chore(release): restore suite version to 2.1.12
- `f3c0606` fix(setup): prevent plugin self-delete during installer mode
- `0289d17` docs(staging): add v2.1.12 e2e checklist and tidy plugin changelog
- `0b26f6f` docs(plugin): restore full 2.1.11-2.1.4 changelog chain
- `2b578b2` chore(plugin): sync changelog to v2.1.12 parity
- `87c1700` fix(app): stabilize staging diagnostics and API test placement
- `98b22cd` merge(chore): integrate remaining f75f release fixes into main
- `e9efb4f` merge(feat): integrate ecf4 latest implementation into main
- `bb07338` fix(plugin): avoid ambiguous OpenAI account upsert collisions
- `6e0e86b` chore(repo): remove oc-chatgpt reference mirror
- `b07f899` chore(plugin): align package version to 2.1.12
- `4240cd0` feat(plugin): tighten quota refresh defaults and ttl bounds
- `43da28a` feat(plugin): harden OpenAI multi-account parity flow
- `95653c3` fix(testing): stabilize feat-ecf4 gate validation lanes
- `a9ebb83` chore(flowcrate): capture batch-3 commit continuity sha
- `10d0047` feat(flowcrate): execute feat-ecf4 release-handoff evidence runbook
- `e907394` chore(tmp): add local workspace and runtime snapshots
- `411d734` chore(meta): track sisyphus planning and continuation state
- `0a095f1` feat(plugin): strengthen streaming transformer event handling
- `e5d81ca` feat(plugin): refine auth menu selection and ansi rendering
- `33874a7` feat(plugin): harden quota fallback and refresh queue logic
- `c21416b` test(plugin): expand openai provider and probe coverage
- `b5bb369` feat(plugin): improve account lifecycle and auth state handling
- `f2f7d70` feat(plugin): sync setup flow and schema documentation
- `9de30eb` chore(config): update root tooling and profile configuration
- `746820f` docs(landing): refresh docs and marketing content
- `d70d4c2` test(plugin): add probe and refresh hardening suites
- `a22b89a` test(plugin): cover thinking recovery regression boundaries
- `adfbc1f` test(resilience): add deterministic invariant hardening sweeps
- `3b8c73e` chore(plugin): remove orphaned opencode-openai-auth package
- `3439a4c` test(plugin): add resilience decomposition and orchestration coverage
- `0de23d8` feat(plugin): decompose resilience orchestration into focused modules
- `7e00291` test(plugin): stabilize audit and storage verification tests
- `adc0bba` feat(plugin): wire runtime audit emitter and tests
- `2e5dd3a` feat(plugin): emit audit events in auto-update checker
- `d07c603` feat(plugin): add audit sinks for logger and debug
- `26d829e` feat(plugin): add audit config and env controls
- `6ef1c89` test(plugin): add phase0 fixture guardrails baseline
- `1ec1430` docs(installer): sync templates and changelog to 2.1.3
- `e5426d7` docs(installer): bump root install examples to 2.1.3
- `a4d042f` docs(installer): enforce pwsh install command on Windows
- `4dc0298` feat(plugin): probe openai session quota with usage fallback
- `45431e1` feat(plugin): add openai login method menu actions
- `32c7ac4` fix(plugin): harden openai oauth callback listener flow
- `c8e8f1b` chore(release): align beta with 2.1.3 release line
- `4d69b80` docs(release): align package publish instructions
- `5bfeefd` docs(release): update buyer beta publish guidance
- `21fce31` chore(installer): sync LF enforcement and public installer docs
- `e196ce0` fix(installer): harden shell bootstrap and oauth guard
- `1a44dd2` fix(setup): refresh bundled multi-auth staging
- `ccd9250` fix(setup): stabilize local plugin tarball packing
- `9728fa7` feat(plugin): persist openai identity metadata
- `c43c984` feat(plugin): add openai browser and headless auth
- `18bed6d` feat(plugin): finish openai account lifecycle parity
- `f32d1be` fix(plugin): store openai accounts separately
- `a2105d5` feat(plugin): add openai auth wrapper package
- `4fe308b` fix(setup): load plugin-owned openai auth wrapper
- `867c85d` chore(installer): sync public installer templates for 2.1.3
- `d44fd6a` docs(installer): sync install guides to 2.1.3
- `7fefcc1` docs(release): add 2.1.3 oauth visibility notes
- `86a913b` chore(release): bump suite and plugin to 2.1.3
- `2396b81` fix(setup): prefer bundled package fallback for multi-auth
- `b6537f7` fix(installer): align auto setup defaults with installer profile
- `72c20e7` feat(plugin): add openai account menu parity
- `a683f96` fix(release): track antigravity backup template for clean packaging
- `831f8b7` chore(installer): sync public installer templates to 2.1.2
- `26235e6` docs(installer): sync version examples to 2.1.2
- `96054d6` docs(release): add 2.1.2 release notes
- `7ab0e64` chore(release): bump suite and plugin to 2.1.2
- `2e8258f` docs(plugin): document codex multi-auth runtime path
- `faf27ab` feat(plugin): add codex session safety guards
- `a37fe57` feat(plugin): add openai provider routing primitives
- `c28ddf7` feat(plugin): add codex shared-core account state
- `cf0e5c4` chore(installer): restore public installer sync inputs
- `8678464` fix(installer): restore source installer scripts in main repo
- `67f708e` docs(plugin): add 2.1.1 changelog entry
- `8b42615` fix(setup): pin oauth-compatible plugin stack at deploy time
- `092d4a8` docs(quick-start): add version-pin install examples in Indonesian guide
- `d02e899` chore(release): bump suite and plugin version to 2.1.0
- `3614c23` docs(installer): update public installer copy for 2.1.0
- `5a71b0c` chore(runtime): update default GPT-5.4 stack and plugin channels
- `6c25a37` docs(models): add pass-model mapping and GPT-5.4 notes
- `c9968e8` feat(config): add hephaestus to codex 5.4 profiles
- `fd8c41b` docs(troubleshooting): add doctor and path recovery guidance
- `460b6f7` feat(cli): add ocs doctor and docs for version pin
- `b576270` fix(setup): fallback invalid resource mode and document version pin
- `ddb4148` chore(release): bump suite and plugin to 2.0.15
- `e6154d7` fix(installer): restore README copywriting and CTA
- `1ee818e` docs(release): announce gpt-5.4 setup profiles
- `04c6b47` feat(profile): add codex-5.4 setup profiles
- `b9ef079` fix(release): enforce suite artifact naming and v2.0.14 changelog
- `ee4775f` fix(release): keep installer template bundle naming in sync
- `a29203c` chore(release): cut v2.0.14 and align installer topology
- `17bf768` fix(installer): resolve suite bundle names in shell and powershell
- `8215fbb` fix(installer): resolve suite bundle names in shell and powershell
- `1f91073` chore(repo): ignore local release clone workdirs
- `900ceb6` chore(repo): ignore local release clone workdirs
- `0eeec4d` fix(installer): prefer https auth flow and beta semver labels
- `78537cb` fix(installer): prefer https auth flow and beta semver labels
- `2348bd5` docs(release): add v2.0.13 changelog entries
- `3ae10de` fix(installer): use OAuth-first auth and quiet installer setup logs
- `72e5708` chore(repo): checkpoint pending docs, scripts, and flowcrate updates before refactor-4b3f
- `80030cc` fix(auth): restore google oauth flow after reinstall
- `021d1b7` fix(installer): enforce oauth guard across plugin reinstall paths
- `05ea6fb` chore(release): cut v2.0.10 with latest auth/setup fixes
- `401f3c6` chore(release): bump v2.0.9 metadata and add missing v2.0.8 notes
- `b59a7ff` fix(installer): repair ocs shim and enforce auth guard after setup
- `67d3306` fix(setup): harden multi-auth resolution and enforce oauth guard
- `601163d` docs(readme): expose v2.0.8 changes and patched legacy issues
- `fc0f2f2` fix(release): sync root README to releases repo
- `454c945` fix(release): sync full docs to releases repository
- `6c540eb` chore(release): bump plugin version to v2.0.8
- `d411430` fix(release): handle untracked managed paths in repo sync
- `c8850d3` docs: align web-ui guidance and relocate developer docs
- `425f877` chore(release): remove legacy root checksum artifact
- `52b63b5` feat(release): add managed sync pipeline and artifact layout
- `d49a7bf` fix(plugin): harden account persistence on storage load errors
- `0f33118` docs(changelog): add v2.0.7 root release notes
- `5657d6f` chore(release): bump plugin to v2.0.7 and refresh checksums
- `77a9ff5` docs(plugin): add preset selection guide and 5-minute checklist
- `efe0619` test(plugin): cover dynamic routing modes and capability behavior
- `d66a25c` feat(plugin): add dynamic cli-first routing and capability-aware fallback
- `020a85d` fix(installer): keep hybrid auto-setup and simplify next steps
- `21c080c` fix(setup): self-heal bun global duplicate lock corruption
- `544b206` fix(prefs): harden schema loading and restore gemini oauth hybrid flow
- `a734cf3` fix(release): restore antigravity oauth login in installer deployments
- `f0ee9c9` chore(release): cut v2.0.3 with setup CLI fix
- `d838837` fix(cli): restore interactive setup default and add update aliases
- `172c993` fix(installer): enforce bun-only dependency retries
- `7878958` chore(release): finalize 2.0.2 changelog metadata
- `ebd5c79` chore(changelog): finalize released sections
- `2e9a5b9` build(release): include changelogs in bundled artifacts
- `da47524` chore(release): finalize 2.0.1 notes and metadata
- `03d72b7` refactor(plugin): remove manual verify-account menu flow
- `32354da` docs(plugin): record unreleased wave-2 commit trail
- `cbdfa6e` feat(plugin): enforce status floors in cooldown backoff
- `3ff6130` feat(plugin): add adaptive 5xx retry and switching path
- `81a00b9` feat(plugin): add 401 escalation and 404 cooldown routing
- `b1a451b` feat(plugin): harden storage migration and save coordination
- `7ab7e15` feat(plugin): add rest-until-full soft quota lock flow
- `0362157` feat(plugin): normalize model-family cooldown lock keys
- `42fc708` test(plugin): add 429 dedup storm coverage
- `f510011` feat(plugin): extend cooldown duration fallback parsing
- `96302de` feat(plugin): harden phase-1 retry and quota classification
- `b25c385` feat(plugin): add phase-0 policy rollout guardrails
- `120c6a9` docs(prefs): document strict validation apply behavior
- `dae1057` feat(prefs): enforce strict schema validation in wizard
- `1d5800a` fix(release): make bundle copy reliable on Windows
- `b92e68e` fix(installer): enforce bun-only ocs shims and stable install path
- `bc984f7` fix(installer): make ocs bootstrap deterministic on Windows
- `e9693b3` feat(release): automate installer sync and private ocs bootstrap
- `2cc68f4` fix(installer): auto-repair ocs command on Windows
- `c4049b5` fix(release): publish checksum asset with tarball
- `4db11f3` chore(gitignore): ignore local antigravity config file
- `a66fbe3` chore(release): prepare v2 changelog and plugin version
- `1d9e448` docs(scripts): document antigravity fallback behavior
- `2b49027` fix(setup): seed antigravity config from template fallback
- `19fef61` feat(landing): refresh hero section and add hero lab page
- `5cc69bc` docs(multi-auth): add sonnet opus 400 vs 403 triage playbook
- `a3f3d9b` test(multi-auth): add regression coverage for sonnet opus payload edges
- `de9553f` fix(multi-auth): harden claude payload normalization and thinking guards
- `ad3ed96` feat(cli): add global ocs dispatcher and prefs wizard
- `3904771` feat(multi-auth): align CLI quota fallback and image model routing
- `aedcabb` feat(setup): default to hybrid profile and performance mode
- `ee0a386` docs(installer): standardize pwsh cache-buster command
- `33dda63` feat(branding): add final pro hybrid logo system
- `d1ccf00` fix(installer): default to codex hybrid performance
- `7c7ba91` chore(installer): refine next-steps guidance text
- `28c9458` fix(installer): enforce bun-only dependency retries
- `11a42b9` fix(installer): harden dependency install retries and fallback
- `d886420` fix(installer): resolve relative plugin path during bun install
- `b7d8513` fix(installer): continue in current shell when pwsh relaunch fails
- `5d0e2a7` fix(installer): harden ps7 relaunch and bun retry diagnostics
- `1246c2c` fix(installer): normalize COMSPEC before setup execution
- `608e71c` fix(installer): avoid false local-source detection and use plugin setup path
- `b001538` fix(installer): prefer system tar.exe and normalize extraction paths
- `709b036` fix(installer): make windows tar extraction fail-fast and compatible
- `2a21f68` fix(installer): prevent token output pollution and enforce access gate
- `3770ae3` feat(plugin): add profile configs and stabilize plugin test scaffolding
- `8923a8b` chore(runtime): update setup flow and archive legacy cli entry
- `77bc2e0` docs: organize guidance and repository workflow references
- `61798eb` docs(workflow): clarify multi-remote push model and ignore noise
- `46ebc6a` refactor(structure): migrate ocs app and archive legacy web paths
- `6c068d0` fix(installer): avoid false handoff short-circuit in ps5
- `84f07c3` fix(installer): keep terminal open after pwsh handoff
- `450be68` fix(installer): persist bun path and improve access-denied flow
- `0bb5631` fix(installer): add resilient token and gh dependency fallbacks
- `c91d2a9` feat(installer): enhance auth flow with gh CLI auto-login (feat-6164)
- `724ecb8` chore(test): add powershell linting utility
- `2cc362b` chore(assets): remove deprecated dark mode section assets
- `6c59e57` docs(quickstart): sync indonesian guide with recent changes [feat-6164]
- `9c6734a` fix(installer): rewrite powershell plugin installer for syntax stability
- `26e94ef` docs(quickstart): sync english guide with indonesian updates [feat-6164]
- `90cdb91` docs(quickstart): update Google Cloud API enablement flow (feat-6164)
- `aad33bf` docs(quickstart): update recommended tool to OpenCode Web UI
- `4c1d3d3` fix(api): refactor pakasir webhook logic and update tests
- `150b9c3` fix(api): add graceful error handling for missing env vars in create-order
- `3e1bc9d` fix(test): resolve syntax errors and cleanup orphaned blocks in pakasir tests (feat-6164)
- `5639587` fix(ui): remove duplicated button layouts in hero and cta (feat-6164)
- `2dc425d` fix(api): cleanup unused test cases in pakasir webhook tests
- `0fbaee5` fix(ui): improve contrast for badges and primary buttons (feat-6164)
- `53ff07b` fix(api): refactor pakasir webhook and update tests
- `d66d6c9` fix(ocs): improve checkout form validation and logic
- `ed652f2` fix(ocs): update page components for tailwind compatibility
- `0ecce41` fix(ocs): refine web redesign layout and spacing
- `6bdd9d5` fix(ui): resolve tailwind v4 dark mode class conflicts
- `67c1520` feat(ocs): add modular validation and DB-backed rate limiter
- `7e9ef1c` feat(ocs): implement web redesign and admin dashboard (feat-6164)
- `a63aa6a` chore(test): update root vitest workspace
- `6a7fea3` chore(test): configure vitest for ocs and plugin compatibility
- `b0969ba` test(ocs): add integration tests for auth and webhooks (feat-6164)
- `1c96f64` feat(ocs): close distribution architecture gaps (feat-6164)
- `9be294e` docs: add distribution-architecture.md for paid member delivery system
- `3f4ad02` fix(build): switch plugin build from bun build to tsc
- `4ec8bb2` fix(config): remove @latest tag from opencode-multi-auth plugin ref
- `fd48a13` feat(build): add bun prod build pipeline + release packager + SolidJS order portal
- `d729f39` feat(web): rebuild order portal with SolidJS + TailwindCSS v4, Pakasir QRIS integration
- `f4d44a9` chore(test): fix vitest workspace to scope only plugin tests, exclude bun cache
- `7fdca77` chore(test): setup vitest workspace at root for paired 1:1 test coverage
- `73046e9` feat: add opencode-multi-auth as internal plugin, replace opencode-ag-auth dep
- `a585ace` chore: initial setup from andyvand-opencode-config
<!-- OCS_COMMIT_COVERAGE_END -->

## [2.1.12] - 2026-03-16

### Fixed

- Repacked `v2.1.12` with multi-auth self-copy guard so setup skips redundant self-copy when bundled plugin source already points to target directory.
- Hardened installer/setup interactive behavior with `/dev/tty`-first fallback handling for safer non-interactive shells and WSL/Linux sessions.

### Changed

- Synced source-facing version examples and release metadata pointers to `2.1.12` so source docs stay aligned with buyer/installer release lanes.

## [2.1.11] - 2026-03-15

### Fixed

- Stabilized EXA onboarding/check flows for staging release usage, including safer MCP timeout handling and token-path fallback behavior.

### Changed

- Migrated default GitHub/Time MCP server wiring to local MCP command routes used by the buyer/installer `v2.1.11` lane.

## [2.1.10] - 2026-03-15

### Added

- Added cross-platform smoke validation scripts and wrappers for post-install verification (Unix, Windows, CI wrappers).

### Changed

- Synced source release lane with buyer/installer `v2.1.10` stabilization and smoke-run governance.

## [2.1.9] - 2026-03-14

### Changed

- Synced release-line continuity between source artifacts and buyer staging metadata for `v2.1.9`.

## [2.1.8] - 2026-03-14

### Fixed

- Hardened setup/auth recovery edges observed during multi-lane staging synchronization.

## [2.1.7] - 2026-03-14

### Changed

- Updated release metadata and docs continuity for staged parity rollout.

## [2.1.6] - 2026-03-14

### Fixed

- Improved auth/setup guard behavior to reduce false-positive breakage during installer-driven staging tests.

## [2.1.5] - 2026-03-14

### Changed

- Established early `2.1.x` staging publication trail used as baseline for the later `2.1.12` and `2.1.13` parity waves.

## [2.1.4] - 2026-03-11

### Added

- Added `codex-5.3-token-saver` profile registration to setup profile catalog and runtime bundle distribution so it is available in `ocs setup profile` and included in release tarballs.

### Changed

- Release packaging now derives suite artifact version from root `package.json`, decoupling suite release numbering from bundled plugin payload version.
- Kept bundled plugin payload pinned to the previously released `2.1.1` artifact-equivalent contents for this release lane (no plugin payload drift).

## [2.1.3] - 2026-03-08

### Fixed

- Updated setup release behavior so generated runtime config no longer falls back to a raw `file:///.../dist/index.js` plugin spec, restoring `OAuth with Google (Antigravity)` visibility on Linux, macOS, and WSL.

### Changed

- Bumped the suite and bundled plugin release line to `2.1.3` so source dev metadata, buyer beta bundle metadata, installer templates, and public release guidance stay synchronized for the plugin fallback hotfix.

## [2.1.2] - 2026-03-08

### Changed

- Bumped the suite and bundled plugin release line to `2.1.2` so source dev, buyer beta bundle metadata, installer templates, and public release guidance all point to the same published version again.
- Added cross-repo version-sync guardrails for source, buyer beta, and public installer lanes so future release examples do not advance independently.

## [2.1.1] - 2026-03-08

### Fixed

- Restored stable `opencode auth login -> Google -> OAuth with Google (Antigravity)` behavior for new installs by pinning the auth-critical plugin stack during setup deployment, while keeping source plugin declarations on `@latest`.
- Added setup-time protection so future install/update flows keep the OAuth-compatible plugin versions even when source config continues tracking latest plugin channels.

### Changed

- Bumped suite and bundled plugin patch release line to `2.1.1`.

## [2.1.0] - 2026-03-07

### Changed

- Corrected semver from `2.0.15` to `2.1.0` because this release adds new GPT-5.4 setup profiles, `ocs doctor`, installer version pinning guidance, and other user-facing minor features.
- Published `2.1.0` as the semver-correct minor release without deleting the existing `2.0.15` beta artifact.

## [2.0.15] - 2026-03-07

> Beta artifact released before semver correction. Feature set is superseded by `2.1.0`.

### Added

- Added new setup profile `gpt-5.4-best-perform` for GPT-5.4 quality-first Codex workflows.
- Added new setup profile `gpt-5.4-token-saver` for GPT-5.4 core + Codex mini worker lanes to reduce token burn.
- Added profile wiring and labels so both profiles appear directly in `ocs setup profile`.
- Added `ocs doctor` mini diagnostics to quickly inspect `bun`, `ocs`, `opencode`, PATH entries, and shim visibility.

### Changed

- Updated installer description template (`scripts/templates/public-installer-README.md`) with GPT-5.4 highlights and best-use guidance for both new profiles.
- Updated user docs (`README.md`, `docs/quick-start-en.md`, `docs/quick-start-id.md`, `docs/deep-dive-profiles.md`) to document use cases, selection flow, and trade-offs for both GPT-5.4 setup options.
- Hardened current Codex token-saver mapping to OAuth-validated fast lane behavior (`openai/gpt-5.1-codex-mini`) for stable runtime compatibility.
- Added installer version-pin guidance for Bash (`--version`) and PowerShell (`OCS_VERSION`).

### Fixed

- `ocs setup profile` no longer aborts on invalid interactive resource mode input; it falls back to the default mode with a warning.
- Hardened Linux installer path persistence so `ocs` and `opencode` remain discoverable more reliably across new shell sessions.

## [2.0.14] - 2026-03-07

### Fixed

- Stabilized `opencode` post-install command detection by enforcing cross-shell PATH activation and lightweight shim-first recovery in installer flows.
- Hardened Linux/WSL GitHub auth and bundle retrieval to avoid false 401 failures when `gh` session authentication is valid.
- Eliminated redundant heavy `opencode` auto-recovery after successful setup to prevent long hang-like post-install behavior.

### Changed

- Bumped suite and plugin release line to `2.0.14`.
- Rebuilt production release artifact as `opencode-config-suites-v2.0.14.tar.gz` and synced buyer beta channel metadata/releases.
- Added release governance and changelog/release-note guardrails in installer repository to keep dev/buyer/installer release narratives aligned.

## [2.0.13] - 2026-03-07

### Fixed

- Hardened shell installer auth/dependency flow to prevent false local-source detection and non-interactive prompt hangs.
- Updated PowerShell auto-setup execution to use direct headless invocation and remove false fallback warnings.

### Changed

- Reduced installer-mode setup log noise by skipping optional/non-blocking checks and downgrading non-fatal warnings to informational logs.
- Synced public-installer source templates (`install-plugin.sh`, `install-plugin.ps1`) with the latest installer fixes.

## [2.0.12] - 2026-03-06

### Fixed

- Restored valid `opencode-multi-auth` plugin source/build artifacts so runtime plugin loading no longer crashes on malformed bundle output.
- Verified OAuth menu visibility in `opencode auth login` for Google provider (`OAuth with Google (Antigravity)` appears again) after setup/reinstall flow.
- Hardened setup/install sync path to keep `google_auth: false` and deploy plugin spec in a format that Bun can install reliably (`opencode-multi-auth@file:C:/...tgz` on Windows).

## [2.0.11] - 2026-03-06

### Fixed

- Patched plugin installer setup path to enforce `google_auth: false` after reinstall, preventing Gemini/Google OAuth options from disappearing.
- Updated plugin setup flow to resolve `opencode-multi-auth` plugin spec as bundled package dependency (`opencode-multi-auth@file:...`) instead of raw `file:///.../dist/index.js` path.
- Reordered plugin setup deployment so bundled payload sync happens before plugin spec rewrite and plugin install, ensuring newest artifact resolution.

## [2.0.10] - 2026-03-06

### Fixed

- Setup now syncs bundled multi-auth payload before rewriting plugin specs, so deployed `opencode.json` always resolves the latest local artifact instead of stale tarball references.
- Multi-auth plugin spec resolution is now artifact-aware with a safe fallback to local bundled directory when tarball packaging is unavailable.
- Strengthened OAuth visibility guard by enforcing `google_auth: false` in generated runtime config and installer post-setup checks.

## [2.0.9] - 2026-03-06

### Fixed

- Corrected OCS command resolution so `ocs` no longer falls through to `opencode` when a conflicting shim/script already exists on PATH.
- Installer now validates that detected `ocs` is the OpenCode Config Suites CLI and auto-repairs local shims when mismatch is found (including PowerShell precedence on Windows).
- `ocs --version` now follows current suite version from root package metadata (`2.0.9`).

## [2.0.8] - 2026-03-05

### Fixed

- Hardened bundled multi-auth plugin spec generation with cross-platform fallback: when tarball artifact is unavailable, setup now points plugin spec to local bundled package directory instead of a missing `.tgz` file.
- Prevented auth runtime failures such as `BunInstallFailedError` during `opencode auth login` on macOS/Linux environments that do not produce tarball artifacts reliably.

## [2.0.7] - 2026-03-04

### Added

- Dynamic Gemini CLI-first routing policy for plugin runtime with mode controls (`off`, `conservative`, `aggressive`).
- Account-level CLI capability handling (`unknown`/`capable`/`unavailable`) with TTL recovery and automatic CLI bypass for unavailable accounts.
- Natural request pacing controls (`request_jitter_min_ms`, `request_jitter_max_ms`, `request_concurrency_spread_ms`) for high-concurrency traffic.
- Preset tuning guidance and 5-minute checklist in plugin configuration docs.

### Changed

- Extended plugin resolver metadata and route observability for dynamic policy/fallback decisions.
- Updated plugin config schema/env surface and regenerated published schema asset.

### Fixed

- Stabilized plugin floating-point token bucket test assertion.
- Hardened plugin storage migration fixture typing in tests.

## [2.0.6] - 2026-03-04

### Fixed

- `ocs setup:profile:update` now self-heals corrupted Bun global manifest/lock states caused by duplicate `opencode-config-suites` keys.
- Managed global tool bootstrap no longer pollutes Bun global dependencies with local workspace entries, eliminating duplicate-path parse errors and follow-on EPERM/ENOENT failures.

## [2.0.5] - 2026-03-04

### Fixed

- `ocs prefs` now resolves antigravity schema robustly in both repo and installed layouts, preventing schema backend lookup failures from blocking valid edits.
- Hybrid profile now keeps Gemini on plugin OAuth/proxy auth flow by forcing `google_auth: false` so built-in auth cannot hide OAuth options.

### Changed

- Preferences defaults and generated antigravity JSON schema were synchronized with current backend config logic, including schema generator API updates and regenerated schema asset.

## [2.0.4] - 2026-03-04

### Fixed

- Restored Antigravity OAuth login option visibility during `opencode auth login` by correcting setup plugin deployment to a reliably loadable local bundle.

### Changed

- Setup now packs and references `opencode-multi-auth-<version>.tgz` in target config, ensuring installer deployments load the bundled multi-auth plugin version directly.

## [2.0.3] - 2026-03-04

### Changed

- Restored default interactive behavior for `ocs setup profile`/`ocs setup:profile` when no non-interactive flags are passed.
- Added update command aliases `ocs setup update` and `ocs setup:update`, mapped to the same update flow as `ocs setup:profile:update`.

### Commits

- `d838837` fix(cli): restore interactive setup default and add update aliases

## [2.0.2] - 2026-03-04

### Changed

- Release bundling now includes both root and plugin changelog files in artifacts (`CHANGELOG.md` and `PLUGIN_CHANGELOG.md`).
- Finalized changelog cleanup for released sections and commit-trail consistency.

### Commits

- `2e9a5b9` build(release): include changelogs in bundled artifacts
- `da47524` chore(release): finalize 2.0.1 notes and metadata

## [2.0.1] - 2026-03-04

### Changed

- `ocs prefs` wizard now enforces strict schema validation before apply: invalid non-empty inputs are rejected with field-specific feedback, empty input still keeps current value, and apply is blocked when final antigravity validation fails.
- `opencode-multi-auth` runtime now has phased status-policy hardening across `401/403/404/429/5xx`, including adaptive 5xx handling, status floors, model-family lock normalization, storage migration cleanup, and circuit-breaker payload contracts.
- Removed manual `verify account` / `verify all` login menu actions in plugin auth flow to eliminate no-op UX paths.

### Commit Ledger (since 2.0.0)

- `ad3ed96` feat(cli): add global ocs dispatcher and prefs wizard
- `dae1057` feat(prefs): enforce strict schema validation in wizard
- `120c6a9` docs(prefs): document strict validation apply behavior
- `b25c385` feat(plugin): add phase-0 policy rollout guardrails
- `96302de` feat(plugin): harden phase-1 retry and quota classification
- `f510011` feat(plugin): extend cooldown duration fallback parsing
- `42fc708` test(plugin): add 429 dedup storm coverage
- `0362157` feat(plugin): normalize model-family cooldown lock keys
- `7ab7e15` feat(plugin): add rest-until-full soft quota lock flow
- `b1a451b` feat(plugin): harden storage migration and save coordination
- `81a00b9` feat(plugin): add 401 escalation and 404 cooldown routing
- `3ff6130` feat(plugin): add adaptive 5xx retry and switching path
- `cbdfa6e` feat(plugin): enforce status floors in cooldown backoff
- `03d72b7` refactor(plugin): remove manual verify-account menu flow
- `32354da` docs(plugin): record unreleased wave-2 commit trail
- `da47524` chore(release): finalize 2.0.1 notes and metadata

## [2.0.0] - 2026-03-03

### Added

- Global OCS dispatcher and preferences wizard for faster first-run setup (`ad3ed96`).
- Landing refresh with new Hero Lab page and updated brand assets for launch content (`19fef61`).
- Finalized pro hybrid logo system and profile scaffolding for broader deployment coverage (`33dda63`, `3770ae3`).

### Changed

- Setup now defaults to hybrid profile + performance mode and includes antigravity config fallback seeding from template when missing (`aedcabb`, `2b49027`).
- Multi-auth runtime now aligns CLI quota fallback and image model routing with stricter Claude request shaping and diagnostics (`3904771`, `de9553f`).
- Repository structure and workflow docs are reorganized for apps/archive split and release pipeline clarity (`46ebc6a`, `61798eb`, `77bc2e0`, `8923a8b`).

### Fixed

- Windows/public installer flow hardened across auth gating, tar extraction, shell handoff, dependency retries, path normalization, and setup bootstrap reliability (`0bb5631`, `450be68`, `84f07c3`, `6c068d0`, `2a21f68`, `709b036`, `b001538`, `608e71c`, `1246c2c`, `5d0e2a7`, `b7d8513`, `d886420`, `11a42b9`, `28c9458`, `d1ccf00`).
- Sonnet/Opus INVALID_ARGUMENT mitigation now includes payload normalization, non-thinking guards, and schema/tool compatibility enforcement (`de9553f`, `a3f3d9b`, `5cc69bc`).

### Docs

- Expanded installer and script guidance including cache-buster command standardization and antigravity fallback behavior documentation (`ee0a386`, `1d9e448`).

### Verified

- Added regression coverage for Sonnet/Opus payload edge cases and triage playbook for 400 vs 403 failures (`a3f3d9b`, `5cc69bc`).

### Commit Ledger (c91d2a9..1d9e448)

- `0bb5631` fix(installer): add resilient token and gh dependency fallbacks
- `450be68` fix(installer): persist bun path and improve access-denied flow
- `84f07c3` fix(installer): keep terminal open after pwsh handoff
- `6c068d0` fix(installer): avoid false handoff short-circuit in ps5
- `46ebc6a` refactor(structure): migrate ocs app and archive legacy web paths
- `61798eb` docs(workflow): clarify multi-remote push model and ignore noise
- `77bc2e0` docs: organize guidance and repository workflow references
- `8923a8b` chore(runtime): update setup flow and archive legacy cli entry
- `3770ae3` feat(plugin): add profile configs and stabilize plugin test scaffolding
- `2a21f68` fix(installer): prevent token output pollution and enforce access gate
- `709b036` fix(installer): make windows tar extraction fail-fast and compatible
- `b001538` fix(installer): prefer system tar.exe and normalize extraction paths
- `608e71c` fix(installer): avoid false local-source detection and use plugin setup path
- `1246c2c` fix(installer): normalize COMSPEC before setup execution
- `5d0e2a7` fix(installer): harden ps7 relaunch and bun retry diagnostics
- `b7d8513` fix(installer): continue in current shell when pwsh relaunch fails
- `d886420` fix(installer): resolve relative plugin path during bun install
- `11a42b9` fix(installer): harden dependency install retries and fallback
- `28c9458` fix(installer): enforce bun-only dependency retries
- `7c7ba91` chore(installer): refine next-steps guidance text
- `d1ccf00` fix(installer): default to codex hybrid performance
- `33dda63` feat(branding): add final pro hybrid logo system
- `ee0a386` docs(installer): standardize pwsh cache-buster command
- `aedcabb` feat(setup): default to hybrid profile and performance mode
- `3904771` feat(multi-auth): align CLI quota fallback and image model routing
- `ad3ed96` feat(cli): add global ocs dispatcher and prefs wizard
- `de9553f` fix(multi-auth): harden claude payload normalization and thinking guards
- `a3f3d9b` test(multi-auth): add regression coverage for sonnet opus payload edges
- `5cc69bc` docs(multi-auth): add sonnet opus 400 vs 403 triage playbook
- `19fef61` feat(landing): refresh hero section and add hero lab page
- `2b49027` fix(setup): seed antigravity config from template fallback
- `1d9e448` docs(scripts): document antigravity fallback behavior

## [1.10.5] - 2026-02-21

### Fixed

- Setup script no longer overwrites the local repository's `oh-my-opencode.json`. This prevents the git working tree from becoming dirty and fixes the `error: Your local changes would be overwritten by merge` issue during `git pull`.
- Updated `package.json` license identifier to properly reflect commercial/proprietary status (`SEE LICENSE IN LICENSE`).

## [1.10.4] - 2026-02-21

### Docs

- `quick-start-en.md` + `quick-start-id.md`: added concurrent agents column to resource mode table, fixed `performance` mode description, updated plugin count from 4 to 5 (tokenscope added to main table), added plugin auto-install note.

## [1.10.3] - 2026-02-21

### Fixed

- `installPlugins`: exclude `@opencode-ai/*` internal SDK packages from generated `package.json` dependencies — prevents noise in plugin install output.
- `enforcePureConfig`: now also removes `opencode-mem.jsonc` on each deploy — cleans up legacy config from removed plugin.

## [1.10.2] - 2026-02-21

### Fixed

- Plugin installation now generates a `package.json` in `~/.config/opencode` from the deployed `opencode.json` plugin list before running `bun install` — fixes "Bun could not find a package.json" error caused by `enforcePureConfig()` wiping it on each deploy.

## [1.10.1] - 2026-02-21

### Fixed

- Plugin installation after deploy: setup now runs `bun install` in `~/.config/opencode` after copying `opencode.json`, ensuring plugins like `@tarquinen/opencode-dcp` and `cc-safety-net` are actually installed and active.

## [1.10.0] - 2026-02-21

### Added

- **Hardware-aware concurrent agent limiting**: Setup now detects CPU core count and automatically sets `background_task.defaultConcurrency` in `oh-my-opencode.json` based on spare capacity.
  - Formula: `spareCores = max(1, totalCores - 2)` (reserves 2 cores for OS + OpenCode)
  - `low` mode: `max(1, floor(spareCores × 0.4))`
  - `balanced` mode: `max(2, floor(spareCores × 0.8))`
  - `performance` mode: `max(3, spareCores - 1)`
- Setup log now shows the applied concurrency limit after profile deployment.

## [1.9.0] — 2026-02-21

### Changed

- `opencode-multi-auth` updated to @latest (v1.6.0) — now includes proactive context overflow guard for Claude models
  - Automatically detects when context exceeds ~195k tokens before sending to Antigravity
  - Triggers /compact automatically and prompts user to resend — no more session-locking HTTP 400 errors
- Removed `opencode-mem` plugin — fork project cancelled (Antigravity private API not replicable externally)
- Removed `opencode-mem` deployment from setup script — plugin removed from stack
- Fixed `performance` resource mode: now actively upgrades critical agents to `max`/`high` variants (previously identical to `balanced`)

### Fixed

- `opencode-multi-auth` version pin updated from `1.5.11` to @latest

## [1.8.0] - 2026-02-20

### Added

- **Plugin Stack**: Two new plugins added to base `opencode.json` config (zero config, zero API keys):
  - `@tarquinen/opencode-dcp@latest` — Dynamic Context Pruning. Automatically removes stale conversation history (duplicate reads, superseded writes, old errors) before each LLM request to reduce token usage. Fully compatible with oh-my-opencode; disabled for subagents by design.
  - `cc-safety-net@latest` — PreToolUse safety hook. Blocks destructive shell commands (`git reset --hard`, `rm -rf` outside cwd, `git push --force` to main/master, shell wrapper bypasses) before the LLM executes them.
- **Plugin Stack section** in `docs/quick-start-en.md`:
  - Plugin inventory table with role and API key requirements
  - DCP slash command reference (`/dcp context`, `/dcp stats`, `/dcp sweep`, `/dcp distill`)
  - Safety Net overview and verification command (`npx cc-safety-net doctor`)
  - Optional Plugins section: `opencode-mem` (local persistent memory, zero-API-key mode and full-auto mode) and `@ramtinj95/opencode-tokenscope` (token analytics) with full setup instructions
- **Bagian Plugin Stack** di `docs/quick-start-id.md` — terjemahan lengkap semua konten di atas ke Bahasa Indonesia.

### Research (Plan: feat-0da6)

- Audited 4 community-recommended plugins; decision document at `.flowcrate/plans/PLAN_FEAT_0DA6_PLUGIN_AUDIT.md`.
- `opencode-supermemory` superseded by `opencode-mem` (local SQLite + HNSW vector DB, no paid cloud API, contributor overlap with oh-my-opencode author).

### Added

- **Auto Resource Mode** in setup (`low` / `balanced` / `performance`).
  - After profile selection, setup now prompts for resource mode.
  - `low` mode applies deterministic variant downgrade policy: heavy agents (`sisyphus`, `oracle`, `atlas`) downgraded from `max`/`high` to `low`; fast workers (`explore`, `quick`, `unspecified-low`) set to `minimal`.
  - `balanced` (default) preserves profile defaults unchanged.
  - `performance` preserves full `max`/`high` quality on all critical roles.
  - Selected mode persisted to `~/.config/opencode/resource-mode.json` for transparency.
- Resource mode policy constants in `scripts/constants/setup-fallbacks.json` (`policies.low`, `policies.balanced`, `policies.performance`).
- Resource mode options and labels in `scripts/constants/setup-runtime.json`.
- `applyResourceModePolicy(config, resourceModeId)` transform function in `scripts/setup.js`.
- `resolveResourceModeSelection(rawInput)` for number or string input acceptance.
- Expanded **Resource Mode** section in `docs/quick-start-en.md` with behavior table, per-agent variant change matrix, and quick-pick guidance.
- Expanded **Mode Resource** section in `docs/quick-start-id.md` (same in Bahasa Indonesia).

### Changed

- Setup flow: profile selection now followed by resource mode selection before config deploy.
- Deploy line now prints: `📦 Deploying profile: <name> (resource mode: <mode>)`.

## [1.7.1] - 2026-02-20

### Added

- Quick start EN/ID now includes explicit **Load Project** onboarding for first-time users.
- Added cross-drive project loading guidance with copy-paste command examples for Windows paths:
  - `D:\\Projects`
  - `E:\\Work`
- Added home-limited picker workaround with link mapping examples:
  - Windows junction (`mklink /J`)
  - Linux symlink (`ln -s`)
  - macOS symlink (`ln -s`)
- Added **Agent Mode Selection** section (Sisyphus, Hephaestus, Prometheus, Atlas) with best-use-case mapping and prompt examples.
- Added quick FAQ in EN/ID for account operations:
  - temporary disable flow
  - when to change account
  - practical limit/rotation guidance

### Changed

- Refined quick-start headings, navigation hierarchy, and section discoverability.
- Added explicit guidance for Windows port-lock issue after `Ctrl+C`:
  - `taskkill /IM node.exe /F`
- Added changelog index link in `README.md` so users can immediately see new updates.
- Added recommendation to use **VS Code Explorer + integrated terminal** as the default execution path for new users.

## [1.7.0] - 2026-02-20

### Added

- `configs/opus-4.6-lead.json` and `configs/sonnet-4.6-lead.json` as explicit lead-profile canonicals; legacy aliases (`configs/opus-4.6.json`, `configs/sonnet-4.6.json`) are retained for compatibility.
- Setup runtime constants files:
  - `scripts/constants/profile-catalog.json`
  - `scripts/constants/setup-runtime.json`
  - `scripts/constants/setup-fallbacks.json`
- Setup startup update badge logic to check latest GitHub release and print:
  - `[New Update: vX.Y.Z]` with update command hint, or
  - `[Latest: vX.Y.Z]` when current.
- Profile selection guidance additions in quick-start docs:
  - table of contents
  - quick selection matrix (`Use case -> Profile -> Why`)
  - profile decision tree (EN/ID)

### Changed

- Migrated active Gemini Pro model references from `gemini-3-pro` to `gemini-3.1-pro` across profile configs and provider model keys.
- Pinned plugin and dependency alignment to `opencode-multi-auth@1.5.11` in `opencode.json`, `package.json`, and `bun.lock`.
- Refactored `scripts/setup.js` to consume centralized constants for profile ordering, alias mapping, scope hints, header/runtime metadata, model display labels, and fallback defaults.
- Clarified profile naming semantics in docs (`-lead` vs `-all`) to reduce misleading selection outcomes.
- Added `.gemini/` to `.gitignore` for local assistant state.

### Verified

- Isolated smoke test for all visible canonical profiles: `8/8` passed.
- Walkthrough report attached in Flowcrate: `WLKTH_TEST_1587_ISOLATED_PROFILE_SMOKE.md`.

## [1.6.1] - 2026-02-20

### Changed

- Quick start guides now require `gh auth login -h github.com -w` before cloning private repo access.
- Added explicit pre-clone access check using `gh repo view andyvandaric/andyvand-opencode-config`.
- Added troubleshooting for `GraphQL: Could not resolve to a Repository` (wrong account or invite not accepted).
- Added clear profile-switch restart flow: stop running `opencode web` (`Ctrl+C`) and relaunch using the same port.
- Added a structured Gemini Pro/Ultra activation guide for new Google Cloud accounts, including required API enablement and re-auth steps.

## [1.6.0] - 2026-02-20

### Added

- `configs/sonnet-4.6-all.json` - New Sonnet-only profile where all agents and categories run `google/antigravity-claude-sonnet-4-6-thinking`.
- `configs/codex-5.3-sonnet-4.6.json` - New two-model profile using only `openai/gpt-5.3-codex` and `google/antigravity-claude-sonnet-4-6-thinking`, with Codex as primary and Sonnet as quality-focused sub roles.

### Changed

- `README.md` model selection table now includes `sonnet-4.6-all` and `codex-5.3-sonnet-4.6` preset entries.

## [1.5.0] - 2026-02-19

### Added

- **Taplo TOML LSP** — `setup.js` now auto-installs and configures [Taplo](https://taplo.tamasfe.dev) for `.toml` file support. Installs via `cargo` or `brew`, falls back to manual install link.
- **Ghost Spectre / no-winget fallback** — `install.ps1` now tries `winget` → Chocolatey (auto-bootstrapped) → Scoop (auto-bootstrapped) → direct `.exe`/`.msi` download from GitHub releases. Users on stripped Windows ISOs no longer get stuck.
- **Multi-account safe login guide** — step-by-step instructions for adding multiple Google accounts safely: separate Chrome profiles, mobile hotspot tethering, airplane mode to rotate IP between accounts.
- **Account verification guide** — explains `[needs verification]`/`[disabled]` status, how to verify via Antigravity Manager, and the delete-and-re-add flow after successful verification.
- **Quota check guide** — full step-by-step for checking per-account Gemini CLI and Antigravity quota via `opencode auth login` → Check quotas.
- **Working directory note** — clarifies that `opencode web` should be launched from `~/Dev/` not deep subfolders.

### Fixed

- `install.ps1` parse error on PowerShell 5.1 — removed all non-ASCII characters (em dashes, box-drawing, emoji, arrows) from script body; file re-saved as UTF-8 without BOM.
- `install.ps1` pre-clean hang — replaced slow `npm list -g` check with direct uninstall call (~1s vs 10-30s).
- `opencode` command in all docs — corrected to `opencode web --port 8089` (with note that port is user-configurable).
- `Unable to connect` troubleshooting — corrected cause: OpenCode server not running or port changed, not a proxy issue.
- `Skill "skill_mcp" not found` troubleshooting — added fix: install `@kaitranntt/ccs`.

### Changed

- `install.ps1` Quick Start in README now links directly to full guides instead of duplicating steps.
- Quick start docs: added Ghost Spectre file selection table (which `.msi` to pick), loading warning on Antigravity login, and `winget: not found` troubleshooting entry.
- Removed stale `docs/user_guide_singkat.md` and all references to it (done in v1.4.0 cycle, now consolidated).

### Added

- `configs/opus-4.6-lead.json` (legacy alias: `configs/opus-4.6.json`) — New **Opus 4.6 lead** profile: Sisyphus (orchestrator), Oracle, Prometheus, Ultrabrain, Security, and Deep categories run on Claude Opus 4.6 `max` for maximum accuracy and reasoning. Explore/Librarian run on Gemini 3 Flash for speed. Smoke tested ✅
- `configs/gemini-3-all.json` — New **Gemini-only** preset: all agents and categories use exclusively Gemini 3 Pro or Gemini 3 Flash with carefully tuned thinking variants (`minimal`/`low`/`medium`/`high`). No Claude, no OpenAI. Smoke tested ✅
- Pre-clean step in `install.sh` and `install.ps1`: automatically removes any existing `opencode-antigravity-auth` (NoeFabris fork) installation from npm/bun/pnpm/yarn global and OpenCode plugin cache before setup, preventing auth conflicts and account bans.

### Changed

- `install.sh` / `install.ps1`: Pre-clean step runs as Step 0, before all other installation steps.

## [1.3.0] - 2026-02-19

### Added

- `docs/quick-start-en.md` — English quick start guide focused on one-command install.
- `docs/quick-start-id.md` — Indonesian quick start guide (Panduan Quick Start Bahasa Indonesia).

### Changed

- Simplified `README.md`: removed verbose Installation, Usage, Tools & CLI, and Troubleshooting sections now covered by the quick start docs. Added a clean Quick Start block and Documentation table linking to all guides.

## [1.2.0] - 2026-02-19

### Added

- `install.ps1` — One-command Windows installer (PowerShell). Automatically installs Git, Bun, GitHub CLI, clones repo, runs setup.
- `install.sh` — One-command Linux/macOS installer (Bash). Supports Ubuntu/Debian, Fedora, Arch, and macOS.
- Updated `docs/user_guide_singkat.md` to lead with one-liner install commands and a cleaner troubleshooting table.

## [1.1.0] - 2026-02-19

### Added

- New visual identity assets in `assets/` (logo.svg, AI prompts).
- Support for `task(category=...)` compatibility layer in `scripts/setup.js` to map legacy agent names to modern categories.
- Automatic installation of `@biomejs/biome` and `@code-yeongyu/comment-checker` in setup script.
- Improved `doctor` check in setup script to suppress known false-positive "Comment checker unavailable" warnings.
- Documentation for agent compatibility mapping.

### Changed

- Updated `README.md` with new branding and toolchain details.
- Standardized `oh-my-opencode.json` formatting and agent model mappings.
- Refined `scripts/setup.js` tool dependency management and profile description generation.

## [1.0.3] - 2026-02-18

### Changed

- Replaced all Sonnet 4.5 model references with Sonnet 4.6 across project configuration profiles.
- Renamed `configs/sonnet-4.5.json` to `configs/sonnet-4.6-lead.json` (legacy alias `configs/sonnet-4.6.json` retained).
- Updated provider model keys in `opencode.json` from `antigravity-claude-sonnet-4-5*` to `antigravity-claude-sonnet-4-6*`.
- Updated setup profile model label mapping in `scripts/setup.js` to show Sonnet 4.6.
- Updated README model selection note from Sonnet 4.5 to Sonnet 4.6.

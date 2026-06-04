# ACS Installer Changelog

## [0.20.0] - 2026-06-04

### Added
- Tide realtime data framework (createTide, skeleton components, TideProvider)
- Stack Manager & Scheduler pages with live WebSocket data
- Dashboard Command Center redesign with 3-column layout
- Self-healing daemon with hermes auto-patch system
- AI-powered release pipeline (13 gates via 9router)
- AnnouncementCard responsive UI component
- Auto version bump from conventional commits
- Justfile shortcuts for dev/release workflows
- Pipeline unit tests (74 pytest, mypy strict, ruff, bandit)

### Changed
- Repo restructured: apps/acs/cli/ → src/
- Garble build without -literals (3x faster, 40% smaller)
- UPX skips arm64 (unsupported)
- Hardening gate relaxed for buyer repo URL references

### Fixed
- Gateway crash loop (datetime naive vs aware in hermes)
- Frontend API response parsing for nested {success, data} format
- Windows cp1252 encoding in pipeline subprocess calls


## [0.20.1] - 2026-06-04

### Fixed
- Pipeline: handle unicode in Windows console (cp1252 → utf-8).
- Pipeline: increase E2E timeout 10s → 30s (service status needs time).
- Frontend: stack manager button wiring + manifest key.

### Added
- Pipeline: auto-create GitHub Releases on all repos (gate 13).

## [0.20.0] - 2026-06-04

### Added
- Tide framework — new reactive data layer with instant cache hydration, skeleton loading, WebSocket live updates, and prefetch on hover.
- Dashboard: command center redesign with summary cards, announcements, and experimental banners.
- Dashboard: stack manager page, scheduler page, stores, and API libs.
- Server: backend APIs for stack, daemon, announcements, and WebSocket snapshot extension.
- Sync: snapshot browser + quick undo UI, snapshot restore API, post-sync overlap detection, pre-sync backup + progress streaming.
- 9router: PID file management, health check, and process detection.
- CLI: add 9router subcommand.
- Watchdog: auto-restart 9router with backoff (3 per 15min).
- Service: stack auto-start config with per-component toggle.
- Pipeline: E2E release gates + cross-env harness.
- Tooling: shared ACS Python REPL runtime + instant cached status.

### Fixed
- Tide: prevent infinite loop on 401, synchronous cache hydration for instant render.
- Dashboard: SummaryCards responsive layout (2-col mobile, 3-col tablet, 4-col desktop).
- Dashboard: null-guard all WS data access to prevent crash on partial data.
- Frontend: sidebar nav order, stack/scheduler store data extraction + null guards.
- Gateways: prevent credential loss + auto-inject 9router API key.
- Scheduler: daemon status reads state file first + formatUptime NaN guard.
- Kanban: glob all profile kanban DBs instead of hardcoded acs-default.
- Pipeline: preflight before version bump, buyer repo isolation rules, linter fixes.
- UI: theme-aware scrollbars.

## [0.19.0] - 2026-06-01

### Added
- Codex multi-auth account management.
- WebSocket topic-based subscriptions for realtime page updates.
- Claude tab redesign with responsive grid layout for big screens.
- Self-healing skill system + tooling-status/toggle/fix endpoints.
- Claude tooling panel with overlap detection and UX redesign.
- AI-powered release gates 9-13 (review, changelog, README, git release, notify).
- CloakBrowser MCP server config.
- Pipeline: --verify smoke test to dev build.
- Daemon: hermes post-update patch system.
- Legacy script migration engine (detect, migrate, wire into setup + doctor).
- Scheduler: gateway_respawn task — auto-restart dead gateways.

### Fixed
- Frontend: null-guard Board tasks + kanban store improvements.
- Skills: unwrap API response in SkillDiffModal + fix WebSocket URL.
- UI: null-guard builtin_tools and skills arrays in ClaudeToolingPanel.
- Tooling: resolve .mcp.json path, hide terminal window, proper cache invalidation on Windows.
- Gateway: use PowerShell Get-CimInstance instead of deprecated wmic.
- Doctor: api-enrichment deploy uses acs:deploy-enrichment handler.
- Updater: clear stale dismissed flag when current version > dismissed version.
- Naming: gateway display name singular.

## [0.18.0] - 2026-05-30

### Added
- Service: graceful shutdown + PID precision — prevent stale lock false detection.
- Service: OS scheduler for periodic tasks.
- Kanban: board backup and restore.
- Gateways: self-heal logic + wizard UI improvements.
- Doctor + watchdog: enhanced health checks and monitoring.
- Automation: soul deploy + setup migrate.
- CLI: add 'dashboard' top-level subcommand.
- Dashboard: show version dynamically in sidebar header.

### Fixed
- Gateways: upsertEnvVars preserves managed block and empty lines.
- Security: remove all source-revealing paths from binary.
- Windows: hide terminal windows from daemon/broker exec.Command calls.
- Service: daemon status reads state file instead of locked PID file.
- Env: prevent .env credential wipe from silent read errors and full-overwrite.
- Dashboard: restart button now polls and reloads page.
- Install scripts: updated for repo rename.

## [0.17.0] - 2026-05-30

### Added
- Updater: realtime progress bar + hidden window on Windows.
- Self-heal: restart cooldown + Telegram notification on auto-heal.
- Daemon: mesh deliver — broker event delivery to profiles.
- Daemon: kanban reconciler — git commit to card sync.
- Daemon: scheduler core — goroutine-based task runner.
- Dashboard: 3-column layout + PaginatedCard component.
- Model engine: add model auto-detection & priority engine.
- Souls: rebrand all 8 soul templates with ACS identity.
- Setup: add git-credential step — provision .gitconfig per Hermes profile.
- Presets: role-aware presets + toolset availability API.
- Soul templates: role-specific SOUL templates with auto-detect.
- A11y: add tooltips to all interactive elements in agentic components.

### Fixed
- Updater: replace pipe-based download with file-stat progress tracking.
- Service: align daemon PID path with actual daemon lock file location.
- Telegram: disconnected false positive — 60s grace period for connecting state.
- Health: check config.yaml as token fallback, not just .env.
- Doctor: prevent .env credential wipe on file read errors.
- Gateways: raise unresponsive threshold to 20min for long LLM reasoning.
- Gateways: eliminate false-positive unresponsive detection for idle gateways.
- Daemon: concurrency & reliability hardening across broker/daemon/automation.
- UI: gateway cards full-width mobile layout, auto-heal kills stale process.
- Mobile: sidebar auto-expand + auto-hide 10s idle.
- Presets: uniform toolsets for all roles, filter builtin names from custom list.

## [0.16.2] - 2026-05-29

### Fixed
- Gateway wiring: `mergedMaskedAllowedUsers` dedup by raw value — prevents mask collision where short IDs all collapse to single masked entry.

### Added
- 6 wiring E2E tests covering full gateway pipeline (create→file, create→DB, update preserves secrets, get reads file, copy shared env, stale state detection).

## [0.16.1] - 2026-05-29

### Fixed
- Skill sync health endpoint per-skill states.
- Dashboard createEffect import fix.
- Claude config panel and model routing refactored.

## [0.16.0] - 2026-05-29

### Updated
- ACS CLI updated to v0.16.0.
- Added global config management, AI skill merge, broker auto-compose.
- Added dashboard preset manager, skill sync, toolset config, mobile paginator.
- Fixed service stack management.

## [0.15.3] - 2026-05-25

### Fixed
- Published ACS CLI 0.15.3 installer assets.
- Buyer Claude CLI config no longer receives unmanaged hook/statusLine references.
- Prevents Claude CLI failures when optional caveman/OMC hook assets are absent.

### Verified
- Public installer manifest now points to ACS CLI 0.15.3.
- Buyer-gated source repo remains `andyvandaric/andyvand-opencode-config`.

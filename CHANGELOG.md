# Changelog

## [v1.48.0] - 2026-11-27

### Added
- **Authorized Ticketed Self-Updates**: `acs update` automatically generates single-use download tickets with an inline terminal progress bar and a 10-minute stream timeout for reliable upgrades over slow connections.
- **Dynamic HUD Version & Startup Asset Sync**: Statusline and HUD assets synchronize automatically on startup with accurate live version display.

### Fixed
- **Persistent Headed Browser Sessions on Windows**: Preserved headed browser GUI visibility and user profile sessions via CDP without legacy browser remnants interfering.
- **16 MiB SSE Stream Buffer & Event Loop Stability**: Raised SSE scanner buffer to 16 MiB to prevent truncation on large streaming responses and resolved browser event loop crashes.
- **Embedded Profile Hygiene**: Sanitized embedded default browser profile assets to ensure clean buyer workspaces out of the box.

## [v1.47.0] - 2026-11-26

### Added
- **SeleniumBase Pure CDP Browser Automation**: 100% headless background agent web browsing with zero focus-stealing popups and native stealth browser fingerprint emulation for audits, research, and form automation.

### Changed
- **Workspace Path Auto-Quoting & UI Polish**: Automatic quote-handling for statusline workspaces containing directory spaces, paired with standardized official ACS branding and updated Pure CDP browser documentation.

### Fixed
- **Anti-Deadlock Sweeper & Subprocess Immunity**: Strict whitelist guards protecting agent CLI binaries and parent shells from premature termination during long-running tasks.
- **Self-Healing LLM Stream Recovery**: Automated detection and sanitization for malformed closing braces in streaming provider chunks to prevent parsing failures.
- **Bilingual Changelog Delivery**: Curated English and Indonesian release notes synchronized cleanly across download mirrors.

## [v1.46.0] - 2026-11-24

### Added
- **7 Autonomous Reflexes & Multi-Agent Swarm Watchdog**: Hardened executive swarm orchestration with 300s SLA watchdog, 3-checkpoint stagnation probes, and proactive heartbeat supervision across all runtimes.
- **Stateless REST LSP Code Intelligence (<2ms)**: Sub-2ms AST symbol navigation, jump to definition, find references, and compiler diagnostics across Go, TypeScript, Python, and Rust.
- **Antigravity CLI Ecosystem Parity**: First-class detection and native integration for AGY CLI (`agy`), automatic single-command installer, doctor health diagnostics, and environment verification.
- **Zero-Flicker Headless Hook Execution**: In-process console wakeup eliminating Windows terminal/conhost flash and prompt resurfacing for distraction-free coding.
- **Ticketed Binary Streaming**: Direct binary updates streamed via authorized license download ticket conduit with cryptographic payload verification.
- **Dynamic Auto-Registration & Session Bus**: Instant inter-agent message broker (`acs bus`) with background heartbeats, persona CallName resolution, and transparent IPC.
- **Ephemeral Browser Quarantine**: Automatic memory-reclaim reflex putting idle browser agent schemas in quarantine after 60s of inactivity to preserve context tokens.
- **Two-Tier Delete Confirmation & Trashbin Parity**: Guarded soft-delete modals replacing native browser alerts with 30-day retention protection.
- **Remote Developer Feedback Hub**: Direct developer responses and ticket tracking displayed natively within the feedback dashboard.
- **Sovereign Statusline & Telemetry**: Clean borderless 1-2 line statusline displaying active workspace directory, live git stats, and persona role contract.

### Fixed
- **Windows Terminal Window Flash (Zero-Flicker)**: Suppressed conhost window popup on background hooks and agy session boots.
- **Per-Session Token & Alert Isolation**: Strictly isolated context windows across agent sessions, eliminating cross-session token bleeding and HUD alerts.
- **Sub-Millisecond Git Status & SWR**: Non-blocking background repository cache invalidation and 25ms stdin timeout preventing statusline flickering.
- **LSP Environment Initialization**: Local adapters wired for zero-latency code intelligence without heavy process restarts.
- **Flexible Kanban Aliasing & Schema Hygiene**: Normalized task parameter aliasing and prevented runaway card state mutations.
- **Identity Resolution & Workspace Resolver**: Fast-path workspace fallback with reliable author provenance and honest consumer identity defaults.

### Changed
- **Cold Boot Network Optimization**: Accelerated port availability checks and cached version candidates for instant startup.

## [v1.45.0] - 2026-11-19

### Added
- **Lean Progressive Disclosure Strategy**: Modularized governance rules (<24KB ceiling) and active on-demand tool loading, cutting active token overhead by >75% (<5,000 token active footprint).
- **Distraction-Free Headless Execution**: Comprehensive background process isolation preventing command prompt popup windows and window focus stealing.
- **Ephemeral MCP Browser Lifecycle**: On-demand browser automation with auto-quarantine, preserving RAM under 512MB and keeping context window lightweight.
- **Universal Kernel License Gate**: Seamless Turn-0 execution contracts with cryptographic license validation and zero repeated prompts.
- **Antigravity Budget Optimizer**: Dedicated CLI audit engine (`acs antigravity-budget`) to inspect, prune, and benchmark token consumption across active suites.
- **GUI Preflight Connectivity Gate**: Combined preflight verification and multi-tenant commit reconciler with automatic task promotion.
- **Self-Healing Embedded Templates**: Automatic materialization of template configurations and self-repairing fallbacks for Antigravity workspaces.

### Fixed
- **Zero-Conflict Tailscale Relocation**: Automated relocation of conflicting services to port 8443, unblocking 9router proxy on port 443.
- **One-Click MITM Proxy Controls**: Mutual locking and clean privilege elevation for root CA and traffic inspection.
- **SQLite WAL Concurrency & Stale Lock Recovery**: Robust database concurrency handling with automatic recovery of stale index locks during parallel coding.
- **Cross-Project Blueprint Bleed Protection**: Enforced strict project boundaries preventing task bleed across concurrent workspaces.
- **Memory Self-Healing & Catalog UI**: Resolved MCP catalog overflow, stabilized suite status badges, and hardened SQLite access.

### Changed
- **Streamlined MCP & MITM Dashboard**: Converted MCP server management to an instant reachability tester and streamlined proxy configurations.

## [v1.44.0] - 2026-11-18

### Added
- **Specialist Multi-Agent Swarm (23 Personas)**: Integrated Division 1-4 specialist personas (Executive, Platform, Quality, Intel) with master teamwork routing skill.
- **Bidirectional Kanban Board & IDE Blueprint Parity**: Full bidirectional synchronization between IDE markdown checklists and visual Kanban task cards.
- **Second-Brain Memory Compaction**: SQLite WAL optimization with automated FTS5 index maintenance to prevent memory bloat and deliver sub-10ms recall.
- **One-Click Antigravity MITM Cockpit**: Native TLS inspection cockpit with automated Windows hosts file management and zero-friction interception.
- **Cross-Session Lock Governance & 300s Watchdog**: Strict sessionbus locking, deterministic SLA timers, and proactive error fingerprinting.
- **Windows In-Place Non-Renaming Log Rotator**: Multi-process log isolation with automatic rotation preventing file-lock contention on Windows.

### Fixed
- **Stack Updater Progress & Completion Guard**: Prevented premature done progress and false completion states during stack upgrades.
- **Windows Daemon Spawn Stability**: Guarded log file descriptors during background daemon spawns to eliminate restart stalls.
- **Multi-Workspace Git Root Resolution**: Corrected git directory discovery across deeply nested monorepos and submodules.
- **Session ID Binding**: Prevented premature task card completion by validating active agent session ownership.

### Changed
- **Consolidated Dashboard Modals**: Cleaned redundant cards and streamlined Antigravity workspace manager controls.

## [v1.43.0] - 2026-11-16

### Added
- **Stateless REST LSP Intelligence (<2ms)**: Direct symbol definitions, references, and diagnostics bypassing heavy process spawning.
- **Autonomous Blueprint-to-Kanban Sync**: Realtime reflex automatically converting IDE markdown task checklists into Kanban board cards.
- **Zero-Prompt Autonomous Permissions**: Built-in tool permission grants enabling uninterrupted autonomous agent loops.
- **20+ Subagent Persona Registry**: Comprehensive autonomous specialist roles with dual-namespace tool aliasing and execution governance.
- **9Router Maintenance Daemon & Database Pruning**: Background optimizer CLI (`acs optimize-db`) with automatic backup rotation and settings sanitizer.
- **Multi-Project Discovery Engine**: Dynamic workspace discovery for daemon sweeps and background boot synchronization.

### Fixed
- **Port 20130 Dashboard Binding**: Enforced strict environment port isolation and explicit startup flags for production dashboards.
- **Pre-Invocation Hook Protocol**: Aligned native hook payloads with protobuf specifications and consolidated on-demand skill matchers.
- **Windows Low-Resolution Timer Collation**: Guaranteed unique user identifiers on high-concurrency Windows clocks.
- **Backlog Auto-Claim Guard**: Prevented accidental runaway task claims during rapid hook activity.

### Changed
- **Hook Execution Optimization**: Replaced external wrapper scripts with high-performance inline HTTP fetch routines.
- **Unified Antigravity UI Selector**: Consolidated configuration dropdowns into a single clean interface.

## [v1.42.0] - 2026-11-14

### Added
- **Progressive Diagnostic Streaming**: Real-time server-sent events (SSE) diagnostic streams with live latency badges and tier isolation.
- **4-in-1 Usage & Cache Efficiency Dashboard**: Unified token usage and cache efficiency visualizations with zero redundancy.
- **Dynamic Welcome & Announcement Engine**: Versioned announcements and release notifications delivered in-dashboard.
- **Transactional Combo Tombstone Recording**: Dual-cache invalidation and seed-once persistence with Antigravity MITM seeder parity.
- **High-Resolution Usage Charts**: Hourly timeline tooltips, formatted labels, and explicit display metrics for token consumption.

### Fixed
- **Diagnostic Stream Timeouts**: Extended Fiber write timeouts to 180 seconds to guarantee uninterrupted SSE telemetry.
- **Progress Banner Rendering**: Rendered live progress banners to prevent premature error states during long diagnostics.
- **Gateway Default Routing**: Sanitized fallback changelog generation and aligned 9router default gateway routes.
- **Test Suite Parallelism**: Capped Windows test parallelism and raised test timeouts to eliminate intermittent test harness blocks.

## [v1.41.0] - 2026-11-11

### Added
- **9Router Combo Management**: Flexible combo CRUD routes and UI modal supporting visual item reordering across model providers.
- **Reactive Model Combo Stores**: Instant cache synchronization and reactive store mutations on combo updates.
- **Direct Installer Fallback**: Automatic installation bypass and fallback logic for external terminal tools.
- **Unified Preset Routing**: Integrated combo manager into configuration panels and Claude model routing.

### Fixed
- **In-Process Environment Variable Sync**: Ensured dynamic configuration patches propagate immediately to in-flight processes.
- **End-to-End Resilience**: Extended 9router model timeouts under heavy testing loads.

## [v1.40.0] - 2026-11-10

### Added
- **Resilient Model Loader with TTL Cache**: High-throughput memory cache with manual force-refresh support for 9router combos.
- **Interactive Terminal Auto-Resume**: Elevated permission management on in-progress tasks with smooth terminal recovery.
- **Progressive Column Windowing for Kanban**: High-density board pagination and virtualized windowing for large project backlogs.
- **Automated Walkthrough Synthesis**: Provenance tracking and automatic walkthrough generation across blueprint tasks.

### Fixed
- **Sequential Combo Schema Healing**: Automated kind healing and improved compatibility for complex 9router combos.
- **PTY Terminal Process Resolution**: Hardened active session binding and terminal resolution across background workspaces.
- **CDN Distribution Health Resilience**: Calibrated retry backoffs for release distribution health checks.

## [v1.39.0] - 2026-11-09

### Added
- **Second-Brain Knowledge Engine**: Hybrid semantic and keyword retrieval with SQLite WAL backing.
- **Automated Blueprint Stage Verification**: Intelligent context evaluation and automated stage progression.
- **Multi-Agent Coordination Monitor**: Real-time process monitoring and live task status tracking.
- **Secure Encrypted Credential Vault**: Safe storage and resolution for sensitive agent tokens and upstream API keys.

### Fixed
- **Concurrent Health Check Races**: Hardened background recovery against racing diagnostic sweeps.
- **Nested Blueprint Discovery**: Enhanced project discovery across deeply nested folder structures.
- **Background Daemon Recovery**: Stabilized restart loops under race conditions.

## [v1.38.0] - 2026-11-07

### Added
- **Automated Daemon Coordination & Self-Healing**: Resilient supervisory loop for background services and schedulers.
- **Real-Time Service Health Probing**: Adaptive dial retry logic detecting offline ports instantly.
- **Fastpath Virtualenv Discovery**: Accelerated package and version discovery for Python virtual environments.
- **Commit Phase Validation Gate**: Synchronized development tracking and phase commit verification.

### Fixed
- **Process Startup Mutex**: Protected daemon rendezvous points against duplicate process spawns.
- **Release Distribution Hardening**: Added anti-leak protections to distribution pipelines.
- **Daemon Restart Races**: Fixed recovery lockups during simultaneous restart triggers.

## [v1.37.0] - 2026-11-06

### Added
- **Tabbed Project Configuration**: Upstream AI endpoint configuration, masked API key storage, and live connection testing.
- **MCP Panic Shield & Resilience Layer**: Automated recovery preventing crashes during high-throughput tool execution loops.
- **Expanded 16MB Stdio Buffer**: Non-fatal auto-recovery buffer supporting large coding contexts and symbol outputs.
- **Time-Bound Ticketed Binary Downloads**: Cryptographically signed ticketed verification for official release binaries.

### Fixed
- **Background AI Task Termination Guard**: Protected background tasks from unexpected termination during updates.
- **Cross-Platform Startup Tolerances**: Calibrated cold boot timing across Windows and Linux.
- **Antivirus Heuristic Optimization**: Optimized Windows binary packaging to eliminate false-positive antivirus warnings.

## [v1.36.1] - 2026-11-06

### Added
- **Real-Time Token Usage Breakdown**: Model-by-model token visualization and cost tracking on the Usage dashboard.
- **Live Antigravity Quota Tracker**: Remaining allocation metrics and zero-division safeguards.
- **Automated Idea Pre-Assessment**: Fast scoping and evaluation workflow for architectural tasks.

### Fixed
- **Direct OS File Logging for 9Router**: Decoupled process logging to eliminate freeze issues during restarts.
- **Background Health Monitoring**: Automated self-healing restart loops for background services.

## [v1.36.0] - 2026-11-06

### Added
- **Canonical `acs` CLI Namespace**: Standardized single command namespace across all CLI tools, environments, and workflows.
- **Model Routing & Custom Endpoints**: Flexible model picker with custom `base_url`, write-only masked `api_key`, and latency testing.
- **5-Streak Daemon Zombie Recovery**: Graduated escalation ladder for automatic daemon recovery and backoff.
- **Session Bus Coordination**: Session heartbeat renewals, recipient-validated message queues, and unread inbox banners.
- **Kanban Soft-Delete Trashbin**: 30-day retention protection, blueprint reseed engine, and automated status updates.
- **3D WebGL Virtual Office & Code Search**: Spatial studio view and fast trigram code search (`/api/memory/code-search`).

### Fixed
- **Clean Process Restart Lifecycle**: Eliminated tree-kill patterns on daemon restart and port reclamation across Windows and Unix.
- **Windows Browser Path Auto-Detection**: Corrected binary discovery for Chrome and Edge under testing suites.
- **SQLite Snapshot Lock Prevention**: Enforced immediate transaction locking on write connections to eliminate snapshot locks.

## [v1.35.0] - 2026-10-15

### Added
- **Lightweight Kanban Board Projection**: Accelerated board queries (`light` param) with done-column windowing and pagination.
- **Anke Command Center**: Dedicated executive command interface and sidebar navigation for swarm orchestration.
- **Canonical WebSocket PTY Modal**: In-place interactive terminal modal bound directly to active task cards.
- **Domain-Qualified MCP Display (`acs:core`)**: Standardized tool naming with per-server watchdog circuit breakers.
- **Graceful Degraded Cache Fallbacks**: Resilient cache loading with typed error handling and stale file cleanup.

### Fixed
- **Fail-Closed Blueprint Resolution**: Strict validation across blueprint sync, code scanning, and commit creation.
- **Tool Execution Ceilings**: 5-minute timeout boundaries and clean context cancellation for stdio tools.
- **Kanban State Guarding**: Protected completed cards from accidental backlog demotion during upserts.
- **Session Identity Security**: Enforced AgentID ownership validation to prevent session hijacking.

## [v1.34.0] - 2026-10-15

### Added
- **Unified Swarm Orchestration & Session Registry**: Multi-agent task distribution with automatic registration and heartbeat tracking.
- **Fail-Closed Cloudflare Bot Protection**: Hardened verification headers and payload protection across public portals.
- **Bidirectional Task Status Auditing**: Detailed status transition logging and history tracking for Kanban cards.
- **Interactive PTY Session Stream**: Real-time terminal streaming with status recovery and session binding.

### Fixed
- **Windows File System Retry Loops**: Hardened atomic file writing with automated retries under concurrent access.
- **Cold-Start Navigation Hangs**: Background warm-up routine eliminating cold boot latency on initial navigation.
- **Stray Process Reclamation**: Automated sweeper routines releasing orphaned background tasks cleanly.

## [v1.33.0] - 2026-10-12

### Added
- **Three-Tier Task Gate Classifier**: Smart execution tiering (Tier 1 Direct, Tier 2 Blueprint, Tier 3 Operational) with automated impact evaluation.
- **Attestation Recorder & Feedback Loop**: Verification audit logging linking task verdicts directly to blueprint requirements.
- **Session Bus Unread Notification Badges**: Real-time unread count badges on active session heartbeats.

### Fixed
- **Tracker Status Normalization**: Strict fence-aware status parsing eliminating phantom badge states.
- **Large Binary Release Packaging**: Optimized compression and packaging routines to prevent security software false flags.
- **Cold Cost Latency Budgets**: Calibrated latency expectations for clean Windows execution without timeouts.

## [v1.32.0] - 2026-10-11

### Added
- **Canonical Session Identity & Task Storage**: Unified database storage with environment-first session resolution.
- **Zero-Lag Kanban Presence Broadcast**: Real-time WebSocket presence broadcasting and auto-claim on approved gates.
- **Multi-Product CDN Distribution**: Fast-track deployment pipeline with isolated product mirrors and verification probes.
- **Telegram Bot & Chat Gateway**: Secure webhook integration with rate limiting and markdown formatting.
- **CPU Governor & Deadlock Prevention**: Core-aware concurrency clamps and adaptive polling on constrained environments.

### Fixed
- **WebSocket Fallback Probing**: Resilient connection checks ensuring smooth operation when sockets reconnect.
- **Database Trigger Reliability**: View-aware trigger execution and calibrated TTL purges.
- **Terminal Working Directory Isolation**: Sanitized directory resolution ensuring sub-agents start in correct workspace paths.

## [v1.31.0] - 2026-10-08

### Added
- **Real-Time Blueprint Synchronization**: Direct synchronization between local markdown blueprints and task cards.
- **Specialist Agent Role Isolation**: Isolated context and execution boundaries per agent persona.
- **Multi-Tiered Cache for Git Operations**: Accelerated repository status checks and changed file tracking.

### Fixed
- **Autonomous Token Budget Guards**: Prevented runaway token loops during long autonomous coding turns.
- **Memory Consumption in Markdown Parsing**: Optimized large document processing to prevent memory spikes.

## [v1.30.0] - 2026-10-06

### Added
- **Visual Stack Manager GUI**: One-click controls to start, stop, and restart background services and proxies.
- **Sovereign CDN Automatic Updates**: Seamless self-updating binary distribution via official CDN endpoints.
- **Real-Time System Log Filtering**: Interactive error highlighting and log inspection in the dashboard.

### Fixed
- **Dynamic Port Allocation**: Eliminated port conflict issues with existing host development servers.
- **Cross-Platform Termination Handling**: Smooth shutdown signal processing on Windows and Linux.

## [v1.29.0] - 2026-10-05

### Added
- **Local & Remote MCP Tool Launcher**: Automatic tool schema validation and launcher integration.
- **Web-Based Member Authentication**: Single sign-on and instant license entitlement resolution.
- **Interactive Getting Started Guide**: Step-by-step developer onboarding and setup documentation.

### Fixed
- **Informative Network Diagnostics**: Clear user-friendly messages for offline license verification.
- **High-DPI Display Formatting**: Layout alignment fixes for high-resolution monitors.

## [v1.28.0] - 2026-10-04

### Added
- **Modular ACS Architecture**: High-performance Go backend with embedded SolidJS web dashboard.
- **Built-in Developer Kanban**: Task-based development tracking integrated into the developer CLI.
- **Inter-Tool Message Broker**: Local IPC messaging coordinating background agent processes.

### Fixed
- **SQLite Database Initialization**: Hardened WAL schema migration and table setup on initial boot.
- **Optimized Binary Size**: Stripped debug symbols and minimized distribution footprint for fast downloads.

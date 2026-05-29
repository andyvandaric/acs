# ACS Installer Changelog


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

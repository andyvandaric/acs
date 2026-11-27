#!/usr/bin/env bash
# uninstall.sh — Standalone ACS CLI uninstaller for Linux/macOS
# Usage: curl -fsSL https://dl.uikode.com/uninstall.sh | bash
# Or:    bash uninstall.sh [--purge] [--force] [--dry-run] [--help]
set -euo pipefail

PURGE=false
FORCE=false
DRY_RUN=false
HELP=false

for arg in "$@"; do
  case "$arg" in
    -p|--purge) PURGE=true ;;
    -f|--force) FORCE=true ;;
    -d|--dry-run) DRY_RUN=true ;;
    -h|--help) HELP=true ;;
  esac
done

if [[ "$HELP" == "true" ]]; then
  echo ""
  echo "ACS — Universal Uninstaller"
  echo "------------------------------------"
  echo "Usage:"
  echo "  curl -fsSL https://dl.uikode.com/uninstall.sh | bash"
  echo "  bash uninstall.sh [--purge] [--force] [--dry-run] [--help]"
  echo ""
  echo "Options:"
  echo "  -p, --purge     Remove all ACS data, skills, configs, and ~/.acs directory"
  echo "  -f, --force     Skip interactive confirmations"
  echo "  -d, --dry-run   Preview actions without modifying files or system state"
  echo "  -h, --help      Show this help message"
  echo ""
  exit 0
fi

info() { echo "  $*"; }
ok() { echo "[OK] $*"; }
warn() { echo "[WARN] $*" >&2; }

echo ""
echo "ACS — Uninstaller"
echo "------------------------------------"
if [[ "$DRY_RUN" == "true" ]]; then
  echo "  Mode: DRY RUN (no changes will be applied)"
elif [[ "$PURGE" == "true" ]]; then
  echo "  Mode: PURGE (remove everything)"
else
  echo "  Mode: Safe (keep skills, configs, data)"
  echo "  Use --purge to remove everything"
fi
echo ""

ACS_DIR="${HOME}/.acs"
INSTALL_DIR="${ACS_DIR}/bin"
SKILLS_DIR="${ACS_DIR}/skills"
SKILLS_DIR_ALT="${XDG_DATA_HOME:-${HOME}/.local/share}/acs-cli/skills"
HERMES_PROFILE="${HOME}/.hermes/profiles/acs-default"
KANBAN_DB="${HOME}/.hermes/kanban.db"
CLAUDE_DIR="${HOME}/.claude"

# ─── Stop service & delegate to acs ──────────────────────────────────────────
info "Stopping service..."
TARGET_EXE="${INSTALL_DIR}/acs"
CLI_ARGS=("service" "uninstall")
if [[ "$PURGE" == "true" ]]; then CLI_ARGS+=("--purge"); fi
if [[ "$FORCE" == "true" ]]; then CLI_ARGS+=("--force"); fi
if [[ "$DRY_RUN" == "true" ]]; then CLI_ARGS+=("--dry-run"); fi

if [[ "$DRY_RUN" != "true" ]]; then
  if [[ -x "$TARGET_EXE" ]]; then
    "$TARGET_EXE" "${CLI_ARGS[@]}" 2>/dev/null || true
  elif command -v acs >/dev/null 2>&1; then
    acs "${CLI_ARGS[@]}" 2>/dev/null || true
  elif command -v acs-cli >/dev/null 2>&1; then
    acs-cli "${CLI_ARGS[@]}" 2>/dev/null || true
  fi
fi

# Kill by PID file
PID_FILE=""
if [[ -n "${XDG_DATA_HOME:-}" ]]; then
  PID_FILE="${XDG_DATA_HOME}/acs-cli/acs-cli.pid"
else
  PID_FILE="${HOME}/.local/share/acs-cli/acs-cli.pid"
fi
if [[ -f "$PID_FILE" && "$DRY_RUN" != "true" ]]; then
  PID=$(cat "$PID_FILE" 2>/dev/null | python3 -c "import sys,json; print(json.load(sys.stdin).get('pid',''))" 2>/dev/null || true)
  if [[ -n "$PID" ]] && kill -0 "$PID" 2>/dev/null; then
    kill "$PID" 2>/dev/null || true
    ok "Stopped service (PID $PID)"
  fi
  rm -f "$PID_FILE"
fi

# ─── Remove service registration ───────────────────────────────────────────
info "Removing service registration..."
case "$(uname -s)" in
  Darwin)
    PLIST="${HOME}/Library/LaunchAgents/dev.acs.cli.plist"
    if [[ -f "$PLIST" ]]; then
      if [[ "$DRY_RUN" != "true" ]]; then
        launchctl unload "$PLIST" 2>/dev/null || true
        rm -f "$PLIST"
      fi
      ok "Removed launchd plist"
    fi
    ;;
  *)
    for unit in acs.service acs-cli.service acs-watchdog.timer; do
      UNIT="${HOME}/.config/systemd/user/${unit}"
      if [[ -f "$UNIT" ]]; then
        if [[ "$DRY_RUN" != "true" ]]; then
          systemctl --user stop "$unit" 2>/dev/null || true
          systemctl --user disable "$unit" 2>/dev/null || true
          rm -f "$UNIT"
          systemctl --user daemon-reload 2>/dev/null || true
        fi
        ok "Removed systemd unit ($unit)"
      fi
    done
    ;;
esac

# ─── Remove automation (always) ────────────────────────────────────────────
info "Removing automation..."
REMOVED=0

if [[ -d "${HERMES_PROFILE}/hooks/intent-capture" ]]; then
  [[ "$DRY_RUN" != "true" ]] && rm -rf "${HERMES_PROFILE}/hooks/intent-capture"
  REMOVED=$((REMOVED + 1))
fi

for script in watchdog.py board-sweep.py token-refresh.py; do
  if [[ -f "${HERMES_PROFILE}/scripts/${script}" ]]; then
    [[ "$DRY_RUN" != "true" ]] && rm -f "${HERMES_PROFILE}/scripts/${script}"
    REMOVED=$((REMOVED + 1))
  fi
done

if git rev-parse --git-dir >/dev/null 2>&1; then
  HOOK="$(git rev-parse --git-dir)/hooks/post-commit"
  if [[ -f "$HOOK" ]] && grep -q "acs \|acs-cli\|acs-docs" "$HOOK" 2>/dev/null; then
    if [[ "$DRY_RUN" != "true" ]]; then
      if grep -q "# --- ACS START ---" "$HOOK"; then
        sed -i '/# --- ACS START ---/,/# --- ACS END ---/d' "$HOOK"
      else
        rm -f "$HOOK"
      fi
    fi
    REMOVED=$((REMOVED + 1))
  fi
fi

[[ $REMOVED -gt 0 ]] && ok "Removed $REMOVED automation items"

# ─── Surgical MCP cleanup in .claude.json ──────────────────────────────────
CLAUDE_JSON="${HOME}/.claude.json"
if [[ -f "$CLAUDE_JSON" && "$DRY_RUN" != "true" ]]; then
  PY_BIN=""
  if command -v python3 >/dev/null 2>&1; then
    PY_BIN="python3"
  elif command -v python >/dev/null 2>&1; then
    PY_BIN="python"
  fi
  if [[ -n "$PY_BIN" ]]; then
    "$PY_BIN" -c '
import json, pathlib, sys
p = pathlib.Path(sys.argv[1])
try:
    data = json.loads(p.read_text(encoding="utf-8"))
except Exception:
    sys.exit(0)
servers = data.get("mcpServers")
if isinstance(servers, dict):
    keys = [k for k in servers if k.startswith("acs-")]
    if keys:
        for k in keys:
            servers.pop(k, None)
        p.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
' "$CLAUDE_JSON" 2>/dev/null || true
  fi
fi

# ─── Purge-only removals ───────────────────────────────────────────────────
if [[ "$PURGE" == "true" ]]; then
  echo ""
  info "Purging all data..."

  for sdir in "$SKILLS_DIR" "$SKILLS_DIR_ALT"; do
    if [[ -d "$sdir" && "$DRY_RUN" != "true" ]]; then
      rm -rf "$sdir"
    fi
  done
  ok "Removed skills"

  if [[ -f "${HERMES_PROFILE}/SOUL.md" ]]; then
    [[ "$DRY_RUN" != "true" ]] && rm -f "${HERMES_PROFILE}/SOUL.md"
    ok "Removed SOUL.md"
  fi

  if [[ -f "${CLAUDE_DIR}/settings.json" ]]; then
    [[ "$DRY_RUN" != "true" ]] && sed -i '/127\.0\.0\.1:20128/d' "${CLAUDE_DIR}/settings.json"
    ok "Cleaned claude settings.json"
  fi

  if [[ -f "$KANBAN_DB" ]]; then
    if [[ "$DRY_RUN" != "true" ]]; then
      cp "$KANBAN_DB" "${KANBAN_DB}.uninstall-backup"
      rm -f "$KANBAN_DB"
    fi
    ok "Removed kanban.db (backup: ${KANBAN_DB}.uninstall-backup)"
  fi

  if [[ -f "${INSTALL_DIR}/acs" ]]; then
    [[ "$DRY_RUN" != "true" ]] && rm -f "${INSTALL_DIR}/acs"
    ok "Removed binary"
  elif [[ -f "${INSTALL_DIR}/acs-cli" ]]; then
    [[ "$DRY_RUN" != "true" ]] && rm -f "${INSTALL_DIR}/acs-cli"
    ok "Removed legacy binary"
  fi

  for RC in "${HOME}/.bashrc" "${HOME}/.zshrc" "${HOME}/.config/fish/config.fish"; do
    if [[ -f "$RC" ]] && grep -q "${INSTALL_DIR}" "$RC" 2>/dev/null; then
      if [[ "$DRY_RUN" != "true" ]]; then
        sed -i '/# ACS CLI/d' "$RC"
        sed -i "\|${INSTALL_DIR}|d" "$RC"
      fi
      ok "Cleaned PATH from $(basename "$RC")"
    fi
  done

  if [[ -d "$ACS_DIR" ]]; then
    [[ "$DRY_RUN" != "true" ]] && rm -rf "$ACS_DIR"
    ok "Purged $ACS_DIR"
  fi
fi

echo ""
echo "------------------------------------"
if [[ "$DRY_RUN" == "true" ]]; then
  echo "  Dry run complete. No changes made."
elif [[ "$PURGE" == "true" ]]; then
  echo "  ACS fully removed."
else
  echo "  Automation removed. Skills + configs preserved."
  echo "  Run with --purge to remove everything."
fi
echo "------------------------------------"
echo ""

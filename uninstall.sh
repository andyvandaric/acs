#!/usr/bin/env bash
# uninstall.sh — ACS Uninstaller for Linux/macOS
# Usage: curl -fsSL https://dl.uikode.com/uninstall.sh | bash [options]
# Or:    bash uninstall.sh [--purge] [--force] [--dry-run]
set -euo pipefail

PURGE=false
FORCE=false
DRY_RUN=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    -p|--purge)
      PURGE=true
      shift
      ;;
    -f|--force)
      FORCE=true
      shift
      ;;
    -d|--dry-run)
      DRY_RUN=true
      shift
      ;;
    -h|--help)
      echo "ACS — Uninstaller"
      echo ""
      echo "Usage:"
      echo "  ./uninstall.sh [options]"
      echo "  curl -fsSL https://dl.uikode.com/uninstall.sh | bash -s -- [options]"
      echo ""
      echo "Options:"
      echo "  -p, --purge     Purge mode: remove everything (binary, license, DB, skills, configs)"
      echo "  -f, --force     Skip confirmation prompts"
      echo "  -d, --dry-run   Show what would be removed without taking action"
      echo "  -h, --help      Show this help message"
      exit 0
      ;;
    *)
      shift
      ;;
  esac
done

info() { echo "  $*"; }
ok() { echo "✅ $*"; }
warn() { echo "⚠️  $*" >&2; }

INSTALL_DIR="${HOME}/.acs/bin"
ACS_DIR="${HOME}/.acs"
CLAUDE_DIR="${HOME}/.claude"
GEMINI_DIR="${HOME}/.gemini"
CLAUDE_JSON="${HOME}/.claude.json"

echo ""
echo "⚡ ACS — Uninstaller"
echo "────────────────────────────────────"
if [[ "$PURGE" == "true" ]]; then
  echo "  Mode: PURGE (remove binary, license, database, and all configs)"
else
  echo "  Mode: Safe Mode (remove background services & hooks; preserve license & DB)"
  echo "  Use --purge to remove everything."
fi
if [[ "$DRY_RUN" == "true" ]]; then
  echo "  Execution: DRY-RUN (no files or services will be modified)"
fi
echo ""

# ─── 1. In-Binary Delegation (Preferred SSOT Engine) ─────────────────────────
TARGET_EXE=""
if [[ -x "${INSTALL_DIR}/acs" ]]; then
  TARGET_EXE="${INSTALL_DIR}/acs"
elif command -v acs >/dev/null 2>&1; then
  TARGET_EXE="$(command -v acs)"
fi

if [[ -n "$TARGET_EXE" ]]; then
  info "Delegating de-installation to ACS Core engine..."
  CLI_ARGS=("uninstall")
  if [[ "$PURGE" == "true" ]]; then CLI_ARGS+=("--purge"); fi
  if [[ "$FORCE" == "true" ]]; then CLI_ARGS+=("--force"); fi
  if [[ "$DRY_RUN" == "true" ]]; then CLI_ARGS+=("--dry-run"); fi

  if "$TARGET_EXE" "${CLI_ARGS[@]}"; then
    exit 0
  else
    warn "Binary delegation failed. Falling back to standalone script cleanup..."
  fi
fi

# ─── 2. Standalone Fallback Cleanup (If binary is absent) ────────────────────
if [[ "$FORCE" != "true" && "$DRY_RUN" != "true" ]]; then
  if [[ "$PURGE" == "true" ]]; then
    read -r -p "Are you sure you want to PURGE all ACS data, licenses, and binaries? (yes/N): " CONFIRM
    if [[ "${CONFIRM,,}" != "yes" ]]; then
      warn "Uninstallation cancelled."
      exit 0
    fi
  else
    read -r -p "Remove ACS background services and automation? (Y/n): " CONFIRM
    if [[ "${CONFIRM,,}" == "n" ]]; then
      warn "Uninstallation cancelled."
      exit 0
    fi
  fi
fi

# ─── Stop Running Processes ──────────────────────────────────────────────────
info "Stopping running ACS processes..."
if [[ "$DRY_RUN" != "true" ]]; then
  pkill -x acs 2>/dev/null || true
  pkill -x acs-cli 2>/dev/null || true
fi
ok "Stopped running processes"

# Check PID files
for pf in "${ACS_DIR}/data/acs-coder.pid" "${ACS_DIR}/data/acs-daemon.pid" "${HOME}/.local/share/acs-cli/acs-cli.pid"; do
  if [[ -f "$pf" ]]; then
    PID=$(cat "$pf" 2>/dev/null || true)
    if [[ -n "$PID" && "$PID" =~ ^[0-9]+$ ]]; then
      if [[ "$DRY_RUN" != "true" ]] && kill -0 "$PID" 2>/dev/null; then
        kill "$PID" 2>/dev/null || true
      fi
    fi
    if [[ "$DRY_RUN" != "true" ]]; then rm -f "$pf"; fi
  fi
done

# ─── Remove OS Service Registration ──────────────────────────────────────────
info "Removing service registrations..."
case "$(uname -s)" in
  Darwin)
    for plist in "dev.acs.cli.plist" "com.acs.watchdog.plist" "com.acs.kanban-backup.plist"; do
      P_PATH="${HOME}/Library/LaunchAgents/${plist}"
      if [[ -f "$P_PATH" ]]; then
        if [[ "$DRY_RUN" != "true" ]]; then
          launchctl unload "$P_PATH" 2>/dev/null || true
          rm -f "$P_PATH"
        fi
        ok "Removed ${plist}"
      fi
    done
    ;;
  *)
    if command -v systemctl >/dev/null 2>&1; then
      for unit in "acs.service" "acs-cli.service" "acs-watchdog.timer" "acs-kanban-backup.timer"; do
        U_PATH="${HOME}/.config/systemd/user/${unit}"
        if [[ -f "$U_PATH" ]]; then
          if [[ "$DRY_RUN" != "true" ]]; then
            systemctl --user stop "$unit" 2>/dev/null || true
            systemctl --user disable "$unit" 2>/dev/null || true
            rm -f "$U_PATH"
          fi
          ok "Removed ${unit}"
        fi
      done
      if [[ "$DRY_RUN" != "true" ]]; then
        systemctl --user daemon-reload 2>/dev/null || true
      fi
    fi
    ;;
esac

# ─── Remove Automation Hooks & Scripts ───────────────────────────────────────
info "Cleaning automation hooks..."
if [[ -d "${CLAUDE_DIR}/hooks" && "$DRY_RUN" != "true" ]]; then
  rm -f "${CLAUDE_DIR}/hooks/"*.mjs "${CLAUDE_DIR}/hooks/package.json" 2>/dev/null || true
  ok "Cleaned Claude hooks"
fi

if [[ -f "${CLAUDE_DIR}/hud/acs-hud.js" && "$DRY_RUN" != "true" ]]; then
  rm -f "${CLAUDE_DIR}/hud/acs-hud.js"
  ok "Cleaned Claude HUD"
fi

# Remove git post-commit hook
if git rev-parse --git-dir >/dev/null 2>&1; then
  HOOK="$(git rev-parse --git-dir)/hooks/post-commit"
  if [[ -f "$HOOK" ]] && grep -q "acs" "$HOOK" 2>/dev/null; then
    if [[ "$DRY_RUN" != "true" ]]; then
      if grep -q "# --- ACS START ---" "$HOOK"; then
        sed -i '/# --- ACS START ---/,/# --- ACS END ---/d' "$HOOK"
      else
        rm -f "$HOOK"
      fi
    fi
    ok "Cleaned git post-commit hook"
  fi
fi

# ─── Purge Mode Removals ─────────────────────────────────────────────────────
if [[ "$PURGE" == "true" ]]; then
  echo ""
  info "Purging all data, configs, licenses, and binaries..."

  # 1. Clean MCP servers from ~/.claude.json via Python
  if [[ -f "$CLAUDE_JSON" ]]; then
    if [[ "$DRY_RUN" != "true" ]]; then
      python3 -c "
import json, os
path = os.path.expanduser('~/.claude.json')
try:
    with open(path, 'r') as f:
        data = json.load(f)
    if 'mcpServers' in data and isinstance(data['mcpServers'], dict):
        keys_to_del = [k for k in data['mcpServers'] if k.lower().startswith(('acs-', 'acs_')) or k.lower() == 'acs']
        for k in keys_to_del:
            del data['mcpServers'][k]
        with open(path, 'w') as f:
            json.dump(data, f, indent=2)
except Exception:
    pass
" 2>/dev/null || true
    fi
    ok "Surgically cleaned ACS MCP servers from .claude.json"
  fi

  # 2. Clean Antigravity ~/.gemini
  if [[ -d "$GEMINI_DIR" && "$DRY_RUN" != "true" ]]; then
    rm -rf "${GEMINI_DIR}/settings.json" "${GEMINI_DIR}/GEMINI.md" "${GEMINI_DIR}/config" 2>/dev/null || true
    ok "Cleaned Antigravity configuration"
  fi

  # 3. Clean Claude settings.json
  SETTINGS_PATH="${CLAUDE_DIR}/settings.json"
  if [[ -f "$SETTINGS_PATH" && "$DRY_RUN" != "true" ]]; then
    sed -i '/127\.0\.0\.1:20128/d' "$SETTINGS_PATH" 2>/dev/null || true
    ok "Cleaned claude settings.json"
  fi

  # 4. Remove binary
  if [[ -f "${INSTALL_DIR}/acs" && "$DRY_RUN" != "true" ]]; then
    rm -f "${INSTALL_DIR}/acs" "${INSTALL_DIR}/acs-cli"
    ok "Removed binary"
  fi

  # 5. Remove PATH from shell RC files
  for RC in "${HOME}/.bashrc" "${HOME}/.zshrc" "${HOME}/.profile" "${HOME}/.config/fish/config.fish"; do
    if [[ -f "$RC" ]] && grep -q "${INSTALL_DIR}" "$RC" 2>/dev/null; then
      if [[ "$DRY_RUN" != "true" ]]; then
        sed -i '/# ACS/d' "$RC" 2>/dev/null || true
        sed -i "\|${INSTALL_DIR}|d" "$RC" 2>/dev/null || true
      fi
      ok "Cleaned PATH from $(basename "$RC")"
    fi
  done

  # 6. Remove entire ~/.acs directory
  if [[ -d "$ACS_DIR" && "$DRY_RUN" != "true" ]]; then
    rm -rf "$ACS_DIR"
    ok "Purged entire ~/.acs directory"
  fi
fi

echo ""
echo "────────────────────────────────────"
if [[ "$PURGE" == "true" ]]; then
  echo "  ACS fully uninstalled and purged."
else
  echo "  ACS automation & services removed."
  echo "  License and database preserved in ~/.acs/"
  echo "  Run with --purge to completely erase all data."
fi
echo "────────────────────────────────────"
echo ""

#!/usr/bin/env bash
# uninstall.sh — Standalone ACS CLI uninstaller for Linux/macOS
# Usage: curl -fsSL https://raw.githubusercontent.com/andyvandaric/acs/main/uninstall.sh | bash
# Or:    bash uninstall.sh [--purge]
set -euo pipefail

PURGE=false
for arg in "$@"; do
  case "$arg" in
    --purge) PURGE=true ;;
  esac
done

info() { echo "  $*"; }
ok() { echo "✅ $*"; }
warn() { echo "⚠️  $*" >&2; }

echo ""
echo "⚡ ACS CLI — Uninstaller"
echo "────────────────────────────────────"
if [[ "$PURGE" == "true" ]]; then
  echo "  Mode: PURGE (remove everything)"
else
  echo "  Mode: Safe (keep skills, configs, data)"
  echo "  Use --purge to remove everything"
fi
echo ""

INSTALL_DIR="${HOME}/.acs/bin"
SKILLS_DIR="${HOME}/.acs/skills"
SKILLS_DIR_ALT="${XDG_DATA_HOME:-${HOME}/.local/share}/acs-cli/skills"
HERMES_PROFILE="${HOME}/.hermes/profiles/acs-default"
KANBAN_DB="${HOME}/.hermes/kanban.db"
CLAUDE_DIR="${HOME}/.claude"

# ─── Stop service ───────────────────────────────────────────────────────────
info "Stopping service..."
if command -v acs-cli >/dev/null 2>&1; then
  acs-cli service uninstall 2>/dev/null || true
fi

# Kill by PID file
PID_FILE=""
if [[ -n "${XDG_DATA_HOME:-}" ]]; then
  PID_FILE="${XDG_DATA_HOME}/acs-cli/acs-cli.pid"
else
  PID_FILE="${HOME}/.local/share/acs-cli/acs-cli.pid"
fi
if [[ -f "$PID_FILE" ]]; then
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
      launchctl unload "$PLIST" 2>/dev/null || true
      rm -f "$PLIST"
      ok "Removed launchd plist"
    fi
    ;;
  *)
    UNIT="${HOME}/.config/systemd/user/acs-cli.service"
    if [[ -f "$UNIT" ]]; then
      systemctl --user stop acs-cli.service 2>/dev/null || true
      systemctl --user disable acs-cli.service 2>/dev/null || true
      rm -f "$UNIT"
      systemctl --user daemon-reload 2>/dev/null || true
      ok "Removed systemd unit"
    fi
    ;;
esac

# ─── Remove automation (always) ────────────────────────────────────────────
info "Removing automation..."
REMOVED=0

if [[ -d "${HERMES_PROFILE}/hooks/intent-capture" ]]; then
  rm -rf "${HERMES_PROFILE}/hooks/intent-capture"
  REMOVED=$((REMOVED + 1))
fi

for script in watchdog.py board-sweep.py token-refresh.py; do
  if [[ -f "${HERMES_PROFILE}/scripts/${script}" ]]; then
    rm -f "${HERMES_PROFILE}/scripts/${script}"
    REMOVED=$((REMOVED + 1))
  fi
done

# Remove post-commit hook if it's ACS-only
if git rev-parse --git-dir >/dev/null 2>&1; then
  HOOK="$(git rev-parse --git-dir)/hooks/post-commit"
  if [[ -f "$HOOK" ]] && grep -q "acs-cli\|acs-docs" "$HOOK" 2>/dev/null; then
    if grep -q "# --- ACS START ---" "$HOOK"; then
      # Multi-purpose hook — strip ACS section
      sed -i '/# --- ACS START ---/,/# --- ACS END ---/d' "$HOOK"
    else
      rm -f "$HOOK"
    fi
    REMOVED=$((REMOVED + 1))
  fi
fi

[[ $REMOVED -gt 0 ]] && ok "Removed $REMOVED automation items"

# ─── Purge-only removals ───────────────────────────────────────────────────
if [[ "$PURGE" == "true" ]]; then
  echo ""
  info "Purging all data..."

  # Skills
  for sdir in "$SKILLS_DIR" "$SKILLS_DIR_ALT"; do
    if [[ -d "$sdir" ]]; then
      rm -rf "$sdir"
    fi
  done
  ok "Removed skills"

  # Hermes config (SOUL.md only, preserve config.yaml for re-install)
  if [[ -f "${HERMES_PROFILE}/SOUL.md" ]]; then
    rm -f "${HERMES_PROFILE}/SOUL.md"
    ok "Removed SOUL.md"
  fi

  # Claude config — remove 9router apiUrl lines
  if [[ -f "${CLAUDE_DIR}/settings.json" ]]; then
    sed -i '/127\.0\.0\.1:20128/d' "${CLAUDE_DIR}/settings.json"
    ok "Cleaned claude settings.json"
  fi

  # Kanban DB (backup first)
  if [[ -f "$KANBAN_DB" ]]; then
    cp "$KANBAN_DB" "${KANBAN_DB}.uninstall-backup"
    rm -f "$KANBAN_DB"
    ok "Removed kanban.db (backup: ${KANBAN_DB}.uninstall-backup)"
  fi

  # Binary
  if [[ -f "${INSTALL_DIR}/acs-cli" ]]; then
    rm -f "${INSTALL_DIR}/acs-cli"
    ok "Removed binary"
  fi

  # Remove PATH from shell RC
  for RC in "${HOME}/.bashrc" "${HOME}/.zshrc" "${HOME}/.config/fish/config.fish"; do
    if [[ -f "$RC" ]] && grep -q "${INSTALL_DIR}" "$RC" 2>/dev/null; then
      # Remove the ACS CLI comment + PATH line
      sed -i '/# ACS CLI/d' "$RC"
      sed -i "\|${INSTALL_DIR}|d" "$RC"
      ok "Cleaned PATH from $(basename "$RC")"
    fi
  done

  # Remove empty .acs dir
  if [[ -d "${HOME}/.acs" ]]; then
    rmdir "${HOME}/.acs/bin" 2>/dev/null || true
    rmdir "${HOME}/.acs" 2>/dev/null || true
  fi
fi

echo ""
echo "────────────────────────────────────"
if [[ "$PURGE" == "true" ]]; then
  echo "  ACS CLI fully removed."
else
  echo "  Automation removed. Skills + configs preserved."
  echo "  Run with --purge to remove everything."
fi
echo "────────────────────────────────────"
echo ""

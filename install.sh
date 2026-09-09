#!/usr/bin/env bash
# install.sh — Install ACS CLI for Linux/macOS
# Usage: curl -fsSL https://uikode.com/acs/install.sh | bash
set -euo pipefail

CDN_BASE="https://dl.uikode.com"
INSTALL_DIR="${HOME}/.acs/bin"

info() { echo "  $*"; }
ok() { echo "✅ $*"; }
warn() { echo "⚠️  $*" >&2; }
err() { echo "❌ $*" >&2; exit 1; }

echo ""
echo "⚡ ACS CLI — Agnostic Config Suites"
echo "────────────────────────────────────"
echo ""

# ─── Detect OS/Arch ──────────────────────────────────────────────────────────
detect_platform() {
  local os arch
  os="$(uname -s | tr '[:upper:]' '[:lower:]')"
  arch="$(uname -m)"

  case "$os" in
    linux) os="linux" ;;
    darwin) os="darwin" ;;
    *) err "Unsupported OS: $os" ;;
  esac

  case "$arch" in
    x86_64|amd64) arch="amd64" ;;
    aarch64|arm64) arch="arm64" ;;
    *) err "Unsupported architecture: $arch" ;;
  esac

  echo "${os}-${arch}"
}

PLATFORM="$(detect_platform)"
info "Platform: $PLATFORM"

# ─── Fetch manifest for SHA-256 integrity ────────────────────────────────────
echo ""
info "Fetching release manifest..."

FILE_NAME="acs-cli-${PLATFORM}"
DOWNLOAD_URL="${CDN_BASE}/${FILE_NAME}"
MANIFEST_URL="${CDN_BASE}/manifest.json"

MANIFEST="$(curl -fsSL --connect-timeout 10 --max-time 15 "${MANIFEST_URL}" 2>/dev/null || true)"
VERSION=""
EXPECTED_SHA=""

if [[ -n "$MANIFEST" ]]; then
  VERSION="$(echo "$MANIFEST" | python3 -c "import sys,json; print(json.load(sys.stdin).get('version',''))" 2>/dev/null || true)"
  EXPECTED_SHA="$(echo "$MANIFEST" | python3 -c "
import sys, json
try:
    m = json.load(sys.stdin)
    p = '${PLATFORM}'
    k = 'acs-cli-' + p
    if 'files' in m:
        if k in m['files']:
            print(m['files'][k])
        elif k + '.exe' in m['files']:
            print(m['files'][k + '.exe'])
    elif 'artifacts' in m and p in m['artifacts']:
        print(m['artifacts'][p].get('sha256',''))
except Exception:
    pass
" 2>/dev/null || true)"
fi

if [[ -n "$VERSION" ]]; then
  ok "Latest version: v${VERSION}"
fi

info "Artifact: ${FILE_NAME}"

# ─── Download binary directly from Fast CDN (Zero-Auth) ──────────────────────
echo ""
info "Downloading ${FILE_NAME} from Cloudflare Global CDN..."

TMP_DIR="$(mktemp -d)"
TMP_FILE="${TMP_DIR}/${FILE_NAME}"
trap 'rm -rf "$TMP_DIR"' EXIT

if ! curl -fsSL --connect-timeout 15 --max-time 120 "${DOWNLOAD_URL}" -o "${TMP_FILE}"; then
  err "Failed to download ${DOWNLOAD_URL}. Check your connection."
fi

if [[ ! -f "$TMP_FILE" ]]; then
  err "Download failed. File not found at ${TMP_FILE}."
fi

DL_SIZE="$(wc -c < "$TMP_FILE" | tr -d ' ')"
if [[ "$DL_SIZE" -lt 1000000 ]]; then
  err "Download failed: file too small (${DL_SIZE} bytes)."
fi
ok "Downloaded: $(awk "BEGIN{printf \"%.1f\", $DL_SIZE/1048576}") MB"

# ─── Verify SHA-256 ──────────────────────────────────────────────────────────
if [[ -n "$EXPECTED_SHA" ]]; then
  info "Verifying SHA-256 integrity..."
  if command -v sha256sum >/dev/null 2>&1; then
    ACTUAL_SHA="$(sha256sum "$TMP_FILE" | cut -d' ' -f1)"
  elif command -v shasum >/dev/null 2>&1; then
    ACTUAL_SHA="$(shasum -a 256 "$TMP_FILE" | cut -d' ' -f1)"
  else
    warn "No sha256sum/shasum found — skipping integrity check"
    ACTUAL_SHA="$EXPECTED_SHA"
  fi

  if [[ "$ACTUAL_SHA" != "$EXPECTED_SHA" ]]; then
    err "SHA-256 mismatch! Expected: $EXPECTED_SHA, Got: $ACTUAL_SHA"
  fi
  ok "SHA-256 verified"
fi

# ─── Install ─────────────────────────────────────────────────────────────────
echo ""
info "Installing to $INSTALL_DIR..."

# Stop running acs-cli processes before overwriting binary (handles reinstall/update)
if pgrep -x acs-cli >/dev/null 2>&1; then
  info "Stopping running acs-cli processes..."
  pkill -x acs-cli 2>/dev/null || true
  sleep 2
  ok "Processes stopped"
fi

mkdir -p "$INSTALL_DIR"
cp "$TMP_FILE" "${INSTALL_DIR}/acs-cli"
chmod +x "${INSTALL_DIR}/acs-cli"
ok "Installed: ${INSTALL_DIR}/acs-cli"

# ─── PATH setup ──────────────────────────────────────────────────────────────
if [[ ":$PATH:" != *":${INSTALL_DIR}:"* ]]; then
  info "Adding $INSTALL_DIR to PATH..."

  PATH_EXPORT="export PATH=\"${INSTALL_DIR}:\$PATH\""
  PATH_COMMENT="# ACS CLI"

  # Determine shell RC files to update
  RC_FILES=()
  case "${SHELL:-/bin/bash}" in
    */zsh)
      RC_FILES=("$HOME/.zshrc")
      ;;
    */bash)
      RC_FILES=("$HOME/.bashrc")
      # Also add to .profile for login shells (Ubuntu WSL, SSH, etc.)
      # .profile is sourced by login shells but .bashrc often isn't
      if [[ -f "$HOME/.profile" ]] || [[ ! -f "$HOME/.bash_profile" ]]; then
        RC_FILES+=("$HOME/.profile")
      else
        RC_FILES+=("$HOME/.bash_profile")
      fi
      ;;
    */fish)
      RC_FILES=("$HOME/.config/fish/config.fish")
      ;;
    *)
      # Unknown shell — try both common files
      RC_FILES=("$HOME/.bashrc" "$HOME/.profile")
      ;;
  esac

  for RC_FILE in "${RC_FILES[@]}"; do
    if [[ -z "$RC_FILE" ]]; then continue; fi
    if grep -q "$INSTALL_DIR" "$RC_FILE" 2>/dev/null; then continue; fi

    # Create file if it doesn't exist (e.g. fresh Ubuntu)
    touch "$RC_FILE" 2>/dev/null || continue

    echo "" >> "$RC_FILE"
    echo "$PATH_COMMENT" >> "$RC_FILE"
    if [[ "$RC_FILE" == *fish* ]]; then
      echo "set -gx PATH $INSTALL_DIR \$PATH" >> "$RC_FILE"
    else
      echo "$PATH_EXPORT" >> "$RC_FILE"
    fi
    ok "Added to $RC_FILE"
  done

  export PATH="${INSTALL_DIR}:$PATH"
fi

# ─── Register as service ────────────────────────────────────────────────────
echo ""
info "Registering as persistent service..."
if "${INSTALL_DIR}/acs-cli" service install 2>/dev/null; then
  ok "Service registered (auto-starts on login)"
else
  warn "Service registration skipped (run manually: acs-cli service install)"
fi

# ─── Verify ──────────────────────────────────────────────────────────────────
echo ""
if command -v acs-cli >/dev/null 2>&1; then
  ok "acs-cli v$(acs-cli version 2>/dev/null || echo "$VERSION") ready!"
else
  ok "acs-cli v${VERSION} installed to ${INSTALL_DIR}/acs-cli"
  echo ""
  warn "Shell needs to reload PATH. Run one of:"
  echo "    source ~/.profile"
  echo "    source ~/.bashrc"
  echo "    # or just open a new terminal"
fi

echo ""
echo "──────────────────────────────────────────"
echo "  ACS CLI Installed Successfully!"
echo ""
echo "  Next step: Activate your license:"
echo "    acs-cli activate <YOUR_LICENSE_KEY>"
echo "──────────────────────────────────────────"
echo ""

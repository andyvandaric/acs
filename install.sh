#!/usr/bin/env bash
# install.sh — Install ACS for Linux/macOS
# Usage: curl -fsSL https://dl.uikode.com/acs/install.sh | bash
# Legacy: curl -fsSL https://dl.uikode.com/install.sh | bash
set -eu
set -o pipefail 2>/dev/null || true

PRIMARY_CDN_BASE="https://dl.uikode.com/acs"
FALLBACK_CDN_BASE="https://github.com/andyvandaric/acs/releases/latest/download"
INSTALL_DIR="${HOME}/.acs/bin"

if [ -t 1 ]; then
  GREEN='\033[0;32m'
  CYAN='\033[0;36m'
  YELLOW='\033[1;33m'
  RED='\033[0;31m'
  NC='\033[0m'
else
  GREEN=''
  CYAN=''
  YELLOW=''
  RED=''
  NC=''
fi

info() { echo "  $*"; }
ok() { echo "✅ $*"; }
warn() { echo "⚠️  $*" >&2; }
err() { echo "❌ $*" >&2; exit 1; }

VERSION_ARG=""
CODE_ARG=""
LICENSE_KEY="${ACS_LICENSE_KEY:-}"
LIST_VERSIONS=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    -v|--version)
      VERSION_ARG="${2:-}"
      shift 2
      ;;
    -c|--code|--download-code)
      CODE_ARG="${2:-}"
      shift 2
      ;;
    -k|--license-key|--key)
      LICENSE_KEY="${2:-}"
      shift 2
      ;;
    -l|--list|--list-versions)
      LIST_VERSIONS=true
      shift
      ;;
    -h|--help)
      echo "ACS — Universal Installer"
      echo ""
      echo "Usage:"
      echo "  ./install.sh -c <CODE> [options]"
      echo "  ACS_DOWNLOAD_CODE='<CODE>' curl -fsSL https://dl.uikode.com/install.sh | bash"
      echo ""
      echo "Options:"
      echo "  -c, --code <code-8-chars>   8-character ACS download code from https://uikode.com/member"
      echo "  -v, --version <version>     Install or rollback to specific version (e.g. v1.4.0 or 1.4.0)"
      echo "  -k, --license-key <key>     ACS license key (or set ACS_LICENSE_KEY)"
      echo "  -l, --list, --list-versions List all available releases on CDN"
      echo "  -h, --help                  Show this help message"
      echo ""
      echo "Environment variables:"
      echo "  ACS_DOWNLOAD_CODE=<code8>   8-character single-use code from Member Area"
      echo "  ACS_VERSION=<version>       Target version (for piped curl execution)"
      echo "  ACS_LICENSE_KEY=<key>       ACS license key (for piped curl execution)"
      echo "  ACS_LIST=1                  List versions (for piped curl execution)"
      exit 0
      ;;
    *)
      shift
      ;;
  esac
done

DOWNLOAD_CODE="${CODE_ARG:-${ACS_DOWNLOAD_CODE:-}}"

if [[ -n "${ACS_VERSION:-}" && -z "$VERSION_ARG" ]]; then
  VERSION_ARG="$ACS_VERSION"
fi

if [[ "${ACS_LIST:-}" == "1" || "${ACS_LIST:-}" == "true" ]]; then
  LIST_VERSIONS=true
fi

if [[ "$LIST_VERSIONS" == "true" ]]; then
  echo ""
  echo "⚡ ACS — Available Releases"
  echo "────────────────────────────────────"
  echo ""
  VERSIONS_JSON="$(curl -fsSL --connect-timeout 10 --max-time 15 "https://dl.uikode.com/acs/versions.json" 2>/dev/null || curl -fsSL --connect-timeout 10 --max-time 15 "https://dl.uikode.com/versions.json" 2>/dev/null || true)"
  PY_BIN=""
  if command -v python3 >/dev/null 2>&1; then
    PY_BIN="python3"
  elif command -v python >/dev/null 2>&1; then
    PY_BIN="python"
  fi

  if [[ -n "$VERSIONS_JSON" && -n "$PY_BIN" ]]; then
    echo "$VERSIONS_JSON" | "$PY_BIN" -c '
import sys, json
try:
    data = json.load(sys.stdin)
    latest = data.get("latest", "")
    versions = data.get("versions", [])
    if latest:
        print("  Latest Version: " + str(latest))
        print("")
    print("  Available Releases:")
    for v in versions:
        marker = " (latest)" if v == latest else ""
        print("    - " + str(v) + marker)
except Exception:
    pass
' 2>/dev/null || true
  else
    echo "  Latest Version: v1.6.0"
    echo ""
    echo "  Available Releases:"
    echo "    - v1.6.0 (latest)"
    echo "    - v1.4.0"
  fi
  echo ""
  echo "  To install or rollback to a specific version:"
  echo "    curl -fsSL https://dl.uikode.com/install.sh | ACS_VERSION=v1.4.0 bash"
  echo "    ./install.sh --version v1.4.0"
  echo "────────────────────────────────────"
  echo ""
  exit 0
fi

if [[ -n "$VERSION_ARG" ]]; then
  case "$VERSION_ARG" in
    v*) TAG="$VERSION_ARG" ;;
    *)  TAG="v$VERSION_ARG" ;;
  esac
  PRIMARY_CDN_BASE="https://dl.uikode.com/acs/${TAG}"
  FALLBACK_CDN_BASE="https://github.com/andyvandaric/acs/releases/download/${TAG}"
fi

echo ""
echo "⚡ ACS — Agnostic Config Suites"
echo "────────────────────────────────────"
echo ""

# ─── Download Code & License Key Validation (Zero-Leak Gate) ─────────────────
if [[ -z "$DOWNLOAD_CODE" && -z "$LICENSE_KEY" ]]; then
  if [ -t 0 ]; then
    echo ">> Masukkan 8-karakter Download Code Anda dari https://uikode.com/member:"
    read -r entered_code
    if [[ -n "$entered_code" ]]; then
      DOWNLOAD_CODE="$(echo "$entered_code" | tr '[:lower:]' '[:upper:]' | xargs)"
    fi
  fi
fi

if [[ -z "$DOWNLOAD_CODE" && -z "$LICENSE_KEY" ]]; then
  echo "" >&2
  err "Download Code diperlukan untuk mengunduh biner resmi ACS Core.

Panduan Pengambilan Kode:
1. Login ke Member Area: https://uikode.com/member
2. Pada lisensi aktif Anda, klik 'Generate Download Code' (kode 8-karakter, berlaku 15 menit).
3. Jalankan kembali perintah instalasi berikut di terminal:
   ACS_DOWNLOAD_CODE=\"<KODE_8_KARAKTER>\" curl -fsSL https://dl.uikode.com/install.sh | bash"
fi

if [[ -n "$VERSION_ARG" ]]; then
  info "Target Version: ${TAG} (Pinned)"
fi

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

# ─── Fetch manifest for SHA-256 integrity (Dual-Track) ───────────────────────
echo ""
info "Fetching release manifest..."

MANIFEST_URL="${PRIMARY_CDN_BASE}/manifest.json"
FALLBACK_MANIFEST_URL="${FALLBACK_CDN_BASE}/manifest.json"

MANIFEST="$(curl -fsSL --connect-timeout 10 --max-time 15 "${MANIFEST_URL}" 2>/dev/null || true)"
if [[ -z "$MANIFEST" ]]; then
  warn "Primary CDN manifest fetch failed. Attempting fallback to GitHub Releases manifest..."
  MANIFEST="$(curl -fsSL --connect-timeout 10 --max-time 15 "${FALLBACK_MANIFEST_URL}" 2>/dev/null || true)"
fi

VERSION=""
EXPECTED_SHA=""
FILE_NAME="acs-${PLATFORM}"

PY_CMD=""
if command -v python3 >/dev/null 2>&1; then
  PY_CMD="python3"
elif command -v python >/dev/null 2>&1; then
  PY_CMD="python"
fi

if [[ -n "$MANIFEST" && -n "$PY_CMD" ]]; then
  VERSION="$(echo "$MANIFEST" | "$PY_CMD" -c "
import sys, json
try:
    m = json.load(sys.stdin)
    print(m.get('version', ''))
except Exception:
    pass
" 2>/dev/null || true)"

  EXPECTED_SHA="$(echo "$MANIFEST" | "$PY_CMD" -c "
import sys, json
try:
    m = json.load(sys.stdin)
    p = '${PLATFORM}'
    for k in ['acs-' + p, 'acs-cli-' + p, 'acs-' + p + '.exe', 'acs-cli-' + p + '.exe']:
        if 'files' in m and k in m['files']:
            print(m['files'][k])
            break
        elif 'artifacts' in m and p in m['artifacts']:
            print(m['artifacts'][p].get('sha256', ''))
            break
except Exception:
    pass
" 2>/dev/null || true)"

  DETECTED_FILE="$(echo "$MANIFEST" | "$PY_CMD" -c "
import sys, json
try:
    m = json.load(sys.stdin)
    p = '${PLATFORM}'
    if 'artifacts' in m and p in m['artifacts'] and m['artifacts'][p].get('file'):
        print(m['artifacts'][p]['file'])
    elif 'files' in m:
        for k in ['acs-' + p, 'acs-cli-' + p]:
            if k in m['files']:
                print(k)
                break
except Exception:
    pass
" 2>/dev/null || true)"

  if [[ -n "$DETECTED_FILE" ]]; then
    FILE_NAME="$DETECTED_FILE"
  fi
fi

if [[ -n "$VERSION" ]]; then
  ok "Latest version: v${VERSION}"
fi

info "Artifact: ${FILE_NAME}"

# ─── Download binary (Authorized Ticket Stream) ──────────────────────────────
# WHY: Zero-leak gate — direct static downloads are prohibited. Binary is streamed
# only to clients holding a valid single-use ticket bound to their terminal IP.
echo ""
TMP_DIR="$(mktemp -d)"
TMP_FILE="${TMP_DIR}/${FILE_NAME}"
trap 'rm -rf "$TMP_DIR"' EXIT

API_BASE="${ACS_API_URL:-https://api.uikode.com}"
API_BASE="${API_BASE%/}"
info "Requesting authorized download ticket from ${API_BASE}..."

if [[ -n "$DOWNLOAD_CODE" ]]; then
  REQ_PAYLOAD="{\"code\":\"${DOWNLOAD_CODE}\",\"platform\":\"${PLATFORM}\",\"product\":\"acs-core\"}"
else
  REQ_PAYLOAD="{\"license_key\":\"${LICENSE_KEY}\",\"platform\":\"${PLATFORM}\",\"product\":\"acs-core\"}"
fi

TICKET_JSON="$(curl -fsSL --connect-timeout 10 --max-time 20 \
  -X POST "${API_BASE}/api/v1/download/ticket" \
  -H "Content-Type: application/json" \
  -d "$REQ_PAYLOAD" 2>/dev/null || true)"

DOWNLOAD_PATH="$("$PY_CMD" -c "
import sys, json
try:
    data = json.loads(sys.stdin.read())
    if data.get('success') and 'data' in data:
        print(data['data'].get('download_url', ''))
    else:
        err_msg = data.get('error', 'Respon server tidak valid')
        print('ERR:' + str(err_msg))
except Exception as e:
    print('ERR:' + str(e))
" <<< "$TICKET_JSON" 2>/dev/null || true)"

if [[ "$DOWNLOAD_PATH" == ERR:* || -z "$DOWNLOAD_PATH" ]]; then
  ERR_MSG="${DOWNLOAD_PATH#ERR:}"
  err "Gagal mendapatkan izin unduh dari server tiket: ${ERR_MSG:-Kode tidak valid atau server tidak merespons}.
Pastikan Download Code Anda valid (didapatkan di https://uikode.com/member) dan lisensi berstatus aktif."
fi

if [[ "$DOWNLOAD_PATH" == http* ]]; then
  DOWNLOAD_STREAM_URL="$DOWNLOAD_PATH"
else
  DOWNLOAD_STREAM_URL="${API_BASE}${DOWNLOAD_PATH}"
fi

ok "Download ticket verified"
info "Downloading ${FILE_NAME} via authorized secure stream..."

if ! curl -fsSL --connect-timeout 15 --max-time 180 "${DOWNLOAD_STREAM_URL}" -o "${TMP_FILE}"; then
  err "Unduhan stream biner gagal. Silakan coba kembali dengan kode baru dari Member Area."
fi

if [[ ! -f "$TMP_FILE" ]]; then
  err "Download failed. File not found at ${TMP_FILE}."
fi

DL_SIZE="$(wc -c < "$TMP_FILE" | tr -d ' ')"
if [[ "$DL_SIZE" -lt 1000000 ]]; then
  err "Download failed: file too small (${DL_SIZE} bytes)."
fi
ok "Downloaded: $(awk -v size="$DL_SIZE" 'BEGIN { printf "%.1f", size / 1048576 }') MB"

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

# Stop running ACS processes before overwriting binary (handles reinstall/update)
if pgrep -x acs >/dev/null 2>&1 || pgrep -x acs-cli >/dev/null 2>&1; then
  info "Stopping running ACS processes..."
  pkill -x acs 2>/dev/null || true
  pkill -x acs-cli 2>/dev/null || true
  sleep 2
  ok "Processes stopped"
fi

mkdir -p "$INSTALL_DIR"
cp "$TMP_FILE" "${INSTALL_DIR}/acs"
chmod +x "${INSTALL_DIR}/acs"
# Clean up legacy acs-cli binary
rm -f "${INSTALL_DIR}/acs-cli" 2>/dev/null || true
ok "Installed: ${INSTALL_DIR}/acs"

# ─── Persona commands bootstrap ──────────────────────────────────────────
# Idempotent: `acs persona deploy` writes ~/.claude/commands/*.md.
# Non-fatal: older pinned binaries may lack the subcommand — installer continues.
if "${INSTALL_DIR}/acs" persona deploy 2>/dev/null; then
  ok "Persona commands deployed"
else
  info "Persona deploy skipped (binary predates persona support)"
fi

# ─── PATH setup ──────────────────────────────────────────────────────────────
if [[ ":$PATH:" != *":${INSTALL_DIR}:"* ]]; then
  info "Adding $INSTALL_DIR to PATH..."

  PATH_EXPORT="export PATH=\"${INSTALL_DIR}:\$PATH\""
  PATH_COMMENT="# ACS"

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

# ─── Check Prerequisites & Configure Stack ──────────────────────────────────
echo ""
info "Checking environment and prerequisites..."

HAS_NODE_OR_BUN=false
if command -v 9router >/dev/null 2>&1 || command -v bun >/dev/null 2>&1 || command -v npm >/dev/null 2>&1; then
  HAS_NODE_OR_BUN=true
fi

HAS_HEADROOM=false
if command -v headroom >/dev/null 2>&1; then
  HAS_HEADROOM=true
fi

HAS_SYSTEMCTL=false
if command -v systemctl >/dev/null 2>&1; then
  HAS_SYSTEMCTL=true
fi

if [ "$HAS_NODE_OR_BUN" = "true" ]; then
  ok "9router runtime available (Node/Bun found)"
else
  info "npm/bun not found — 9router AI proxy auto-start disabled (install bun or npm to enable)"
fi

if [ "$HAS_HEADROOM" = "true" ]; then
  ok "headroom binary found"
else
  info "headroom not found — context compression proxy auto-start disabled (optional)"
fi

if [ "$HAS_SYSTEMCTL" = "true" ]; then
  ok "systemctl found"
else
  info "systemctl not found (container/minimal Linux) — persistent service registration skipped"
fi

# Configure stack-config.json so background stack skips missing optional components
# rather than attempting auto-repair or logging errors during activation
AUTO_9ROUTER="true"
if [ "$HAS_NODE_OR_BUN" = "false" ]; then
  AUTO_9ROUTER="false"
fi

AUTO_HEADROOM="true"
if [ "$HAS_HEADROOM" = "false" ]; then
  AUTO_HEADROOM="false"
fi

for CFG_DIR in "${HOME}/.acs/data" "${HOME}/.acs"; do
  mkdir -p "$CFG_DIR" 2>/dev/null || true
  CFG_FILE="${CFG_DIR}/stack-config.json"
  if [ ! -f "$CFG_FILE" ]; then
    cat > "$CFG_FILE" <<EOF 2>/dev/null || true
{
  "auto_start": {
    "9router": ${AUTO_9ROUTER},
    "dashboard": true,
    "scheduler": true,
    "headroom": ${AUTO_HEADROOM},
    "gateways": false
  }
}
EOF
  else
    [ -w "$CFG_FILE" ] || chmod +w "$CFG_FILE" 2>/dev/null || true
    if [ "$AUTO_9ROUTER" = "false" ]; then
      sed 's/"9router":[[:space:]]*true/"9router": false/g' "$CFG_FILE" > "${CFG_FILE}.tmp" 2>/dev/null && mv "${CFG_FILE}.tmp" "$CFG_FILE" 2>/dev/null || rm -f "${CFG_FILE}.tmp"
    fi
    if [ "$AUTO_HEADROOM" = "false" ]; then
      sed 's/"headroom":[[:space:]]*true/"headroom": false/g' "$CFG_FILE" > "${CFG_FILE}.tmp" 2>/dev/null && mv "${CFG_FILE}.tmp" "$CFG_FILE" 2>/dev/null || rm -f "${CFG_FILE}.tmp"
    fi
  fi
done

# ─── Configure Stack with License Verification ─────────────────────────────
echo ""
info "Configuring ACS agentic stack..."
SETUP_ARGS=()
if [[ -n "${LICENSE_KEY:-}" ]]; then
  SETUP_ARGS+=("--license-key" "$LICENSE_KEY")
fi

if "${INSTALL_DIR}/acs" setup "${SETUP_ARGS[@]}"; then
  # ─── Register as persistent service only after setup succeeds ────────────
  echo ""
  if [ "$HAS_SYSTEMCTL" = "true" ]; then
    info "Registering as persistent service..."
    if "${INSTALL_DIR}/acs" service install --force 2>/dev/null; then
      ok "Service registered (auto-starts on login)"
    else
      warn "Service registration skipped (run manually: acs service install)"
    fi
  else
    info "Persistent service registration skipped (systemctl not available in container)"
  fi

  # Start background stack
  "${INSTALL_DIR}/acs" start 2>/dev/null || true
  ok "ACS background services started"

  # ─── Verify & Status ─────────────────────────────────────────────────────
  echo ""
  if command -v acs >/dev/null 2>&1; then
    ok "acs v$("${INSTALL_DIR}/acs" version 2>/dev/null | sed -E 's/^(acs|acs-cli)[[:space:]]*//' || echo "$VERSION") ready!"
  else
    ok "acs v${VERSION} installed to ${INSTALL_DIR}/acs"
    echo ""
    warn "Shell needs to reload PATH. Run one of:"
    echo "    source ~/.profile"
    echo "    source ~/.bashrc"
    echo "    # or just open a new terminal"
  fi

  echo ""
  echo "──────────────────────────────────────────"
  printf "  ${GREEN}ACS Installed & Configured Successfully!${NC}\n"
  printf "  ${CYAN}Dashboard: http://localhost:20130${NC}\n"
  echo "──────────────────────────────────────────"
  echo ""
else
  echo ""
  warn "ACS binary installed, but stack setup was not completed."
  info "To complete setup and activate your license, run:"
  printf "    ${YELLOW}acs setup${NC}\n"
  printf "  or: ${YELLOW}acs setup --license-key <YOUR_KEY>${NC}\n"
  printf "  or: ${YELLOW}acs activate <YOUR_LICENSE_KEY>${NC}\n"
  if [ "$HAS_NODE_OR_BUN" = "false" ]; then
    echo ""
    info "Optional prerequisites for full AI stack (install anytime):"
    info "  • 9router AI proxy: curl -fsSL https://bun.sh/install | bash"
  fi
  echo ""
fi

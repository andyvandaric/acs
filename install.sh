#!/usr/bin/env bash
# install.sh — Install ACS CLI for Linux/macOS
# Usage: curl -fsSL https://raw.githubusercontent.com/andyvandaric/acs/main/install.sh | bash
set -euo pipefail

GITHUB_SOURCE_REPO="andyvandaric/andyvand-opencode-config"
GITHUB_SOURCE_BRANCH="main"
WHATSAPP_ORDER_URL="https://wa.me/6281289731212?text=Mau%20order%20ACS%20nya%2C%20mohon%20infonya%20ya"
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

# ─── Resolve GitHub token ────────────────────────────────────────────────────
echo ""
info "Resolving GitHub auth..."

TOKEN=""

if [[ -n "${GITHUB_TOKEN:-}" ]]; then
  TOKEN="${GITHUB_TOKEN}"
  info "Auth: using GITHUB_TOKEN env var"
elif command -v gh >/dev/null 2>&1; then
  if gh auth status >/dev/null 2>&1; then
    # Try gh auth token (v2.17+), fallback to hosts.yml for older versions
    TOKEN="$(gh auth token 2>/dev/null || true)"
    if [[ -z "$TOKEN" ]]; then
      # Old gh CLI — read token from hosts.yml directly
      GH_HOSTS="${XDG_CONFIG_HOME:-$HOME/.config}/gh/hosts.yml"
      if [[ -f "$GH_HOSTS" ]]; then
        TOKEN="$(grep -A2 'github.com' "$GH_HOSTS" | grep 'oauth_token' | awk '{print $2}' | tr -d '[:space:]')"
      fi
    fi
    if [[ -n "$TOKEN" ]]; then
      info "Auth: using gh CLI token"
    else
      info "Auth: using gh CLI session"
    fi
  else
    info "gh CLI found but not authenticated. Attempting login..."
    if gh auth login 2>/dev/null; then
      gh auth refresh -h github.com -s repo >/dev/null 2>&1 || true
      TOKEN="$(gh auth token 2>/dev/null || true)"
      if [[ -z "$TOKEN" ]]; then
        GH_HOSTS="${XDG_CONFIG_HOME:-$HOME/.config}/gh/hosts.yml"
        if [[ -f "$GH_HOSTS" ]]; then
          TOKEN="$(grep -A2 'github.com' "$GH_HOSTS" | grep 'oauth_token' | awk '{print $2}' | tr -d '[:space:]')"
        fi
      fi
      ok "GitHub login successful"
    else
      warn "gh auth login failed"
    fi
  fi
fi

if [[ -z "$TOKEN" ]]; then
  warn "No GitHub token found."
  info "Install GitHub CLI and login: gh auth login"
  info "Or set GITHUB_TOKEN environment variable."
  err "Cannot proceed without GitHub authentication."
fi

# ─── Verify repo access ─────────────────────────────────────────────────────
echo ""
info "Verifying access..."
USE_GH_API=false

HTTP_CODE="$(curl -sS --http1.1 -o /dev/null -w "%{http_code}" \
  --connect-timeout 10 --max-time 30 \
  -H "Authorization: token ${TOKEN}" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/${GITHUB_SOURCE_REPO}/contents/assets/acs?ref=${GITHUB_SOURCE_BRANCH}")"

if [[ "$HTTP_CODE" == "200" ]]; then
  ok "Repo access verified"
elif [[ "$HTTP_CODE" == "401" || "$HTTP_CODE" == "403" || "$HTTP_CODE" == "404" ]]; then
  # Try gh API as fallback (works when gh session has access but token lacks repo scope)
  if command -v gh >/dev/null 2>&1 && gh api "repos/${GITHUB_SOURCE_REPO}/contents/assets/acs?ref=${GITHUB_SOURCE_BRANCH}" >/dev/null 2>&1; then
    ok "Repo access verified (via gh)"
    # Switch to gh-based download mode
    USE_GH_API=true
  else
    warn "You do not have ACS access yet (HTTP $HTTP_CODE)."
    echo ""
    echo "  Order ACS: $WHATSAPP_ORDER_URL"
    echo ""
    if command -v xdg-open >/dev/null 2>&1; then xdg-open "$WHATSAPP_ORDER_URL" 2>/dev/null || true
    elif command -v open >/dev/null 2>&1; then open "$WHATSAPP_ORDER_URL" 2>/dev/null || true; fi
    exit 1
  fi
elif [[ "$HTTP_CODE" == "000" ]]; then
  err "Cannot reach GitHub API (HTTP 000). Check network/proxy/firewall."
else
  err "Unexpected GitHub API response (HTTP $HTTP_CODE)"
fi

# ─── Fetch manifest ──────────────────────────────────────────────────────────
echo ""
info "Fetching release manifest..."

if [[ "$USE_GH_API" == "true" ]]; then
  MANIFEST="$(gh api "repos/${GITHUB_SOURCE_REPO}/contents/assets/acs/manifest.json?ref=${GITHUB_SOURCE_BRANCH}" -H "Accept: application/vnd.github.raw")"
else
  MANIFEST="$(curl -fsSL --http1.1 \
    -H "Authorization: token ${TOKEN}" \
    -H "Accept: application/vnd.github.raw" \
    "https://api.github.com/repos/${GITHUB_SOURCE_REPO}/contents/assets/acs/manifest.json?ref=${GITHUB_SOURCE_BRANCH}")"
fi

VERSION="$(echo "$MANIFEST" | python3 -c "import sys,json; print(json.load(sys.stdin)['version'])" 2>/dev/null || true)"
if [[ -z "$VERSION" ]]; then
  err "Failed to parse manifest.json"
fi
ok "Latest version: v${VERSION}"

# ─── Determine artifact ──────────────────────────────────────────────────────
FILE_NAME="$(echo "$MANIFEST" | python3 -c "
import sys, json
m = json.load(sys.stdin)
p = '${PLATFORM}'
if p in m['artifacts']:
    print(m['artifacts'][p]['file'])
" 2>/dev/null || true)"

EXPECTED_SHA="$(echo "$MANIFEST" | python3 -c "
import sys, json
m = json.load(sys.stdin)
p = '${PLATFORM}'
if p in m['artifacts']:
    print(m['artifacts'][p]['sha256'])
" 2>/dev/null || true)"

if [[ -z "$FILE_NAME" ]]; then
  err "No artifact found for platform: $PLATFORM"
fi

info "Artifact: $FILE_NAME"

# ─── Download binary ─────────────────────────────────────────────────────────
echo ""
info "Downloading $FILE_NAME..."

TMP_DIR="$(mktemp -d)"
TMP_FILE="${TMP_DIR}/${FILE_NAME}"
trap 'rm -rf "$TMP_DIR"' EXIT

DOWNLOADED=false

# Method 1: Git LFS sparse checkout (most reliable for large files)
if command -v git >/dev/null 2>&1 && git lfs version >/dev/null 2>&1; then
  LFS_DIR="${TMP_DIR}/lfs-clone"
  if git clone --no-checkout --depth 1 --branch "${GITHUB_SOURCE_BRANCH}" \
    "https://x-access-token:${TOKEN}@github.com/${GITHUB_SOURCE_REPO}.git" \
    "$LFS_DIR" >/dev/null 2>&1; then
    cd "$LFS_DIR"
    git sparse-checkout set "assets/acs/$FILE_NAME" >/dev/null 2>&1
    git checkout >/dev/null 2>&1
    git lfs pull --include="assets/acs/$FILE_NAME" >/dev/null 2>&1
    cd - >/dev/null
    if [[ -f "$LFS_DIR/assets/acs/$FILE_NAME" ]] && [[ "$(wc -c < "$LFS_DIR/assets/acs/$FILE_NAME")" -gt 1000000 ]]; then
      cp "$LFS_DIR/assets/acs/$FILE_NAME" "$TMP_FILE"
      DOWNLOADED=true
    fi
  fi
  rm -rf "$LFS_DIR" 2>/dev/null || true
fi

# Method 2: gh API download (when curl token auth fails)
if [[ "$DOWNLOADED" != "true" ]] && [[ "$USE_GH_API" == "true" ]]; then
  DL_URL="$(gh api "repos/${GITHUB_SOURCE_REPO}/contents/assets/acs/${FILE_NAME}?ref=${GITHUB_SOURCE_BRANCH}" --jq .download_url 2>/dev/null || true)"
  if [[ -n "$DL_URL" && "$DL_URL" != "null" ]]; then
    curl -fsSL --http1.1 "$DL_URL" -o "$TMP_FILE" 2>/dev/null
    if [[ -f "$TMP_FILE" ]] && [[ "$(wc -c < "$TMP_FILE")" -gt 1000000 ]]; then
      DOWNLOADED=true
    fi
  fi
fi

# Method 3: GitHub Contents API download_url (curl with token)
if [[ "$DOWNLOADED" != "true" ]]; then
  DL_URL="$(curl -fsSL --http1.1 \
    -H "Authorization: token ${TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/${GITHUB_SOURCE_REPO}/contents/assets/acs/${FILE_NAME}?ref=${GITHUB_SOURCE_BRANCH}" \
    | python3 -c "import sys,json; print(json.load(sys.stdin).get('download_url',''))" 2>/dev/null || true)"
  if [[ -n "$DL_URL" ]]; then
    curl -fsSL --http1.1 -H "Authorization: token ${TOKEN}" "$DL_URL" -o "$TMP_FILE"
    DOWNLOADED=true
  fi
fi

if [[ "$DOWNLOADED" != "true" ]] || [[ ! -f "$TMP_FILE" ]]; then
  err "Download failed. Try again or check your network."
fi

DL_SIZE="$(wc -c < "$TMP_FILE" | tr -d ' ')"
if [[ "$DL_SIZE" -lt 1000000 ]]; then
  err "Download failed: file too small (${DL_SIZE} bytes). May be a Git LFS pointer."
fi
ok "Downloaded: $(awk "BEGIN{printf \"%.1f\", $DL_SIZE/1048576}") MB"

# ─── Verify SHA-256 ──────────────────────────────────────────────────────────
if [[ -n "$EXPECTED_SHA" ]]; then
  info "Verifying integrity..."
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

mkdir -p "$INSTALL_DIR"
cp "$TMP_FILE" "${INSTALL_DIR}/acs-cli"
chmod +x "${INSTALL_DIR}/acs-cli"
ok "Installed: ${INSTALL_DIR}/acs-cli"

# ─── PATH setup ──────────────────────────────────────────────────────────────
if [[ ":$PATH:" != *":${INSTALL_DIR}:"* ]]; then
  info "Adding $INSTALL_DIR to PATH..."

  SHELL_RC=""
  case "${SHELL:-/bin/bash}" in
    */zsh) SHELL_RC="$HOME/.zshrc" ;;
    */bash) SHELL_RC="$HOME/.bashrc" ;;
    */fish) SHELL_RC="$HOME/.config/fish/config.fish" ;;
  esac

  if [[ -n "$SHELL_RC" ]]; then
    if ! grep -q "$INSTALL_DIR" "$SHELL_RC" 2>/dev/null; then
      echo "" >> "$SHELL_RC"
      echo "# ACS CLI" >> "$SHELL_RC"
      if [[ "$SHELL_RC" == *fish* ]]; then
        echo "set -gx PATH $INSTALL_DIR \$PATH" >> "$SHELL_RC"
      else
        echo "export PATH=\"${INSTALL_DIR}:\$PATH\"" >> "$SHELL_RC"
      fi
      ok "Added to $SHELL_RC"
    fi
  fi

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
  ok "Installed! Restart your shell or run: export PATH=\"${INSTALL_DIR}:\$PATH\""
fi

echo ""
echo "────────────────────────────────────"
echo "  Next: acs-cli setup"
echo "────────────────────────────────────"
echo ""

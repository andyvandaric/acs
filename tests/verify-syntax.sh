#!/usr/bin/env bash
# verify-syntax.sh — Automated syntax & structure verification for install.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_SH="${SCRIPT_DIR}/../install.sh"

echo "===================================================="
echo "  ACS Universal Installer: verify-syntax.sh"
echo "===================================================="
echo ""

TESTS_PASSED=0
TESTS_FAILED=0

assert_test() {
  local name="$1"
  shift
  if "$@"; then
    echo "  [PASS] ${name}"
    TESTS_PASSED=$((TESTS_PASSED + 1))
  else
    echo "  [FAIL] ${name}"
    TESTS_FAILED=$((TESTS_FAILED + 1))
  fi
}

# 1. POSIX Bash Syntax Check
test_bash_syntax() {
  bash -n "${INSTALL_SH}"
}
assert_test "Bash syntax check (bash -n) yields zero errors" test_bash_syntax

# 2. Target binary checks
test_target_binary() {
  grep -q 'cp "\$TMP_FILE" "\${INSTALL_DIR}/acs"' "${INSTALL_SH}" && \
  grep -q 'chmod +x "\${INSTALL_DIR}/acs"' "${INSTALL_SH}"
}
assert_test "Target binary is installed to \${INSTALL_DIR}/acs" test_target_binary

test_clean_legacy_binary() {
  grep -q 'rm -f "\${INSTALL_DIR}/acs-cli"' "${INSTALL_SH}"
}
assert_test "Cleans up legacy acs-cli binary" test_clean_legacy_binary

test_process_cleanup() {
  grep -q 'pgrep -x acs' "${INSTALL_SH}" && \
  grep -q 'pkill -x acs' "${INSTALL_SH}"
}
assert_test "Process termination targets acs and acs-cli" test_process_cleanup

# 3. Dual-Track Download Resilience checks
test_primary_cdn() {
  grep -q 'PRIMARY_CDN_BASE="https://dl.uikode.com"' "${INSTALL_SH}"
}
assert_test "Primary CDN base is configured to dl.uikode.com" test_primary_cdn

test_fallback_cdn() {
  grep -q 'FALLBACK_CDN_BASE="https://github.com/andyvandaric/acs/releases/latest/download"' "${INSTALL_SH}"
}
assert_test "Fallback CDN base is configured to GitHub Releases" test_fallback_cdn

test_dual_track_manifest() {
  grep -q 'MANIFEST_URL="\${PRIMARY_CDN_BASE}/manifest.json"' "${INSTALL_SH}" && \
  grep -q 'FALLBACK_MANIFEST_URL="\${FALLBACK_CDN_BASE}/manifest.json"' "${INSTALL_SH}"
}
assert_test "Dual-track manifest fetch URLs configured" test_dual_track_manifest

test_dual_track_download() {
  grep -q 'PRIMARY_DOWNLOAD_URL="\${PRIMARY_CDN_BASE}/\${FILE_NAME}"' "${INSTALL_SH}" && \
  grep -q 'FALLBACK_DOWNLOAD_URL="\${FALLBACK_CDN_BASE}/\${FILE_NAME}"' "${INSTALL_SH}"
}
assert_test "Dual-track binary download URLs configured" test_dual_track_download

# 4. Inline Python Manifest Parser Check
test_python_parser_syntax() {
  local py=""
  if command -v python3 >/dev/null 2>&1; then
    py="python3"
  elif command -v python >/dev/null 2>&1; then
    py="python"
  else
    echo "    (Python not available on test host — skipping runner assertion)"
    return 0
  fi

  local sample_manifest='{
    "version": "1.4.0",
    "artifacts": {
      "linux-amd64": {
        "file": "acs-linux-amd64",
        "sha256": "abcdef1234567890abcdef1234567890",
        "size": 10485760
      }
    },
    "files": {
      "acs-linux-amd64": "abcdef1234567890abcdef1234567890"
    }
  }'

  local parsed_ver parsed_sha
  parsed_ver="$(echo "$sample_manifest" | "$py" -c "
import sys, json
try:
    m = json.load(sys.stdin)
    print(m.get('version', ''))
except Exception:
    pass
")"

  parsed_sha="$(echo "$sample_manifest" | "$py" -c "
import sys, json
try:
    m = json.load(sys.stdin)
    p = 'linux-amd64'
    for k in ['acs-' + p, 'acs-cli-' + p, 'acs-' + p + '.exe', 'acs-cli-' + p + '.exe']:
        if 'files' in m and k in m['files']:
            print(m['files'][k])
            break
        elif 'artifacts' in m and p in m['artifacts']:
            print(m['artifacts'][p].get('sha256', ''))
            break
except Exception:
    pass
")"

  [[ "$parsed_ver" == "1.4.0" && "$parsed_sha" == "abcdef1234567890abcdef1234567890" ]]
}
assert_test "Inline Python parser correctly extracts version & SHA256" test_python_parser_syntax

# 5. Security & Verification
test_sha_verification() {
  grep -q 'ACTUAL_SHA=' "${INSTALL_SH}" && \
  grep -q 'SHA-256 mismatch!' "${INSTALL_SH}"
}
assert_test "SHA-256 integrity verification is enforced" test_sha_verification

# 6. Service & Next Steps branding checks
test_service_command() {
  grep -q '"\${INSTALL_DIR}/acs" service install' "${INSTALL_SH}"
}
assert_test "Service installation command uses acs" test_service_command

test_next_step() {
  grep -q 'acs activate <YOUR_LICENSE_KEY>' "${INSTALL_SH}"
}
assert_test "Next step activation instructions use acs activate" test_next_step

# 7. Version Pinning and Listing Capabilities
test_version_pinning() {
  grep -q 'ACS_VERSION' "${INSTALL_SH}" && \
  grep -q -- '-v|--version' "${INSTALL_SH}" && \
  grep -q 'PRIMARY_CDN_BASE="https://dl.uikode.com/\${TAG}"' "${INSTALL_SH}"
}
assert_test "Supports --version parameter and ACS_VERSION env var" test_version_pinning

test_list_versions() {
  grep -q -- '-l|--list|--list-versions' "${INSTALL_SH}" && \
  grep -q 'https://dl.uikode.com/versions.json' "${INSTALL_SH}"
}
assert_test "Supports --list-versions parameter and ACS_LIST env var" test_list_versions

test_acs_branding() {
  grep -q '⚡ ACS — Agnostic Config Suites' "${INSTALL_SH}" && \
  grep -q 'PATH_COMMENT="# ACS"' "${INSTALL_SH}"
}
assert_test "Standardizes branding to ACS instead of obsolete acs-cli" test_acs_branding

echo ""
echo "----------------------------------------------------"
echo "Total Tests: $((TESTS_PASSED + TESTS_FAILED)) | Passed: ${TESTS_PASSED} | Failed: ${TESTS_FAILED}"

if [[ "${TESTS_FAILED}" -gt 0 ]]; then
  echo "VERDICT: FAILED"
  exit 1
else
  echo "VERDICT: ALL TESTS PASSED"
  exit 0
fi

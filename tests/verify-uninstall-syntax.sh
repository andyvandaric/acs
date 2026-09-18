#!/usr/bin/env bash
# verify-uninstall-syntax.sh — Automated syntax & structure verification for uninstall.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UNINSTALL_SH="${SCRIPT_DIR}/../uninstall.sh"

echo "===================================================="
echo "  ACS Universal Uninstaller: verify-uninstall-syntax.sh"
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
  bash -n "${UNINSTALL_SH}"
}
assert_test "Bash syntax check (bash -n) yields zero errors" test_bash_syntax

# 2. Parameters
test_parameters() {
  grep -q -- '-p|--purge' "${UNINSTALL_SH}" && \
  grep -q -- '-f|--force' "${UNINSTALL_SH}" && \
  grep -q -- '-d|--dry-run' "${UNINSTALL_SH}" && \
  grep -q -- '-h|--help' "${UNINSTALL_SH}"
}
assert_test "Supports --purge, --force, --dry-run, and --help parameters" test_parameters

# 3. Binary Delegation
test_binary_delegation() {
  grep -q 'TARGET_EXE="\${INSTALL_DIR}/acs"' "${UNINSTALL_SH}" && \
  grep -q '"\$TARGET_EXE" "\${CLI_ARGS\[@\]}"' "${UNINSTALL_SH}"
}
assert_test "Binary delegation checks for target acs and executes uninstall" test_binary_delegation

# 4. Service and Timers Cleanup
test_service_cleanup() {
  grep -q 'systemctl --user stop "\$unit"' "${UNINSTALL_SH}" && \
  grep -q 'acs\.service' "${UNINSTALL_SH}" && \
  grep -q 'acs-watchdog\.timer' "${UNINSTALL_SH}"
}
assert_test "Stops and cleans systemd units and timers (acs.service, acs-watchdog.timer)" test_service_cleanup

# 5. Surgical MCP Cleanup
test_mcp_cleanup() {
  grep -q "mcpServers" "${UNINSTALL_SH}" && \
  grep -q "acs-" "${UNINSTALL_SH}"
}
assert_test "Includes surgical cleanup of ACS MCP servers from .claude.json" test_mcp_cleanup

# 6. Recursive Purge
test_recursive_purge() {
  grep -q 'rm -rf "\$ACS_DIR"' "${UNINSTALL_SH}"
}
assert_test "Purge mode removes entire ~/.acs directory recursively" test_recursive_purge

# 7. Sovereign CDN URL
test_cdn_url() {
  grep -q 'https://dl\.uikode\.com/uninstall\.sh' "${UNINSTALL_SH}"
}
assert_test "Usage references Sovereign CDN dl.uikode.com" test_cdn_url

echo ""
echo "----------------------------------------------------"
echo "Total Tests: $((TESTS_PASSED + TESTS_FAILED)) | Passed: ${TESTS_PASSED} | Failed: ${TESTS_FAILED}"
if [[ ${TESTS_FAILED} -gt 0 ]]; then
  echo "VERDICT: FAILED"
  exit 1
else
  echo "VERDICT: ALL TESTS PASSED"
  exit 0
fi

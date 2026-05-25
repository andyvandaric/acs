# uninstall.ps1 — Standalone ACS CLI uninstaller for Windows
# Usage: irm https://raw.githubusercontent.com/andyvandaric/acs/main/uninstall.ps1 | iex
# Or:    .\uninstall.ps1 [-Purge]
$ErrorActionPreference = "Stop"

param([switch]$Purge)

# Re-parse args if invoked via piped iex
if (-not $Purge -and ($args -contains "--purge" -or $args -contains "-Purge")) {
    $Purge = $true
}

function Info($msg) { Write-Host "  $msg" }
function Ok($msg) { Write-Host "✅ $msg" -ForegroundColor Green }
function Warn($msg) { Write-Host "⚠️  $msg" -ForegroundColor Yellow }

$INSTALL_DIR = "$env:USERPROFILE\.acs\bin"
$SKILLS_DIR = "$env:USERPROFILE\.acs\skills"
$HERMES_PROFILE = "$env:LOCALAPPDATA\hermes\profiles\acs-default"
$KANBAN_DB = "$env:LOCALAPPDATA\hermes\kanban.db"
$CLAUDE_DIR = "$env:USERPROFILE\.claude"
$PID_FILE = "$env:LOCALAPPDATA\acs-cli\acs-cli.pid"

Write-Host ""
Write-Host "⚡ ACS CLI — Uninstaller" -ForegroundColor Cyan
Write-Host "────────────────────────────────────"
if ($Purge) {
    Write-Host "  Mode: PURGE (remove everything)" -ForegroundColor Red
} else {
    Write-Host "  Mode: Safe (keep skills, configs, data)"
    Write-Host "  Use -Purge to remove everything"
}
Write-Host ""

# ─── Stop service ───────────────────────────────────────────────────────────
Info "Stopping service..."
if (Test-Path "$INSTALL_DIR\acs-cli.exe") {
    try { & "$INSTALL_DIR\acs-cli.exe" service uninstall 2>$null } catch {}
}

if (Test-Path $PID_FILE) {
    try {
        $pidJson = Get-Content $PID_FILE -Raw | ConvertFrom-Json
        $proc = Get-Process -Id $pidJson.pid -ErrorAction SilentlyContinue
        if ($proc) {
            Stop-Process -Id $pidJson.pid -Force -ErrorAction SilentlyContinue
            Ok "Stopped service (PID $($pidJson.pid))"
        }
    } catch {}
    Remove-Item $PID_FILE -Force -ErrorAction SilentlyContinue
}

# ─── Remove service registration (registry Run key) ────────────────────────
Info "Removing service registration..."
$regKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
$regValue = "ACS_CLI_Service"
try {
    $existing = Get-ItemProperty -Path $regKey -Name $regValue -ErrorAction SilentlyContinue
    if ($existing) {
        Remove-ItemProperty -Path $regKey -Name $regValue -Force
        Ok "Removed registry Run key"
    }
} catch {}

# ─── Remove automation (always) ────────────────────────────────────────────
Info "Removing automation..."
$removed = 0

$hooksDir = Join-Path $HERMES_PROFILE "hooks\intent-capture"
if (Test-Path $hooksDir) {
    Remove-Item $hooksDir -Recurse -Force
    $removed++
}

$scripts = @("watchdog.py", "board-sweep.py", "token-refresh.py")
foreach ($script in $scripts) {
    $scriptPath = Join-Path $HERMES_PROFILE "scripts\$script"
    if (Test-Path $scriptPath) {
        Remove-Item $scriptPath -Force
        $removed++
    }
}

# Remove post-commit hook if in a git repo
try {
    $gitDir = git rev-parse --git-dir 2>$null
    if ($gitDir) {
        $hookPath = Join-Path $gitDir "hooks\post-commit"
        if ((Test-Path $hookPath) -and (Select-String -Path $hookPath -Pattern "acs-cli|acs-docs" -Quiet)) {
            if (Select-String -Path $hookPath -Pattern "# --- ACS START ---" -Quiet) {
                $content = Get-Content $hookPath -Raw
                $content = $content -replace '(?s)# --- ACS START ---.*?# --- ACS END ---\r?\n?', ''
                Set-Content $hookPath $content
            } else {
                Remove-Item $hookPath -Force
            }
            $removed++
        }
    }
} catch {}

if ($removed -gt 0) { Ok "Removed $removed automation items" }

# ─── Purge-only removals ───────────────────────────────────────────────────
if ($Purge) {
    Write-Host ""
    Info "Purging all data..."

    # Skills (check both possible locations)
    $skillsPaths = @($SKILLS_DIR, "$env:LOCALAPPDATA\acs-cli\skills")
    foreach ($sp in $skillsPaths) {
        if (Test-Path $sp) {
            Remove-Item $sp -Recurse -Force
        }
    }
    Ok "Removed skills"

    # Hermes SOUL.md
    $soulPath = Join-Path $HERMES_PROFILE "SOUL.md"
    if (Test-Path $soulPath) {
        Remove-Item $soulPath -Force
        Ok "Removed SOUL.md"
    }

    # Claude config — remove 9router apiUrl lines
    $settingsPath = Join-Path $CLAUDE_DIR "settings.json"
    if (Test-Path $settingsPath) {
        $content = Get-Content $settingsPath -Raw
        $content = $content -replace '(?m)^.*127\.0\.0\.1:20128.*\r?\n?', ''
        Set-Content $settingsPath $content
        Ok "Cleaned claude settings.json"
    }

    # Kanban DB (backup first)
    if (Test-Path $KANBAN_DB) {
        Copy-Item $KANBAN_DB "$KANBAN_DB.uninstall-backup" -Force
        Remove-Item $KANBAN_DB -Force
        Ok "Removed kanban.db (backup: $KANBAN_DB.uninstall-backup)"
    }

    # Binary (rename since running process can't delete itself)
    $binaryPath = Join-Path $INSTALL_DIR "acs-cli.exe"
    if (Test-Path $binaryPath) {
        $uninstallPath = "$binaryPath.uninstall"
        Move-Item $binaryPath $uninstallPath -Force -ErrorAction SilentlyContinue
        Ok "Removed binary (renamed to .uninstall)"
    }

    # Remove PATH from user environment
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -like "*$INSTALL_DIR*") {
        $newPath = ($currentPath -split ";" | Where-Object { $_ -ne $INSTALL_DIR }) -join ";"
        [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        Ok "Removed from PATH"
    }

    # Remove empty .acs dir
    $acsDir = "$env:USERPROFILE\.acs"
    if ((Test-Path $acsDir) -and -not (Get-ChildItem $acsDir -Recurse -File)) {
        Remove-Item $acsDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host ""
Write-Host "────────────────────────────────────"
if ($Purge) {
    Write-Host "  ACS CLI fully removed." -ForegroundColor Green
} else {
    Write-Host "  Automation removed. Skills + configs preserved."
    Write-Host "  Run with -Purge to remove everything."
}
Write-Host "────────────────────────────────────"
Write-Host ""

# uninstall.ps1 - Standalone ACS CLI uninstaller for Windows
# Usage: irm https://dl.uikode.com/uninstall.ps1 | iex
# Or:    .\uninstall.ps1 [-Purge] [-Force] [-DryRun] [-Help]
param(
    [switch]$Purge,
    [switch]$Force,
    [switch]$DryRun,
    [switch]$Help
)

$ErrorActionPreference = "Stop"

# Re-parse args if invoked via piped iex
if (-not $Purge -and ($args -contains "--purge" -or $args -contains "-Purge" -or $args -contains "-p")) {
    $Purge = $true
}
if (-not $Force -and ($args -contains "--force" -or $args -contains "-Force" -or $args -contains "-f")) {
    $Force = $true
}
if (-not $DryRun -and ($args -contains "--dry-run" -or $args -contains "-DryRun" -or $args -contains "-d")) {
    $DryRun = $true
}
if (-not $Help -and ($args -contains "--help" -or $args -contains "-Help" -or $args -contains "-h")) {
    $Help = $true
}

if ($Help) {
    Write-Host ""
    Write-Host "ACS - Universal Uninstaller" -ForegroundColor Cyan
    Write-Host "------------------------------------"
    Write-Host "Usage:"
    Write-Host "  irm https://dl.uikode.com/uninstall.ps1 | iex"
    Write-Host "  .\uninstall.ps1 [-Purge] [-Force] [-DryRun] [-Help]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -Purge    Remove all ACS data, skills, configs, and ~/.acs directory"
    Write-Host "  -Force    Skip interactive confirmations"
    Write-Host "  -DryRun   Preview actions without modifying files or system state"
    Write-Host "  -Help     Show this help message"
    Write-Host ""
    return
}

function Info($msg) { Write-Host "  $msg" }
function Ok($msg) { Write-Host "[OK] $msg" -ForegroundColor Green }
function Warn($msg) { Write-Host "[WARN] $msg" -ForegroundColor Yellow }

$ACS_DIR = "$env:USERPROFILE\.acs"
$INSTALL_DIR = "$ACS_DIR\bin"
$SKILLS_DIR = "$ACS_DIR\skills"
$HERMES_PROFILE = "$env:LOCALAPPDATA\hermes\profiles\acs-default"
$KANBAN_DB = "$env:LOCALAPPDATA\hermes\kanban.db"
$CLAUDE_DIR = "$env:USERPROFILE\.claude"
# Canonical runtime PID files first, legacy PID file last (pre-migration installs).
$PID_FILES = @(
    "$env:USERPROFILE\.acs\data\acs-coder.pid",
    "$env:USERPROFILE\.acs\data\acs-daemon.pid",
    "$env:LOCALAPPDATA\acs-cli\acs-cli.pid"
)

Write-Host ""
Write-Host "ACS - Uninstaller" -ForegroundColor Cyan
Write-Host "------------------------------------"
if ($DryRun) {
    Write-Host "  Mode: DRY RUN (no changes will be applied)" -ForegroundColor Yellow
} elseif ($Purge) {
    Write-Host "  Mode: PURGE (remove everything)" -ForegroundColor Red
} else {
    Write-Host "  Mode: Safe (keep skills, configs, data)"
    Write-Host "  Use -Purge to remove everything"
}
Write-Host ""

# --- Stop service & delegate to acs.exe -------------------------------------
Info "Stopping service..."
$cliArgs = @("service", "uninstall")
if ($Purge) { $cliArgs += "--purge" }
if ($Force) { $cliArgs += "--force" }
if ($DryRun) { $cliArgs += "--dry-run" }

$targetExe = Join-Path $INSTALL_DIR "acs.exe"
$legacyExe = Join-Path $INSTALL_DIR "acs-cli.exe"
if (Test-Path $targetExe) {
    if (-not $DryRun) {
        try { & $targetExe @cliArgs 2>$null } catch {}
    } else {
        Info "[DRY RUN] Would run: $targetExe $($cliArgs -join ' ')"
    }
} elseif (Test-Path $legacyExe) {
    if (-not $DryRun) {
        try { & $legacyExe @cliArgs 2>$null } catch {}
    } else {
        Info "[DRY RUN] Would run: $legacyExe $($cliArgs -join ' ')"
    }
}

foreach ($pidFile in $PID_FILES) {
    if (Test-Path $pidFile) {
        if (-not $DryRun) {
            try {
                $pidJson = Get-Content $pidFile -Raw | ConvertFrom-Json
                $proc = Get-Process -Id $pidJson.pid -ErrorAction SilentlyContinue
                if ($proc) {
                    Stop-Process -Id $pidJson.pid -Force -ErrorAction SilentlyContinue
                    Ok "Stopped service (PID $($pidJson.pid))"
                }
            } catch {}
            Remove-Item $pidFile -Force -ErrorAction SilentlyContinue
        } else {
            Info "[DRY RUN] Would stop PID from $pidFile"
        }
    }
}

# --- Remove service registration (registry Run key + Scheduled Tasks) -------
Info "Removing service registration..."
$regKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
$regValue = "ACS_CLI_Service"
try {
    $existing = Get-ItemProperty -Path $regKey -Name $regValue -ErrorAction SilentlyContinue
    if ($existing) {
        if (-not $DryRun) {
            Remove-ItemProperty -Path $regKey -Name $regValue -Force
            Ok "Removed registry Run key"
        } else {
            Info "[DRY RUN] Would remove registry Run key $regValue"
        }
    }
} catch {}

foreach ($t in @("ACS Watchdog", "ACS Kanban Backup")) {
    if (-not $DryRun) {
        try { & schtasks.exe /Delete /TN $t /F 2>$null | Out-Null } catch {}
    } else {
        Info "[DRY RUN] Would delete scheduled task $t"
    }
}

# --- Remove automation (always) ---------------------------------------------
Info "Removing automation..."
$removed = 0

$hooksDir = Join-Path $HERMES_PROFILE "hooks\intent-capture"
if (Test-Path $hooksDir) {
    if (-not $DryRun) { Remove-Item $hooksDir -Recurse -Force }
    $removed++
}

$scripts = @("watchdog.py", "board-sweep.py", "token-refresh.py")
foreach ($script in $scripts) {
    $scriptPath = Join-Path $HERMES_PROFILE "scripts\$script"
    if (Test-Path $scriptPath) {
        if (-not $DryRun) { Remove-Item $scriptPath -Force }
        $removed++
    }
}

# Remove post-commit hook if in a git repo
try {
    $gitDir = git rev-parse --git-dir 2>$null
    if ($gitDir) {
        $hookPath = Join-Path $gitDir "hooks\post-commit"
        if ((Test-Path $hookPath) -and (Select-String -Path $hookPath -Pattern "acs |acs-cli|acs-docs" -Quiet)) {
            if (-not $DryRun) {
                if (Select-String -Path $hookPath -Pattern "# --- ACS START ---" -Quiet) {
                    $content = Get-Content $hookPath -Raw
                    $content = $content -replace '(?s)# --- ACS START ---.*?# --- ACS END ---\r?\n?', ''
                    Set-Content $hookPath $content
                } else {
                    Remove-Item $hookPath -Force
                }
            }
            $removed++
        }
    }
} catch {}

if ($removed -gt 0) { Ok "Removed $removed automation items" }

# --- Surgical MCP cleanup in .claude.json -----------------------------------
$claudeJsonPath = Join-Path $env:USERPROFILE ".claude.json"
if (Test-Path $claudeJsonPath) {
    try {
        $jsonObj = Get-Content $claudeJsonPath -Raw -Encoding UTF8 | ConvertFrom-Json
        if ($jsonObj -and $jsonObj.mcpServers) {
            $acsKeys = @($jsonObj.mcpServers.PSObject.Properties | Where-Object { $_.Name -like "acs-*" } | ForEach-Object { $_.Name })
            if ($acsKeys.Count -gt 0) {
                if (-not $DryRun) {
                    foreach ($k in $acsKeys) {
                        $jsonObj.mcpServers.PSObject.Properties.Remove($k)
                    }
                    $jsonObj | ConvertTo-Json -Depth 16 | Set-Content -Path $claudeJsonPath -Encoding UTF8
                    Ok "Removed $($acsKeys.Count) ACS MCP server(s) from .claude.json"
                } else {
                    Info "[DRY RUN] Would remove ACS MCP keys: $($acsKeys -join ', ')"
                }
            }
        }
    } catch {}
}

# --- Purge-only removals ----------------------------------------------------
if ($Purge) {
    Write-Host ""
    Info "Purging all data..."

    # Skills (check both possible locations)
    $skillsPaths = @($SKILLS_DIR, "$env:LOCALAPPDATA\acs-cli\skills")
    foreach ($sp in $skillsPaths) {
        if (Test-Path $sp) {
            if (-not $DryRun) { Remove-Item $sp -Recurse -Force }
        }
    }
    Ok "Removed skills"

    # Hermes SOUL.md
    $soulPath = Join-Path $HERMES_PROFILE "SOUL.md"
    if (Test-Path $soulPath) {
        if (-not $DryRun) { Remove-Item $soulPath -Force }
        Ok "Removed SOUL.md"
    }

    # Claude config - remove 9router apiUrl lines
    $settingsPath = Join-Path $CLAUDE_DIR "settings.json"
    if (Test-Path $settingsPath) {
        if (-not $DryRun) {
            $content = Get-Content $settingsPath -Raw
            $content = $content -replace '(?m)^.*127\.0\.0\.1:20128.*\r?\n?', ''
            Set-Content $settingsPath $content
        }
        Ok "Cleaned claude settings.json"
    }

    # Kanban DB (backup first)
    if (Test-Path $KANBAN_DB) {
        if (-not $DryRun) {
            Copy-Item $KANBAN_DB "$KANBAN_DB.uninstall-backup" -Force
            Remove-Item $KANBAN_DB -Force
        }
        Ok "Removed kanban.db (backup: $KANBAN_DB.uninstall-backup)"
    }

    # Binary (modern first, legacy fallback; rename since running process can't delete itself)
    $binaryPath = Join-Path $INSTALL_DIR "acs.exe"
    if (-not (Test-Path $binaryPath)) {
        $binaryPath = Join-Path $INSTALL_DIR "acs-cli.exe"
    }
    if (Test-Path $binaryPath) {
        if (-not $DryRun) {
            $uninstallPath = "$binaryPath.uninstall"
            Move-Item $binaryPath $uninstallPath -Force -ErrorAction SilentlyContinue
        }
        Ok "Removed binary"
    }

    # Remove PATH from user environment
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -like "*$INSTALL_DIR*") {
        if (-not $DryRun) {
            $newPath = ($currentPath -split ";" | Where-Object { $_ -ne $INSTALL_DIR }) -join ";"
            [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        }
        Ok "Removed from PATH"
    }

    # Remove entire ~/.acs directory recursively
    if (Test-Path $ACS_DIR) {
        if (-not $DryRun) {
            Remove-Item $ACS_DIR -Recurse -Force -ErrorAction SilentlyContinue
        }
        Ok "Purged $ACS_DIR"
    }
}

Write-Host ""
Write-Host "------------------------------------"
if ($DryRun) {
    Write-Host "  Dry run complete. No changes made." -ForegroundColor Yellow
} elseif ($Purge) {
    Write-Host "  ACS fully removed." -ForegroundColor Green
} else {
    Write-Host "  Automation removed. Skills + configs preserved."
    Write-Host "  Run with -Purge to remove everything."
}
Write-Host "------------------------------------"
Write-Host ""

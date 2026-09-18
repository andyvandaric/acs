# uninstall.ps1 — ACS Uninstaller for Windows
# Usage: irm https://dl.uikode.com/uninstall.ps1 | iex
# Or:    pwsh -NoProfile -ExecutionPolicy Bypass -File uninstall.ps1 [-Purge] [-Force] [-DryRun]

[CmdletBinding()]
param(
    [Alias("p")]
    [switch]$Purge,
    [Alias("f")]
    [switch]$Force,
    [Alias("d")]
    [switch]$DryRun,
    [Alias("h")]
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
if ($Help -or ($args -contains "--help" -or $args -contains "-Help" -or $args -contains "-h")) {
    Write-Host ""
    Write-Host "ACS - Uninstaller" -ForegroundColor Cyan
    Write-Host "------------------------------------"
    Write-Host "Usage:"
    Write-Host "  .\uninstall.ps1 [options]"
    Write-Host "  irm https://dl.uikode.com/uninstall.ps1 | iex"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -Purge, -p                 Purge mode: remove everything (binary, license, DB, skills, configs)"
    Write-Host "  -Force, -f                 Skip confirmation prompts"
    Write-Host "  -DryRun, -d                Show what would be removed without taking action"
    Write-Host "  -Help, -h                  Show this help screen"
    Write-Host ""
    return
}

$isPS7 = ($PSVersionTable.PSVersion.Major -ge 7)
$markOk = if ($isPS7) { "`u{2705} " } else { "[OK] " }
$markWarn = if ($isPS7) { "`u{26A0}`u{FE0F}  " } else { "[WARN] " }
$markBolt = if ($isPS7) { "`u{26A1} " } else { ">> " }

function Info($msg) { Write-Host "  $msg" }
function Ok($msg) { Write-Host "$script:markOk$msg" -ForegroundColor Green }
function Warn($msg) { Write-Host "$script:markWarn$msg" -ForegroundColor Yellow }

$INSTALL_DIR = Join-Path ([Environment]::GetFolderPath("UserProfile")) ".acs\bin"
$ACS_DIR = Join-Path ([Environment]::GetFolderPath("UserProfile")) ".acs"
$CLAUDE_DIR = Join-Path ([Environment]::GetFolderPath("UserProfile")) ".claude"
$GEMINI_DIR = Join-Path ([Environment]::GetFolderPath("UserProfile")) ".gemini"
$CLAUDE_JSON = Join-Path ([Environment]::GetFolderPath("UserProfile")) ".claude.json"

Write-Host ""
Write-Host "$markBolt ACS - Uninstaller" -ForegroundColor Cyan
Write-Host "------------------------------------"
if ($Purge) {
    Write-Host "  Mode: PURGE (remove binary, license, database, and all configs)" -ForegroundColor Red
} else {
    Write-Host "  Mode: Safe Mode (remove background services & hooks; preserve license & DB)" -ForegroundColor Green
    Write-Host "  Use -Purge to remove everything."
}
if ($DryRun) {
    Write-Host "  Execution: DRY-RUN (no files or services will be modified)" -ForegroundColor Yellow
}
Write-Host ""

# ─── 1. In-Binary Delegation (Preferred SSOT Engine) ─────────────────────────
$targetExe = Join-Path $INSTALL_DIR "acs.exe"
if (-not (Test-Path $targetExe)) {
    $cmdAcs = Get-Command "acs" -ErrorAction SilentlyContinue
    if ($cmdAcs) { $targetExe = $cmdAcs.Source }
}

if (Test-Path $targetExe) {
    Info "Delegating de-installation to ACS Core engine..."
    $cliArgs = @("uninstall")
    if ($Purge) { $cliArgs += "--purge" }
    if ($Force) { $cliArgs += "--force" }
    if ($DryRun) { $cliArgs += "--dry-run" }

    try {
        & $targetExe @cliArgs
        exit $LASTEXITCODE
    } catch {
        Warn "Binary delegation failed ($_). Falling back to standalone script cleanup..."
    }
}

# ─── 2. Standalone Fallback Cleanup (If binary is absent) ────────────────────
if (-not $Force -and -not $DryRun) {
    $promptMsg = if ($Purge) { "Are you sure you want to PURGE all ACS data, licenses, and binaries? (yes/N): " } else { "Remove ACS background services and automation? (Y/n): " }
    $confirm = Read-Host -Prompt $promptMsg
    if ($Purge) {
        if ($confirm.Trim().ToLower() -ne "yes") {
            Warn "Uninstallation cancelled."
            return
        }
    } else {
        if ($confirm.Trim().ToLower() -eq "n") {
            Warn "Uninstallation cancelled."
            return
        }
    }
}

# ─── Stop Running Processes ──────────────────────────────────────────────────
Info "Stopping running ACS processes..."
$procs = Get-Process -Name "acs", "acs-cli" -ErrorAction SilentlyContinue
if ($procs) {
    if (-not $DryRun) {
        $procs | Stop-Process -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 1
    }
    Ok "Stopped running processes"
}

# Check PID files
$pidFiles = @(
    Join-Path $ACS_DIR "data\acs-coder.pid",
    Join-Path $ACS_DIR "data\acs-daemon.pid",
    "$env:LOCALAPPDATA\acs-cli\acs-cli.pid"
)
foreach ($pf in $pidFiles) {
    if (Test-Path $pf) {
        try {
            $pidVal = Get-Content $pf -Raw -ErrorAction SilentlyContinue
            if ($pidVal -match '^\d+$') {
                $p = Get-Process -Id ([int]$pidVal.Trim()) -ErrorAction SilentlyContinue
                if ($p -and -not $DryRun) { $p | Stop-Process -Force -ErrorAction SilentlyContinue }
            }
        } catch {}
        if (-not $DryRun) { Remove-Item $pf -Force -ErrorAction SilentlyContinue }
    }
}

# ─── Remove OS Service Registration ──────────────────────────────────────────
Info "Removing service registrations..."
$regKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
$regValue = "ACS_CLI_Service"
try {
    if (Get-ItemProperty -Path $regKey -Name $regValue -ErrorAction SilentlyContinue) {
        if (-not $DryRun) { Remove-ItemProperty -Path $regKey -Name $regValue -Force -ErrorAction SilentlyContinue }
        Ok "Removed registry auto-start key"
    }
} catch {}

# ─── Remove Windows Scheduled Tasks ──────────────────────────────────────────
Info "Removing Windows Task Scheduler jobs..."
$tasks = @("ACS Watchdog", "ACS Kanban Backup", "ACS_9Router")
foreach ($t in $tasks) {
    try {
        if (-not $DryRun) {
            schtasks.exe /Delete /TN $t /F 2>&1 | Out-Null
        }
    } catch {}
}
Ok "Cleaned up scheduled tasks"

# ─── Remove Automation Hooks & Scripts ───────────────────────────────────────
Info "Cleaning automation hooks..."
$claudeHooks = Join-Path $CLAUDE_DIR "hooks"
if (Test-Path $claudeHooks) {
    if (-not $DryRun) {
        Get-ChildItem $claudeHooks -Filter "*.mjs" | Remove-Item -Force -ErrorAction SilentlyContinue
        Remove-Item (Join-Path $claudeHooks "package.json") -Force -ErrorAction SilentlyContinue
    }
    Ok "Cleaned Claude hooks"
}

$claudeHud = Join-Path $CLAUDE_DIR "hud\acs-hud.js"
if (Test-Path $claudeHud) {
    if (-not $DryRun) { Remove-Item $claudeHud -Force -ErrorAction SilentlyContinue }
    Ok "Cleaned Claude HUD"
}

# Remove git post-commit hook
try {
    $gitDir = git rev-parse --git-dir 2>$null
    if ($gitDir) {
        $hookPath = Join-Path $gitDir "hooks\post-commit"
        if ((Test-Path $hookPath) -and (Select-String -Path $hookPath -Pattern "acs" -Quiet)) {
            if (-not $DryRun) {
                if (Select-String -Path $hookPath -Pattern "# --- ACS START ---" -Quiet) {
                    $content = Get-Content $hookPath -Raw
                    $content = $content -replace '(?s)# --- ACS START ---.*?# --- ACS END ---\r?\n?', ''
                    Set-Content $hookPath $content
                } else {
                    Remove-Item $hookPath -Force
                }
            }
            Ok "Cleaned git post-commit hook"
        }
    }
} catch {}

# ─── Purge Mode Removals ─────────────────────────────────────────────────────
if ($Purge) {
    Write-Host ""
    Info "Purging all data, configs, licenses, and binaries..."

    # 1. Clean MCP servers from ~/.claude.json
    if (Test-Path $CLAUDE_JSON) {
        try {
            if (-not $DryRun) {
                $jsonObj = Get-Content $CLAUDE_JSON -Raw | ConvertFrom-Json
                if ($jsonObj.mcpServers) {
                    $propNames = $jsonObj.mcpServers.PSObject.Properties.Name | Where-Object { $_ -like "acs-*" -or $_ -like "acs_*" -or $_ -eq "acs" }
                    foreach ($pn in $propNames) {
                        $jsonObj.mcpServers.PSObject.Properties.Remove($pn)
                    }
                    $updatedJson = $jsonObj | ConvertTo-Json -Depth 10
                    Set-Content $CLAUDE_JSON $updatedJson
                }
            }
            Ok "Surgically cleaned ACS MCP servers from .claude.json"
        } catch {
            Warn "Could not update .claude.json: $_"
        }
    }

    # 2. Clean Antigravity ~/.gemini
    if (Test-Path $GEMINI_DIR) {
        if (-not $DryRun) {
            Remove-Item (Join-Path $GEMINI_DIR "settings.json") -Force -ErrorAction SilentlyContinue
            Remove-Item (Join-Path $GEMINI_DIR "GEMINI.md") -Force -ErrorAction SilentlyContinue
            Remove-Item (Join-Path $GEMINI_DIR "config") -Recurse -Force -ErrorAction SilentlyContinue
        }
        Ok "Cleaned Antigravity configuration"
    }

    # 3. Clean Claude settings.json 9router references
    $settingsPath = Join-Path $CLAUDE_DIR "settings.json"
    if (Test-Path $settingsPath) {
        try {
            if (-not $DryRun) {
                $sContent = Get-Content $settingsPath -Raw
                $sContent = $sContent -replace '(?m)^.*127\.0\.0\.1:20128.*\r?\n?', ''
                Set-Content $settingsPath $sContent
            }
            Ok "Cleaned claude settings.json"
        } catch {}
    }

    # 4. Clean persistent Environment Variables
    try {
        if (-not $DryRun) {
            reg delete "HKCU\Environment" /v "ANTHROPIC_BASE_URL" /f 2>$null | Out-Null
            reg delete "HKCU\Environment" /v "ANTHROPIC_AUTH_TOKEN" /f 2>$null | Out-Null
            reg delete "HKCU\Environment" /v "ACS_API_KEY" /f 2>$null | Out-Null
        }
        Ok "Cleaned registry environment variables"
    } catch {}

    # 5. Remove PATH from user environment
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -like "*$INSTALL_DIR*") {
        if (-not $DryRun) {
            $newPath = ($currentPath -split ";" | Where-Object { $_ -ne $INSTALL_DIR }) -join ";"
            [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        }
        Ok "Removed $INSTALL_DIR from User PATH"
    }

    # 6. Remove 9router database
    $nineRouterDir = "$env:APPDATA\9router"
    if (Test-Path $nineRouterDir) {
        if (-not $DryRun) { Remove-Item $nineRouterDir -Recurse -Force -ErrorAction SilentlyContinue }
        Ok "Removed 9router database"
    }

    # 7. Remove entire ~/.acs directory (license, database, binaries, logs)
    if (Test-Path $ACS_DIR) {
        if (-not $DryRun) {
            # Try removing binaries first
            Remove-Item (Join-Path $INSTALL_DIR "*") -Force -ErrorAction SilentlyContinue
            Remove-Item $ACS_DIR -Recurse -Force -ErrorAction SilentlyContinue
        }
        Ok "Purged entire ~/.acs directory"
    }
}

Write-Host ""
Write-Host ("-" * 36)
if ($Purge) {
    Write-Host "  ACS fully uninstalled and purged." -ForegroundColor Green
} else {
    Write-Host "  ACS automation & services removed." -ForegroundColor Green
    Write-Host "  License and database preserved in ~/.acs/"
    Write-Host "  Run with -Purge to completely erase all data."
}
Write-Host ("-" * 36)
Write-Host ""

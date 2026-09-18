# install.ps1 - Install ACS for Windows
# Usage: irm https://dl.uikode.com/install.ps1 | iex
# Or:    pwsh -NoProfile -ExecutionPolicy Bypass -File install.ps1

[CmdletBinding()]
param(
    [Alias("v")]
    [string]$Version = $env:ACS_VERSION,
    [Alias("k", "key")]
    [string]$LicenseKey = $env:ACS_LICENSE_KEY,
    [Alias("l", "list")]
    [switch]$ListVersions,
    [Alias("h")]
    [switch]$Help
)

# Enable TLS 1.2 for older Windows 10 / PowerShell 5.1 environments
try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
} catch {}

if ($env:ACS_LIST -eq "1" -or $env:ACS_LIST -eq "true") {
    $ListVersions = $true
}

if ($Help) {
    Write-Host ""
    Write-Host "ACS - Universal Installer" -ForegroundColor Cyan
    Write-Host "------------------------------------"
    Write-Host "Usage:"
    Write-Host "  .\install.ps1 [options]"
    Write-Host "  irm https://dl.uikode.com/install.ps1 | iex"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -Version, -v <version>     Install or rollback to specific version (e.g. v1.4.0 or 1.4.0)"
    Write-Host "  -LicenseKey, -k <key>      ACS license key (or set `$env:ACS_LICENSE_KEY)"
    Write-Host "  -ListVersions, -l          List all available releases on CDN"
    Write-Host "  -Help, -h                  Show this help screen"
    Write-Host ""
    Write-Host "Environment Variables:"
    Write-Host "  `$env:ACS_VERSION = 'v1.4.0' Pinned version for piped iex execution"
    Write-Host "  `$env:ACS_LICENSE_KEY = 'KEY' ACS license key for automated activation"
    Write-Host "  `$env:ACS_LIST = '1'         List available versions"
    Write-Host ""
    return
}

if ($ListVersions) {
    Write-Host ""
    Write-Host "ACS - Available Releases" -ForegroundColor Cyan
    Write-Host ("-" * 36)
    Write-Host ""
    $vData = $null
    try {
        $vData = Invoke-RestMethod -Uri "https://dl.uikode.com/versions.json" -UseBasicParsing -TimeoutSec 10
    } catch {}

    if ($vData -and $vData.versions) {
        Write-Host "  Latest Version: $($vData.latest)" -ForegroundColor Green
        Write-Host ""
        Write-Host "  Available Releases:"
        foreach ($v in $vData.versions) {
            $marker = if ($v -eq $vData.latest) { " (latest)" } else { "" }
            Write-Host "    - $v$marker"
        }
    } else {
        Write-Host "  Latest Version: v1.6.0" -ForegroundColor Green
        Write-Host "  Available Releases: v1.6.0, v1.4.0"
    }
    Write-Host ""
    Write-Host "  To install or rollback to a specific version:" -ForegroundColor Cyan
    Write-Host "    `$env:ACS_VERSION = 'v1.4.0'; irm https://dl.uikode.com/install.ps1 | iex" -ForegroundColor White
    Write-Host "    pwsh -File install.ps1 -Version v1.4.0" -ForegroundColor White
    Write-Host ("-" * 36)
    Write-Host ""
    return
}

# --- PS5 Bootstrap: detect PS version and relaunch in PS7 if needed -----------
# This section MUST be parseable by PowerShell 5.1 (no PS7 syntax)
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host ""
    Write-Host "ACS - Agnostic Config Suites" -ForegroundColor Cyan
    Write-Host "------------------------------------"
    Write-Host ""
    Write-Host "  !! PowerShell $($PSVersionTable.PSVersion) detected - PS 7+ required." -ForegroundColor Yellow

    # Check if pwsh already exists
    $pwshPath = $null
    $pwshCmd = Get-Command pwsh -ErrorAction SilentlyContinue
    if ($pwshCmd) {
        $pwshPath = $pwshCmd.Source
    } elseif (Test-Path "$env:ProgramFiles\PowerShell\7\pwsh.exe") {
        $pwshPath = "$env:ProgramFiles\PowerShell\7\pwsh.exe"
    } elseif (Test-Path "${env:ProgramFiles(x86)}\PowerShell\7\pwsh.exe") {
        $pwshPath = "${env:ProgramFiles(x86)}\PowerShell\7\pwsh.exe"
    }

    # Relaunch in pwsh if available
    if ($pwshPath) {
        Write-Host "  OK PowerShell 7 found at: $pwshPath" -ForegroundColor Green
        Write-Host "  Re-launching installer in pwsh..." -ForegroundColor Cyan

        # Save the installer script to a temp file to avoid re-download issues
        $tempScript = Join-Path $env:TEMP "acs-install-relaunch.ps1"
        try {
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            try {
                Invoke-WebRequest -Uri "https://dl.uikode.com/install.ps1" -OutFile $tempScript -UseBasicParsing -TimeoutSec 30
            } catch {
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/andyvandaric/acs/main/install.ps1" -OutFile $tempScript -UseBasicParsing -TimeoutSec 30
            }
            $childArgs = @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $tempScript)
            if ($Version) { $childArgs += @("-Version", $Version) }
            & $pwshPath @childArgs
            if ($LASTEXITCODE -ne 0) {
                throw "PowerShell 7 child execution failed with exit code $LASTEXITCODE"
            }
        } catch {
            # Fallback: pipe method if file download fails
            Write-Host "  Retrying with pipe method..." -ForegroundColor Yellow
            & $pwshPath -NoProfile -ExecutionPolicy Bypass -Command "try { irm https://dl.uikode.com/install.ps1 | iex } catch { irm https://raw.githubusercontent.com/andyvandaric/acs/main/install.ps1 | iex }; if (`$LASTEXITCODE -ne 0) { throw `"Execution failed`" }"
            if ($LASTEXITCODE -ne 0) {
                throw "PowerShell 7 execution failed with exit code $LASTEXITCODE"
            }
        } finally {
            Remove-Item $tempScript -Force -ErrorAction SilentlyContinue
        }

        # Propagate PATH after pwsh finishes
        $acsDir = Join-Path ([Environment]::GetFolderPath("UserProfile")) ".acs\bin"
        if (((Test-Path "$acsDir\acs.exe") -or (Test-Path "$acsDir\acs-cli.exe")) -and ($env:Path -notlike "*$acsDir*")) {
            $env:Path = "$acsDir;$env:Path"
        }
        return
    }

    Write-Host "  PowerShell 7 not found. Continuing directly with Windows PowerShell..." -ForegroundColor Cyan
}

# --- Install-ACS: Compatible with PowerShell 5.1 and 7+ -----------------------

function Install-ACS {
param(
    [string]$TargetVersion,
    [string]$LicenseKey
)
$ErrorActionPreference = "Stop"

if ($TargetVersion) {
    $tag = if ($TargetVersion.StartsWith("v")) { $TargetVersion } else { "v$TargetVersion" }
    $PRIMARY_CDN_BASE = "https://dl.uikode.com/$tag"
    $FALLBACK_CDN_BASE = "https://github.com/andyvandaric/acs/releases/download/$tag"
} else {
    $PRIMARY_CDN_BASE = "https://dl.uikode.com"
    $FALLBACK_CDN_BASE = "https://github.com/andyvandaric/acs/releases/latest/download"
}
$INSTALL_DIR = Join-Path ([Environment]::GetFolderPath("UserProfile")) ".acs\bin"

$isPS7 = ($PSVersionTable.PSVersion.Major -ge 7)
$markOk = if ($isPS7) { "`u{2705} " } else { "[OK] " }
$markWarn = if ($isPS7) { "`u{26A0}`u{FE0F}  " } else { "[WARN] " }
$markErr = if ($isPS7) { "`u{274C} " } else { "[ERR] " }
$markBolt = if ($isPS7) { "`u{26A1} " } else { ">> " }

function Info($msg) { Write-Host "  $msg" }
function Ok($msg) { Write-Host "$script:markOk$msg" -ForegroundColor Green }
function Warn($msg) { Write-Host "$script:markWarn$msg" -ForegroundColor Yellow }
function Err($msg) { Write-Host "$script:markErr$msg" -ForegroundColor Red; throw $msg }

Write-Host ""
Write-Host "$markBolt ACS - Agnostic Config Suites" -ForegroundColor Cyan
Write-Host ("-" * 36)
Write-Host ""

if ($TargetVersion) {
    Info "Target Version: $tag (Pinned)"
}

# --- Detect Arch -------------------------------------------------------------
$arch = if ([Environment]::Is64BitOperatingSystem) {
    if ($env:PROCESSOR_ARCHITECTURE -eq "ARM64" -or (Get-CimInstance Win32_Processor).Architecture -eq 12) {
        "arm64"
    } else {
        "amd64"
    }
} else {
    Err "32-bit Windows is not supported"
}

$PLATFORM = "windows-$arch"
$FILE_NAME = "acs-$PLATFORM.exe"
Info "Platform: $PLATFORM"

# --- Fetch manifest for SHA-256 integrity (Dual-Track) -----------------------
Write-Host ""
Info "Fetching release manifest..."

$MANIFEST_URL = "$PRIMARY_CDN_BASE/manifest.json"
$FALLBACK_MANIFEST_URL = "$FALLBACK_CDN_BASE/manifest.json"
$EXPECTED_SHA = $null
$VERSION = $null
$manifest = $null

try {
    $manifest = Invoke-RestMethod -Uri $MANIFEST_URL -UseBasicParsing -TimeoutSec 15
} catch {
    Warn "Primary CDN manifest fetch failed: $($_.Exception.Message)"
    Info "Attempting fallback to GitHub Releases manifest..."
    try {
        $manifest = Invoke-RestMethod -Uri $FALLBACK_MANIFEST_URL -UseBasicParsing -TimeoutSec 15
    } catch {
        Warn "Fallback manifest also unavailable ($($_.Exception.Message)). Proceeding..."
    }
}

if ($manifest) {
    if ($manifest.version) {
        $VERSION = $manifest.version
        Ok "Latest version: v$VERSION"
    }
    # Support both manifest formats and naming conventions (acs- vs acs-cli-):
    $candidates = @($FILE_NAME, "acs-cli-$PLATFORM.exe", "acs-$PLATFORM", "acs-cli-$PLATFORM")
    if ($manifest.files) {
        foreach ($c in $candidates) {
            if ($manifest.files.PSObject.Properties[$c]) {
                $EXPECTED_SHA = $manifest.files.$c
                $FILE_NAME = $c
                break
            }
        }
    } elseif ($manifest.artifacts) {
        if ($manifest.artifacts.PSObject.Properties[$PLATFORM]) {
            $EXPECTED_SHA = $manifest.artifacts.$PLATFORM.sha256
            if ($manifest.artifacts.$PLATFORM.file) {
                $FILE_NAME = $manifest.artifacts.$PLATFORM.file
            }
        } else {
            foreach ($c in $candidates) {
                $matched = $manifest.artifacts | Where-Object { $_.file -eq $c }
                if ($matched) {
                    $EXPECTED_SHA = $matched.sha256
                    $FILE_NAME = $matched.file
                    break
                }
            }
        }
    }
}

Info "Artifact: $FILE_NAME"

# --- Download binary (Dual-Track: Primary CDN -> Fallback GitHub) ------------
Write-Host ""
$TMP_DIR = Join-Path $env:TEMP "acs-install-$(Get-Random)"
New-Item -ItemType Directory -Path $TMP_DIR -Force | Out-Null
$TMP_FILE = Join-Path $TMP_DIR $FILE_NAME

$downloadSuccess = $false
$primaryUrl = if ($VERSION -and -not $TargetVersion) { "$PRIMARY_CDN_BASE/v$VERSION/$FILE_NAME" } else { "$PRIMARY_CDN_BASE/$FILE_NAME" }
$fallbackUrl = "$FALLBACK_CDN_BASE/$FILE_NAME"

Info "Downloading $FILE_NAME from Fast Global CDN..."
try {
    Invoke-WebRequest -Uri $primaryUrl -OutFile $TMP_FILE -UseBasicParsing -TimeoutSec 120
    if ((Test-Path $TMP_FILE) -and ((Get-Item $TMP_FILE).Length -ge 1000000)) {
        $downloadSuccess = $true
    }
} catch {
    Warn "Primary CDN download failed: $($_.Exception.Message)"
}

if (-not $downloadSuccess) {
    Info "Attempting fallback to GitHub Releases ($fallbackUrl)..."
    try {
        Invoke-WebRequest -Uri $fallbackUrl -OutFile $TMP_FILE -UseBasicParsing -TimeoutSec 120
        if ((Test-Path $TMP_FILE) -and ((Get-Item $TMP_FILE).Length -ge 1000000)) {
            $downloadSuccess = $true
        }
    } catch {
        Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
        Err "Download failed from both CDN and GitHub Releases. Check your connection: $($_.Exception.Message)"
    }
}

if (-not (Test-Path $TMP_FILE)) {
    Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
    Err "Download failed: file not found at $TMP_FILE"
}

$dlSize = (Get-Item $TMP_FILE).Length
if ($dlSize -lt 1000000) {
    Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
    Err "Download failed: file too small ($dlSize bytes)."
}
$dlMB = [math]::Round($dlSize / 1MB, 1)
Ok "Download complete ($dlMB MB)"

# --- Verify SHA-256 ----------------------------------------------------------
if ($EXPECTED_SHA) {
    Info "Verifying SHA-256 integrity..."
    $actualSha = $null
    if (Get-Command Get-FileHash -ErrorAction SilentlyContinue) {
        $actualSha = (Get-FileHash -Path $TMP_FILE -Algorithm SHA256).Hash.ToLower()
    } else {
        $stream = [System.IO.File]::OpenRead($TMP_FILE)
        try {
            $sha = [System.Security.Cryptography.SHA256]::Create()
            $bytes = $sha.ComputeHash($stream)
            $actualSha = (-join ($bytes | ForEach-Object { "{0:x2}" -f $_ })).ToLower()
        } finally {
            $stream.Close()
        }
    }
    if ($actualSha -ne $EXPECTED_SHA.ToLower()) {
        Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
        Err "SHA-256 mismatch! Expected: $EXPECTED_SHA, Got: $actualSha"
    }
    Ok "SHA-256 verified"
}

# --- Install -----------------------------------------------------------------
Write-Host ""
Info "Installing to $INSTALL_DIR..."

# Stop running acs and acs-cli processes before overwriting binary (handles reinstall/update)
$acsProcs = Get-Process -Name "acs", "acs-cli" -ErrorAction SilentlyContinue
if ($acsProcs) {
    Info "Stopping running ACS processes..."
    $acsProcs | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Ok "Processes stopped"
}

New-Item -ItemType Directory -Path $INSTALL_DIR -Force | Out-Null
$targetExe = Join-Path $INSTALL_DIR "acs.exe"
Copy-Item $TMP_FILE $targetExe -Force

# Clean up legacy acs-cli.exe if present
$legacyExe = Join-Path $INSTALL_DIR "acs-cli.exe"
if (Test-Path $legacyExe) {
    Remove-Item $legacyExe -Force -ErrorAction SilentlyContinue
}

Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
Ok "Installed: $targetExe"

# --- PATH setup --------------------------------------------------------------
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*$INSTALL_DIR*") {
    Info "Adding $INSTALL_DIR to user PATH..."
    [Environment]::SetEnvironmentVariable("Path", "$INSTALL_DIR;$currentPath", "User")
    Ok "Added to user PATH"
}
if ($env:Path -notlike "*$INSTALL_DIR*") {
    $env:Path = "$INSTALL_DIR;$env:Path"
}
# Broadcast WM_SETTINGCHANGE so other open shells pick it up
try {
    Add-Type -Namespace Win32 -Name NativeMethods -MemberDefinition '[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)] public static extern IntPtr SendMessageTimeout(IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam, uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);'
    $HWND_BROADCAST = [IntPtr]0xffff
    $WM_SETTINGCHANGE = 0x1a
    $result = [UIntPtr]::Zero
    [Win32.NativeMethods]::SendMessageTimeout($HWND_BROADCAST, $WM_SETTINGCHANGE, [UIntPtr]::Zero, "Environment", 2, 5000, [ref]$result) | Out-Null
} catch { }

# --- Configure Stack with License Verification -------------------------------
Write-Host ""
Info "Configuring ACS agentic stack..."
$setupArgs = @()
if ($LicenseKey) {
    $setupArgs += "--license-key", $LicenseKey
}

$setupExitCode = 1
try {
    & $targetExe setup @setupArgs
    $setupExitCode = $LASTEXITCODE
} catch {
    $setupExitCode = 1
}

if ($setupExitCode -eq 0) {
    # --- Register as persistent service only after setup succeeds -----------
    Write-Host ""
    Info "Registering as persistent service..."
    try {
        $svcOutput = & $targetExe service install --force 2>&1
        if ($LASTEXITCODE -eq 0) {
            Ok "Service registered (auto-starts on login)"
        } else {
            Warn "Service registration skipped: $svcOutput"
            Info "You can register manually later: acs service install"
        }
    } catch {
        Warn "Service registration failed: $_"
        Info "You can register manually later: acs service install"
    }

    # Auto-start background stack
    try {
        & $targetExe start 2>&1 | Out-Null
        Ok "ACS background services started"
    } catch { }

    # --- Verify & Status -----------------------------------------------------
    Write-Host ""
    $acsVersion = & $targetExe version 2>$null
    if ($acsVersion) {
        $acsVersion = $acsVersion -replace '^(acs|acs-cli)\s*', ''
        Ok "acs v$acsVersion ready!"
    } else {
        Ok "Installed successfully!"
    }

    Write-Host ""
    Write-Host ("-" * 42)
    Write-Host "  ACS Installed & Configured Successfully!" -ForegroundColor Green
    Write-Host "  Dashboard: http://localhost:20130" -ForegroundColor Cyan
    Write-Host ("-" * 42)
    Write-Host ""
} else {
    Write-Host ""
    Warn "ACS binary installed, but stack setup was not completed."
    Info "To complete setup and activate your license, run:"
    Write-Host "    acs setup" -ForegroundColor Yellow
    Write-Host "  or: acs setup --license-key <YOUR_KEY>" -ForegroundColor Yellow
    Write-Host "  or: acs activate <YOUR_LICENSE_KEY>" -ForegroundColor Yellow
    Write-Host ""
}

} # end Install-ACS function

# --- Run with error capture ---------------------------------------------------
try {
    Install-ACS -TargetVersion $Version -LicenseKey $LicenseKey
} catch {
    Write-Host ""
    Write-Host ("-" * 36) -ForegroundColor Red
    Write-Host "  Installation failed: $_" -ForegroundColor Red
    Write-Host ("-" * 36) -ForegroundColor Red
    Write-Host ""
    Write-Host "  If this persists, contact support or try:" -ForegroundColor Yellow
    Write-Host "    pwsh -NoProfile -ExecutionPolicy Bypass -File install.ps1" -ForegroundColor Yellow
    Write-Host ""
    if ($PSCommandPath) {
        exit 1
    }
}

# Ensure PATH is available in the caller's session
$_acsDir = Join-Path ([Environment]::GetFolderPath("UserProfile")) ".acs\bin"
if ((Test-Path "$_acsDir\acs.exe") -and ($env:Path -notlike "*$_acsDir*")) {
    $env:Path = "$_acsDir;$env:Path"
}

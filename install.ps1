# install.ps1 — Install ACS CLI for Windows
# Usage: irm https://uikode.com/acs/install.ps1 | iex
# Or:    pwsh -NoProfile -ExecutionPolicy Bypass -File install.ps1

# ─── PS5 Bootstrap: detect PS version and relaunch in PS7 if needed ───────────
# This section MUST be parseable by PowerShell 5.1 (no PS7 syntax)
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host ""
    Write-Host "ACS CLI - Agnostic Config Suites" -ForegroundColor Cyan
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
    }

    # If not found, try to install
    if (-not $pwshPath) {
        Write-Host "  PowerShell 7 not found. Attempting install..." -ForegroundColor Cyan

        # Check if running as admin (needed for MSI install)
        $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

        # Method 1: winget (works without admin if --scope user, but PS7 needs machine scope)
        $wingetInstalled = $false
        if (Get-Command winget -ErrorAction SilentlyContinue) {
            Write-Host "  Trying winget..." -ForegroundColor Cyan
            try {
                $wingetOut = winget install --id Microsoft.PowerShell --source winget --accept-package-agreements --accept-source-agreements --silent 2>&1
                if ($LASTEXITCODE -eq 0) {
                    $wingetInstalled = $true
                } else {
                    Write-Host "  winget install returned code $LASTEXITCODE" -ForegroundColor Yellow
                }
            } catch {
                Write-Host "  winget failed: $_" -ForegroundColor Yellow
            }
        }

        # Method 2: Direct MSI download (requires elevation)
        if (-not $wingetInstalled -and -not (Test-Path "$env:ProgramFiles\PowerShell\7\pwsh.exe")) {
            Write-Host "  Trying direct download..." -ForegroundColor Cyan
            try {
                $msiUrl = "https://github.com/PowerShell/PowerShell/releases/download/v7.4.7/PowerShell-7.4.7-win-x64.msi"
                $msiPath = Join-Path $env:TEMP "pwsh-install.msi"

                # TLS 1.2 required for GitHub downloads on PS5
                [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
                Write-Host "  Downloading PowerShell 7..." -ForegroundColor Cyan
                Invoke-WebRequest -Uri $msiUrl -OutFile $msiPath -UseBasicParsing -TimeoutSec 120

                if (Test-Path $msiPath) {
                    $msiArgs = "/i `"$msiPath`" /quiet /norestart ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ENABLE_PSREMOTING=0 REGISTER_MANIFEST=0 USE_MU=0 ENABLE_MU=0 ADD_PATH=1"

                    if ($isAdmin) {
                        # Already elevated — run directly
                        Write-Host "  Installing (admin)..." -ForegroundColor Cyan
                        $proc = Start-Process msiexec.exe -ArgumentList $msiArgs -Wait -PassThru -NoNewWindow
                        if ($proc.ExitCode -ne 0) {
                            Write-Host "  MSI exited with code $($proc.ExitCode)" -ForegroundColor Yellow
                        }
                    } else {
                        # Need elevation — use RunAs verb (will show UAC prompt)
                        Write-Host "  Requesting admin permission to install PowerShell 7..." -ForegroundColor Cyan
                        Write-Host "  (A UAC prompt may appear — please approve it)" -ForegroundColor Yellow
                        try {
                            $proc = Start-Process msiexec.exe -ArgumentList $msiArgs -Verb RunAs -Wait -PassThru
                            if ($proc.ExitCode -ne 0) {
                                Write-Host "  MSI exited with code $($proc.ExitCode)" -ForegroundColor Yellow
                            }
                        } catch {
                            Write-Host "  !! Elevation denied or failed: $_" -ForegroundColor Yellow
                        }
                    }
                    Remove-Item $msiPath -Force -ErrorAction SilentlyContinue
                }
            } catch {
                Write-Host "  !! Download/install failed: $_" -ForegroundColor Yellow
            }
        }

        # Re-check — MSI installs to Program Files, refresh PATH awareness
        $candidatePaths = @(
            "$env:ProgramFiles\PowerShell\7\pwsh.exe",
            "${env:SystemDrive}\Program Files\PowerShell\7\pwsh.exe"
        )
        foreach ($candidate in $candidatePaths) {
            if (Test-Path $candidate) {
                $pwshPath = $candidate
                break
            }
        }
        if (-not $pwshPath) {
            # Also try refreshed PATH (winget may have added it)
            $refreshedPath = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User")
            $env:Path = $refreshedPath
            $pwshCmd = Get-Command pwsh -ErrorAction SilentlyContinue
            if ($pwshCmd) {
                $pwshPath = $pwshCmd.Source
            }
        }
    }

    # Relaunch in pwsh
    if ($pwshPath) {
        Write-Host "  OK PowerShell 7 found at: $pwshPath" -ForegroundColor Green
        Write-Host "  Re-launching installer in pwsh..." -ForegroundColor Cyan

        # Save the installer script to a temp file to avoid re-download issues
        $tempScript = Join-Path $env:TEMP "acs-install-relaunch.ps1"
        try {
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -Uri "https://uikode.com/acs/install.ps1" -OutFile $tempScript -UseBasicParsing -TimeoutSec 30
            & $pwshPath -NoProfile -ExecutionPolicy Bypass -File $tempScript
        } catch {
            # Fallback: pipe method if file download fails
            Write-Host "  Retrying with pipe method..." -ForegroundColor Yellow
            & $pwshPath -NoProfile -ExecutionPolicy Bypass -Command "irm https://uikode.com/acs/install.ps1 | iex"
        } finally {
            Remove-Item $tempScript -Force -ErrorAction SilentlyContinue
        }

        # Propagate PATH after pwsh finishes
        $acsDir = Join-Path ([Environment]::GetFolderPath("UserProfile")) ".acs\bin"
        if ((Test-Path "$acsDir\acs-cli.exe") -and ($env:Path -notlike "*$acsDir*")) {
            $env:Path = "$acsDir;$env:Path"
        }
        return
    }

    Write-Host ""
    Write-Host "  !! Could not install or find PowerShell 7." -ForegroundColor Red
    Write-Host ""
    Write-Host "  Install manually:" -ForegroundColor Yellow
    Write-Host "    winget install --id Microsoft.PowerShell --source winget" -ForegroundColor White
    Write-Host "  Or download from: https://aka.ms/powershell-release" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  Then re-run:" -ForegroundColor Yellow
    Write-Host "    irm https://uikode.com/acs/install.ps1 | iex" -ForegroundColor White
    Write-Host ""
    return
}

# ─── Everything below requires PowerShell 7+ ─────────────────────────────────
# PS5 will never reach here (it returns above)

function Install-ACS {
$ErrorActionPreference = "Stop"

$CDN_BASE = "https://dl.uikode.com"
$INSTALL_DIR = Join-Path ([Environment]::GetFolderPath("UserProfile")) ".acs\bin"

function Info($msg) { Write-Host "  $msg" }
function Ok($msg) { Write-Host "`u{2705} $msg" -ForegroundColor Green }
function Warn($msg) { Write-Host "`u{26A0}`u{FE0F}  $msg" -ForegroundColor Yellow }
function Err($msg) { Write-Host "`u{274C} $msg" -ForegroundColor Red; throw $msg }

Write-Host ""
Write-Host "`u{26A1} ACS CLI `u{2014} Agnostic Config Suites" -ForegroundColor Cyan
Write-Host ("-" * 36)
Write-Host ""

# ─── Detect Arch ─────────────────────────────────────────────────────────────
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
$FILE_NAME = "acs-cli-$PLATFORM.exe"
Info "Platform: $PLATFORM"

# ─── Fetch manifest for SHA-256 integrity ────────────────────────────────────
Write-Host ""
Info "Fetching release manifest..."

$DOWNLOAD_URL = "$CDN_BASE/$FILE_NAME"
$MANIFEST_URL = "$CDN_BASE/manifest.json"
$EXPECTED_SHA = $null
$VERSION = $null

try {
    $manifest = Invoke-RestMethod -Uri $MANIFEST_URL -UseBasicParsing -TimeoutSec 15
    if ($manifest.version) {
        $VERSION = $manifest.version
        Ok "Latest version: v$VERSION"
    }
    # Support both manifest formats:
    # Format A (new): {"files": {"acs-cli-windows-amd64.exe": "sha256"}}
    # Format B (legacy): {"artifacts": {"windows-amd64": {"file": "...", "sha256": "..."}}}
    if ($manifest.files) {
        if ($manifest.files.PSObject.Properties[$FILE_NAME]) {
            $EXPECTED_SHA = $manifest.files.$FILE_NAME
        } elseif ($manifest.files.PSObject.Properties["acs-cli-$PLATFORM"]) {
            $EXPECTED_SHA = $manifest.files."acs-cli-$PLATFORM"
        }
    } elseif ($manifest.artifacts) {
        if ($manifest.artifacts.PSObject.Properties[$PLATFORM]) {
            $EXPECTED_SHA = $manifest.artifacts.$PLATFORM.sha256
        } else {
            $matched = $manifest.artifacts | Where-Object { $_.file -eq $FILE_NAME }
            if ($matched) {
                $EXPECTED_SHA = $matched.sha256
            }
        }
    }
} catch {
    Warn "Could not fetch manifest for hash verification ($($_.Exception.Message)). Proceeding..."
}

Info "Artifact: $FILE_NAME"

# ─── Download binary directly from Fast CDN (Zero-Auth) ──────────────────────
Write-Host ""
Info "Downloading $FILE_NAME from Cloudflare Global CDN..."

$TMP_DIR = Join-Path $env:TEMP "acs-install-$(Get-Random)"
New-Item -ItemType Directory -Path $TMP_DIR -Force | Out-Null
$TMP_FILE = Join-Path $TMP_DIR $FILE_NAME

try {
    Invoke-WebRequest -Uri $DOWNLOAD_URL -OutFile $TMP_FILE -UseBasicParsing -TimeoutSec 120
} catch {
    Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
    Err "Failed to download $DOWNLOAD_URL. Check your connection: $($_.Exception.Message)"
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

# ─── Verify SHA-256 ──────────────────────────────────────────────────────────
if ($EXPECTED_SHA) {
    Info "Verifying SHA-256 integrity..."
    $actualSha = (Get-FileHash -Path $TMP_FILE -Algorithm SHA256).Hash.ToLower()
    if ($actualSha -ne $EXPECTED_SHA.ToLower()) {
        Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
        Err "SHA-256 mismatch! Expected: $EXPECTED_SHA, Got: $actualSha"
    }
    Ok "SHA-256 verified"
}

# ─── Install ─────────────────────────────────────────────────────────────────
Write-Host ""
Info "Installing to $INSTALL_DIR..."

# Stop running acs-cli processes before overwriting binary (handles reinstall/update)
$acsProcs = Get-Process -Name "acs-cli" -ErrorAction SilentlyContinue
if ($acsProcs) {
    Info "Stopping running acs-cli processes..."
    $acsProcs | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Ok "Processes stopped"
}

New-Item -ItemType Directory -Path $INSTALL_DIR -Force | Out-Null
Copy-Item $TMP_FILE (Join-Path $INSTALL_DIR "acs-cli.exe") -Force
Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
Ok "Installed: $INSTALL_DIR\acs-cli.exe"

# ─── PATH setup ──────────────────────────────────────────────────────────────
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

# ─── Register as service ────────────────────────────────────────────────────
Write-Host ""
Info "Registering as persistent service..."
$acsCli = Join-Path $INSTALL_DIR "acs-cli.exe"
try {
    $svcOutput = & $acsCli service install 2>&1
    if ($LASTEXITCODE -eq 0) {
        Ok "Service registered (auto-starts on login)"
    } else {
        Warn "Service registration skipped: $svcOutput"
        Info "You can register manually later: acs-cli service install"
    }
} catch {
    Warn "Service registration failed: $_"
    Info "You can register manually later: acs-cli service install"
}

# ─── Verify & Next Steps ─────────────────────────────────────────────────────
Write-Host ""
$acsVersion = & $acsCli version 2>$null
if ($acsVersion) {
    $acsVersion = $acsVersion -replace '^acs-cli\s*', ''
    Ok "acs-cli v$acsVersion ready!"
} else {
    Ok "Installed successfully!"
}

Write-Host ""
Write-Host ("-" * 42)
Write-Host "  ACS CLI Installed Successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "  Next Step: Activate your license:" -ForegroundColor Cyan
Write-Host "    acs-cli activate <YOUR_LICENSE_KEY>" -ForegroundColor Yellow
Write-Host ("-" * 42)
Write-Host ""

} # end Install-ACS function

# ─── Run with error capture ───────────────────────────────────────────────────
try {
    Install-ACS
} catch {
    Write-Host ""
    Write-Host ("-" * 36) -ForegroundColor Red
    Write-Host "  Installation failed: $_" -ForegroundColor Red
    Write-Host ("-" * 36) -ForegroundColor Red
    Write-Host ""
    Write-Host "  If this persists, contact support or try:" -ForegroundColor Yellow
    Write-Host "    pwsh -NoProfile -ExecutionPolicy Bypass -File install.ps1" -ForegroundColor Yellow
    Write-Host ""
}

# Ensure PATH is available in the caller's session
$_acsDir = Join-Path ([Environment]::GetFolderPath("UserProfile")) ".acs\bin"
if ((Test-Path "$_acsDir\acs-cli.exe") -and ($env:Path -notlike "*$_acsDir*")) {
    $env:Path = "$_acsDir;$env:Path"
}

# install.ps1 - Install ACS CLI for Windows
# Usage: irm https://dl.uikode.com/install.ps1 | iex
# Or:    pwsh -NoProfile -ExecutionPolicy Bypass -File install.ps1

# --- PS5 Bootstrap: detect PS version and relaunch in PS7 if needed -----------
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
                        # Already elevated - run directly
                        Write-Host "  Installing (admin)..." -ForegroundColor Cyan
                        $proc = Start-Process msiexec.exe -ArgumentList $msiArgs -Wait -PassThru -NoNewWindow
                        if ($proc.ExitCode -ne 0) {
                            Write-Host "  MSI exited with code $($proc.ExitCode)" -ForegroundColor Yellow
                        }
                    } else {
                        # Need elevation - use RunAs verb (will show UAC prompt)
                        Write-Host "  Requesting admin permission to install PowerShell 7..." -ForegroundColor Cyan
                        Write-Host "  (A UAC prompt may appear - please approve it)" -ForegroundColor Yellow
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

        # Re-check - MSI installs to Program Files, refresh PATH awareness
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
            try {
                Invoke-WebRequest -Uri "https://dl.uikode.com/install.ps1" -OutFile $tempScript -UseBasicParsing -TimeoutSec 30
            } catch {
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/andyvandaric/acs/main/install.ps1" -OutFile $tempScript -UseBasicParsing -TimeoutSec 30
            }
            & $pwshPath -NoProfile -ExecutionPolicy Bypass -File $tempScript
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

    Write-Host ""
    Write-Host "  !! Could not install or find PowerShell 7." -ForegroundColor Red
    Write-Host ""
    Write-Host "  Install manually:" -ForegroundColor Yellow
    Write-Host "    winget install --id Microsoft.PowerShell --source winget" -ForegroundColor White
    Write-Host "  Or download from: https://aka.ms/powershell-release" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  Then re-run:" -ForegroundColor Yellow
    Write-Host "    irm https://dl.uikode.com/install.ps1 | iex" -ForegroundColor White
    Write-Host ""
    return
}

# --- Everything below requires PowerShell 7+ ---------------------------------
# PS5 will never reach here (it returns above)

function Install-ACS {
$ErrorActionPreference = "Stop"

$PRIMARY_CDN_BASE = "https://dl.uikode.com"
$FALLBACK_CDN_BASE = "https://github.com/andyvandaric/acs/releases/latest/download"
$INSTALL_DIR = Join-Path ([Environment]::GetFolderPath("UserProfile")) ".acs\bin"

function Info($msg) { Write-Host "  $msg" }
function Ok($msg) { Write-Host "`u{2705} $msg" -ForegroundColor Green }
function Warn($msg) { Write-Host "`u{26A0}`u{FE0F}  $msg" -ForegroundColor Yellow }
function Err($msg) { Write-Host "`u{274C} $msg" -ForegroundColor Red; throw $msg }

Write-Host ""
Write-Host "`u{26A1} ACS CLI `u{2014} Agnostic Config Suites" -ForegroundColor Cyan
Write-Host ("-" * 36)
Write-Host ""

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
$primaryUrl = "$PRIMARY_CDN_BASE/$FILE_NAME"
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
    $actualSha = (Get-FileHash -Path $TMP_FILE -Algorithm SHA256).Hash.ToLower()
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

# --- Register as service ----------------------------------------------------
Write-Host ""
Info "Registering as persistent service..."
try {
    $svcOutput = & $targetExe service install 2>&1
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

# --- Verify & Next Steps -----------------------------------------------------
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
Write-Host "  ACS Installed Successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "  Next Step: Activate your license in 1 step:" -ForegroundColor Cyan
Write-Host "    acs activate <YOUR_LICENSE_KEY>" -ForegroundColor Yellow
Write-Host ("-" * 42)
Write-Host ""

} # end Install-ACS function

# --- Run with error capture ---------------------------------------------------
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
    if ($PSCommandPath) {
        exit 1
    }
}

# Ensure PATH is available in the caller's session
$_acsDir = Join-Path ([Environment]::GetFolderPath("UserProfile")) ".acs\bin"
if ((Test-Path "$_acsDir\acs.exe") -and ($env:Path -notlike "*$_acsDir*")) {
    $env:Path = "$_acsDir;$env:Path"
}

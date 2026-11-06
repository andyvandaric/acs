# install.ps1 - Install ACS for Windows
# Usage: $env:ACS_DOWNLOAD_CODE="<CODE>"; irm https://dl.uikode.com/install.ps1 | iex
# Or:    pwsh -NoProfile -ExecutionPolicy Bypass -File install.ps1 -Code <CODE>

[CmdletBinding()]
param(
    [Alias("v")]
    [string]$Version = $env:ACS_VERSION,
    [Alias("c", "code")]
    [string]$DownloadCode = $env:ACS_DOWNLOAD_CODE,
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
    Write-Host "  .\install.ps1 -Code <CODE> [options]"
    Write-Host "  `$env:ACS_DOWNLOAD_CODE='<CODE>'; irm https://dl.uikode.com/install.ps1 | iex"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -Code, -c <code-8-chars>   8-character ACS download code from https://uikode.com/member"
    Write-Host "  -Version, -v <version>     Install or rollback to specific version (e.g. v1.4.0 or 1.4.0)"
    Write-Host "  -LicenseKey, -k <key>      ACS license key (or set `$env:ACS_LICENSE_KEY)"
    Write-Host "  -ListVersions, -l          List all available releases on CDN"
    Write-Host "  -Help, -h                  Show this help screen"
    Write-Host ""
    Write-Host "Environment Variables:"
    Write-Host "  `$env:ACS_DOWNLOAD_CODE = 'CODE'   8-character single-use code from Member Area"
    Write-Host "  `$env:ACS_VERSION = 'v1.4.0'       Pinned version for piped iex execution"
    Write-Host "  `$env:ACS_LICENSE_KEY = 'KEY'      ACS license key for automated activation"
    Write-Host "  `$env:ACS_LIST = '1'               List available versions"
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
        $vData = Invoke-RestMethod -Uri "https://dl.uikode.com/acs/versions.json" -UseBasicParsing -TimeoutSec 10
    } catch {
        try {
            $vData = Invoke-RestMethod -Uri "https://dl.uikode.com/versions.json" -UseBasicParsing -TimeoutSec 10
        } catch {}
    }

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

        # Reuse existing script file if running locally, or download to temp if piped
        $isLocalFile = ($PSCommandPath -and (Test-Path $PSCommandPath))
        $tempScript = if ($isLocalFile) { $PSCommandPath } else { Join-Path $env:TEMP "acs-install-relaunch.ps1" }
        try {
            if (-not $isLocalFile) {
                [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
                try {
                    Invoke-WebRequest -Uri "https://dl.uikode.com/acs/install.ps1" -OutFile $tempScript -UseBasicParsing -TimeoutSec 30
                } catch {
                    try {
                        Invoke-WebRequest -Uri "https://dl.uikode.com/install.ps1" -OutFile $tempScript -UseBasicParsing -TimeoutSec 30
                    } catch {
                        Invoke-WebRequest -Uri "https://raw.githubusercontent.com/andyvandaric/acs/main/install.ps1" -OutFile $tempScript -UseBasicParsing -TimeoutSec 30
                    }
                }
            }
            $childArgs = @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $tempScript)
            if ($Version) { $childArgs += @("-Version", $Version) }
            if ($DownloadCode) { $childArgs += @("-Code", $DownloadCode) }
            if ($LicenseKey) { $childArgs += @("-LicenseKey", $LicenseKey) }
            & $pwshPath @childArgs
            $childExit = $LASTEXITCODE
            if ($childExit -ne 0) {
                if ($PSCommandPath) {
                    exit $childExit
                }
                return
            }
        } catch {
            # Fallback: pipe method if script file launch fails completely
            Write-Host "  Retrying with pipe method..." -ForegroundColor Yellow
            $pipeEnv = ""
            if ($DownloadCode) { $pipeEnv += "`$env:ACS_DOWNLOAD_CODE='$DownloadCode'; " }
            if ($LicenseKey) { $pipeEnv += "`$env:ACS_LICENSE_KEY='$LicenseKey'; " }
            & $pwshPath -NoProfile -ExecutionPolicy Bypass -Command "$pipeEnv try { irm https://dl.uikode.com/install.ps1 | iex } catch { irm https://raw.githubusercontent.com/andyvandaric/acs/main/install.ps1 | iex }"
            if ($LASTEXITCODE -ne 0) {
                if ($PSCommandPath) {
                    exit $LASTEXITCODE
                }
                return
            }
        } finally {
            if (-not $isLocalFile) {
                Remove-Item $tempScript -Force -ErrorAction SilentlyContinue
            }
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
    [string]$LicenseKey,
    [string]$DownloadCode
)
$ErrorActionPreference = "Stop"

if ($TargetVersion) {
    $tag = if ($TargetVersion.StartsWith("v")) { $TargetVersion } else { "v$TargetVersion" }
    $PRIMARY_CDN_BASE = "https://dl.uikode.com/acs/$tag"
    $FALLBACK_CDN_BASE = "https://github.com/andyvandaric/acs/releases/download/$tag"
} else {
    $PRIMARY_CDN_BASE = "https://dl.uikode.com/acs"
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

# --- Download Code & License Key Validation (Zero-Leak Gate) -----------------
if (-not $DownloadCode -and -not $LicenseKey) {
    if ([Environment]::UserInteractive -and -not [Console]::IsInputRedirected) {
        Write-Host ">> Masukkan 8-karakter Download Code Anda dari https://uikode.com/member" -ForegroundColor Cyan
        $entered = Read-Host "Download Code"
        if ($entered) {
            $DownloadCode = $entered.Trim().ToUpper()
        }
    }
}

if (-not $DownloadCode -and -not $LicenseKey) {
    Write-Host ""
    Write-Host "$script:markErr Download Code diperlukan untuk mengunduh biner resmi ACS Core." -ForegroundColor Red
    Write-Host ""
    Write-Host "Panduan Pengambilan Kode:" -ForegroundColor Yellow
    Write-Host "1. Login ke Member Area: https://uikode.com/member"
    Write-Host "2. Pada lisensi aktif Anda, klik 'Generate Download Code' (kode 8-karakter, berlaku 15 menit)."
    Write-Host "3. Jalankan kembali script instalasi berikut di PowerShell:"
    Write-Host '   $env:ACS_DOWNLOAD_CODE="<KODE_8_KARAKTER>"; irm https://dl.uikode.com/install.ps1 | iex' -ForegroundColor Cyan
    Write-Host ""
    throw "Instalasi dibatalkan: Download Code tidak ditemukan."
}

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

# WHY: TOCTOU H5 — bytes tidak pernah menyentuh disk sebelum SHA256 in-memory
# cocok; staging kanonis di LOCALAPPDATA (SSOT: repos/installer/install.ps1).
function Get-StagingDir {
    $base = $env:LOCALAPPDATA
    if (-not $base) { $base = $env:TEMP }
    $dir = Join-Path $base "ACS\staging\acs-install-$(Get-Random)"
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    return $dir
}

function Get-BytesWithProgress {
    param([string]$Url)
    # 1. On PowerShell 7+, use HttpClient for memory stream reading
    if ($PSVersionTable.PSVersion.Major -ge 7) {
        try {
            $client = [System.Net.Http.HttpClient]::new()
            try {
                $resp = $client.GetAsync($Url, [System.Net.Http.HttpCompletionOption]::ResponseHeadersRead).GetAwaiter().GetResult()
                [void]$resp.EnsureSuccessStatusCode()
                $total = $resp.Content.Headers.ContentLength
                $stream = $resp.Content.ReadAsStreamAsync().GetAwaiter().GetResult()
                $mem = New-Object System.IO.MemoryStream
                try {
                    $buf = New-Object byte[] 81920
                    $read = 0
                    $lastMb = -1
                    while (($n = $stream.Read($buf, 0, $buf.Length)) -gt 0) {
                        $mem.Write($buf, 0, $n)
                        $read += $n
                        if ($total -and $total -gt 0) {
                            $mb = [math]::Floor($read / 1MB)
                            if ($mb -ne $lastMb) { $lastMb = $mb; Write-Progress -Activity "Downloading" -Status "$mb MB" -PercentComplete ([math]::Min(100, ($read * 100 / $total))) }
                        }
                    }
                    Write-Progress -Activity "Downloading" -Completed
                    return $mem.ToArray()
                } finally { $mem.Dispose(); $stream.Dispose() }
            } finally { $client.Dispose() }
        } catch {
            # Fall through to WebClient if HttpClient fails
        }
    }

    # 2. Universal reliable fallback: WebClient
    $wc = New-Object System.Net.WebClient
    try {
        return $wc.DownloadData($Url)
    } finally {
        $wc.Dispose()
    }
}

function Test-Sha256Bytes {
    param([byte[]]$Bytes, [string]$Expected)
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try {
        $hash = $sha.ComputeHash($Bytes)
        $actual = ([BitConverter]::ToString($hash) -replace '-','').ToLower()
        return $actual -eq $Expected.ToLower()
    } finally { $sha.Dispose() }
}

# --- Download binary (Authorized Ticket Stream) -----------------------------
# WHY: Zero-leak gate — direct static downloads are prohibited. Binary is streamed
# only to clients holding a valid single-use ticket bound to their terminal IP.
Write-Host ""
$TMP_DIR = Get-StagingDir
$TMP_FILE = Join-Path $TMP_DIR $FILE_NAME

$API_BASE = if ($env:ACS_API_URL) { $env:ACS_API_URL.TrimEnd('/') } else { "https://api.uikode.com" }
Info "Requesting authorized download ticket from $API_BASE..."

$ticketPayload = @{
    platform = $PLATFORM
    product = "acs-core"
}
if ($DownloadCode) {
    $ticketPayload["code"] = $DownloadCode.Trim().ToUpper()
} elseif ($LicenseKey) {
    $ticketPayload["license_key"] = $LicenseKey.Trim()
}

$ticketJson = $ticketPayload | ConvertTo-Json -Compress
$ticketResp = $null
try {
    $ticketResp = Invoke-RestMethod -Uri "$API_BASE/api/v1/download/ticket" -Method Post -Body $ticketJson -ContentType "application/json" -TimeoutSec 15
} catch {
    $errMsg = $_.Exception.Message
    try {
        if ($_.ErrorDetails -and $_.ErrorDetails.Message) {
            $errJson = $_.ErrorDetails.Message | ConvertFrom-Json
            if ($errJson.error) { $errMsg = $errJson.error }
        }
    } catch {}
    Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
    Err "Gagal mendapatkan izin unduh dari server tiket: $errMsg`n`nPastikan Download Code Anda valid (didapatkan di https://uikode.com/member) dan lisensi berstatus aktif."
}

if (-not $ticketResp -or -not $ticketResp.success -or -not $ticketResp.data -or -not $ticketResp.data.download_url) {
    Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
    Err "Respon server tiket tidak valid atau tidak memuat URL unduhan."
}

$downloadPath = $ticketResp.data.download_url
$DOWNLOAD_STREAM_URL = if ($downloadPath.StartsWith("http")) { $downloadPath } else { "$API_BASE$downloadPath" }
Ok "Download ticket verified (expires in $($ticketResp.data.expires_in_seconds)s)"

Write-Host ""
Info "Downloading $FILE_NAME via authorized secure stream..."
$downloadSuccess = $false
$verifiedBytes = $null

try {
    $candidate = Get-BytesWithProgress -Url $DOWNLOAD_STREAM_URL
    if ($candidate -and $candidate.Length -ge 1000000) {
        if ($EXPECTED_SHA) {
            if (Test-Sha256Bytes -Bytes $candidate -Expected $EXPECTED_SHA) {
                $verifiedBytes = $candidate
                $downloadSuccess = $true
            } else {
                Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
                Err "SHA-256 mismatch! File rusak atau tidak valid. Expected: $EXPECTED_SHA. Aborted before disk write."
            }
        } else {
            $verifiedBytes = $candidate
            $downloadSuccess = $true
        }
    } else {
        Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
        Err "Unduhan biner gagal: ukuran file terlalu kecil atau kosong."
    }
} catch {
    Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
    Err "Unduhan stream biner gagal: $($_.Exception.Message)"
}

if (-not $downloadSuccess -or -not $verifiedBytes) {
    Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
    Err "Download failed: verified bytes unavailable."
}

[System.IO.File]::WriteAllBytes($TMP_FILE, $verifiedBytes)
$verifiedBytes = $null
$candidate = $null

$dlSize = (Get-Item $TMP_FILE).Length
if ($dlSize -lt 1000000) {
    Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
    Err "Download failed: file too small ($dlSize bytes)."
}
$dlMB = [math]::Round($dlSize / 1MB, 1)
Ok "Download complete ($dlMB MB)"

# --- Verify SHA-256 ----------------------------------------------------------
# Pre-write in-memory via Test-Sha256Bytes di atas; blok ini re-assert saja.
if ($EXPECTED_SHA) {
    Info "Verifying SHA-256 integrity..."
    Ok "SHA-256 verified (pre-write in-memory)"
} else {
    Warn "Manifest SHA unavailable; size-guard only."
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

# --- Persona commands bootstrap ----------------------------------------------
# Idempotent: `acs persona deploy` writes ~/.claude/commands/*.md.
# Non-fatal: older pinned binaries may lack the subcommand — installer continues.
try {
    & $targetExe persona deploy 2>&1 | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Ok "Persona commands deployed"
    } else {
        Info "Persona deploy skipped (binary predates persona support)"
    }
} catch {
    Info "Persona deploy skipped: $_"
}

# --- PATH setup --------------------------------------------------------------
$userProfile = [Environment]::GetFolderPath("UserProfile")
$acsBin = $INSTALL_DIR
$envBin = Join-Path $userProfile ".acs\env\bin"
if (-not (Test-Path $envBin)) {
    New-Item -ItemType Directory -Path $envBin -Force | Out-Null
}

$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
$pathParts = @()
if ($currentPath) {
    $pathParts = $currentPath -split ';' | Where-Object { $_ -and -not (Test-Path $_ -PathType Leaf) }
}

$targetDirs = @($acsBin, $envBin)
$newParts = @()
foreach ($dir in $targetDirs) {
    if ($newParts -notcontains $dir) {
        $newParts += $dir
    }
}
foreach ($part in $pathParts) {
    if ($newParts -notcontains $part) {
        $newParts += $part
    }
}

$updatedPath = $newParts -join ';'
if ($currentPath -ne $updatedPath) {
    Info "Persisting ACS binaries and isolated toolchain to user PATH..."
    [Environment]::SetEnvironmentVariable("Path", $updatedPath, "User")
    Ok "Added $acsBin and $envBin to user PATH"
}

foreach ($dir in $targetDirs) {
    if ($env:Path -notlike "*$dir*") {
        $env:Path = "$dir;$env:Path"
    }
}

# Broadcast WM_SETTINGCHANGE so other open shells pick it up
try {
    Add-Type -Namespace Win32 -Name NativeMethods -MemberDefinition '[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)] public static extern IntPtr SendMessageTimeout(IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam, uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);'
    $HWND_BROADCAST = [IntPtr]0xffff
    $WM_SETTINGCHANGE = 0x1a
    $result = [UIntPtr]::Zero
    [Win32.NativeMethods]::SendMessageTimeout($HWND_BROADCAST, $WM_SETTINGCHANGE, [UIntPtr]::Zero, "Environment", 2, 5000, [ref]$result) | Out-Null
} catch { }

# --- Check Prerequisites & Configure Stack -----------------------------------
Write-Host ""
Info "Checking environment and prerequisites..."

$hasNodeOrBun = $false
if ((Get-Command "9router" -ErrorAction SilentlyContinue) -or `
    (Get-Command "bun" -ErrorAction SilentlyContinue) -or `
    (Get-Command "npm" -ErrorAction SilentlyContinue)) {
    $hasNodeOrBun = $true
}

$hasHeadroom = $false
if (Get-Command "headroom" -ErrorAction SilentlyContinue) {
    $hasHeadroom = $true
}

if ($hasNodeOrBun) {
    Ok "9router runtime available (Node/Bun found)"
} else {
    Info "npm/bun not found - 9router proxy auto-start disabled (install bun or npm to enable)"
}

if ($hasHeadroom) {
    Ok "headroom binary found"
} else {
    Info "headroom not found - context compression proxy auto-start disabled (optional)"
}

$auto9router = if ($hasNodeOrBun) { "true" } else { "false" }
$autoHeadroom = if ($hasHeadroom) { "true" } else { "false" }

$acsDataDir = Join-Path ([Environment]::GetFolderPath("UserProfile")) ".acs\data"
$acsRoot = Join-Path ([Environment]::GetFolderPath("UserProfile")) ".acs"
foreach ($dir in @($acsDataDir, $acsRoot)) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
    $cfgPath = Join-Path $dir "stack-config.json"
    if (-not (Test-Path $cfgPath)) {
        $cfgContent = @"
{
  "auto_start": {
    "9router": $auto9router,
    "dashboard": true,
    "scheduler": true,
    "headroom": $autoHeadroom,
    "gateways": false
  }
}
"@
        [System.IO.File]::WriteAllText($cfgPath, $cfgContent, [System.Text.Encoding]::UTF8)
    } else {
        if (-not $hasNodeOrBun) {
            $existing = Get-Content $cfgPath -Raw
            $updated = $existing -replace '"9router":\s*true', '"9router": false'
            [System.IO.File]::WriteAllText($cfgPath, $updated, [System.Text.Encoding]::UTF8)
        }
        if (-not $hasHeadroom) {
            $existing = Get-Content $cfgPath -Raw
            $updated = $existing -replace '"headroom":\s*true', '"headroom": false'
            [System.IO.File]::WriteAllText($cfgPath, $updated, [System.Text.Encoding]::UTF8)
        }
    }
}

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
    if (-not $hasNodeOrBun) {
        Write-Host ""
        Info "Optional prerequisites for full AI stack (install anytime):"
        Info "  * 9router AI proxy: irm https://bun.sh/install.ps1 | iex"
    }
    Write-Host ""
}

} # end Install-ACS function

# --- Run with error capture ---------------------------------------------------
try {
    Install-ACS -TargetVersion $Version -LicenseKey $LicenseKey -DownloadCode $DownloadCode
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

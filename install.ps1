# install.ps1 — Install ACS CLI for Windows
# Usage: irm https://raw.githubusercontent.com/andyvandaric/acs/main/install.ps1 | iex
# Or:    pwsh -NoProfile -ExecutionPolicy Bypass -File install.ps1

# Wrap in a function to prevent exit from killing the host shell
function Install-ACS {
$ErrorActionPreference = "Stop"

$GITHUB_SOURCE_REPO = "andyvandaric/andyvand-opencode-config"
$GITHUB_SOURCE_BRANCH = "main"
$WHATSAPP_ORDER_URL = "https://wa.me/6281289731212?text=Mau%20order%20ACS%20nya%2C%20mohon%20infonya%20ya"
$INSTALL_DIR = "$env:USERPROFILE\.acs\bin"

function Info($msg) { Write-Host "  $msg" }
function Ok($msg) { Write-Host "✅ $msg" -ForegroundColor Green }
function Warn($msg) { Write-Host "⚠️  $msg" -ForegroundColor Yellow }
function Err($msg) { Write-Host "❌ $msg" -ForegroundColor Red; throw $msg }

Write-Host ""
Write-Host "⚡ ACS CLI — Agnostic Config Suites" -ForegroundColor Cyan
Write-Host "────────────────────────────────────"
Write-Host ""

# ─── Require PowerShell 7+ ────────────────────────────────────────────────────
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Warn "PowerShell $($PSVersionTable.PSVersion) detected — PS 7+ required."

    # Check if pwsh already exists somewhere
    $pwshPath = $null
    $pwshCmd = Get-Command pwsh -ErrorAction SilentlyContinue
    if ($pwshCmd) {
        $pwshPath = $pwshCmd.Source
    } elseif (Test-Path "$env:ProgramFiles\PowerShell\7\pwsh.exe") {
        $pwshPath = "$env:ProgramFiles\PowerShell\7\pwsh.exe"
    }

    # If not found, try to install
    if (-not $pwshPath) {
        Info "PowerShell 7 not found. Attempting install..."

        $installed = $false

        # Method 1: winget (may need admin)
        if (-not $installed -and (Get-Command winget -ErrorAction SilentlyContinue)) {
            Info "Trying winget..."
            try {
                $wingetOut = winget install --id Microsoft.PowerShell --source winget --accept-package-agreements --accept-source-agreements --silent 2>&1
                if ($LASTEXITCODE -eq 0) { $installed = $true }
            } catch { }
        }

        # Method 2: Direct MSI download (no admin needed for per-user)
        if (-not $installed) {
            Info "Trying direct download..."
            try {
                $msiUrl = "https://github.com/PowerShell/PowerShell/releases/download/v7.4.7/PowerShell-7.4.7-win-x64.msi"
                $msiPath = Join-Path $env:TEMP "pwsh-install.msi"
                Invoke-WebRequest -Uri $msiUrl -OutFile $msiPath -UseBasicParsing -TimeoutSec 120
                # Install per-user (no admin required)
                $msiArgs = "/i `"$msiPath`" /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ENABLE_PSREMOTING=0 REGISTER_MANIFEST=0 USE_MU=0 ENABLE_MU=0"
                Start-Process msiexec.exe -ArgumentList $msiArgs -Wait -NoNewWindow
                if ($LASTEXITCODE -eq 0) { $installed = $true }
                Remove-Item $msiPath -Force -ErrorAction SilentlyContinue
            } catch {
                Warn "MSI install failed: $_"
            }
        }

        # Re-check after install attempts
        if (Test-Path "$env:ProgramFiles\PowerShell\7\pwsh.exe") {
            $pwshPath = "$env:ProgramFiles\PowerShell\7\pwsh.exe"
        } elseif (Get-Command pwsh -ErrorAction SilentlyContinue) {
            $pwshPath = (Get-Command pwsh).Source
        }
    }

    # Relaunch in pwsh if available
    if ($pwshPath) {
        Ok "PowerShell 7 found at: $pwshPath"
        Info "Re-launching installer in pwsh..."
        & $pwshPath -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/andyvandaric/acs/main/install.ps1 | iex"
        if ($LASTEXITCODE -ne 0) {
            throw "PowerShell 7 installer failed with exit code $LASTEXITCODE"
        }
        return
    }

    # All methods failed
    Err "Could not install or find PowerShell 7. Install manually: https://aka.ms/powershell-release then re-run this installer."
}

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
Info "Platform: $PLATFORM"

# ─── Resolve GitHub token ────────────────────────────────────────────────────
Write-Host ""
Info "Resolving GitHub auth..."

$TOKEN = ""

if ($env:GITHUB_TOKEN) {
    $TOKEN = $env:GITHUB_TOKEN.Trim()
    Info "Auth: using GITHUB_TOKEN env var"
} elseif (Get-Command gh -ErrorAction SilentlyContinue) {
    $ghStatus = gh auth status 2>&1
    if ($LASTEXITCODE -eq 0) {
        $TOKEN = (gh auth token 2>$null)
        if ($TOKEN) {
            $TOKEN = $TOKEN.Trim()
            Info "Auth: using gh CLI token"
        } else {
            Info "Auth: using gh CLI session"
        }
    } else {
        Info "gh CLI found but not authenticated. Attempting login..."
        gh auth login
        if ($LASTEXITCODE -eq 0) {
            gh auth refresh -h github.com --scopes repo 2>$null
            $TOKEN = (gh auth token 2>$null)
            if ($TOKEN) { $TOKEN = $TOKEN.Trim() }
            Ok "GitHub login successful"
        } else {
            Warn "gh auth login failed"
        }
    }
}

if (-not $TOKEN) {
    Warn "No GitHub token found."
    Info "Install GitHub CLI and login: gh auth login"
    Info "Or set GITHUB_TOKEN environment variable."
    Err "Cannot proceed without GitHub authentication."
}

# ─── Verify repo access ─────────────────────────────────────────────────────
Write-Host ""
Info "Verifying access..."

$headers = @{
    "Authorization" = "token $TOKEN"
    "Accept" = "application/vnd.github+json"
}

try {
    $response = Invoke-WebRequest -Uri "https://api.github.com/repos/$GITHUB_SOURCE_REPO/contents/assets/acs?ref=$GITHUB_SOURCE_BRANCH" `
        -Headers $headers -UseBasicParsing -TimeoutSec 30 -ErrorAction Stop
    Ok "Repo access verified"
} catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    if ($statusCode -eq 401 -or $statusCode -eq 403 -or $statusCode -eq 404) {
        # Try gh API fallback
        $ghCheck = $null
        if (Get-Command gh -ErrorAction SilentlyContinue) {
            $env:GH_TOKEN = $TOKEN
            $ghCheck = gh api "repos/$GITHUB_SOURCE_REPO/contents/assets/acs?ref=$GITHUB_SOURCE_BRANCH" 2>$null
        }
        if ($ghCheck) {
            Ok "Repo access verified (via gh)"
        } else {
            Warn "You do not have ACS access yet (HTTP $statusCode)."
            Write-Host ""
            Write-Host "  Order ACS: $WHATSAPP_ORDER_URL"
            Write-Host ""
            Start-Process $WHATSAPP_ORDER_URL -ErrorAction SilentlyContinue
            throw "No ACS access"
        }
    } elseif (-not $_.Exception.Response) {
        Err "Cannot reach GitHub API. Check network/proxy/firewall."
    } else {
        Err "Unexpected GitHub API response (HTTP $statusCode)"
    }
}

# ─── Fetch manifest ──────────────────────────────────────────────────────────
Write-Host ""
Info "Fetching release manifest..."

$manifestHeaders = @{
    "Authorization" = "token $TOKEN"
    "Accept" = "application/vnd.github.raw"
}

try {
    $response = Invoke-WebRequest `
    -Uri "https://api.github.com/repos/$GITHUB_SOURCE_REPO/contents/assets/acs/manifest.json?ref=$GITHUB_SOURCE_BRANCH" `
    -Headers $manifestHeaders `
    -UseBasicParsing `
    -TimeoutSec 30
    $manifestRaw = [System.Text.Encoding]::UTF8.GetString($response.Content)
    $manifest = $manifestRaw | ConvertFrom-Json
} catch {
    Write-Host $_
    Err "Failed to fetch manifest.json"
}

$VERSION = $manifest.version
Ok "Latest version: v$VERSION"

# ─── Determine artifact ──────────────────────────────────────────────────────
$artifact = $manifest.artifacts.$PLATFORM
if (-not $artifact) {
    Err "No artifact found for platform: $PLATFORM"
}

$FILE_NAME = $artifact.file
$EXPECTED_SHA = $artifact.sha256
Info "Artifact: $FILE_NAME"

# ─── Download binary ─────────────────────────────────────────────────────────
Write-Host ""
Info "Downloading $FILE_NAME..."

$TMP_DIR = Join-Path $env:TEMP "acs-install-$(Get-Random)"
New-Item -ItemType Directory -Path $TMP_DIR -Force | Out-Null
$TMP_FILE = Join-Path $TMP_DIR $FILE_NAME

$downloaded = $false

# Method 1: GitHub Contents API
try {
    $contentsUrl = "https://api.github.com/repos/$GITHUB_SOURCE_REPO/contents/assets/acs/${FILE_NAME}?ref=$GITHUB_SOURCE_BRANCH"
    $contentsResp = Invoke-WebRequest -Uri $contentsUrl -Headers $headers -UseBasicParsing -TimeoutSec 30
    $contentsJson = $contentsResp.Content | ConvertFrom-Json
    $dlUrl = $contentsJson.download_url

    if ($dlUrl) {
        $dlHeaders = @{ "Authorization" = "token $TOKEN" }
        Invoke-WebRequest -Uri $dlUrl -Headers $dlHeaders -OutFile $TMP_FILE -UseBasicParsing -TimeoutSec 120
        $downloaded = $true
    }
} catch {
    # Fallback below
}

# Method 2: Git LFS sparse checkout
if (-not $downloaded -and (Get-Command git -ErrorAction SilentlyContinue)) {
    $lfsCheck = git lfs version 2>$null
    if ($LASTEXITCODE -eq 0) {
        $lfsDir = Join-Path $TMP_DIR "lfs-clone"
        git clone --no-checkout --depth 1 --branch $GITHUB_SOURCE_BRANCH `
            "https://x-access-token:${TOKEN}@github.com/${GITHUB_SOURCE_REPO}.git" `
            $lfsDir 2>$null
        if ($LASTEXITCODE -eq 0) {
            Push-Location $lfsDir
            git sparse-checkout set "assets/acs/$FILE_NAME" 2>$null
            git checkout 2>$null
            git lfs pull --include="assets/acs/$FILE_NAME" 2>$null
            Pop-Location
            $lfsFile = Join-Path $lfsDir "assets\acs\$FILE_NAME"
            if ((Test-Path $lfsFile) -and (Get-Item $lfsFile).Length -gt 1000000) {
                Copy-Item $lfsFile $TMP_FILE
                $downloaded = $true
            }
        }
        Remove-Item -Recurse -Force $lfsDir -ErrorAction SilentlyContinue
    }
}

if (-not $downloaded -or -not (Test-Path $TMP_FILE)) {
    Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
    Err "Download failed. Try again or check your network."
}

$dlSize = (Get-Item $TMP_FILE).Length
if ($dlSize -lt 1000000) {
    Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
    Err "Download failed: file too small ($dlSize bytes). May be a Git LFS pointer."
}
$dlMB = [math]::Round($dlSize / 1MB, 1)
Ok "Downloaded: $dlMB MB"

# ─── Verify SHA-256 ──────────────────────────────────────────────────────────
if ($EXPECTED_SHA) {
    Info "Verifying integrity..."
    $actualSha = (Get-FileHash -Path $TMP_FILE -Algorithm SHA256).Hash.ToLower()
    if ($actualSha -ne $EXPECTED_SHA) {
        Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
        Err "SHA-256 mismatch! Expected: $EXPECTED_SHA, Got: $actualSha"
    }
    Ok "SHA-256 verified"
}

# ─── Install ─────────────────────────────────────────────────────────────────
Write-Host ""
Info "Installing to $INSTALL_DIR..."

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
# Always ensure current session has it (propagates to script scope via [Environment])
if ($env:Path -notlike "*$INSTALL_DIR*") {
    $env:Path = "$INSTALL_DIR;$env:Path"
}
# Broadcast WM_SETTINGCHANGE so other open shells pick it up
try {
    Add-Type -Namespace Win32 -Name NativeMethods -MemberDefinition @"
[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
public static extern IntPtr SendMessageTimeout(
    IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam,
    uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
"@
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

# ─── Verify ──────────────────────────────────────────────────────────────────
Write-Host ""
$acsVersion = & $acsCli version 2>$null
if ($acsVersion) {
    # Strip "acs-cli " prefix if present (avoid "vacs-cli 0.14.0")
    $acsVersion = $acsVersion -replace '^acs-cli\s*', ''
    Ok "acs-cli v$acsVersion ready!"
} else {
    Ok "Installed! Run: acs-cli setup"
}

Write-Host ""
Write-Host "────────────────────────────────────"
Write-Host "  Next: acs-cli setup" -ForegroundColor Cyan
Write-Host "────────────────────────────────────"
Write-Host ""

} # end Install-ACS function

# ─── Run with error capture (prevents exit from killing host shell) ───────────
try {
    Install-ACS
} catch {
    Write-Host ""
    Write-Host "────────────────────────────────────" -ForegroundColor Red
    Write-Host "  Installation failed: $_" -ForegroundColor Red
    Write-Host "────────────────────────────────────" -ForegroundColor Red
    Write-Host ""
    Write-Host "  If this persists, contact support or try:" -ForegroundColor Yellow
    Write-Host "    pwsh -NoProfile -ExecutionPolicy Bypass -File install.ps1" -ForegroundColor Yellow
    Write-Host ""
    if ($PSCommandPath) {
        exit 1
    }
}

# Ensure PATH is available in the caller's session (function scope doesn't propagate)
$_acsDir = "$env:USERPROFILE\.acs\bin"
if ((Test-Path "$_acsDir\acs-cli.exe") -and ($env:Path -notlike "*$_acsDir*")) {
    $env:Path = "$_acsDir;$env:Path"
}

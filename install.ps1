# install.ps1 — Install ACS CLI for Windows
# Usage: irm https://raw.githubusercontent.com/andyvandaric/acs/main/install.ps1 | iex
# Or:    pwsh -NoProfile -ExecutionPolicy Bypass -File install.ps1

# Enable TLS 1.2 for older Windows 10 / PowerShell 5.1 environments
try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
} catch {}

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

        # Method 1: winget
        if (Get-Command winget -ErrorAction SilentlyContinue) {
            Write-Host "  Trying winget..." -ForegroundColor Cyan
            try {
                $null = winget install --id Microsoft.PowerShell --source winget --accept-package-agreements --accept-source-agreements --silent 2>&1
            } catch { }
        }

        # Method 2: Direct MSI download
        if (-not (Test-Path "$env:ProgramFiles\PowerShell\7\pwsh.exe")) {
            Write-Host "  Trying direct download..." -ForegroundColor Cyan
            try {
                $msiUrl = "https://github.com/PowerShell/PowerShell/releases/download/v7.4.7/PowerShell-7.4.7-win-x64.msi"
                $msiPath = Join-Path $env:TEMP "pwsh-install.msi"
                Invoke-WebRequest -Uri $msiUrl -OutFile $msiPath -UseBasicParsing -TimeoutSec 120
                Start-Process msiexec.exe -ArgumentList "/i `"$msiPath`" /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ENABLE_PSREMOTING=0 REGISTER_MANIFEST=0 USE_MU=0 ENABLE_MU=0" -Wait -NoNewWindow
                Remove-Item $msiPath -Force -ErrorAction SilentlyContinue
            } catch {
                Write-Host "  !! MSI install failed: $_" -ForegroundColor Yellow
            }
        }

        # Re-check
        if (Test-Path "$env:ProgramFiles\PowerShell\7\pwsh.exe") {
            $pwshPath = "$env:ProgramFiles\PowerShell\7\pwsh.exe"
        } elseif (Get-Command pwsh -ErrorAction SilentlyContinue) {
            $pwshPath = (Get-Command pwsh).Source
        }
    }

    # Relaunch in pwsh
    if ($pwshPath) {
        Write-Host "  OK PowerShell 7 found at: $pwshPath" -ForegroundColor Green
        Write-Host "  Re-launching installer in pwsh..." -ForegroundColor Cyan
        & $pwshPath -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/andyvandaric/acs/main/install.ps1 | iex"
        # Propagate PATH after pwsh finishes
        $acsDir = "$env:USERPROFILE\.acs\bin"
        if ((Test-Path "$acsDir\acs.exe") -and ($env:Path -notlike "*$acsDir*")) {
            $env:Path = "$acsDir;$env:Path"
        }
        return
    }

    Write-Host ""
    Write-Host "  !! Could not install or find PowerShell 7." -ForegroundColor Red
    Write-Host "  Install manually: https://aka.ms/powershell-release" -ForegroundColor Yellow
    Write-Host "  Then re-run this installer." -ForegroundColor Yellow
    Write-Host ""
    return
}

# ─── Everything below requires PowerShell 7+ ─────────────────────────────────
# PS5 will never reach here (it returns above)

# ─── PRODUCT CLI arg (manual $args parse; no param() block keeps PS5 bootstrap byte-identical) ───
# Supports: pwsh -File install.ps1 -PRODUCT vpsease | $env:PRODUCT='vpsease' | $PRODUCT='vpsease'; irm ... | iex
$script:PRODUCT_FROM_ARGS = ""
for ($__pi = 0; $__pi -lt $args.Count; $__pi++) {
    if ([string]$args[$__pi] -eq "-PRODUCT") {
        if (($__pi + 1) -lt $args.Count) { $script:PRODUCT_FROM_ARGS = [string]$args[$__pi + 1] }
    }
}

function Install-ACS {
$ErrorActionPreference = "Stop"

$GITHUB_SOURCE_BRANCH = "main"
$WHATSAPP_ORDER_URL = "https://wa.me/6281289731212?text=Mau%20order%20ACS%20nya%2C%20mohon%20infonya%20ya"

# ─── PRODUCT namespace (phase-03 P2: generic installer; mirror of install.sh) ──
$PRODUCT = $script:PRODUCT_FROM_ARGS
if (-not $PRODUCT -and $env:PRODUCT) { $PRODUCT = $env:PRODUCT }
if (-not $PRODUCT) { $PRODUCT = "acs" }
$PRODUCT = ([string]$PRODUCT).Trim().ToLowerInvariant()
switch ($PRODUCT) {
    "acs" {
        $GITHUB_SOURCE_REPO = "andyvandaric/agnostic-config-suites"
        $ASSETS_DIR = "assets/acs"
        $CDN_PREFIX = "/acs/"
        $INSTALL_DIR = "$env:USERPROFILE\.acs\bin"
    }
    "vpsease" {
        $GITHUB_SOURCE_REPO = "andyvandaric/agnostic-config-suites"
        $ASSETS_DIR = "assets/vpsease"
        $CDN_PREFIX = "/vpsease/"
        $INSTALL_DIR = "$env:USERPROFILE\.vpsease\bin"
    }
    default {
        Write-Error "Unknown PRODUCT: '${PRODUCT}'. Valid values: acs|vpsease" -ErrorAction Continue
        exit 1
    }
}
$script:PRODUCT = $PRODUCT

function Info($msg) { Write-Host "  $msg" }
function Ok($msg) { Write-Host "`u{2705} $msg" -ForegroundColor Green }
function Warn($msg) { Write-Host "`u{26A0}`u{FE0F}  $msg" -ForegroundColor Yellow }
function Err($msg) { Write-Host "`u{274C} $msg" -ForegroundColor Red; throw $msg }

function Repair-BrokenBunClaude {
    $bunGlobalDir = "$env:USERPROFILE\.bun\install\global\node_modules\@anthropic-ai\claude-code"
    if (-not (Test-Path $bunGlobalDir)) { return }
    $isBroken = $false
    $bunClaudeExe = "$env:USERPROFILE\.bun\bin\claude.exe"
    if (Test-Path $bunClaudeExe) {
        $item = Get-Item $bunClaudeExe -ErrorAction SilentlyContinue
        if ($null -ne $item -and $item.Length -le 1024) { $isBroken = $true }
    } else {
        $isBroken = $true
    }
    if (-not $isBroken) { return }
    Warn "Detected broken bun Claude Code stub (triggers 16-bit app error). Auto-healing..."
    Remove-Item -Recurse -Force $bunGlobalDir -ErrorAction SilentlyContinue
    Remove-Item -Force "$env:USERPROFILE\.bun\bin\claude*" -ErrorAction SilentlyContinue
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        Info "Reinstalling Claude Code via npm..."
        & npm install -g "@anthropic-ai/claude-code" 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Ok "Claude Code auto-healed via npm"
        } else {
            Warn "npm reinstall failed. Run: npm install -g @anthropic-ai/claude-code"
        }
    } else {
        Warn "npm not found. Run manually: npm install -g @anthropic-ai/claude-code"
    }
}

Write-Host ""
Write-Host "`u{26A1} ACS CLI `u{2014} Agnostic Config Suites" -ForegroundColor Cyan
Write-Host "`u{2500}" * 36
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
    $response = Invoke-WebRequest -Uri "https://api.github.com/repos/$GITHUB_SOURCE_REPO/contents/$ASSETS_DIR?ref=$GITHUB_SOURCE_BRANCH" `
        -Headers $headers -UseBasicParsing -TimeoutSec 30 -ErrorAction Stop
    Ok "Repo access verified"
} catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    if ($statusCode -eq 401 -or $statusCode -eq 403 -or $statusCode -eq 404) {
        $ghCheck = $null
        if (Get-Command gh -ErrorAction SilentlyContinue) {
            $env:GH_TOKEN = $TOKEN
            $ghCheck = gh api "repos/$GITHUB_SOURCE_REPO/contents/$ASSETS_DIR?ref=$GITHUB_SOURCE_BRANCH" 2>$null
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
        -Uri "https://api.github.com/repos/$GITHUB_SOURCE_REPO/contents/$ASSETS_DIR/manifest.json?ref=$GITHUB_SOURCE_BRANCH" `
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

# Progress download helper — synchronous stream read with inline progress
function Download-WithProgress {
    param([string]$Url, [hashtable]$Headers, [string]$OutFile)

    try {
        $request = [System.Net.HttpWebRequest]::Create($Url)
        $request.Timeout = 120000
        foreach ($key in $Headers.Keys) {
            $request.Headers.Add($key, $Headers[$key])
        }

        $response = $request.GetResponse()
        $totalBytes = $response.ContentLength
        $stream = $response.GetResponseStream()
        $fileStream = [System.IO.File]::Create($OutFile)
        $buffer = New-Object byte[] 65536
        $bytesRead = 0
        $totalRead = 0
        $lastReport = 0

        while (($bytesRead = $stream.Read($buffer, 0, $buffer.Length)) -gt 0) {
            $fileStream.Write($buffer, 0, $bytesRead)
            $totalRead += $bytesRead
            $mb = [math]::Round($totalRead / 1MB, 1)
            if ($mb -ge $lastReport + 1) {
                $lastReport = [math]::Floor($mb)
                if ($totalBytes -gt 0) {
                    $pct = [math]::Round(($totalRead / $totalBytes) * 100)
                    Write-Host "`r  Downloading... ${mb}MB / $([math]::Round($totalBytes / 1MB, 1))MB ($pct%)" -NoNewline
                } else {
                    Write-Host "`r  Downloading... ${mb}MB" -NoNewline
                }
            }
        }

        $fileStream.Close()
        $stream.Close()
        $response.Close()
        Write-Host ""
        return $true
    } catch {
        return $false
    }
}

# Method 1: GitHub Contents API
try {
    $contentsUrl = "https://api.github.com/repos/$GITHUB_SOURCE_REPO/contents/$ASSETS_DIR/${FILE_NAME}?ref=$GITHUB_SOURCE_BRANCH"
    $contentsResp = Invoke-WebRequest -Uri $contentsUrl -Headers $headers -UseBasicParsing -TimeoutSec 30
    $contentsJson = $contentsResp.Content | ConvertFrom-Json
    $dlUrl = $contentsJson.download_url

    if ($dlUrl) {
        $dlHeaders = @{ "Authorization" = "token $TOKEN" }
        $result = Download-WithProgress -Url $dlUrl -Headers $dlHeaders -OutFile $TMP_FILE
        if ($result) { $downloaded = $true }
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
            git sparse-checkout set "$ASSETS_DIR/$FILE_NAME" 2>$null
            git checkout 2>$null
            git lfs pull --include="$ASSETS_DIR/$FILE_NAME" 2>$null
            Pop-Location
            $lfsFile = Join-Path $lfsDir (($ASSETS_DIR -replace '/', '\') + "\$FILE_NAME")
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
Copy-Item $TMP_FILE (Join-Path $INSTALL_DIR "acs.exe") -Force
# Clean up legacy acs-cli.exe if present
$legacyExe = Join-Path $INSTALL_DIR "acs-cli.exe"
if (Test-Path $legacyExe) {
    Remove-Item $legacyExe -Force -ErrorAction SilentlyContinue
}
Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue
Ok "Installed: $INSTALL_DIR\acs.exe"

# ─── PATH setup (single source of truth: $INSTALL_DIR and ~/.acs/env/bin) ────────
$userProfile = [Environment]::GetFolderPath("UserProfile")
$envBin = Join-Path $userProfile ".acs\env\bin"
if (-not (Test-Path $envBin)) {
    New-Item -ItemType Directory -Path $envBin -Force | Out-Null
}
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
$parts = @()
if ($currentPath) {
    $parts = $currentPath -split ';' | ForEach-Object { $_.Trim() } | Where-Object { $_ }
}
$installNorm = $INSTALL_DIR.TrimEnd('\')
$envBinNorm = $envBin.TrimEnd('\')
$seen = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::OrdinalIgnoreCase)
$ordered = New-Object System.Collections.Generic.List[string]
[void]$seen.Add($installNorm)
[void]$ordered.Add($INSTALL_DIR)
if ($seen.Add($envBinNorm)) { [void]$ordered.Add($envBin) }
foreach ($p in $parts) {
    $pn = $p.TrimEnd('\')
    # Secondary acs locations are not SoT — drop them
    if ($pn -like '*\go\bin') { continue }
    if ($seen.Add($pn)) { [void]$ordered.Add($p) }
}
$newPath = [string]::Join(';', $ordered)
if ($newPath -ne $currentPath) {
    Info "Enforcing user PATH SoT: $INSTALL_DIR; $envBin"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Ok "User PATH SoT updated"
}
$env:Path = "$INSTALL_DIR;$envBin;$env:Path"
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
$acsBin = Join-Path $INSTALL_DIR "acs.exe"
try {
    $svcOutput = & $acsBin service install 2>&1
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

# ─── Repair broken bun Claude Code stubs (proactive) ────────────────────────
Write-Host ""
Info "Checking for broken Claude Code installations..."
Repair-BrokenBunClaude

# ─── Verify ──────────────────────────────────────────────────────────────────
Write-Host ""
$acsVersion = & $acsBin --version 2>$null
if ($acsVersion) {
    $acsVersion = $acsVersion -replace '^acs\s*', ''
    Ok "acs v$acsVersion ready!"
} else {
    Ok "Installed! Run: acs setup"
}

Write-Host ""
Write-Host "`u{2500}" * 36
Write-Host "  Next: acs setup" -ForegroundColor Cyan
Write-Host "`u{2500}" * 36
Write-Host ""

} # end Install-ACS function

# ─── Run with error capture ───────────────────────────────────────────────────
try {
    Install-ACS
} catch {
    Write-Host ""
    Write-Host "`u{2500}" * 36 -ForegroundColor Red
    Write-Host "  Installation failed: $_" -ForegroundColor Red
    Write-Host "`u{2500}" * 36 -ForegroundColor Red
    Write-Host ""
    Write-Host "  If this persists, contact support or try:" -ForegroundColor Yellow
    Write-Host "    pwsh -NoProfile -ExecutionPolicy Bypass -File install.ps1" -ForegroundColor Yellow
    Write-Host ""
}

# Ensure PATH is available in the caller's session (PRODUCT-aware; default stays acs)
if ($script:PRODUCT -eq "vpsease") { $_acsDir = "$env:USERPROFILE\.vpsease\bin" } else { $_acsDir = "$env:USERPROFILE\.acs\bin" }
if ((Test-Path "$_acsDir\acs.exe") -and ($env:Path -notlike "*$_acsDir*")) {
    $env:Path = "$_acsDir;$env:Path"
}

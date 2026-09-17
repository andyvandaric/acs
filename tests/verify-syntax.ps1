<#
.SYNOPSIS
    Automated syntax & structure verification for install.ps1.
.DESCRIPTION
    Runs AST parsing using System.Management.Automation.Language.Parser and validates
    all Phase 01 criteria: 0 syntax errors, dual-track fallback, target binary name 'acs.exe'.
#>
$ErrorActionPreference = "Stop"
$scriptPath = Join-Path $PSScriptRoot "..\install.ps1"

if (-not (Test-Path $scriptPath)) {
    Write-Error "Target file not found: $scriptPath"
    exit 1
}

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "  ACS Universal Installer: verify-syntax.ps1" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

$testsPassed = 0
$testsFailed = 0

function Assert-Test($Name, [scriptblock]$Test) {
    try {
        $result = & $Test
        if ($result -ne $false) {
            Write-Host "  [PASS] $Name" -ForegroundColor Green
            $script:testsPassed++
        } else {
            Write-Host "  [FAIL] $Name (condition returned false)" -ForegroundColor Red
            $script:testsFailed++
        }
    } catch {
        Write-Host "  [FAIL] $Name ($_)" -ForegroundColor Red
        $script:testsFailed++
    }
}

# 1. AST Syntax & Parser Test
Assert-Test "PowerShell AST ParseFile yields zero parse errors" {
    $parseErrors = $null
    $tokens = $null
    $ast = [System.Management.Automation.Language.Parser]::ParseFile($scriptPath, [ref]$tokens, [ref]$parseErrors)
    if ($parseErrors -and $parseErrors.Count -gt 0) {
        $parseErrors | ForEach-Object { Write-Host "    Line $($_.Extent.StartLineNumber): $($_.Message)" -ForegroundColor Yellow }
        return $false
    }
    return $true
}

$content = [System.IO.File]::ReadAllText($scriptPath, [System.Text.Encoding]::UTF8)

# 2. Target binary checks
Assert-Test "Target installation binary is acs.exe" {
    $content -match 'Copy-Item\s+\$TMP_FILE\s+\$targetExe' -and $content -match '\$targetExe\s*=\s*Join-Path\s+\$INSTALL_DIR\s+"acs\.exe"'
}

Assert-Test "Removes or cleans legacy acs-cli.exe" {
    $content -match 'acs-cli\.exe' -and $content -match 'Remove-Item\s+\$legacyExe'
}

Assert-Test "Process cleanup targets both acs and legacy acs-cli" {
    $content -match 'Get-Process\s+-Name\s+"acs",\s*"acs-cli"'
}

# 3. Dual-Track Download Resilience checks
Assert-Test "Primary CDN base is configured to dl.uikode.com" {
    $content -match '\$PRIMARY_CDN_BASE\s*=\s*"https://dl\.uikode\.com"'
}

Assert-Test "Fallback CDN base is configured to GitHub Releases" {
    $content -match '\$FALLBACK_CDN_BASE\s*=\s*"https://github\.com/andyvandaric/acs/releases/latest/download"'
}

Assert-Test "Dual-track manifest fetch logic is present" {
    $content -match '\$MANIFEST_URL\s*=\s*"\$PRIMARY_CDN_BASE/manifest\.json"' -and
    $content -match '\$FALLBACK_MANIFEST_URL\s*=\s*"\$FALLBACK_CDN_BASE/manifest\.json"' -and
    $content -match 'Invoke-RestMethod.*\$FALLBACK_MANIFEST_URL'
}

Assert-Test "Dual-track binary download fallback logic is present" {
    $content -match 'Invoke-WebRequest.*\$primaryUrl' -and
    $content -match 'Invoke-WebRequest.*\$fallbackUrl'
}

# 4. Security & Integrity verification
Assert-Test "SHA-256 integrity verification is enforced" {
    $content -match 'Get-FileHash.*SHA256' -and
    $content -match 'SHA-256 mismatch!'
}

Assert-Test "Minimum file size guard is enforced" {
    $content -match '\$dlSize\s+-lt\s+1000000'
}

# 5. Service & Next Steps branding checks
Assert-Test "Service installation command uses acs instead of acs-cli" {
    $content -match '\$targetExe\s+service\s+install' -and
    $content -notmatch 'acs-cli\s+service\s+install'
}

Assert-Test "Post-install activation instruction uses acs activate" {
    $content -match 'acs\s+activate\s+<YOUR_LICENSE_KEY>'
}

Write-Host ""
Write-Host "----------------------------------------------------"
Write-Host "Total Tests: $($testsPassed + $testsFailed) | Passed: $testsPassed | Failed: $testsFailed"
if ($testsFailed -gt 0) {
    Write-Host "VERDICT: FAILED" -ForegroundColor Red
    exit 1
} else {
    Write-Host "VERDICT: ALL TESTS PASSED" -ForegroundColor Green
    exit 0
}

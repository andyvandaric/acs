<#
.SYNOPSIS
    Automated syntax & structure verification for uninstall.ps1.
.DESCRIPTION
    Runs AST parsing using System.Management.Automation.Language.Parser and validates
    all uninstaller criteria: 0 syntax errors, parameter support, binary delegation,
    scheduled tasks cleanup, surgical MCP cleanup, and recursive purge.
#>
$ErrorActionPreference = "Stop"
$scriptPath = Join-Path $PSScriptRoot "..\uninstall.ps1"

if (-not (Test-Path $scriptPath)) {
    Write-Error "Target file not found: $scriptPath"
    exit 1
}

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "  ACS Universal Uninstaller: verify-uninstall-syntax.ps1" -ForegroundColor Cyan
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

$content = Get-Content $scriptPath -Raw

# 2. Parameters
Assert-Test "Supports -Purge, -Force, -DryRun, and -Help parameters" {
    $content -match '\[switch\]\$Purge' -and
    $content -match '\[switch\]\$Force' -and
    $content -match '\[switch\]\$DryRun' -and
    $content -match '\[switch\]\$Help'
}

# 3. Binary Delegation
Assert-Test "Binary delegation checks for acs.exe and executes uninstall" {
    $content -match '\$targetExe\s*=\s*Join-Path\s+\$INSTALL_DIR\s+"acs\.exe"' -and
    $content -match '&\s+\$targetExe\s+@cliArgs'
}

# 4. Scheduled Tasks Cleanup
Assert-Test "Removes Windows Task Scheduler jobs (ACS Watchdog, Kanban Backup)" {
    $content -match 'schtasks\.exe\s+/Delete\s+/TN\s+\$t\s+/F' -and
    $content -match '"ACS Watchdog"' -and
    $content -match '"ACS Kanban Backup"'
}

# 5. Surgical MCP Cleanup
Assert-Test "Includes surgical cleanup of ACS MCP servers from .claude.json" {
    $content -match '\$jsonObj\.mcpServers\.PSObject\.Properties\.Remove' -and
    $content -match 'acs-\*'
}

# 6. Recursive Purge
Assert-Test "Purge mode removes entire ~/.acs directory recursively" {
    $content -match 'Remove-Item\s+\$ACS_DIR\s+-Recurse\s+-Force'
}

# 7. Sovereign CDN URL
Assert-Test "Usage references Sovereign CDN dl.uikode.com" {
    $content -match 'https://dl\.uikode\.com/uninstall\.ps1'
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

$ErrorActionPreference = "Stop"
$scriptPath = Join-Path $PSScriptRoot "..\install.ps1"
$content = Get-Content -Raw -Path $scriptPath

function Assert-MatchText($Name, $Pattern) {
    if ($content -notmatch $Pattern) {
        throw "FAIL: $Name"
    }
    Write-Host "PASS: $Name"
}

function Assert-NotMatchText($Name, $Pattern) {
    if ($content -match $Pattern) {
        throw "FAIL: $Name"
    }
    Write-Host "PASS: $Name"
}

Assert-MatchText "pwsh relaunch propagates child exit code" '(?s)&\s+\$pwshPath\s+-NoProfile\s+-ExecutionPolicy\s+Bypass\s+-Command.*if\s*\(\s*\$LASTEXITCODE\s+-ne\s+0\s*\).*throw'
Assert-MatchText "pwsh relaunch uses same pinned source URL" 'https://raw\.githubusercontent\.com/andyvandaric/acs/main/install\.ps1'
Assert-MatchText "top-level catch exits non-zero for file execution" '(?s)catch\s*\{.*if\s*\(\s*\$PSCommandPath\s*\).*exit\s+1'
Assert-MatchText "sha mismatch remains hard failure" 'Err\s+"SHA-256 mismatch! Expected: \$EXPECTED_SHA, Got: \$actualSha"'
Assert-NotMatchText "no silent return immediately after pwsh relaunch" '(?s)&\s+\$pwshPath\s+-NoProfile\s+-ExecutionPolicy\s+Bypass\s+-Command[^\r\n]*\r?\n\s*return'

Assert-NotMatchText "no host-killing exit for Invoke-Expression path" "\$MyInvocation\.InvocationName\s+-ne\s+'\.'"

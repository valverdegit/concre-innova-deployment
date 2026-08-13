[CmdletBinding()]
param(
    [string]$ManifestPath = 'config/release-manifest.yml'
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $ManifestPath)) {
    throw "Release manifest not found: $ManifestPath"
}

$manifest = Get-Content -Raw -LiteralPath $ManifestPath
$shaMatches = [regex]::Matches($manifest, '(?m)^\s*ref:\s*([0-9a-f]{40})\s*$')

if ($shaMatches.Count -ne 2) {
    throw 'The release manifest must contain exactly two immutable 40-character commit SHAs.'
}

if ($manifest -match '(?m)^\s*ref:\s*(main|master|develop|latest)\s*$') {
    throw 'Mutable branch references are not allowed in the release manifest.'
}

Write-Output 'RELEASE_MANIFEST_OK'

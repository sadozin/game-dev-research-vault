[CmdletBinding()]
param(
    [switch]$NoPush
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$repoRoot = Split-Path -Parent $PSScriptRoot
$workspaceRoot = Split-Path -Parent $repoRoot
$brainRoot = Join-Path $workspaceRoot 'brain'
$conceptSource = Join-Path $brainRoot 'wiki\concepts'
$sourceSource = Join-Path $brainRoot 'wiki\sources'
$conceptTarget = Join-Path $repoRoot 'wiki\concepts'
$sourceTarget = Join-Path $repoRoot 'wiki\sources'

if (-not (Test-Path -LiteralPath $conceptSource)) {
    throw "Expected private brain concepts at $conceptSource."
}

function Reset-PublishDirectory {
    param([string]$Path)

    New-Item -ItemType Directory -Force -Path $Path | Out-Null
    Get-ChildItem -LiteralPath $Path -File -Filter '*.md' | Remove-Item -Force
}

Reset-PublishDirectory -Path $conceptTarget
Reset-PublishDirectory -Path $sourceTarget

$tagPattern = '(?im)^tags:\s*\[[^\]]*\b(game|mmo|vrchat|unity|unreal|blender|optimization|clicker|idle|assets|textures|rigging|avatars|mcp)\b'
$publishedConcepts = @()

Get-ChildItem -LiteralPath $conceptSource -File -Filter '*.md' | ForEach-Object {
    $content = Get-Content -LiteralPath $_.FullName -Raw
    if ($content -match $tagPattern) {
        Copy-Item -LiteralPath $_.FullName -Destination $conceptTarget -Force
        $publishedConcepts += [PSCustomObject]@{ Name = $_.BaseName; Content = $content }
    }
}

$sourceNames = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
foreach ($concept in $publishedConcepts) {
    [regex]::Matches($concept.Content, '\[\[([^\]|#]+)') | ForEach-Object {
        $candidate = $_.Groups[1].Value.Trim()
        if (Test-Path -LiteralPath (Join-Path $sourceSource ($candidate + '.md'))) {
            [void]$sourceNames.Add($candidate)
        }
    }
}

foreach ($sourceName in $sourceNames) {
    Copy-Item -LiteralPath (Join-Path $sourceSource ($sourceName + '.md')) -Destination $sourceTarget -Force
}

$index = @(
    '# Game Dev Research Index'
    ''
    'Open this repository folder as an Obsidian vault. Notes below are generated from the private'
    'research brain; edit the source brain and rerun `tools/publish-research.ps1` rather than'
    'editing generated files here.'
    ''
    '## Concepts'
    ''
) + ($publishedConcepts.Name | Sort-Object | ForEach-Object { '- [[' + $_ + ']]' }) + @(
    ''
    '## Source summaries'
    ''
) + ($sourceNames | Sort-Object | ForEach-Object { '- [[' + $_ + ']]' })

$utf8 = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText((Join-Path $repoRoot 'INDEX.md'), (($index -join "`n") + "`n"), $utf8)

if (-not (Test-Path -LiteralPath (Join-Path $repoRoot '.git'))) {
    & git -C $repoRoot init -b main
}

& git -C $repoRoot add --all
& git -C $repoRoot diff --cached --quiet
if ($LASTEXITCODE -eq 0) {
    Write-Host 'Public vault is already synchronized.'
    exit 0
}

$gitName = & git -C $repoRoot config user.name
$gitEmail = & git -C $repoRoot config user.email
if ([string]::IsNullOrWhiteSpace($gitName) -or [string]::IsNullOrWhiteSpace($gitEmail)) {
    Write-Warning 'Research export is staged but not committed: configure git user.name and user.email for this repository.'
    exit 0
}

& git -C $repoRoot commit -m 'Publish game-development research'

if ($NoPush) {
    Write-Host 'Committed locally; push skipped by -NoPush.'
    exit 0
}

$remoteNames = & git -C $repoRoot remote
if ($remoteNames -notcontains 'origin') {
    Write-Warning 'Committed locally; no origin remote is configured, so nothing was pushed.'
    exit 0
}

& git -C $repoRoot push -u origin main

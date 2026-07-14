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
$manifestPath = Join-Path $repoRoot '.brain-export-manifest.txt'

if (-not (Test-Path -LiteralPath $conceptSource)) {
    throw "Expected private brain concepts at $conceptSource."
}

New-Item -ItemType Directory -Force -Path $conceptTarget | Out-Null
New-Item -ItemType Directory -Force -Path $sourceTarget | Out-Null

$tagPattern = '(?im)^tags:\s*\[[^\]]*\b(game|mmo|vrchat|unity|unreal|godot|blender|optimization|clicker|idle|assets|textures|rigging|avatars|mcp)\b'
$publishedConcepts = @()

Get-ChildItem -LiteralPath $conceptSource -File -Filter '*.md' | ForEach-Object {
    $content = Get-Content -LiteralPath $_.FullName -Raw
    if ($content -match $tagPattern) {
        Copy-Item -LiteralPath $_.FullName -Destination $conceptTarget -Force
        $publishedConcepts += [PSCustomObject]@{ Name = $_.BaseName; Content = $content }
    }
}

$currentExports = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
foreach ($concept in $publishedConcepts) {
    [void]$currentExports.Add(('wiki/concepts/' + $concept.Name + '.md'))
}

$sourceNames = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
foreach ($concept in $publishedConcepts) {
    [regex]::Matches($concept.Content, '\[\[([^\]|#]+)') | ForEach-Object {
        $candidate = $_.Groups[1].Value.Trim()
        # Obsidian links may be basename-only (`[[source]]`) or path-qualified
        # (`[[wiki/sources/source|source]]`). The private vault uses qualified links when a raw
        # provenance stub and compiled source summary share a basename, so always resolve the leaf
        # name before checking the source-summary directory.
        $candidateLeaf = Split-Path -Leaf ($candidate -replace '/', '\')
        if (Test-Path -LiteralPath (Join-Path $sourceSource ($candidateLeaf + '.md'))) {
            [void]$sourceNames.Add($candidateLeaf)
        }
    }
}

foreach ($sourceName in $sourceNames) {
    Copy-Item -LiteralPath (Join-Path $sourceSource ($sourceName + '.md')) -Destination $sourceTarget -Force
    [void]$currentExports.Add(('wiki/sources/' + $sourceName + '.md'))
}

# Delete only stale files that a previous brain export owned. Public pages contributed directly to
# this repository are deliberately outside the manifest and survive every publish.
if (Test-Path -LiteralPath $manifestPath) {
    Get-Content -LiteralPath $manifestPath | ForEach-Object {
        $relativePath = $_.Trim()
        if ($relativePath -and -not $currentExports.Contains($relativePath)) {
            $ownedPath = Join-Path $repoRoot ($relativePath -replace '/', '\')
            if (Test-Path -LiteralPath $ownedPath) {
                Remove-Item -LiteralPath $ownedPath -Force
            }
        }
    }
}

$allConceptNames = Get-ChildItem -LiteralPath $conceptTarget -File -Filter '*.md' |
    ForEach-Object { $_.BaseName } | Sort-Object -Unique
$allSourceNames = Get-ChildItem -LiteralPath $sourceTarget -File -Filter '*.md' |
    ForEach-Object { $_.BaseName } | Sort-Object -Unique

$index = @(
    '# Game Dev Research Index'
    ''
    'Open this repository folder as an Obsidian vault. Notes below are generated from the private'
    'research brain; edit the source brain and rerun `tools/publish-research.ps1` rather than'
    'editing generated files here.'
    ''
    '## Concepts'
    ''
) + ($allConceptNames | ForEach-Object { '- [[' + $_ + ']]' }) + @(
    ''
    '## Source summaries'
    ''
) + ($allSourceNames | ForEach-Object { '- [[' + $_ + ']]' })

$utf8 = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText((Join-Path $repoRoot 'INDEX.md'), (($index -join "`n") + "`n"), $utf8)
[System.IO.File]::WriteAllLines($manifestPath, ($currentExports | Sort-Object), $utf8)

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

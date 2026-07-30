# Install skill-router into common AI harness paths (Windows)
param(
  [ValidateSet("cursor", "claude", "antigravity", "agents", "all")]
  [string]$Target = "all",
  [switch]$Project
)

$ErrorActionPreference = "Stop"
$Root = $PSScriptRoot
$SkillSrc = $Root

function Ensure-Dir($p) {
  if (-not (Test-Path $p)) { New-Item -ItemType Directory -Path $p -Force | Out-Null }
}

function Install-SkillFolder($dest) {
  Ensure-Dir $dest
  Copy-Item -Force (Join-Path $SkillSrc "SKILL.md") (Join-Path $dest "SKILL.md")
  Copy-Item -Force (Join-Path $SkillSrc "registry.md") (Join-Path $dest "registry.md")
  Write-Host "Skill -> $dest"
}

function Install-CursorRule($destDir) {
  Ensure-Dir $destDir
  Copy-Item -Force (Join-Path $SkillSrc ".cursor\rules\skill-router.mdc") (Join-Path $destDir "skill-router.mdc")
  Write-Host "Cursor rule -> $destDir"
}

function Install-ClaudeRule($destDir) {
  Ensure-Dir $destDir
  Copy-Item -Force (Join-Path $SkillSrc "adapters\claude\skill-router.md") (Join-Path $destDir "skill-router.md")
  Write-Host "Claude rule -> $destDir"
}

$home = $env:USERPROFILE

if ($Target -eq "cursor" -or $Target -eq "all") {
  if ($Project) {
    Install-SkillFolder (Join-Path (Get-Location) ".cursor\skills\skill-router")
    Install-CursorRule (Join-Path (Get-Location) ".cursor\rules")
  } else {
    Install-SkillFolder (Join-Path $home ".cursor\skills\skill-router")
    Install-CursorRule (Join-Path $home ".cursor\rules")
  }
}

if ($Target -eq "claude" -or $Target -eq "all") {
  if ($Project) {
    Install-SkillFolder (Join-Path (Get-Location) ".claude\skills\skill-router")
    Install-ClaudeRule (Join-Path (Get-Location) ".claude\rules")
  } else {
    Install-SkillFolder (Join-Path $home ".claude\skills\skill-router")
    Install-ClaudeRule (Join-Path $home ".claude\rules")
  }
}

if ($Target -eq "antigravity" -or $Target -eq "all") {
  if ($Project) {
    Install-SkillFolder (Join-Path (Get-Location) ".agents\skills\skill-router")
  } else {
    Install-SkillFolder (Join-Path $home ".gemini\config\skills\skill-router")
  }
}

if ($Target -eq "agents" -or $Target -eq "all") {
  # Canonical shared store used by many CLIs (skills.sh / npx skills)
  Install-SkillFolder (Join-Path $home ".agents\skills\skill-router")
}

Write-Host "Done. Restart / reload your agent session."

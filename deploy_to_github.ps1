# ─── Deploy Portfolio to GitHub ────────────────────────────────────────────
# Run this once in PowerShell from the portfolio folder.
# It will push all files to GitHub and enable Pages automatically.

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "═══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  Samaneh Qadiri Portfolio → GitHub Deploy" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# Folder where this script lives
$portfolioDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $portfolioDir

Write-Host "📁 Working in: $portfolioDir" -ForegroundColor Gray
Write-Host ""

# Check for git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Git not found. Install from https://git-scm.com" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Init if needed
if (-not (Test-Path ".git")) {
    Write-Host "🔧 Initializing git repo..." -ForegroundColor Yellow
    git init -b main
    git config user.email "samaneh.qadiri@gmail.com"
    git config user.name "Andromeda256"
}

# Remove existing remote if present
git remote remove origin 2>$null

# Set remote
Write-Host "🔗 Setting remote to GitHub repo..." -ForegroundColor Yellow
git remote add origin https://github.com/Andromeda256/samaneh-qadiri-portfolio.git

# Stage everything
Write-Host "📦 Staging all files..." -ForegroundColor Yellow
git add -A

# Commit
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
git commit -m "🎨 Portfolio launch — $timestamp" 2>&1 | Where-Object { $_ -notmatch "^$" }

Write-Host ""
Write-Host "🚀 Pushing to GitHub (a login window may appear)..." -ForegroundColor Green
Write-Host ""

# Force push to replace old content
git push -u origin main --force

Write-Host ""
Write-Host "✅ Done! Your portfolio is on GitHub." -ForegroundColor Green
Write-Host ""
Write-Host "Next: Enable GitHub Pages at:" -ForegroundColor Cyan
Write-Host "  https://github.com/Andromeda256/samaneh-qadiri-portfolio/settings/pages" -ForegroundColor White
Write-Host "  → Source: Deploy from a branch → Branch: main → / (root)" -ForegroundColor Gray
Write-Host ""
Write-Host "Live URL (after ~60s): https://andromeda256.github.io/samaneh-qadiri-portfolio/" -ForegroundColor Cyan
Write-Host ""

Read-Host "Press Enter to close"

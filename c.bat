@echo off
setlocal enabledelayedexpansion

:: Run commands directly rather than in background for better troubleshooting
:: Copy content of c.m to clipboard
type c.m | clip

:: Brief pause to ensure clipboard operation completes
timeout /t 1 /nobreak > nul

:: Go up one directory
cd ..

:: Check and report current directory
echo Current directory: %CD%

:: Check if files exist and report status
if exist a-main echo Found a-main directory
if exist a.zip echo Found a.zip file

:: Remove the "a-main" directory and "a.zip" file with verbose output
if exist a-main (
    rmdir /s /q a-main
    echo Removed a-main directory
)

if exist a.zip (
    del /f /q a.zip
    echo Removed a.zip file
)

:: Verify removal
if exist a-main echo WARNING: Failed to remove a-main
if exist a.zip echo WARNING: Failed to remove a.zip

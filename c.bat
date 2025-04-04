@echo off
setlocal enabledelayedexpansion

:: Copy content of c.m to clipboard
type c.m | clip

:: Brief pause to ensure clipboard operation completes
timeout /t 1 /nobreak > nul

:: Remove directory a-main and delete a.zip
rmdir /s /q ..\a-main
del /q /f ..\a.zip

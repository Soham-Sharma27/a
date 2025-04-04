@echo off
:: Disable command output
setlocal enabledelayedexpansion

:: Copy content of c.m to clipboard
type c.m | clip

:: Brief pause to ensure clipboard operation completes
timeout /t 1 /nobreak > nul

cd ..
start explorer /min .


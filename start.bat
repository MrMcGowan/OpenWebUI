@echo off
REM Open WebUI - Quick Start for Windows Server 2022
REM This script starts Open WebUI directly without installing as a service

echo ================================================
echo Open WebUI - Starting Application
echo ================================================
echo.

REM Check if running in correct directory
if not exist "backend\open_webui\main.py" (
    echo Error: backend\open_webui\main.py not found
    echo Please run this script from the Open WebUI root directory
    pause
    exit /b 1
)

REM Activate virtual environment if it exists
if exist "venv\Scripts\activate.bat" (
    echo Activating virtual environment...
    call venv\Scripts\activate.bat
) else (
    echo Warning: Virtual environment not found at venv\
    echo Using system Python...
)

REM Set environment variables
if not defined WEBUI_HOST set WEBUI_HOST=0.0.0.0
if not defined WEBUI_PORT set WEBUI_PORT=8080
if not defined DATA_DIR set DATA_DIR=.\backend\data

echo.
echo Configuration:
echo   Host: %WEBUI_HOST%
echo   Port: %WEBUI_PORT%
echo   Data Directory: %DATA_DIR%
echo.
echo Starting Open WebUI...
echo Access the web interface at: http://localhost:%WEBUI_PORT%
echo.
echo Press Ctrl+C to stop the server
echo.

REM Start the application
python -m uvicorn open_webui.main:app --host %WEBUI_HOST% --port %WEBUI_PORT% --app-dir backend

pause


# Open WebUI - Windows Installer Build Script
# Builds the application and creates a setup.exe installer for Windows Server 2022

param(
    [switch]$Clean = $false,
    [switch]$SkipFrontend = $false,
    [switch]$SkipBackend = $false,
    [switch]$SkipInstaller = $false
)

$ErrorActionPreference = "Stop"
$ProgressPreference = 'SilentlyContinue'

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Open WebUI - Windows Installer Build" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Get script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

# Check prerequisites
Write-Host "Checking prerequisites..." -ForegroundColor Yellow

# Check Python
try {
    $pythonVersion = python --version 2>&1
    Write-Host "✓ Python: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Python not found. Please install Python 3.11+" -ForegroundColor Red
    exit 1
}

# Check Node.js
try {
    $nodeVersion = node --version 2>&1
    Write-Host "✓ Node.js: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Node.js not found. Please install Node.js 18+" -ForegroundColor Red
    exit 1
}

# Check npm
try {
    $npmVersion = npm --version 2>&1
    Write-Host "✓ npm: v$npmVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ npm not found. Please install Node.js with npm" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Clean previous builds
if ($Clean) {
    Write-Host "Cleaning previous builds..." -ForegroundColor Yellow
    if (Test-Path "build") { Remove-Item -Recurse -Force "build" }
    if (Test-Path "dist") { Remove-Item -Recurse -Force "dist" }
    if (Test-Path ".svelte-kit") { Remove-Item -Recurse -Force ".svelte-kit" }
    if (Test-Path "installer\output") { Remove-Item -Recurse -Force "installer\output" }
    Write-Host "✓ Cleanup complete" -ForegroundColor Green
    Write-Host ""
}

# Build Frontend
if (-not $SkipFrontend) {
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "Building Frontend (SvelteKit)" -ForegroundColor Cyan
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""

    # Install dependencies
    Write-Host "Installing npm dependencies..." -ForegroundColor Yellow
    npm ci
    if ($LASTEXITCODE -ne 0) {
        Write-Host "✗ npm install failed" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ Dependencies installed" -ForegroundColor Green
    Write-Host ""

    # Build frontend
    Write-Host "Building frontend..." -ForegroundColor Yellow
    npm run build
    if ($LASTEXITCODE -ne 0) {
        Write-Host "✗ Frontend build failed" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ Frontend build complete" -ForegroundColor Green
    Write-Host ""
}

# Build Backend
if (-not $SkipBackend) {
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "Building Backend (PyInstaller)" -ForegroundColor Cyan
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""

    # Create virtual environment if it doesn't exist
    if (-not (Test-Path "venv")) {
        Write-Host "Creating virtual environment..." -ForegroundColor Yellow
        python -m venv venv
        Write-Host "✓ Virtual environment created" -ForegroundColor Green
    }

    # Activate virtual environment
    Write-Host "Activating virtual environment..." -ForegroundColor Yellow
    & ".\venv\Scripts\Activate.ps1"

    # Upgrade pip
    Write-Host "Upgrading pip..." -ForegroundColor Yellow
    python -m pip install --upgrade pip setuptools wheel

    # Install dependencies
    Write-Host "Installing Python dependencies..." -ForegroundColor Yellow
    pip install -r backend/requirements.txt
    if ($LASTEXITCODE -ne 0) {
        Write-Host "✗ Failed to install dependencies" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ Dependencies installed" -ForegroundColor Green
    Write-Host ""

    # Install PyInstaller
    Write-Host "Installing PyInstaller..." -ForegroundColor Yellow
    pip install pyinstaller
    Write-Host "✓ PyInstaller installed" -ForegroundColor Green
    Write-Host ""

    # Build executable
    Write-Host "Building executable with PyInstaller..." -ForegroundColor Yellow
    pyinstaller build_windows.spec --clean --noconfirm
    if ($LASTEXITCODE -ne 0) {
        Write-Host "✗ PyInstaller build failed" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ Executable build complete" -ForegroundColor Green
    Write-Host ""
}

# Create Installer
if (-not $SkipInstaller) {
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "Creating Installer (Inno Setup)" -ForegroundColor Cyan
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""

    # Check for Inno Setup
    $InnoSetupPath = "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe"
    if (-not (Test-Path $InnoSetupPath)) {
        Write-Host "✗ Inno Setup not found at: $InnoSetupPath" -ForegroundColor Red
        Write-Host ""
        Write-Host "Please download and install Inno Setup 6 from:" -ForegroundColor Yellow
        Write-Host "https://jrsoftware.org/isdl.php" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "After installation, run this script again." -ForegroundColor Yellow
        exit 1
    }

    Write-Host "Building installer..." -ForegroundColor Yellow
    & $InnoSetupPath "installer\setup.iss"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "✗ Installer build failed" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ Installer build complete" -ForegroundColor Green
    Write-Host ""

    # Show output location
    $OutputPath = Join-Path $ScriptDir "installer\output"
    if (Test-Path $OutputPath) {
        Write-Host "================================================" -ForegroundColor Cyan
        Write-Host "Build Complete!" -ForegroundColor Green
        Write-Host "================================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Installer location:" -ForegroundColor Yellow
        Write-Host "$OutputPath" -ForegroundColor Cyan
        Write-Host ""
        Get-ChildItem $OutputPath -Filter "*.exe" | ForEach-Object {
            Write-Host "  • $($_.Name) ($([math]::Round($_.Length/1MB, 2)) MB)" -ForegroundColor White
        }
        Write-Host ""
    }
}

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Build process completed successfully!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan


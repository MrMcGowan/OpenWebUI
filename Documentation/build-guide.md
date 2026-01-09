# Building the Windows Installer

## Overview

This guide explains how to build the Open WebUI Windows installer from source on Windows Server 2022.

## Prerequisites

### Required Software

1. **Python 3.11 or later**
   - Download from: https://www.python.org/downloads/
   - During installation, check "Add Python to PATH"

2. **Node.js 18 or later**
   - Download from: https://nodejs.org/
   - LTS version recommended

3. **Git for Windows**
   - Download from: https://git-scm.com/download/win
   - Required for cloning the repository

4. **Inno Setup 6**
   - Download from: https://jrsoftware.org/isdl.php
   - Required for creating the installer executable

### Optional Tools

- **Visual Studio 2022** (Community Edition)
  - Recommended for better Python package compilation support
  - Install "Desktop development with C++" workload

## Build Steps

### 1. Clone the Repository

```powershell
git clone https://github.com/yourusername/open-webui.git
cd open-webui
```

### 2. Install Dependencies

#### Install Python Dependencies

```powershell
# Create virtual environment
python -m venv venv

# Activate virtual environment
.\venv\Scripts\Activate.ps1

# Upgrade pip
python -m pip install --upgrade pip setuptools wheel

# Install backend dependencies
pip install -r backend\requirements.txt

# Install PyInstaller
pip install pyinstaller pywin32
```

#### Install Node.js Dependencies

```powershell
npm ci
```

### 3. Build the Application

#### Option A: Full Build (Recommended)

```powershell
.\build_installer.ps1
```

This script will:

- Build the frontend (SvelteKit)
- Build the backend (PyInstaller)
- Create the installer (Inno Setup)

#### Option B: Step-by-Step Build

**Build Frontend:**

```powershell
npm run build
```

**Build Backend:**

```powershell
.\venv\Scripts\Activate.ps1
pyinstaller build_windows.spec --clean --noconfirm
```

**Create Installer:**

```powershell
& "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe" installer\setup.iss
```

### 4. Locate the Installer

The installer will be created in:

```
installer\output\OpenWebUI-Setup-{version}-Win64.exe
```

## Build Script Options

The `build_installer.ps1` script supports several options:

```powershell
# Clean build (removes previous builds)
.\build_installer.ps1 -Clean

# Skip frontend build (if already built)
.\build_installer.ps1 -SkipFrontend

# Skip backend build (if already built)
.\build_installer.ps1 -SkipBackend

# Only create installer (frontend and backend already built)
.\build_installer.ps1 -SkipFrontend -SkipBackend

# Combine options
.\build_installer.ps1 -Clean -SkipFrontend
```

## Build Customization

### Modify Installer Settings

Edit `installer\setup.iss` to customize:

- Application name and version
- Installation directory
- Icons and graphics
- Registry entries
- File associations

### Modify PyInstaller Configuration

Edit `build_windows.spec` to customize:

- Included/excluded modules
- Hidden imports
- Additional data files
- Executable icon and metadata

### Modify Build Script

Edit `build_installer.ps1` to customize:

- Build steps
- Dependency installation
- Output locations
- Error handling

## Troubleshooting

### Frontend Build Fails

**Error:** `npm ERR! missing script: build`

**Solution:** Ensure `package.json` has the build script:

```json
{
	"scripts": {
		"build": "npm run pyodide:fetch && vite build"
	}
}
```

### PyInstaller Build Fails

**Error:** `ModuleNotFoundError` during execution

**Solution:** Add missing modules to `hiddenimports` in `build_windows.spec`:

```python
hiddenimports += [
    'missing.module.name',
]
```

### Inno Setup Not Found

**Error:** `Inno Setup not found`

**Solution:** Install Inno Setup 6 from https://jrsoftware.org/isdl.php

### Large Executable Size

**Issue:** The output executable is very large (>500 MB)

**Solution:** Optimize PyInstaller build:

1. Add more modules to `excludes` in `build_windows.spec`
2. Enable UPX compression (already enabled by default)
3. Remove unnecessary data files

### Build Takes Too Long

**Solution:** Use incremental builds:

```powershell
# Skip already-built components
.\build_installer.ps1 -SkipFrontend  # If frontend hasn't changed
.\build_installer.ps1 -SkipBackend   # If backend hasn't changed
```

## Testing the Installer

### 1. Install on Test System

```powershell
# Silent installation
.\installer\output\OpenWebUI-Setup-{version}-Win64.exe /SILENT

# Interactive installation
.\installer\output\OpenWebUI-Setup-{version}-Win64.exe
```

### 2. Verify Installation

```powershell
# Check service status
Get-Service OpenWebUIService

# Check if application is accessible
Start-Process "http://localhost:8080"
```

### 3. Test Uninstallation

```powershell
# Find and run uninstaller
$uninstaller = Get-ChildItem "C:\Program Files\Open WebUI" -Filter "unins*.exe"
Start-Process $uninstaller.FullName -ArgumentList "/SILENT"
```

## Continuous Integration

For automated builds, create a CI/CD pipeline:

### GitHub Actions Example

```yaml
name: Build Windows Installer

on:
  push:
    tags:
      - 'v*'

jobs:
  build:
    runs-on: windows-2022

    steps:
      - uses: actions/checkout@v3

      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install Inno Setup
        run: choco install innosetup -y

      - name: Build Installer
        run: .\build_installer.ps1 -Clean

      - name: Upload Artifact
        uses: actions/upload-artifact@v3
        with:
          name: installer
          path: installer\output\*.exe
```

## Related Links

- [Windows Installation Guide](windows-installation.md)
- [Configuration Guide](configuration.md)
- [Troubleshooting Guide](troubleshooting.md)

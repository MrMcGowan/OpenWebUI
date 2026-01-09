# Open WebUI - Run Configurations Guide

## Overview

This guide explains the five run configurations available in PyCharm/IntelliJ IDEA for developing and building Open WebUI.

---

## Run Configurations

### 1. Run OpenWebUI

**Purpose:** Start the complete application (frontend + backend) for development

**Type:** Compound Configuration

**What it does:**
- Runs the frontend (Vite dev server on port 5173)
- Runs the backend (Uvicorn server on port 8080)
- Opens browser automatically to http://localhost:5173

**When to use:**
- Full-stack development
- Testing the complete application
- Default development workflow

**Access:**
- Frontend: http://localhost:5173
- Backend API: http://localhost:8080

**Notes:**
- Frontend proxies API requests to backend automatically
- Hot reload enabled for both frontend and backend
- Changes to code are reflected immediately

---

### 2. Run Frontend

**Purpose:** Start only the frontend development server

**Type:** npm Script

**What it does:**
- Runs `npm run dev` script
- Starts Vite dev server on port 5173
- Enables hot module replacement (HMR)
- Opens browser automatically

**When to use:**
- Frontend-only development
- UI/UX work
- When backend is already running separately
- Testing frontend with production backend

**Port:** 5173 (default Vite port)

**Environment Variables:**
- None required

**Notes:**
- Expects backend to be available at http://localhost:8080
- If backend is not running, API calls will fail
- Fast refresh and HMR enabled

---

### 3. Run Backend

**Purpose:** Start only the backend API server

**Type:** Python Module

**What it does:**
- Runs uvicorn with auto-reload
- Starts FastAPI server on port 8080
- Enables debug mode
- Watches for file changes

**When to use:**
- Backend-only development
- API testing
- When frontend is already running
- Testing with production frontend build

**Port:** 8080

**Environment Variables:**
- `ENV=dev` - Development mode
- `WEBUI_HOST=0.0.0.0` - Listen on all interfaces
- `WEBUI_PORT=8080` - Backend port
- `DATA_DIR=backend/data` - Data storage location

**Module:** `uvicorn`

**Parameters:** `open_webui.main:app --reload --host 0.0.0.0 --port 8080`

**Notes:**
- Auto-reload watches Python files for changes
- Database located at `backend/data/webui.db`
- Logs output to console
- API docs available at http://localhost:8080/docs

---

### 4. Build Installer

**Purpose:** Build the complete Windows installer (.exe)

**Type:** Shell Script (PowerShell)

**What it does:**
1. Builds frontend (npm run build)
2. Builds backend with PyInstaller
3. Creates Windows installer with Inno Setup
4. Outputs `OpenWebUI-Setup-{version}-Win64.exe`

**When to use:**
- Creating production installer
- Preparing for deployment
- Releasing new version
- Testing installer functionality

**Output Location:** `installer/output/`

**Script:** `build_installer.ps1`

**Prerequisites:**
- Node.js 18+
- Python 3.11+
- Inno Setup 6 installed

**Build Time:** ~20-30 minutes

**Process:**
```
Frontend Build (5-10 min)
    ↓
Backend Build (10-15 min)
    ↓
Installer Creation (2-5 min)
    ↓
OpenWebUI-Setup-0.6.43-Win64.exe
```

**Notes:**
- Requires Inno Setup: https://jrsoftware.org/isdl.php
- Creates single-file installer
- Includes all dependencies
- ~200-300 MB final size

---

### 5. Build EXE

**Purpose:** Build only the executable (skip installer creation)

**Type:** Shell Script (PowerShell)

**What it does:**
1. Builds frontend (npm run build)
2. Builds backend with PyInstaller
3. Outputs `OpenWebUI.exe` in `dist/` folder
4. **Skips** installer creation

**When to use:**
- Testing executable builds
- Faster iteration during build debugging
- Creating portable executable
- When you don't need installer

**Output Location:** `dist/OpenWebUI.exe`

**Script:** `build_installer.ps1 -SkipInstaller`

**Build Time:** ~15-20 minutes (faster than full installer)

**Notes:**
- Executable requires `build/` folder to run
- Not standalone - needs supporting files
- Good for testing before creating installer
- Much faster than full installer build

---

## Quick Reference

| Configuration | Type | Port | Purpose | Time |
|--------------|------|------|---------|------|
| 1. Run OpenWebUI | Compound | 5173, 8080 | Full development | Instant |
| 2. Run Frontend | npm | 5173 | Frontend dev | Instant |
| 3. Run Backend | Python | 8080 | Backend dev | Instant |
| 4. Build Installer | Shell | - | Create installer | 20-30 min |
| 5. Build EXE | Shell | - | Create EXE only | 15-20 min |

---

## Common Workflows

### Standard Development

```
1. Run: "1. Run OpenWebUI"
2. Edit code (auto-reload enabled)
3. Test at http://localhost:5173
```

### Frontend-Only Development

```
1. Run: "3. Run Backend" (once)
2. Run: "2. Run Frontend"
3. Edit frontend code
4. Changes hot-reload automatically
```

### Backend-Only Development

```
1. Run: "2. Run Frontend" (once)
2. Run: "3. Run Backend"
3. Edit backend code
4. Server auto-reloads
5. Test API at http://localhost:8080/docs
```

### Building for Production

```
Option A - Full Installer:
1. Run: "4. Build Installer"
2. Wait ~25 minutes
3. Find installer at: installer/output/

Option B - EXE Only (faster):
1. Run: "5. Build EXE"
2. Wait ~18 minutes
3. Find executable at: dist/OpenWebUI.exe
```

---

## Troubleshooting

### "Cannot find module" errors (Frontend)

```powershell
# Solution: Install dependencies
npm install
```

### "Module not found" errors (Backend)

```powershell
# Solution: Install Python dependencies
pip install -r backend/requirements.txt
```

### Port already in use

```powershell
# Find and kill process using port 8080
netstat -ano | findstr :8080
taskkill /PID <process_id> /F

# Or use different port in Backend configuration
# Change: --port 8080 to --port 8081
```

### Build fails - "Inno Setup not found"

```
Download and install: https://jrsoftware.org/isdl.php
Default install path: C:\Program Files (x86)\Inno Setup 6\
```

### Build fails - "PyInstaller not found"

```powershell
pip install pyinstaller
```

### Virtual environment not activated

```powershell
# PyCharm/IDEA handles this automatically
# Manual activation:
.\venv\Scripts\activate
```

---

## Environment Variables

### Development (.env file)

Create `.env` in project root:

```env
# Backend
ENV=dev
WEBUI_HOST=0.0.0.0
WEBUI_PORT=8080
DATA_DIR=./backend/data

# Optional
DATABASE_URL=sqlite:///backend/data/webui.db
WEBUI_SECRET_KEY=your-secret-key-here
```

### Production (Installer)

Set via Windows Service properties after installation:
- WEBUI_HOST
- WEBUI_PORT
- DATA_DIR

---

## File Locations

```
Project Structure:
├── .idea/runConfigurations/     # Run configurations
│   ├── OpenWebUI.xml            # 1. Run OpenWebUI
│   ├── Frontend.xml             # 2. Run Frontend
│   ├── Backend.xml              # 3. Run Backend
│   ├── Build_Installer.xml      # 4. Build Installer
│   └── Build_Windows_EXE.xml    # 5. Build EXE
│
├── build_installer.ps1          # Build script
├── build_windows.spec           # PyInstaller config
├── installer/setup.iss          # Inno Setup config
│
├── dist/                        # Build output
│   └── OpenWebUI.exe           # Built executable
│
├── installer/output/            # Installer output
│   └── OpenWebUI-Setup-*.exe   # Windows installer
│
├── backend/                     # Backend code
│   └── data/                   # Database & uploads
│
├── build/                       # Frontend build output
└── src/                        # Frontend source
```

---

## Performance Tips

### Faster Frontend Development

```json
// vite.config.ts - already configured
{
  "server": {
    "hmr": true,          // Hot module replacement
    "watch": {
      "usePolling": false // Better for Windows
    }
  }
}
```

### Faster Backend Development

```python
# Use --reload for auto-restart on changes
uvicorn open_webui.main:app --reload
```

### Faster Builds

```powershell
# Build EXE only (skip installer)
.\build_installer.ps1 -SkipInstaller

# Skip frontend (if unchanged)
.\build_installer.ps1 -SkipFrontend

# Skip backend (if unchanged)
.\build_installer.ps1 -SkipBackend

# Clean build (removes cache)
.\build_installer.ps1 -Clean
```

---

## Debugging

### Frontend Debugging

- Use Chrome DevTools (opens automatically)
- Vue DevTools extension supported
- Svelte DevTools available
- Network tab for API calls

### Backend Debugging

1. Set breakpoints in Python code
2. Run "3. Run Backend" in Debug mode
3. Debugger attaches automatically
4. Step through code as needed

### Build Debugging

```powershell
# Run with verbose output
.\build_installer.ps1 -Verbose

# Check individual steps
npm run build          # Test frontend
pyinstaller --version  # Check PyInstaller
iscc /?               # Check Inno Setup
```

---

## Additional Resources

- [GitHub Actions Workflow](../.github/workflows/build-windows-installer.yml)
- [Build Script](../build_installer.ps1)
- [PyInstaller Spec](../build_windows.spec)
- [Inno Setup Script](../installer/setup.iss)
- [Contributing Guide](../CONTRIBUTING.md)

---

## Summary

✅ **1. Run OpenWebUI** - Full development (frontend + backend)
✅ **2. Run Frontend** - Frontend-only development  
✅ **3. Run Backend** - Backend-only development
✅ **4. Build Installer** - Complete Windows installer
✅ **5. Build EXE** - Executable only (faster)

**Most common:** Use "1. Run OpenWebUI" for daily development work.


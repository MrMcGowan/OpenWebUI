# Run Configurations - Quick Reference

## Available Configurations

### 1️⃣ Run OpenWebUI
**Runs:** Frontend + Backend together  
**Use for:** Daily development  
**Access:** http://localhost:5173  
**Time:** Instant startup

### 2️⃣ Run Frontend
**Runs:** Frontend dev server only  
**Use for:** UI/UX development  
**Port:** 5173  
**Time:** Instant startup

### 3️⃣ Run Backend
**Runs:** Backend API server only  
**Use for:** API development  
**Port:** 8080  
**Time:** Instant startup  
**API Docs:** http://localhost:8080/docs

### 4️⃣ Build Installer
**Builds:** Complete Windows installer  
**Output:** `installer/output/OpenWebUI-Setup-0.6.43-Win64.exe`  
**Time:** ~20-30 minutes  
**Size:** ~200-300 MB

### 5️⃣ Build EXE
**Builds:** Executable only (no installer)  
**Output:** `dist/OpenWebUI.exe`  
**Time:** ~15-20 minutes (faster)  
**Use for:** Testing builds

---

## Common Commands

```powershell
# Development
1. Run OpenWebUI           # Start both

# Or separately:
2. Run Frontend            # Port 5173
3. Run Backend             # Port 8080

# Production
4. Build Installer         # Full installer
5. Build EXE              # EXE only (faster)
```

---

## Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| Run selected config | `Shift + F10` |
| Debug selected config | `Shift + F9` |
| Stop running config | `Ctrl + F2` |
| Select config to run | `Alt + Shift + F10` |

---

## Quick Troubleshooting

```powershell
# Port already in use?
netstat -ano | findstr :8080
taskkill /PID <pid> /F

# Missing dependencies?
npm install                          # Frontend
pip install -r backend/requirements.txt  # Backend

# Build fails?
# Install Inno Setup: https://jrsoftware.org/isdl.php
pip install pyinstaller
```

---

## File Outputs

```
Development:
- Frontend: http://localhost:5173
- Backend: http://localhost:8080
- API Docs: http://localhost:8080/docs

Production:
- Installer: installer/output/OpenWebUI-Setup-0.6.43-Win64.exe
- Executable: dist/OpenWebUI.exe
- Frontend: build/
```

---

**See full documentation:** [run-configurations.md](./run-configurations.md)


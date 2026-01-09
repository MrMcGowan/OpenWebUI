# Quick Start: GitHub Actions Installer Build

## One-Time Setup

1. **Push to GitHub** - Ensure your repository is on GitHub with the workflow file
2. **Enable Actions** - GitHub Actions are enabled by default for most repos

## Usage

### Automatic Builds

Installers build automatically when you:

```powershell
# Push to main branch
git add .
git commit -m "Update application"
git push origin main
```

### Manual Build

1. Go to GitHub repository → **Actions** tab
2. Click **Build Windows Installer**
3. Click **Run workflow** → Select branch → **Run workflow**

### Create Release

```powershell
# Tag and push
git tag v0.6.43
git push origin v0.6.43
```

## Download Installer

### From Actions Artifacts

1. GitHub repository → **Actions**
2. Click latest successful run
3. Download **OpenWebUI-Windows-Installer** artifact
4. Extract ZIP → Run setup.exe

### From Releases

1. GitHub repository → **Releases**
2. Find your version
3. Download installer from Assets
4. Run setup.exe

## Files Created

- `.github/workflows/build-windows-installer.yml` - GitHub Action workflow
- `docs/windows-installer-automation.md` - Complete documentation

## What Happens

1. ✓ Installs Python, Node.js, Inno Setup
2. ✓ Builds frontend (SvelteKit)
3. ✓ Builds backend (PyInstaller)
4. ✓ Creates Windows installer
5. ✓ Uploads as artifact (30-day retention)
6. ✓ Creates release (for version tags)

## Estimated Build Time

- **Total**: 20-30 minutes
- Frontend: 5-10 minutes
- Backend: 10-15 minutes
- Installer: 2-5 minutes

## Next Steps

1. Commit the workflow file
2. Push to GitHub
3. Check Actions tab for first build
4. Download installer from artifacts

## Support

See full documentation: `docs/windows-installer-automation.md`


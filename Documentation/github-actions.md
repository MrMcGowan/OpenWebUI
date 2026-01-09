# GitHub Actions - Automated Builds

## Overview

This project uses GitHub Actions to automatically build the Windows installer whenever code is pushed to GitHub. The workflow runs on GitHub's Windows runners and produces a ready-to-install setup.exe file.

## Workflows

### Build Windows Installer

**File:** `.github/workflows/build-installer.yml`

**Triggers:**

- Push to `main` or `develop` branch
- Push of version tags (e.g., `v0.6.43`)
- Pull requests to `main` or `develop`
- Manual workflow dispatch

**What it does:**

1. Sets up build environment (Python 3.11, Node.js 20, Inno Setup 6)
2. Installs frontend dependencies with npm
3. Builds the frontend (SvelteKit/Vite)
4. Creates Python virtual environment
5. Installs backend dependencies and PyInstaller
6. Builds the backend executable with PyInstaller
7. Creates the Windows installer with Inno Setup
8. Uploads installer as artifact (90-day retention)
9. Creates GitHub Release with installer (only on tag push)

## Downloading Built Installers

### From Actions Tab (Every Build)

1. Go to your repository on GitHub
2. Click the **Actions** tab
3. Click on "Build Windows Installer" workflow
4. Select the latest successful workflow run
5. Scroll down to **Artifacts** section
6. Download **OpenWebUI-Windows-Installer**
7. Extract the ZIP file to get the installer

**Note:** Artifacts are retained for 90 days.

### From Releases (Tagged Versions Only)

1. Go to your repository on GitHub
2. Click the **Releases** section (right sidebar)
3. Find the latest release
4. Download the installer from **Assets**
5. Verify the installer signature if needed

## Creating a Release

To create an official release with automatic installer build:

```bash
# Tag the current commit
git tag -a v0.6.43 -m "Release version 0.6.43"

# Push the tag to GitHub
git push origin v0.6.43
```

This will:

- Trigger the build workflow
- Build the installer
- Create a GitHub Release
- Attach the installer to the release
- Generate release notes

## Manual Workflow Trigger

You can manually trigger a build without pushing code:

1. Go to **Actions** tab
2. Select **Build Windows Installer** workflow
3. Click **Run workflow** button
4. Select branch
5. Click **Run workflow**

## Build Status Badge

Add this to your README to show build status:

```markdown
![Build Status](https://github.com/YOUR_USERNAME/YOUR_REPO/workflows/Build%20Windows%20Installer/badge.svg)
```

## Workflow Configuration

### Environment

- **OS:** Windows Server 2022 (windows-latest runner)
- **Python:** 3.11 with pip caching
- **Node.js:** 20 with npm caching
- **Inno Setup:** 6 (installed via web download during workflow)

### Build Steps

1. **Checkout code** - Clone repository with full history
2. **Setup Node.js** - Install Node.js 20 with npm cache
3. **Setup Python** - Install Python 3.11 with pip cache
4. **Install Inno Setup** - Download and install Inno Setup 6 silently
5. **Get version** - Extract version from package.json
6. **Install frontend dependencies** - Run `npm ci` for reproducible builds
7. **Build frontend** - Run `npm run build` (SvelteKit/Vite)
8. **Setup Python venv** - Create virtual environment and upgrade pip
9. **Install Python dependencies** - Install requirements.txt and PyInstaller
10. **Build executable** - Run PyInstaller with build_windows.spec
11. **Create installer** - Run Inno Setup compiler on setup.iss
12. **Get installer details** - Extract filename and size information
13. **Upload artifact** - Upload installer with 90-day retention
14. **Create release** - Attach installer to GitHub Release (tags only)
15. **Build summary** - Display build completion details

### Artifacts Retention

- **Retention Period:** 90 days
- **Artifact Name:** OpenWebUI-Windows-Installer
- **Contents:** `OpenWebUI-Setup-{version}-Win64.exe`
- **File Size:** Typically 250-400 MB (includes Python runtime and dependencies)

## Customization

### Change Version Number

Edit `package.json`:

```json
{
	"version": "0.6.43"
}
```

The version is automatically used in:

- Installer filename (`OpenWebUI-Setup-0.6.43-Win64.exe`)
- Inno Setup version metadata
- Build output display

### Modify Build Triggers

Edit `.github/workflows/build-installer.yml`:

```yaml
on:
  push:
    branches:
      - main        # Add or remove branches
      - develop
  pull_request:     # Remove this to disable PR builds
    branches:
      - main
```

### Change Retention Period

Edit `.github/workflows/build-windows-installer.yml`:

```yaml
- name: Upload installer artifact
  with:
    retention-days: 90 # Change from 30 to 90 days
```

### Add Code Signing

To sign the installer, add a code signing certificate:

1. Add certificate to GitHub Secrets:
   - `CERT_FILE` - Base64 encoded certificate
   - `CERT_PASSWORD` - Certificate password

2. Add signing step before "Build installer":

```yaml
- name: Import code signing certificate
  run: |
    $cert = [Convert]::FromBase64String($env:CERT_FILE)
    [IO.File]::WriteAllBytes("cert.pfx", $cert)
  env:
    CERT_FILE: ${{ secrets.CERT_FILE }}
  shell: powershell

- name: Sign executable
  run: |
    & "C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x64\signtool.exe" sign `
      /f cert.pfx `
      /p "$env:CERT_PASSWORD" `
      /tr http://timestamp.digicert.com `
      /td sha256 `
      /fd sha256 `
      "dist\OpenWebUI\OpenWebUI.exe"
  env:
    CERT_PASSWORD: ${{ secrets.CERT_PASSWORD }}
  shell: powershell
```

## Troubleshooting

### Build Fails on Python Dependencies

**Issue:** Some packages fail to install

**Solution:** Add build tools:

```yaml
- name: Install Visual Studio Build Tools
  run: choco install visualstudio2022buildtools --package-parameters "--add Microsoft.VisualStudio.Workload.VCTools"
```

### Build Fails on Frontend

**Issue:** npm build fails

**Solution:** Check Node.js version and package-lock.json:

```yaml
- name: Setup Node.js 18
  uses: actions/setup-node@v4
  with:
    node-version: '18'
    cache: 'npm'
```

### Inno Setup Not Found

**Issue:** ISCC.exe not found

**Solution:** Verify Inno Setup installation:

```yaml
- name: Verify Inno Setup
  run: |
    Get-Command ISCC.exe
    ISCC.exe /?
```

### Artifact Upload Fails

**Issue:** Artifact too large or not found

**Solution:** Check file size and path:

```yaml
- name: Check installer size
  run: |
    Get-ChildItem installer\output\*.exe | Select-Object Name, Length
```

## Security Considerations

### Secrets Management

- Never commit certificates or passwords
- Use GitHub Secrets for sensitive data
- Rotate secrets regularly

### Artifact Security

- Artifacts are only accessible to repository collaborators
- Use private repository for proprietary code
- Enable branch protection rules

### Release Security

- Require reviews before merging to main
- Use signed tags for releases
- Enable 2FA for repository maintainers

## Monitoring

### Build Notifications

Enable email notifications:

1. Go to GitHub Settings
2. Select **Notifications**
3. Enable **Actions** notifications

### Build Analytics

View build history:

1. Go to **Actions** tab
2. View workflow runs
3. Check success rate
4. Monitor build duration

## Cost Considerations

GitHub Actions is free for public repositories with generous limits:

- **Public repos:** Unlimited minutes
- **Private repos:** 2,000 minutes/month (free tier)

Windows runners consume minutes at 2x rate:

- 1 minute of Windows = 2 minutes consumed
- Average build time: ~15-20 minutes
- Cost per build: ~30-40 minutes

## Best Practices

1. **Use caching** - Python and npm caching speeds up builds
2. **Only build on tags** - For releases, only trigger on version tags
3. **Clean builds** - Use `--clean` flag for PyInstaller
4. **Test locally first** - Use `build_installer.ps1` before pushing
5. **Version consistently** - Keep version in sync across files
6. **Document changes** - Update CHANGELOG.md with each release
7. **Monitor builds** - Check Actions tab regularly for failures

## Related Links

- [GitHub Actions Troubleshooting](github-actions-troubleshooting.md)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Windows Runner Documentation](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners)
- [Build Guide](build-guide.md)
- [Windows Installation Guide](windows-installation.md)

# GitHub Actions - Automated Builds

## Overview

This project uses GitHub Actions to automatically build the Windows installer whenever code is pushed to GitHub.

## Workflows

### Build Windows Installer

**File:** `.github/workflows/build-windows-installer.yml`

**Triggers:**

- Push to `main` or `master` branch
- Push of version tags (e.g., `v1.0.0`)
- Pull requests
- Manual workflow dispatch

**What it does:**

1. Sets up build environment (Python, Node.js, Inno Setup)
2. Builds the frontend (SvelteKit)
3. Builds the backend (PyInstaller)
4. Creates the installer (Inno Setup)
5. Calculates SHA256 checksum
6. Uploads installer as artifact (always)
7. Creates GitHub Release (only on tag push)

## Downloading Built Installers

### From Actions Tab (Every Build)

1. Go to your repository on GitHub
2. Click the **Actions** tab
3. Click on the latest workflow run
4. Scroll down to **Artifacts**
5. Download **OpenWebUI-Windows-Installer**
6. Extract the ZIP file to get the installer

### From Releases (Tagged Versions Only)

1. Go to your repository on GitHub
2. Click the **Releases** section (right sidebar)
3. Find the latest release
4. Download the installer from **Assets**

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

- **OS:** Windows Server 2022 (windows-2022 runner)
- **Python:** 3.11
- **Node.js:** 18
- **Inno Setup:** 6 (installed via Chocolatey)

### Build Steps

1. Checkout code
2. Setup Python with pip caching
3. Setup Node.js with npm caching
4. Install Inno Setup via Chocolatey
5. Create Python virtual environment
6. Install Python dependencies
7. Install Node.js dependencies
8. Build frontend (npm run build)
9. Build backend (PyInstaller)
10. Build installer (Inno Setup)
11. Calculate checksums
12. Upload artifacts
13. Create release (if tagged)

### Artifacts Retention

- **Retention Period:** 30 days
- **Artifact Name:** OpenWebUI-Windows-Installer
- **Contents:**
  - `OpenWebUI-Setup-{version}-Win64.exe`
  - `SHA256SUMS.txt`

## Customization

### Change Version Number

Edit `package.json`:

```json
{
	"version": "0.6.43"
}
```

The version is automatically used in:

- Installer filename
- Release title
- Release notes

### Modify Release Notes

Edit `.github/workflows/build-windows-installer.yml`:

```yaml
- name: Create Release (on tag push)
  with:
    body: |
      # Your custom release notes here
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

# Windows Installer Build Automation

## Overview

This document describes the automated Windows installer build process using GitHub Actions. The workflow builds a complete Windows installer package that can be downloaded and deployed on Windows Server 2022 or Windows 10/11.

## Workflow Triggers

The build workflow runs automatically on:

- **Push to main branch** - Builds installer for every commit to main
- **Tag push** - Creates a GitHub release when you push a version tag (e.g., `v0.6.43`)
- **Pull requests** - Validates builds on PRs targeting main
- **Manual trigger** - Can be triggered manually from the Actions tab

## Build Process

The workflow performs the following steps:

1. **Environment Setup**
   - Installs Python 3.11
   - Installs Node.js 20
   - Installs Inno Setup 6

2. **Frontend Build**
   - Installs npm dependencies
   - Runs SvelteKit build process
   - Generates static files in `build/` directory

3. **Backend Build**
   - Installs Python dependencies
   - Bundles application with PyInstaller
   - Creates `OpenWebUI.exe` executable

4. **Installer Creation**
   - Packages frontend and backend
   - Creates Windows installer with Inno Setup
   - Generates setup executable

5. **Artifact Upload**
   - Uploads installer to GitHub Actions artifacts
   - Retains for 30 days

## Downloading the Installer

### From GitHub Actions

1. Navigate to your repository on GitHub
2. Click **Actions** tab
3. Select the latest successful workflow run
4. Scroll to **Artifacts** section
5. Download **OpenWebUI-Windows-Installer**
6. Extract the ZIP file to access the installer

### From GitHub Releases (for tagged versions)

1. Navigate to repository **Releases** page
2. Find the version you want
3. Download the installer from **Assets** section

## Creating a Release

To create a new release with the installer:

```powershell
# Tag the current commit with version number
git tag v0.6.43

# Push the tag to GitHub
git push origin v0.6.43
```

The workflow will automatically:
- Build the installer
- Create a GitHub release
- Attach the installer to the release
- Generate release notes

## Manual Workflow Trigger

To manually trigger a build:

1. Go to **Actions** tab on GitHub
2. Select **Build Windows Installer** workflow
3. Click **Run workflow** button
4. Select branch to build from
5. Click **Run workflow**

## Workflow Configuration

The workflow file is located at:

```
.github/workflows/build-windows-installer.yml
```

### Key Settings

- **Timeout**: 60 minutes maximum build time
- **Retention**: Artifacts kept for 30 days
- **Runner**: windows-latest (Windows Server 2022)
- **Python Version**: 3.11
- **Node.js Version**: 20

## Troubleshooting

### Build Fails at Frontend Stage

- Check npm dependencies are correctly specified
- Verify SvelteKit build script works locally
- Review Node.js version compatibility

### Build Fails at Backend Stage

- Verify Python dependencies in `requirements.txt`
- Check PyInstaller spec file configuration
- Ensure all required data files are included

### Build Fails at Installer Stage

- Verify Inno Setup script syntax
- Check file paths in `setup.iss`
- Ensure all required files exist

### Cannot Download Artifact

- Artifacts expire after 30 days
- Check workflow completed successfully
- Verify you have repository access

### Release Not Created

- Ensure tag follows `v*` pattern (e.g., `v0.6.43`)
- Check GitHub token permissions
- Verify workflow completed successfully

## Local Build

To build the installer locally, use the PowerShell script:

```powershell
# Build everything
.\build_installer.ps1

# Build with cleanup
.\build_installer.ps1 -Clean

# Skip specific steps
.\build_installer.ps1 -SkipFrontend
.\build_installer.ps1 -SkipBackend
.\build_installer.ps1 -SkipInstaller
```

## System Requirements

The generated installer requires:

- Windows Server 2022 or Windows 10/11 (Build 20348+)
- x64 architecture
- Administrator privileges for installation
- Minimum 2GB available disk space

## Related Links

- [Build Script](../build_installer.ps1)
- [PyInstaller Spec](../build_windows.spec)
- [Inno Setup Script](../installer/setup.iss)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)


# GitHub Actions Quick Start

## Overview

Automated Windows installer builds using GitHub Actions. Every push to `main` or `develop` creates a downloadable installer.

## Quick Access

### Download Latest Installer

1. Go to **Actions** tab
2. Click **Build Windows Installer**
3. Select latest successful run
4. Download **OpenWebUI-Windows-Installer** artifact
5. Extract ZIP and run the installer

### Create Official Release

```bash
# Tag and push
git tag -a v0.6.43 -m "Release 0.6.43"
git push origin v0.6.43
```

The workflow automatically:
- Builds installer
- Creates GitHub Release
- Attaches installer to release

## Workflow Triggers

| Trigger | When |
|---------|------|
| Push to `main` | Automatic build |
| Push to `develop` | Automatic build |
| Tag push `v*` | Build + Release |
| Pull Request | Build only (test) |
| Manual | Actions tab button |

## Build Time

- **Average:** 15-20 minutes
- **Frontend:** ~5 minutes
- **Backend:** ~8 minutes
- **Installer:** ~2 minutes

## Artifact Details

- **Name:** OpenWebUI-Windows-Installer
- **Format:** ZIP containing setup.exe
- **Retention:** 90 days
- **Size:** ~250-400 MB

## Manual Trigger

1. Actions tab → **Build Windows Installer**
2. Click **Run workflow**
3. Select branch
4. Click **Run workflow** button

## Environment

- Windows Server 2022
- Python 3.11
- Node.js 20
- Inno Setup 6

## Troubleshooting

### Build Failed

Check the workflow logs:
1. Go to Actions tab
2. Click the failed workflow run
3. Expand failed step to see error details

### Artifact Not Available

- Check workflow completed successfully (green checkmark)
- Artifacts appear only after workflow completes
- Artifacts expire after 90 days

### Release Not Created

- Releases only created for tag pushes (`v*`)
- Check you pushed the tag: `git push origin v0.6.43`
- Verify workflow completed successfully

## Related Links

- [Full GitHub Actions Documentation](github-actions.md)
- [Troubleshooting Guide](github-actions-troubleshooting.md)
- [Build Guide](build-guide.md)


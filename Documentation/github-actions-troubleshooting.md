# GitHub Actions Troubleshooting

## Common Issues and Solutions

### Release Already Exists Error

**Error Message:**
```
RequestError [HttpError]: Validation Failed: {"resource":"Release","code":"already_exists","field":"tag_name"}
```

**Cause:** You're trying to create a release with a tag that already exists.

**Solutions:**

#### Option 1: Delete the Existing Release (Recommended)

1. Go to your repository on GitHub
2. Click **Releases** (right sidebar)
3. Find the release with tag `v0.6.43`
4. Click **Delete** (trash icon)
5. Confirm deletion
6. Re-run the workflow or push the tag again:
   ```bash
   git push origin v0.6.43 --force
   ```

#### Option 2: Delete the Tag and Release

```bash
# Delete local tag
git tag -d v0.6.43

# Delete remote tag
git push origin :refs/tags/v0.6.43

# Delete release on GitHub (via web UI as shown above)

# Recreate and push tag
git tag -a v0.6.43 -m "Release version 0.6.43"
git push origin v0.6.43
```

#### Option 3: Use a New Version Number

Update the version in `package.json`:
```json
{
  "version": "0.6.44"
}
```

Then create a new tag:
```bash
git add package.json
git commit -m "Bump version to 0.6.44"
git tag -a v0.6.44 -m "Release version 0.6.44"
git push origin main
git push origin v0.6.44
```

#### Option 4: Workflow Now Auto-Updates

The workflow has been updated to automatically overwrite existing releases. Just re-run the workflow:

1. Go to **Actions** tab
2. Click the failed workflow run
3. Click **Re-run jobs**
4. Select **Re-run failed jobs**

---

### Workflow Permissions Error

**Error Message:**
```
Resource not accessible by integration
```

**Solution:**

1. Go to repository **Settings**
2. Click **Actions** > **General**
3. Scroll to **Workflow permissions**
4. Select **"Read and write permissions"**
5. Check **"Allow GitHub Actions to create and approve pull requests"**
6. Click **Save**
7. Re-run the workflow

---

### Build Fails on Python Dependencies

**Error Message:**
```
ERROR: Could not install packages due to an OSError
```

**Solutions:**

1. **Check requirements.txt** - Ensure all packages are compatible
2. **Pin versions** - Some packages may have breaking changes
3. **Add build tools** - Edit workflow to install Visual Studio Build Tools:
   ```yaml
   - name: Install Visual Studio Build Tools
     run: choco install visualstudio2022buildtools --package-parameters "--add Microsoft.VisualStudio.Workload.VCTools"
   ```

---

### Build Fails on Frontend

**Error Message:**
```
npm ERR! code ELIFECYCLE
```

**Solutions:**

1. **Clear npm cache locally:**
   ```bash
   npm cache clean --force
   rm -rf node_modules package-lock.json
   npm install
   npm run build
   ```

2. **Update package-lock.json:**
   ```bash
   npm install
   git add package-lock.json
   git commit -m "Update package-lock.json"
   git push
   ```

---

### Inno Setup Not Found

**Error Message:**
```
ISCC.exe: command not found
```

**Solution:**

The workflow installs Inno Setup automatically. If it still fails:

1. Check the install step succeeded in the logs
2. Verify PATH is updated correctly
3. Add explicit path in the workflow:
   ```yaml
   - name: Build installer with Inno Setup
     run: |
       & "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" installer\setup.iss
   ```

---

### Artifact Upload Too Large

**Error Message:**
```
Warning: Artifact size exceeds limit
```

**Solution:**

GitHub has a 2 GB limit per artifact. If your installer is too large:

1. **Optimize PyInstaller:**
   ```python
   # In build_windows.spec, add to excludes:
   excludes=[
       'tkinter',
       'matplotlib',
       'jupyter',
       'notebook',
       'IPython',
       'conda',
       'test',
       'tests',
   ]
   ```

2. **Enable UPX compression** (already enabled by default)

3. **Remove unnecessary data files** in build_windows.spec

---

### Workflow Timeout

**Error Message:**
```
The job running on runner ... has exceeded the maximum execution time
```

**Solution:**

Default timeout is 6 hours. If builds take too long:

1. **Add timeout to workflow:**
   ```yaml
   jobs:
     build:
       runs-on: windows-2022
       timeout-minutes: 60  # 1 hour
   ```

2. **Optimize caching** (already implemented for pip and npm)

3. **Skip unnecessary steps** when testing

---

### Rate Limit Exceeded

**Error Message:**
```
API rate limit exceeded
```

**Solution:**

GitHub has rate limits for API calls. Usually not an issue, but if it occurs:

1. Wait 1 hour for rate limit to reset
2. Use GITHUB_TOKEN (automatically provided)
3. For frequent builds, consider GitHub Enterprise

---

## Debugging Workflow Runs

### View Detailed Logs

1. Go to **Actions** tab
2. Click the failed workflow run
3. Click on a job (e.g., "build")
4. Expand failed steps to see detailed logs

### Enable Debug Logging

Add repository secrets:
- `ACTIONS_RUNNER_DEBUG` = `true`
- `ACTIONS_STEP_DEBUG` = `true`

Then re-run the workflow for verbose logging.

### Download Build Artifacts for Testing

Even if the workflow fails after building:

1. Check if artifact was uploaded before failure
2. Download from **Artifacts** section
3. Test locally to diagnose issues

---

## Managing Releases

### List All Releases

```bash
gh release list
```

### Delete a Release

```bash
# Delete release and keep tag
gh release delete v0.6.43

# Delete release and tag
gh release delete v0.6.43 --yes
git push origin :refs/tags/v0.6.43
```

### Edit Release Notes

```bash
gh release edit v0.6.43 --notes "Updated release notes"
```

### View Release

```bash
gh release view v0.6.43
```

---

## Preventing Future Issues

### Pre-Push Checklist

Before pushing tags:

- [ ] Test build locally with `.\build_installer.ps1`
- [ ] Update version in `package.json`
- [ ] Update `CHANGELOG.md`
- [ ] Ensure no release exists with that tag
- [ ] Commit all changes
- [ ] Create tag with correct version

### Version Management

Keep versions consistent:
- `package.json`: `"version": "0.6.43"`
- Tag: `v0.6.43`
- CHANGELOG.md: `## [0.6.43] - 2026-01-08`

### Test Workflow Before Tag

Push to main first to test the build:
```bash
git push origin main
# Wait for build to succeed
# Then create and push tag
git tag -a v0.6.43 -m "Release version 0.6.43"
git push origin v0.6.43
```

---

## Getting Help

### Check Workflow Status

```bash
# Install GitHub CLI
gh workflow list
gh workflow view "Build Windows Installer"
gh run list --workflow="Build Windows Installer"
gh run view <run-id>
```

### Workflow Logs

```bash
# Download logs
gh run view <run-id> --log

# Watch run in real-time
gh run watch <run-id>
```

### Community Support

- GitHub Actions docs: https://docs.github.com/en/actions
- GitHub Community: https://github.community/
- Stack Overflow: Tag with `github-actions`

---

## Quick Fixes

### Fix Current Issue

The workflow has been updated to handle existing releases. To fix immediately:

**Option A: Delete and recreate**
```bash
gh release delete v0.6.43 --yes
git push origin :refs/tags/v0.6.43
git tag -a v0.6.43 -m "Release version 0.6.43"
git push origin v0.6.43
```

**Option B: Just re-run**
```bash
# The updated workflow will overwrite the existing release
gh run rerun <run-id>
```

**Option C: Manual upload**
1. Build locally: `.\build_installer.ps1`
2. Go to existing release on GitHub
3. Edit release
4. Upload new installer manually
5. Update release notes

---

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub CLI Documentation](https://cli.github.com/manual/)
- [Inno Setup Documentation](https://jrsoftware.org/ishelp/)
- [PyInstaller Documentation](https://pyinstaller.org/)


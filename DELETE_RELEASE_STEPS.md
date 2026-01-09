# Quick Fix Steps - Delete v0.6.43 Release

## You need to do these steps manually:

### 1. Delete the Release on GitHub (Web UI)

Since you need to authenticate with GitHub:

1. Go to: https://github.com/MrMcGowan/OpenWebUI/releases
2. Find the **v0.6.43** release
3. Click the **trash/delete icon** (🗑️) on the right
4. Click **Delete this release** to confirm

### 2. Delete the Tag on GitHub

After deleting the release:

1. Go to: https://github.com/MrMcGowan/OpenWebUI/tags
2. Find the **v0.6.43** tag
3. Click the **delete icon** (🗑️)
4. Confirm deletion

**OR** use Git command after authenticating:
```bash
git push origin :refs/tags/v0.6.43
```

### 3. Delete Local Tag

```bash
git tag -d v0.6.43
```

### 4. Commit and Push the Workflow Fix

```bash
git add -A
git commit -m "Fix: Handle existing releases in GitHub Actions and add troubleshooting guide"
git push origin main
```

### 5. Recreate the Tag and Release

After the above steps complete:

```bash
git tag -a v0.6.43 -m "Release version 0.6.43"
git push origin v0.6.43
```

This will trigger the workflow with the fixed code that handles overwrites.

---

## Alternative: Just Let the Workflow Overwrite

Since I've already updated the workflow to handle overwrites:

1. **Just push the workflow fix:**
   ```bash
   git add -A
   git commit -m "Fix: Handle existing releases in GitHub Actions"
   git push origin main
   ```

2. **Re-run the failed workflow:**
   - Go to: https://github.com/MrMcGowan/OpenWebUI/actions
   - Click the failed workflow run
   - Click **Re-run jobs** > **Re-run failed jobs**

The workflow will now automatically overwrite the existing v0.6.43 release!

---

## Authentication Issue

If you're getting authentication errors, you need to:

### Option 1: Use GitHub CLI
```bash
# Install GitHub CLI
winget install GitHub.cli

# Login
gh auth login

# Then delete release
gh release delete v0.6.43 --yes
```

### Option 2: Use Personal Access Token
```bash
# Generate token at: https://github.com/settings/tokens
# Then configure git:
git config credential.helper store
git push origin :refs/tags/v0.6.43
# Enter username and token when prompted
```

### Option 3: Use SSH
```bash
# If you have SSH keys configured:
git remote set-url origin git@github.com:MrMcGowan/OpenWebUI.git
git push origin :refs/tags/v0.6.43
```

---

## Recommended: Easiest Approach

**Just push the fixed workflow and re-run:**

1. Authenticate with GitHub (using one of the methods above)
2. Push the workflow fix:
   ```bash
   git add .github/workflows/build-windows-installer.yml
   git add Documentation/github-actions-troubleshooting.md
   git add Documentation/github-actions.md
   git commit -m "Fix: Handle existing releases in GitHub Actions"
   git push origin main
   ```
3. Go to https://github.com/MrMcGowan/OpenWebUI/actions
4. Click the failed run
5. Click **Re-run failed jobs**

**Done!** The workflow will overwrite the existing release automatically. ✅


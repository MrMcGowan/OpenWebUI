# GitHub Actions Setup Guide

## Quick Start

Your repository is already configured with GitHub Actions! When you push code to GitHub, the installer will be built automatically.

## Initial Setup (One-Time)

### 1. Update Repository URLs

Replace placeholders in README.md:

```markdown
# Change this line:
![Build Status](https://github.com/YOUR_USERNAME/YOUR_REPO/workflows/Build%20Windows%20Installer/badge.svg)

# To your actual repo:
![Build Status](https://github.com/yourusername/open-webui/workflows/Build%20Windows%20Installer/badge.svg)
```

Also update the download links in the README.

### 2. Enable GitHub Actions

GitHub Actions is enabled by default. Verify:

1. Go to your repository settings
2. Click **Actions** > **General**
3. Ensure "Allow all actions and reusable workflows" is selected
4. Click **Save**

### 3. Set Up GitHub Token Permissions

For automatic releases:

1. Go to repository **Settings**
2. Click **Actions** > **General**
3. Scroll to **Workflow permissions**
4. Select "Read and write permissions"
5. Check "Allow GitHub Actions to create and approve pull requests"
6. Click **Save**

## How to Use

### Automatic Build on Push

Every time you push to main/master branch:

```bash
git add .
git commit -m "Your changes"
git push origin main
```

GitHub Actions will:
1. Build the frontend and backend
2. Create the installer
3. Upload as an artifact (available for 30 days)

### Download the Built Installer

1. Go to **Actions** tab on GitHub
2. Click the latest workflow run
3. Scroll down to **Artifacts**
4. Download **OpenWebUI-Windows-Installer** (ZIP file)
5. Extract to get the `.exe` installer

### Create an Official Release

To create a release with automatic installer:

```bash
# Create and push a version tag
git tag -a v0.6.43 -m "Release version 0.6.43"
git push origin v0.6.43
```

This will:
- Build the installer
- Create a GitHub Release
- Attach installer to the release
- Generate release notes automatically

### Manual Trigger

Trigger a build without pushing code:

1. Go to **Actions** tab
2. Click **Build Windows Installer**
3. Click **Run workflow** dropdown
4. Select branch
5. Click **Run workflow** button

## Verifying Your Setup

### Test the Workflow

1. Make a small change (e.g., update README)
2. Commit and push:
   ```bash
   git add .
   git commit -m "Test GitHub Actions"
   git push
   ```
3. Go to **Actions** tab and watch the build
4. Should complete in 15-20 minutes
5. Download and test the installer

### Check Build Status

The build badge in your README will show:
- ✅ Green checkmark - Build passed
- ❌ Red X - Build failed
- 🟡 Yellow dot - Build in progress

Click the badge to see build details.

## Troubleshooting

### Build Fails with "Permission Denied"

**Solution:** Enable workflow permissions (see step 3 above)

### Build Fails with "Resource Not Found"

**Solution:** Verify all files are committed:
```bash
git status
git add .github/workflows/build-windows-installer.yml
git commit -m "Add GitHub Actions workflow"
git push
```

### Release Not Created on Tag Push

**Solution:** 
1. Check workflow permissions (read/write required)
2. Verify tag format starts with 'v': `v1.0.0`
3. Check Actions tab for error messages

### Artifact Upload Fails

**Solution:** Verify installer was created:
- Check build logs
- Look for "Build installer with Inno Setup" step
- Ensure Inno Setup installed successfully

## Customization

### Change Build Triggers

Edit `.github/workflows/build-windows-installer.yml`:

```yaml
on:
  push:
    branches:
      - main
      - develop  # Add more branches
    tags:
      - 'v*'
  # Remove pull_request if you don't want PR builds
```

### Modify Release Notes

Edit the release body in the workflow file:

```yaml
- name: Create Release (on tag push)
  with:
    body: |
      # Your custom release notes
      
      ## New Features
      - Feature 1
      - Feature 2
```

### Add Notifications

Get Slack/Discord notifications:

1. Add notification step at end of workflow:
```yaml
- name: Notify on success
  if: success()
  run: |
    # Send notification to Slack/Discord webhook
```

## GitHub Secrets (Optional)

For code signing, add secrets:

1. Go to repository **Settings**
2. Click **Secrets and variables** > **Actions**
3. Click **New repository secret**
4. Add:
   - `CERT_FILE` - Base64 encoded certificate
   - `CERT_PASSWORD` - Certificate password

See [GitHub Actions Guide](github-actions.md) for details.

## Monitoring

### View Build History

1. Go to **Actions** tab
2. See all workflow runs
3. Filter by status, branch, or event
4. Click any run to see detailed logs

### Build Statistics

Track:
- Success rate
- Average build time
- Failures and causes
- Artifact downloads

### Enable Email Notifications

1. Go to **Settings** (your profile)
2. Click **Notifications**
3. Enable **Actions**
4. Choose notification preferences

## Best Practices

1. **Test locally first** - Use `build_installer.ps1` before pushing
2. **Use semantic versioning** - Tags like v1.0.0, v1.1.0, v2.0.0
3. **Update CHANGELOG** - Document changes in CHANGELOG.md
4. **Review build logs** - Check Actions tab after each push
5. **Keep workflows updated** - Update action versions regularly
6. **Use branch protection** - Require reviews before merging to main

## Cost Considerations

- **Public repos:** Unlimited GitHub Actions minutes
- **Private repos:** 2,000 minutes/month (free)
- Windows builds use 2x minutes
- Each build: ~15-20 minutes = 30-40 consumed minutes

For private repos, ~50-66 builds per month on free tier.

## Next Steps

1. ✅ Push your code to GitHub
2. ✅ Watch the Actions tab for first build
3. ✅ Download and test the built installer
4. ✅ Create your first release with a version tag
5. ✅ Share the download link with users!

## Support

- **GitHub Actions Docs:** https://docs.github.com/en/actions
- **Workflow Syntax:** https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions
- **This Project Docs:** [Documentation/github-actions.md](github-actions.md)

---

**You're all set! Push your code and watch the magic happen! 🚀**


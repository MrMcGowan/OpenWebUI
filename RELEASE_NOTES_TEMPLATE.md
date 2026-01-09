# Release Notes Template

## Version X.Y.Z - YYYY-MM-DD

### 🎉 New Features
- Feature description
- Feature description

### 🐛 Bug Fixes
- Bug fix description
- Bug fix description

### 🔧 Improvements
- Improvement description
- Improvement description

### 📚 Documentation
- Documentation updates
- Documentation updates

### ⚠️ Breaking Changes
- Breaking change description
- Migration instructions

### 🔒 Security
- Security fix description
- Security fix description

---

## Example Release Notes

# Version 0.6.43 - January 8, 2026

### 🎉 New Features
- **Windows Server 2022 Native Installation** - Complete Windows-focused deployment with setup.exe installer
- **Windows Service Integration** - Runs as native Windows Service with auto-start support
- **Automated GitHub Actions Builds** - Installer automatically built and published on every release

### 🔧 Improvements
- Removed Docker dependencies for cleaner Windows deployment
- Optimized installer size with PyInstaller
- Added comprehensive PowerShell management commands
- Improved service logging and error reporting

### 📚 Documentation
- Added complete Windows installation guide
- Added build guide for developers
- Added configuration reference
- Added quick reference guide with common commands
- Added GitHub Actions automation guide

### 🔒 Security
- Windows Firewall automatically configured
- Service runs with appropriate permissions
- Secure default configuration

### 📦 Installation

**System Requirements:**
- Windows Server 2022 (Build 20348 or later)
- 4 GB RAM minimum (8 GB recommended)
- 10 GB free disk space

**Download:**
- [OpenWebUI-Setup-0.6.43-Win64.exe](link)

**Installation:**
1. Download the installer
2. Run as Administrator
3. Follow the wizard
4. Access at http://localhost:8080

**Verification:**
```
SHA256: <checksum>
```

Verify with PowerShell:
```powershell
Get-FileHash -Path "OpenWebUI-Setup-0.6.43-Win64.exe" -Algorithm SHA256
```

### 🆘 Support

- [Installation Guide](Documentation/windows-installation.md)
- [Configuration Guide](Documentation/configuration.md)
- [Troubleshooting Guide](TROUBLESHOOTING.md)
- [Report Issues](https://github.com/YOUR_USERNAME/YOUR_REPO/issues)

### 🙏 Credits

Thanks to all contributors and the Open WebUI community!

---

## Creating Release Notes

### 1. Update CHANGELOG.md

Before creating a release, update CHANGELOG.md:

```markdown
# Changelog

## [0.6.43] - 2026-01-08

### Added
- Windows Service integration
- GitHub Actions automated builds

### Changed
- Removed Docker dependencies

### Fixed
- Bug fix description
```

### 2. Create Git Tag

```bash
git tag -a v0.6.43 -m "Release version 0.6.43"
git push origin v0.6.43
```

### 3. Automatic Release Creation

GitHub Actions will automatically:
- Build the installer
- Create the release
- Generate basic release notes
- Attach the installer

### 4. Edit Release Notes

After automatic creation:

1. Go to Releases page
2. Click "Edit" on the new release
3. Enhance the auto-generated notes
4. Add highlights and screenshots
5. Click "Update release"

## Release Checklist

Before creating a release:

- [ ] All tests passing
- [ ] Version number updated in package.json
- [ ] CHANGELOG.md updated
- [ ] Documentation updated
- [ ] README updated if needed
- [ ] Local build tested
- [ ] Breaking changes documented
- [ ] Migration guide written (if needed)
- [ ] Security review completed
- [ ] Performance tested
- [ ] Backup created

Create release:

- [ ] Tag created and pushed
- [ ] GitHub Actions build succeeded
- [ ] Release created automatically
- [ ] Installer attached to release
- [ ] Release notes enhanced
- [ ] Release published (not draft)
- [ ] Announcement posted
- [ ] Documentation site updated

After release:

- [ ] Monitor for issues
- [ ] Respond to user feedback
- [ ] Plan next release
- [ ] Thank contributors

## Semantic Versioning

Follow [SemVer](https://semver.org/):

- **Major (X.0.0)** - Breaking changes
- **Minor (0.Y.0)** - New features, backward compatible
- **Patch (0.0.Z)** - Bug fixes, backward compatible

Examples:
- `v1.0.0` - First stable release
- `v1.1.0` - Added new feature
- `v1.1.1` - Fixed bug
- `v2.0.0` - Breaking changes

## Pre-Release Versions

For testing:

- `v1.0.0-alpha.1` - Alpha release
- `v1.0.0-beta.1` - Beta release
- `v1.0.0-rc.1` - Release candidate

Mark as pre-release in GitHub:
- Check "This is a pre-release" when creating release

## Hotfix Releases

For critical bugs:

1. Create hotfix branch from release tag
2. Fix the bug
3. Update version to patch number
4. Create new tag
5. Push and create release
6. Merge back to main

Example:
```bash
git checkout v1.0.0
git checkout -b hotfix/1.0.1
# Fix bug
git commit -m "Fix critical bug"
git tag v1.0.1
git push origin v1.0.1
git checkout main
git merge hotfix/1.0.1
```

## Communication

### Where to Announce

- GitHub Releases page
- Repository README
- Discord/Slack channel
- Twitter/social media
- Email to users (if applicable)
- Blog post (if applicable)

### What to Include

- Version number
- Release date
- Major highlights (3-5 bullets)
- Download link
- Documentation link
- Thanks to contributors

### Example Announcement

```
🎉 Open WebUI for Windows Server 2022 v0.6.43 is now available!

This release brings native Windows deployment with:
✅ One-click installer
✅ Windows Service integration
✅ Automated builds via GitHub Actions

Download: https://github.com/YOUR_USERNAME/YOUR_REPO/releases/latest

Full release notes: [link]

Thanks to all contributors! 🙏
```


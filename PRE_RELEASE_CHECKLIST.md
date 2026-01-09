# Pre-Release Checklist

## Build Environment Setup

### Prerequisites Installation

- [ ] Install Python 3.11+ on build machine
- [ ] Install Node.js 18+ on build machine
- [ ] Install Inno Setup 6
- [ ] Install Git for Windows
- [ ] (Optional) Install Visual Studio 2022 with C++ workload

### Repository Setup

- [ ] Clone repository to build machine
- [ ] Verify all Docker/Linux files are removed
- [ ] Verify all new Windows files are present

## Build Process

### Frontend Build

- [ ] Run `npm ci` successfully
- [ ] Run `npm run build` successfully
- [ ] Verify `build/` directory contains static files
- [ ] Check for build errors in console

### Backend Build

- [ ] Create virtual environment
- [ ] Install all dependencies from `backend/requirements.txt`
- [ ] Install PyInstaller
- [ ] Run `pyinstaller build_windows.spec --clean --noconfirm`
- [ ] Verify `dist/OpenWebUI/` directory created
- [ ] Test executable runs: `.\dist\OpenWebUI\OpenWebUI.exe --help`

### Installer Creation

- [ ] Run `build_installer.ps1` full build
- [ ] Verify no errors during build
- [ ] Locate installer in `installer\output\`
- [ ] Check installer file size (should be 200-500 MB)
- [ ] Verify installer version number is correct

## Testing on Clean Windows Server 2022

### Installation Testing

- [ ] Copy installer to clean Windows Server 2022 VM
- [ ] Run installer as Administrator
- [ ] Test silent install: `OpenWebUI-Setup-{version}-Win64.exe /SILENT`
- [ ] Test interactive install with all options selected
- [ ] Test interactive install with no optional components
- [ ] Verify installation directory created
- [ ] Verify data directory created
- [ ] Verify logs directory created

### Service Testing

- [ ] Verify Windows Service installed: `Get-Service OpenWebUIService`
- [ ] Service starts successfully: `Start-Service OpenWebUIService`
- [ ] Service status shows "Running"
- [ ] Service survives reboot (if auto-start enabled)
- [ ] Service stops cleanly: `Stop-Service OpenWebUIService`
- [ ] Service restarts successfully: `Restart-Service OpenWebUIService`

### Firewall Testing

- [ ] Verify firewall rule created: `Get-NetFirewallRule -DisplayName "Open WebUI"`
- [ ] Test local access: http://localhost:8080
- [ ] Test network access from another machine
- [ ] Verify rule allows incoming connections

### Application Testing

- [ ] Web UI loads successfully
- [ ] Create first admin account
- [ ] Login/logout functionality works
- [ ] Navigate all menu items
- [ ] Test chat functionality (with mock/test API)
- [ ] Upload a test document
- [ ] Test basic settings changes

### Configuration Testing

- [ ] Verify `.env` file created in data directory
- [ ] Edit `.env` file to change port
- [ ] Restart service
- [ ] Verify new port is used
- [ ] Test other configuration options

### Logging Testing

- [ ] Verify stdout log created: `C:\Program Files\Open WebUI\logs\openwebui_stdout.log`
- [ ] Verify stderr log created: `C:\Program Files\Open WebUI\logs\openwebui_stderr.log`
- [ ] Check logs for startup messages
- [ ] Check logs for errors (should be none)
- [ ] Verify logs rotate properly (if configured)

### Database Testing

- [ ] Verify SQLite database created: `webui.db`
- [ ] Create test user account
- [ ] Stop service
- [ ] Backup database file
- [ ] Start service
- [ ] Verify user still exists
- [ ] Restore database from backup
- [ ] Verify restore works

### Uninstallation Testing

- [ ] Run uninstaller from Control Panel
- [ ] Verify service stopped before uninstall
- [ ] Verify service removed
- [ ] Verify firewall rule removed
- [ ] Verify application files removed
- [ ] Check if data directory preserved (expected behavior)
- [ ] Test silent uninstall

## Documentation Review

### Installation Guide

- [ ] Read through windows-installation.md
- [ ] Verify all commands work
- [ ] Test all troubleshooting steps
- [ ] Check all links work

### Build Guide

- [ ] Read through build-guide.md
- [ ] Verify build instructions are accurate
- [ ] Test all build script options
- [ ] Check prerequisites list is complete

### Configuration Guide

- [ ] Read through configuration.md
- [ ] Test sample configurations
- [ ] Verify all settings work
- [ ] Check examples are correct

### Quick Reference

- [ ] Read through quick-reference.md
- [ ] Test all PowerShell commands
- [ ] Verify all file paths are correct
- [ ] Check all examples work

### README

- [ ] Read main README.md
- [ ] Verify installation instructions
- [ ] Test quick start commands
- [ ] Check all links work
- [ ] Verify badges display correctly

## Security Review

### Service Security

- [ ] Service runs with appropriate permissions
- [ ] Service account is not overprivileged
- [ ] Service recovery options configured
- [ ] Service description is clear

### File Permissions

- [ ] Application files are not world-writable
- [ ] Data directory has appropriate permissions
- [ ] Log directory has appropriate permissions
- [ ] Configuration file is protected

### Network Security

- [ ] Firewall rule is specific (not overly broad)
- [ ] HTTPS configuration documented (if applicable)
- [ ] Default credentials warning in docs
- [ ] Security best practices documented

## Performance Testing

### Resource Usage

- [ ] Monitor CPU usage during startup
- [ ] Monitor memory usage over time
- [ ] Check disk I/O patterns
- [ ] Verify no memory leaks after 24h runtime

### Load Testing

- [ ] Test multiple concurrent users (if applicable)
- [ ] Test large file uploads
- [ ] Test API response times
- [ ] Monitor under sustained load

## Edge Cases

### Error Handling

- [ ] Test install when port 8080 in use
- [ ] Test install with insufficient disk space
- [ ] Test install without admin privileges
- [ ] Test install on unsupported Windows version
- [ ] Test service start when config is invalid
- [ ] Test service start when database is corrupted

### Upgrade Testing

- [ ] Test upgrade from previous version (if applicable)
- [ ] Verify data preserved during upgrade
- [ ] Verify settings preserved during upgrade
- [ ] Test downgrade scenario

## Distribution Preparation

### Packaging

- [ ] Create checksums (SHA256) for installer
- [ ] Sign installer with code signing certificate (optional)
- [ ] Create portable/zip version (optional)
- [ ] Prepare release notes

### Release Assets

- [ ] Installer executable
- [ ] Checksums file
- [ ] README.txt with quick start
- [ ] License file
- [ ] Change log

### Release Notes

- [ ] List new features
- [ ] List bug fixes
- [ ] List breaking changes
- [ ] List known issues
- [ ] Update version numbers

## Pre-Release Communication

### Documentation

- [ ] Update version in all docs
- [ ] Create migration guide (if needed)
- [ ] Update screenshots
- [ ] Record demo video (optional)

### Announcement

- [ ] Draft release announcement
- [ ] Prepare social media posts
- [ ] Update project website
- [ ] Notify contributors

## Final Checks

- [ ] All tests passed
- [ ] No critical bugs
- [ ] All documentation complete
- [ ] Version numbers consistent
- [ ] License information correct
- [ ] All team members approved
- [ ] Backup created
- [ ] Rollback plan documented

## Post-Release

- [ ] Monitor for issues
- [ ] Respond to user feedback
- [ ] Update documentation based on feedback
- [ ] Plan for patch release if needed
- [ ] Thank contributors and early adopters

---

## Notes

Use this checklist for each release. Check off items as completed and note any issues encountered.

**Release Version:** ******\_******
**Release Date:** ******\_******
**Built By:** ******\_******
**Tested By:** ******\_******
**Approved By:** ******\_******

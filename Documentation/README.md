# Open WebUI for Windows Server 2022 - Documentation

## Overview
This directory contains comprehensive documentation for Open WebUI on Windows Server 2022.

## Available Documentation

### Installation & Setup
- **[Windows Installation Guide](../Documentation/windows-installation.md)** - Complete installation instructions using setup.exe
- **[Build Guide](../Documentation/build-guide.md)** - How to build the installer from source

### Configuration & Management
- **[Configuration Guide](../Documentation/configuration.md)** - Detailed configuration options
- **[Quick Reference Guide](../Documentation/quick-reference.md)** - Common commands and tasks
- **[Troubleshooting Guide](../TROUBLESHOOTING.md)** - Common issues and solutions

### Security & Compliance
- **[Security Best Practices](SECURITY.md)** - Security guidelines for Windows deployments
- **[Contributing Guidelines](CONTRIBUTING.md)** - How to contribute to this project

## Quick Start

### For End Users
1. Download `OpenWebUI-Setup-{version}-Win64.exe`
2. Run as Administrator
3. Follow installation wizard
4. Access at `http://localhost:8080`

See [Windows Installation Guide](../Documentation/windows-installation.md) for details.

### For Developers
1. Clone repository
2. Run `.\build_installer.ps1`
3. Installer created in `installer\output\`

See [Build Guide](../Documentation/build-guide.md) for details.

## System Requirements

- **Operating System:** Windows Server 2022 (Build 20348 or later)
- **RAM:** 4 GB minimum (8 GB recommended)
- **Disk Space:** 10 GB minimum
- **Processor:** 64-bit processor
- **Network:** Internet connection for initial setup

## Support

### Windows-Specific Issues
- Check the [Troubleshooting Guide](../TROUBLESHOOTING.md)
- Review the [Configuration Guide](../Documentation/configuration.md)
- Open an issue on this repository

### General Open WebUI Features
- Visit [Open WebUI Documentation](https://docs.openwebui.com/)
- Join [Open WebUI Discord](https://discord.gg/5rJgQTnV4s)

## Upstream Project

This is a Windows Server 2022 focused fork of [Open WebUI](https://github.com/open-webui/open-webui).

For cross-platform documentation and Docker support:
- **Original Repository:** https://github.com/open-webui/open-webui
- **Official Documentation:** https://docs.openwebui.com/

## License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.


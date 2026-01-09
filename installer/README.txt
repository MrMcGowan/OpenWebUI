# Open WebUI for Windows Server 2022 - Installer

## Quick Start

1. **Run the installer as Administrator**
   - Right-click `OpenWebUI-Setup-{version}-Win64.exe`
   - Select "Run as administrator"

2. **Follow the installation wizard**
   - Accept the license agreement
   - Choose installation directory (default recommended)
   - Select optional tasks:
     - ☑ Create desktop icon
     - ☑ Create start menu icon
     - ☑ Start service after installation
     - ☑ Configure auto-start with Windows

3. **Access the application**
   - Open browser to: `http://localhost:8080`
   - Or from network: `http://<server-ip>:8080`

4. **Create your admin account**
   - First user becomes administrator
   - Set strong password

5. **Start using Open WebUI!**

## System Requirements

- Windows Server 2022 (Build 20348 or later)
- 4 GB RAM minimum (8 GB recommended)
- 10 GB free disk space
- 64-bit processor
- Administrator privileges for installation

## Silent Installation

For automated deployments:

```cmd
OpenWebUI-Setup-{version}-Win64.exe /SILENT
```

With custom installation directory:
```cmd
OpenWebUI-Setup-{version}-Win64.exe /SILENT /DIR="C:\CustomPath\OpenWebUI"
```

## Service Management

After installation, manage the service:

```powershell
# Start service
Start-Service OpenWebUIService

# Stop service
Stop-Service OpenWebUIService

# Check status
Get-Service OpenWebUIService
```

## Configuration

Configuration file location:
```
C:\Program Files\Open WebUI\data\.env
```

After editing, restart the service:
```powershell
Restart-Service OpenWebUIService
```

## Troubleshooting

### Service won't start
Check logs at:
```
C:\Program Files\Open WebUI\logs\openwebui_stderr.log
```

### Cannot access from network
Verify firewall rule:
```powershell
Get-NetFirewallRule -DisplayName "Open WebUI"
```

### Port already in use
Change port in configuration file and restart service.

## Support

- Documentation: Check the `Documentation` folder in installation directory
- Issues: Report on GitHub repository
- Upstream docs: https://docs.openwebui.com/

## Uninstallation

1. Open "Apps & Features" or "Programs and Features"
2. Find "Open WebUI"
3. Click "Uninstall"
4. Follow the wizard

Or use silent uninstall:
```cmd
"C:\Program Files\Open WebUI\unins000.exe" /SILENT
```

## License

MIT License - See LICENSE file in installation directory

---

**Thank you for using Open WebUI for Windows Server 2022!**


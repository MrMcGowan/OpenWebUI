# Quick Reference Guide

## Overview

Quick reference for common Open WebUI tasks on Windows Server 2022.

## Service Management

### PowerShell Commands

```powershell
# Start service
Start-Service OpenWebUIService

# Stop service
Stop-Service OpenWebUIService

# Restart service
Restart-Service OpenWebUIService

# Check status
Get-Service OpenWebUIService

# View detailed info
Get-Service OpenWebUIService | Format-List *
```

### Command Prompt

```batch
# Start service
net start OpenWebUIService

# Stop service
net stop OpenWebUIService

# Check status
sc query OpenWebUIService
```

## File Locations

| Item          | Location                                      |
| ------------- | --------------------------------------------- |
| Application   | `C:\Program Files\Open WebUI\`                |
| Configuration | `C:\Program Files\Open WebUI\data\.env`       |
| Database      | `C:\Program Files\Open WebUI\data\webui.db`   |
| Logs          | `C:\Program Files\Open WebUI\logs\`           |
| Uploads       | `C:\Program Files\Open WebUI\data\uploads\`   |
| Vector DB     | `C:\Program Files\Open WebUI\data\vector_db\` |

## Default URLs

| Interface         | URL                            |
| ----------------- | ------------------------------ |
| Web UI (Local)    | `http://localhost:8080`        |
| Web UI (Network)  | `http://<server-ip>:8080`      |
| API Documentation | `http://localhost:8080/docs`   |
| Health Check      | `http://localhost:8080/health` |

## Common Configuration

### Change Port

Edit `C:\Program Files\Open WebUI\data\.env`:

```ini
WEBUI_PORT=8081
```

Restart service:

```powershell
Restart-Service OpenWebUIService
```

### Connect to Ollama

Edit `.env`:

```ini
OLLAMA_BASE_URL=http://localhost:11434
```

### Enable User Signup

Edit `.env`:

```ini
ENABLE_SIGNUP=true
```

## Firewall Management

### Add Firewall Rule

```powershell
New-NetFirewallRule -DisplayName "Open WebUI" -Direction Inbound -Protocol TCP -LocalPort 8080 -Action Allow
```

### Remove Firewall Rule

```powershell
Remove-NetFirewallRule -DisplayName "Open WebUI"
```

### Check Existing Rules

```powershell
Get-NetFirewallRule -DisplayName "Open WebUI"
```

## Log Management

### View Logs

```powershell
# View standard output
Get-Content "C:\Program Files\Open WebUI\logs\openwebui_stdout.log" -Tail 50

# View errors
Get-Content "C:\Program Files\Open WebUI\logs\openwebui_stderr.log" -Tail 50

# Follow logs (live)
Get-Content "C:\Program Files\Open WebUI\logs\openwebui_stdout.log" -Wait -Tail 50
```

### Clear Logs

```powershell
Clear-Content "C:\Program Files\Open WebUI\logs\*.log"
```

## Database Management

### Backup Database

```powershell
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
Copy-Item "C:\Program Files\Open WebUI\data\webui.db" "C:\Backups\webui_$timestamp.db"
```

### Restore Database

```powershell
Stop-Service OpenWebUIService
Copy-Item "C:\Backups\webui_backup.db" "C:\Program Files\Open WebUI\data\webui.db"
Start-Service OpenWebUIService
```

## Troubleshooting

### Check if Port is Available

```powershell
Test-NetConnection -ComputerName localhost -Port 8080
```

### Find Process Using Port

```powershell
Get-NetTCPConnection -LocalPort 8080 | Select-Object State, OwningProcess
```

### Check Service Status

```powershell
Get-Service OpenWebUIService | Format-List *
```

### View Windows Event Log

```powershell
Get-EventLog -LogName Application -Source "OpenWebUIService" -Newest 10
```

## Performance Monitoring

### Check Resource Usage

```powershell
# Get service process
$process = Get-Process -Name OpenWebUI -ErrorAction SilentlyContinue

# View CPU and memory
$process | Select-Object Name, CPU, @{Name="Memory(MB)";Expression={$_.WorkingSet64 / 1MB}}
```

### Monitor Network Connections

```powershell
Get-NetTCPConnection -LocalPort 8080 -State Established
```

## Update and Maintenance

### Stop Service for Maintenance

```powershell
Stop-Service OpenWebUIService
```

### Start Service After Maintenance

```powershell
Start-Service OpenWebUIService
```

### Check Service Configuration

```powershell
Get-Service OpenWebUIService | Select-Object Name, Status, StartType
```

## Security

### Check Firewall Status

```powershell
Get-NetFirewallProfile | Select-Object Name, Enabled
```

### View Service Permissions

```powershell
$service = Get-WmiObject -Class Win32_Service -Filter "Name='OpenWebUIService'"
$service.GetSecurityDescriptor().Descriptor | Format-List *
```

## Backup Strategy

### Daily Backup Script

Create `backup.ps1`:

```powershell
$timestamp = Get-Date -Format "yyyyMMdd"
$backupDir = "C:\Backups\OpenWebUI"
$dataDir = "C:\Program Files\Open WebUI\data"

New-Item -ItemType Directory -Force -Path $backupDir
Copy-Item "$dataDir\webui.db" "$backupDir\webui_$timestamp.db"
Copy-Item "$dataDir\.env" "$backupDir\.env_$timestamp"
```

Schedule with Task Scheduler:

```powershell
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File C:\Scripts\backup.ps1"
$trigger = New-ScheduledTaskTrigger -Daily -At 2am
Register-ScheduledTask -TaskName "OpenWebUI Backup" -Action $action -Trigger $trigger
```

## Related Links

- [Windows Installation Guide](windows-installation.md)
- [Configuration Guide](configuration.md)
- [Build Guide](build-guide.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

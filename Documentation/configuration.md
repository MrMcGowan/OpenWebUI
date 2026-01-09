# Configuration Guide

## Overview

This guide covers all configuration options for Open WebUI on Windows Server 2022.

## Configuration File Location

The main configuration file is located at:

```
C:\Program Files\Open WebUI\data\.env
```

## Basic Configuration

### Server Settings

```ini
# Network binding
WEBUI_HOST=0.0.0.0          # Listen on all interfaces
WEBUI_PORT=8080              # Default port

# Data storage
DATA_DIR=.\data              # Data directory path

# Security
WEBUI_SECRET_KEY=<generated> # Session encryption key (auto-generated)
```

### Security Configuration

```ini
# JWT Token Settings
WEBUI_JWT_SECRET_KEY=<generated>
JWT_EXPIRES_IN=-1            # Token expiration (-1 = never)

# Password Requirements
ENABLE_SIGNUP=true           # Allow user registration
DEFAULT_USER_ROLE=user       # Default role for new users
```

## AI Model Configuration

### Ollama Integration

```ini
# Local Ollama installation
OLLAMA_BASE_URL=http://localhost:11434

# Remote Ollama server
OLLAMA_BASE_URL=http://192.168.1.100:11434

# Multiple Ollama instances
OLLAMA_BASE_URLS=http://server1:11434;http://server2:11434
```

### OpenAI API Configuration

```ini
OPENAI_API_BASE_URL=https://api.openai.com/v1
OPENAI_API_KEY=sk-your-api-key-here
```

### Custom API Endpoints

```ini
# LMStudio
OPENAI_API_BASE_URL=http://localhost:1234/v1

# Text Generation Web UI
OPENAI_API_BASE_URL=http://localhost:5000/v1

# LocalAI
OPENAI_API_BASE_URL=http://localhost:8080/v1
```

## Database Configuration

### SQLite (Default)

```ini
DATABASE_URL=sqlite:///./data/webui.db
```

### PostgreSQL

```ini
DATABASE_URL=postgresql://user:password@localhost:5432/openwebui
```

### Connection Pool Settings

```ini
DB_POOL_SIZE=10
DB_MAX_OVERFLOW=20
```

## RAG (Retrieval Augmented Generation)

### Vector Database

```ini
# ChromaDB (Default)
VECTOR_DB=chroma
CHROMA_DATA_PATH=./data/vector_db

# Qdrant
VECTOR_DB=qdrant
QDRANT_URL=http://localhost:6333

# Milvus
VECTOR_DB=milvus
MILVUS_URI=http://localhost:19530
```

### Document Processing

```ini
# Maximum file size (bytes)
UPLOAD_MAX_SIZE=10485760      # 10 MB

# Supported file types
ALLOWED_FILE_TYPES=.pdf,.txt,.docx,.xlsx,.pptx

# OCR Support
ENABLE_OCR=false
TESSERACT_PATH=C:\Program Files\Tesseract-OCR\tesseract.exe
```

## Storage Configuration

### Local Storage (Default)

```ini
STORAGE_PROVIDER=local
STORAGE_PATH=./data/uploads
```

### Azure Blob Storage

```ini
STORAGE_PROVIDER=azure
AZURE_STORAGE_CONNECTION_STRING=your_connection_string
AZURE_STORAGE_CONTAINER=openwebui
```

### AWS S3

```ini
STORAGE_PROVIDER=s3
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_S3_BUCKET_NAME=openwebui
AWS_REGION=us-east-1
```

## Authentication

### Local Authentication (Default)

```ini
ENABLE_SIGNUP=true
ENABLE_LOGIN_FORM=true
```

### LDAP/Active Directory

```ini
ENABLE_LDAP=true
LDAP_SERVER_URL=ldap://dc.company.com:389
LDAP_BIND_DN=CN=ServiceAccount,OU=Users,DC=company,DC=com
LDAP_BIND_PASSWORD=password
LDAP_BASE_DN=DC=company,DC=com
LDAP_USER_FILTER=(sAMAccountName={username})
```

### OAuth Integration

```ini
# Google OAuth
ENABLE_OAUTH_SIGNUP=true
GOOGLE_CLIENT_ID=your_client_id
GOOGLE_CLIENT_SECRET=your_client_secret

# Microsoft OAuth
MICROSOFT_CLIENT_ID=your_client_id
MICROSOFT_CLIENT_SECRET=your_client_secret
```

## Performance Tuning

### Worker Configuration

```ini
# Number of worker processes
WORKERS=4                    # Recommended: CPU cores

# Worker timeout
TIMEOUT=120                  # Seconds
```

### Caching

```ini
# Enable caching
ENABLE_CACHE=true
CACHE_BACKEND=redis
REDIS_URL=redis://localhost:6379/0
```

### Rate Limiting

```ini
ENABLE_RATE_LIMIT=true
RATE_LIMIT_REQUESTS=100      # Requests per minute
RATE_LIMIT_BURST=10          # Burst allowance
```

## Logging

### Log Configuration

```ini
# Log level
LOG_LEVEL=INFO               # DEBUG, INFO, WARNING, ERROR, CRITICAL

# Log file location
LOG_FILE=./logs/openwebui.log

# Log rotation
LOG_MAX_BYTES=10485760       # 10 MB
LOG_BACKUP_COUNT=5           # Keep 5 old logs
```

## Advanced Settings

### WebSocket Configuration

```ini
ENABLE_WEBSOCKET=true
WEBSOCKET_PING_INTERVAL=20
WEBSOCKET_PING_TIMEOUT=20
```

### CORS Settings

```ini
ENABLE_CORS=true
CORS_ALLOW_ORIGINS=["*"]
CORS_ALLOW_CREDENTIALS=true
```

### Proxy Configuration

```ini
# HTTP Proxy
HTTP_PROXY=http://proxy.company.com:8080
HTTPS_PROXY=http://proxy.company.com:8080
NO_PROXY=localhost,127.0.0.1
```

## Environment-Specific Configuration

### Development

```ini
ENV=development
DEBUG=true
RELOAD=true
LOG_LEVEL=DEBUG
```

### Production

```ini
ENV=production
DEBUG=false
RELOAD=false
LOG_LEVEL=INFO
ENABLE_RATE_LIMIT=true
```

## Applying Configuration Changes

After modifying the configuration file:

### Using PowerShell

```powershell
Restart-Service OpenWebUIService
```

### Using Services Console

1. Press `Win + R`, type `services.msc`
2. Find "Open WebUI Service"
3. Right-click and select "Restart"

### Using Command Prompt

```batch
net stop OpenWebUIService
net start OpenWebUIService
```

## Configuration Validation

To validate your configuration:

```powershell
# Check if service is running
Get-Service OpenWebUIService | Select-Object Status, StartType

# Check logs for errors
Get-Content "C:\Program Files\Open WebUI\logs\openwebui_stderr.log" -Tail 50

# Test connectivity
Test-NetConnection -ComputerName localhost -Port 8080
```

## Troubleshooting

### Configuration Not Applied

**Issue:** Changes to `.env` file not taking effect

**Solution:**

1. Verify file is saved
2. Restart the service
3. Check for syntax errors in `.env` file

### Service Won't Start After Configuration Change

**Issue:** Service fails to start after configuration change

**Solution:**

1. Check logs: `C:\Program Files\Open WebUI\logs\openwebui_stderr.log`
2. Restore previous working configuration
3. Validate configuration syntax

### Port Already in Use

**Issue:** Cannot bind to port 8080

**Solution:**

```powershell
# Find process using port 8080
netstat -ano | findstr :8080

# Change port in .env
WEBUI_PORT=8081

# Restart service
Restart-Service OpenWebUIService
```

## Related Links

- [Windows Installation Guide](windows-installation.md)
- [Build Guide](build-guide.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

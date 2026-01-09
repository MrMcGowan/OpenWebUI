# Open WebUI for Windows Server 2022 👋

![Build Status](https://github.com/YOUR_USERNAME/YOUR_REPO/workflows/Build%20Windows%20Installer/badge.svg)
![Windows Server 2022](https://img.shields.io/badge/Windows%20Server-2022-blue?logo=windows&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.11+-blue?logo=python&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

![Open WebUI Banner](./banner.png)

**Open WebUI for Windows Server 2022** is a streamlined, Windows-native version of the Open WebUI AI platform. This fork is specifically designed for **Windows Server 2022** with a convenient **setup.exe installer** for enterprise deployments.

**Key Features:**

- ✅ Windows Server 2022 native installation
- ✅ One-click setup.exe installer
- ✅ Windows Service integration
- ✅ Automatic startup configuration
- ✅ Simplified deployment for Windows environments
- ✅ No Docker or WSL required

**Open WebUI** is an [extensible](https://docs.openwebui.com/features/plugin/), feature-rich, and user-friendly self-hosted AI platform designed to operate entirely offline. It supports various LLM runners like **Ollama** and **OpenAI-compatible APIs**, with **built-in inference engine** for RAG, making it a **powerful AI deployment solution**.

Passionate about open-source AI? [Join our team →](https://careers.openwebui.com/)

![Open WebUI Demo](./demo.png)

> [!TIP]  
> **Looking for an [Enterprise Plan](https://docs.openwebui.com/enterprise)?** – **[Speak with Our Sales Team Today!](https://docs.openwebui.com/enterprise)**
>
> Get **enhanced capabilities**, including **custom theming and branding**, **Service Level Agreement (SLA) support**, **Long-Term Support (LTS) versions**, and **more!**

For more information, be sure to check out our [Open WebUI Documentation](https://docs.openwebui.com/).

## Key Features of Open WebUI ⭐

- 🚀 **Effortless Windows Setup**: Install seamlessly on Windows Server 2022 with a single setup.exe installer. No Docker, WSL, or Linux knowledge required.

- 🤝 **Ollama/OpenAI API Integration**: Effortlessly integrate OpenAI-compatible APIs for versatile conversations alongside Ollama models. Customize the OpenAI API URL to link with **LMStudio, GroqCloud, Mistral, OpenRouter, and more**.

- 🛡️ **Granular Permissions and User Groups**: By allowing administrators to create detailed user roles and permissions, we ensure a secure user environment. This granularity not only enhances security but also allows for customized user experiences, fostering a sense of ownership and responsibility amongst users.

- 📱 **Responsive Design**: Enjoy a seamless experience across Desktop PC, Laptop, and Mobile devices.

- 📱 **Progressive Web App (PWA) for Mobile**: Enjoy a native app-like experience on your mobile device with our PWA, providing offline access on localhost and a seamless user interface.

- ✒️🔢 **Full Markdown and LaTeX Support**: Elevate your LLM experience with comprehensive Markdown and LaTeX capabilities for enriched interaction.

- 🎤📹 **Hands-Free Voice/Video Call**: Experience seamless communication with integrated hands-free voice and video call features using multiple Speech-to-Text providers (Local Whisper, OpenAI, Deepgram, Azure) and Text-to-Speech engines (Azure, ElevenLabs, OpenAI, Transformers, WebAPI), allowing for dynamic and interactive chat environments.

- 🛠️ **Model Builder**: Easily create Ollama models via the Web UI. Create and add custom characters/agents, customize chat elements, and import models effortlessly through [Open WebUI Community](https://openwebui.com/) integration.

- 🐍 **Native Python Function Calling Tool**: Enhance your LLMs with built-in code editor support in the tools workspace. Bring Your Own Function (BYOF) by simply adding your pure Python functions, enabling seamless integration with LLMs.

- 💾 **Persistent Artifact Storage**: Built-in key-value storage API for artifacts, enabling features like journals, trackers, leaderboards, and collaborative tools with both personal and shared data scopes across sessions.

- 📚 **Local RAG Integration**: Dive into the future of chat interactions with groundbreaking Retrieval Augmented Generation (RAG) support using your choice of 9 vector databases and multiple content extraction engines (Tika, Docling, Document Intelligence, Mistral OCR, External loaders). Load documents directly into chat or add files to your document library, effortlessly accessing them using the `#` command before a query.

- 🔍 **Web Search for RAG**: Perform web searches using 15+ providers including `SearXNG`, `Google PSE`, `Brave Search`, `Kagi`, `Mojeek`, `Tavily`, `Perplexity`, `serpstack`, `serper`, `Serply`, `DuckDuckGo`, `SearchApi`, `SerpApi`, `Bing`, `Jina`, `Exa`, `Sougou`, `Azure AI Search`, and `Ollama Cloud`, injecting results directly into your chat experience.

- 🌐 **Web Browsing Capability**: Seamlessly integrate websites into your chat experience using the `#` command followed by a URL. This feature allows you to incorporate web content directly into your conversations, enhancing the richness and depth of your interactions.

- 🎨 **Image Generation & Editing Integration**: Create and edit images using multiple engines including OpenAI's DALL-E, Gemini, ComfyUI (local), and AUTOMATIC1111 (local), with support for both generation and prompt-based editing workflows.

- ⚙️ **Many Models Conversations**: Effortlessly engage with various models simultaneously, harnessing their unique strengths for optimal responses. Enhance your experience by leveraging a diverse set of models in parallel.

- 🔐 **Role-Based Access Control (RBAC)**: Ensure secure access with restricted permissions; only authorized individuals can access your Ollama, and exclusive model creation/pulling rights are reserved for administrators.

- 🗄️ **Flexible Database & Storage Options**: Choose from SQLite (with optional encryption), PostgreSQL, or configure cloud storage backends (S3, Google Cloud Storage, Azure Blob Storage) for scalable deployments.

- 🔍 **Advanced Vector Database Support**: Select from 9 vector database options including ChromaDB, PGVector, Qdrant, Milvus, Elasticsearch, OpenSearch, Pinecone, S3Vector, and Oracle 23ai for optimal RAG performance.

- 🔐 **Enterprise Authentication**: Full support for LDAP/Active Directory integration, SCIM 2.0 automated provisioning, and SSO via trusted headers alongside OAuth providers. Enterprise-grade user and group provisioning through SCIM 2.0 protocol, enabling seamless integration with identity providers like Okta, Azure AD, and Google Workspace for automated user lifecycle management.

- ☁️ **Cloud-Native Integration**: Native support for Google Drive and OneDrive/SharePoint file picking, enabling seamless document import from enterprise cloud storage.

- 📊 **Production Observability**: Built-in OpenTelemetry support for traces, metrics, and logs, enabling comprehensive monitoring with your existing observability stack.

- ⚖️ **Horizontal Scalability**: Redis-backed session management and WebSocket support for multi-worker and multi-node deployments behind load balancers.

- 🌐🌍 **Multilingual Support**: Experience Open WebUI in your preferred language with our internationalization (i18n) support. Join us in expanding our supported languages! We're actively seeking contributors!

- 🧩 **Pipelines, Open WebUI Plugin Support**: Seamlessly integrate custom logic and Python libraries into Open WebUI using [Pipelines Plugin Framework](https://github.com/open-webui/pipelines). Launch your Pipelines instance, set the OpenAI URL to the Pipelines URL, and explore endless possibilities. [Examples](https://github.com/open-webui/pipelines/tree/main/examples) include **Function Calling**, User **Rate Limiting** to control access, **Usage Monitoring** with tools like Langfuse, **Live Translation with LibreTranslate** for multilingual support, **Toxic Message Filtering** and much more.

- 🌟 **Continuous Updates**: We are committed to improving Open WebUI with regular updates, fixes, and new features.

Want to learn more about Open WebUI's features? Check out our [Open WebUI documentation](https://docs.openwebui.com/features) for a comprehensive overview!

---

We are incredibly grateful for the generous support of our sponsors. Their contributions help us to maintain and improve our project, ensuring we can continue to deliver quality work to our community. Thank you!

## How to Install on Windows Server 2022 🚀

### Method 1: Using the Setup.exe Installer (Recommended)

The easiest way to install Open WebUI on Windows Server 2022:

#### Download Options:

**Option A: From Releases (Stable)**

1. Go to the [Releases page](https://github.com/YOUR_USERNAME/YOUR_REPO/releases)
2. Download the latest `OpenWebUI-Setup-{version}-Win64.exe`

**Option B: From Actions (Latest Build)**

1. Go to the [Actions tab](https://github.com/YOUR_USERNAME/YOUR_REPO/actions)
2. Click the latest successful workflow run
3. Download **OpenWebUI-Windows-Installer** from Artifacts
4. Extract the ZIP to get the installer

#### Install:

1. **Run as Administrator** - Right-click the installer and select "Run as administrator"
2. **Follow the wizard** - Accept defaults or customize installation location
3. **Access the application** - Navigate to `http://localhost:8080` in your browser

The installer automatically:

- ✅ Installs all dependencies
- ✅ Configures Windows Firewall
- ✅ Sets up Windows Service
- ✅ Configures auto-start on boot

**📖 [Detailed Installation Guide](Documentation/windows-installation.md)**

### Method 2: Build from Source

For developers who want to build the installer themselves:

```powershell
# Clone the repository
git clone https://github.com/yourusername/open-webui.git
cd open-webui

# Build the installer
.\build_installer.ps1
```

The installer will be created in `installer\output\`

**📖 [Build Guide](Documentation/build-guide.md)**

### Method 3: Manual Installation (Development)

For development and testing:

```powershell
# Install Python dependencies
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r backend\requirements.txt

# Install Node.js dependencies and build frontend
npm ci
npm run build

# Start the application
.\start.bat
```

Access the application at `http://localhost:8080`

## System Requirements

- **Operating System:** Windows Server 2022 (Build 20348 or later)
- **RAM:** 4 GB minimum (8 GB recommended)
- **Disk Space:** 10 GB minimum
- **Processor:** 64-bit processor
- **Network:** Internet connection for initial setup

## Quick Start

After installation:

1. **Access the Web Interface**
   - Open browser to `http://localhost:8080`
   - Or from network: `http://<server-ip>:8080`

2. **Create Admin Account**
   - First user automatically becomes admin

3. **Configure AI Models**
   - Connect to Ollama, OpenAI, or other compatible APIs
   - Start chatting with AI models

## Service Management

Open WebUI runs as a Windows Service:

```powershell
# Start service
Start-Service OpenWebUIService

# Stop service
Stop-Service OpenWebUIService

# Check status
Get-Service OpenWebUIService
```

Or use the Windows Services console (`services.msc`)

---

## Configuration

Configuration is stored in `C:\Program Files\Open WebUI\data\.env`

Common settings:

```ini
WEBUI_HOST=0.0.0.0
WEBUI_PORT=8080
DATA_DIR=.\data
WEBUI_SECRET_KEY=<auto-generated>
```

**📖 [Full Configuration Guide](Documentation/configuration.md)**

---

## Documentation

- **[Windows Installation Guide](Documentation/windows-installation.md)** - Complete installation instructions
- **[Build Guide](Documentation/build-guide.md)** - How to build the installer from source
- **[GitHub Actions Guide](Documentation/github-actions.md)** - Automated builds and releases
- **[Configuration Guide](Documentation/configuration.md)** - Detailed configuration options
- **[Troubleshooting Guide](TROUBLESHOOTING.md)** - Common issues and solutions

---

## Upstream Project

This is a Windows Server 2022 focused fork of [Open WebUI](https://github.com/open-webui/open-webui).

For the original cross-platform version with Docker support, see:

- **Original Repository:** https://github.com/open-webui/open-webui
- **Documentation:** https://docs.openwebui.com/

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Support

For Windows-specific issues with this fork:

- Check the [Troubleshooting Guide](TROUBLESHOOTING.md)
- Review the [Documentation](Documentation/)
- Open an issue on this repository

For general Open WebUI features and functionality:

- Visit the [official Open WebUI documentation](https://docs.openwebui.com/)
- Join the [Open WebUI Discord](https://discord.gg/5rJgQTnV4s)

  ```

  ```

- **For CPU Only**:
  If you're not using a GPU, use this command instead:

  ```bash
  docker run -d -p 3000:8080 -v ollama:/root/.ollama -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:ollama
  ```

Both commands facilitate a built-in, hassle-free installation of both Open WebUI and Ollama, ensuring that you can get everything up and running swiftly.

After installation, you can access Open WebUI at [http://localhost:3000](http://localhost:3000). Enjoy! 😄

### Other Installation Methods

We offer various installation alternatives, including non-Docker native installation methods, Docker Compose, Kustomize, and Helm. Visit our [Open WebUI Documentation](https://docs.openwebui.com/getting-started/) or join our [Discord community](https://discord.gg/5rJgQTnV4s) for comprehensive guidance.

Look at the [Local Development Guide](https://docs.openwebui.com/getting-started/advanced-topics/development) for instructions on setting up a local development environment.

### Troubleshooting

Encountering connection issues? Our [Open WebUI Documentation](https://docs.openwebui.com/troubleshooting/) has got you covered. For further assistance and to join our vibrant community, visit the [Open WebUI Discord](https://discord.gg/5rJgQTnV4s).

#### Open WebUI: Server Connection Error

If you're experiencing connection issues, it’s often due to the WebUI docker container not being able to reach the Ollama server at 127.0.0.1:11434 (host.docker.internal:11434) inside the container . Use the `--network=host` flag in your docker command to resolve this. Note that the port changes from 3000 to 8080, resulting in the link: `http://localhost:8080`.

**Example Docker Command**:

```bash
docker run -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

### Keeping Your Docker Installation Up-to-Date

Check our Updating Guide available in our [Open WebUI Documentation](https://docs.openwebui.com/getting-started/updating).

### Using the Dev Branch 🌙

> [!WARNING]
> The `:dev` branch contains the latest unstable features and changes. Use it at your own risk as it may have bugs or incomplete features.

If you want to try out the latest bleeding-edge features and are okay with occasional instability, you can use the `:dev` tag like this:

```bash
docker run -d -p 3000:8080 -v open-webui:/app/backend/data --name open-webui --add-host=host.docker.internal:host-gateway --restart always ghcr.io/open-webui/open-webui:dev
```

### Offline Mode

If you are running Open WebUI in an offline environment, you can set the `HF_HUB_OFFLINE` environment variable to `1` to prevent attempts to download models from the internet.

```bash
export HF_HUB_OFFLINE=1
```

## What's Next? 🌟

Discover upcoming features on our roadmap in the [Open WebUI Documentation](https://docs.openwebui.com/roadmap/).

## License 📜

This project contains code under multiple licenses. The current codebase includes components licensed under the Open WebUI License with an additional requirement to preserve the "Open WebUI" branding, as well as prior contributions under their respective original licenses. For a detailed record of license changes and the applicable terms for each section of the code, please refer to [LICENSE_HISTORY](./LICENSE_HISTORY). For complete and updated licensing details, please see the [LICENSE](./LICENSE) and [LICENSE_HISTORY](./LICENSE_HISTORY) files.

## Support 💬

If you have any questions, suggestions, or need assistance, please open an issue or join our
[Open WebUI Discord community](https://discord.gg/5rJgQTnV4s) to connect with us! 🤝

## Star History

<a href="https://star-history.com/#open-webui/open-webui&Date">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=open-webui/open-webui&type=Date&theme=dark" />
    <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=open-webui/open-webui&type=Date" />
    <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=open-webui/open-webui&type=Date" />
  </picture>
</a>

---

Created by [Timothy Jaeryang Baek](https://github.com/tjbck) - Let's make Open WebUI even more amazing together! 💪

# 🚀 Claude + GitHub + VS Code Workspace Template

**Production-ready development environment** combining Claude AI, GitHub Codespaces, and VS Code for maximum productivity.

---

## ✨ What You Get

🎯 **Fully-Equipped Cloud Development Environment:**
- **Multiple Languages:** Node.js, Python, Go, Rust, Java
- **DevOps Tools:** Docker, Kubernetes, Terraform, AWS CLI, Azure CLI
- **AI-Powered Coding:** GitHub Copilot & Copilot Chat
- **40+ VS Code Extensions:** Pre-installed and configured
- **Enhanced Shell:** Zsh with Oh My Zsh, modern CLI tools (bat, exa, fzf)
- **Auto-Configuration:** Post-create scripts set everything up automatically

🤖 **AI-Powered Workflow:**
- Claude AI for architecture, debugging, and complex problem-solving
- GitHub Copilot for intelligent code completion
- IntelliCode for AI-assisted development
- Integrated development workflow with best practices

🔐 **Security & Best Practices:**
- SSH key management with agent auto-start
- Secure environment variable handling
- EditorConfig for consistent code formatting
- Security-focused extensions and linting

📚 **Comprehensive Documentation:**
- Step-by-step setup guides for every scenario
- AI integration workflows and best practices
- DevOps and deployment guides
- Extensive troubleshooting resources

---

## 🏃 Quick Start (5 Minutes)

### 1. Create Your Project

**Option A: Use This Template**
1. Click **"Use this template"** → **"Create a new repository"**
2. Name your project
3. Choose public/private
4. Click **"Create repository"**

**Option B: Clone & Customize**
```bash
git clone https://github.com/JeffreyLovett/claude-github-codespace-template.git my-project
cd my-project
```

---

### 2. Launch Codespace

1. Go to your repository on GitHub
2. Click **Code** → **Codespaces** → **Create codespace on main**
3. Wait 2-3 minutes for environment setup
4. Start coding! 🎉

---

### 3. Verify Installation

Run in Codespace terminal:
```bash
# Language runtimes
node --version     # Node.js LTS
python --version   # Python 3.11
go version         # Go latest
rustc --version    # Rust latest
java --version     # Java latest

# DevOps tools
docker --version   # Docker
kubectl version --client  # Kubernetes
terraform version  # Terraform
aws --version      # AWS CLI
az version         # Azure CLI
gh --version       # GitHub CLI
```

---

## 📖 Full Documentation

| Document | Purpose |
|----------|---------|
| **[WORKSPACE_SETUP.md](./WORKSPACE_SETUP.md)** | Complete setup walkthrough |
| **[.devcontainer/README.md](./.devcontainer/README.md)** | DevContainer configuration details |
| **[docs/CLAUDE_INTEGRATION.md](./docs/CLAUDE_INTEGRATION.md)** | Claude AI workflow guide |
| **[docs/SSH_VPS_GUIDE.md](./docs/SSH_VPS_GUIDE.md)** | Remote server connections |
| **[.github/CODESPACES.md](./.github/CODESPACES.md)** | GitHub Codespaces configuration |

---

## 🛠️ What's Included

### Languages & Runtimes
- **Node.js (LTS)** with npm, yarn, pnpm - JavaScript/TypeScript development
- **Python 3.11** with pip, black, pylint - Python development & data science
- **Go (latest)** - Systems programming & cloud services
- **Rust (latest)** - High-performance applications
- **Java (latest)** with Maven & Gradle - Enterprise development

### DevOps & Cloud Tools
- **Docker** - Container development with Docker-in-Docker
- **Kubernetes** - kubectl & Helm for container orchestration
- **Terraform** - Infrastructure as Code
- **AWS CLI** - Amazon Web Services management
- **Azure CLI** - Microsoft Azure management
- **GitHub CLI** - Repository management from terminal

### Shell & Terminal
- **Zsh with Oh My Zsh** - Enhanced shell experience
- **Modern CLI tools** - bat (better cat), exa (better ls), fzf (fuzzy finder)
- **Helpful aliases** - Pre-configured shortcuts for git, docker, and more
- **SSH agent** - Automatic SSH key management

### VS Code Extensions (40+)

**AI & Productivity:**
- GitHub Copilot & Copilot Chat
- IntelliCode & API usage examples
- Error Lens, Path Intellisense
- Better Comments, TODO Highlight
- Spell Checker

**Languages:**
- Python (Pylance, Black, isort, debugpy)
- JavaScript/TypeScript (ESLint, Prettier)
- Go, Rust Analyzer, Java Pack
- Web Dev (Tailwind, Auto Rename Tag, HTML/CSS)

**DevOps:**
- Docker, Kubernetes Tools
- Terraform, AWS Toolkit, Azure Tools

**Git:**
- GitLens, Git Graph, Git History
- GitHub Pull Requests

**Database & API:**
- SQLTools, REST Client, Thunder Client

**Documentation:**
- Markdown All-in-One
- Markdown Lint, Mermaid Diagrams

**Testing:**
- Test Explorer, Jest Runner

**Collaboration:**
- Live Share

### Port Forwarding
Pre-configured ports: `3000-3010`, `5000-5001`, `5432`, `5678`, `6379`, `8000`, `8080`, `8888`, `9000`
- Web applications (React, Express, Next.js)
- API servers (Flask, Django, FastAPI)
- Databases (PostgreSQL, Redis)
- Development servers & debugging

---

## 🎯 Common Workflows

### Workflow 1: New Feature with Claude + Copilot

```bash
# 1. Plan architecture with Claude (in browser)
# → Describe your feature, get design suggestions

# 2. Implement in Codespace
npm init -y
npm install express

# 3. Let Copilot help write code
# → Start typing, accept suggestions

# 4. Test & iterate
npm test
```

### Workflow 2: Deploy to VPS

```bash
# 1. Generate SSH key
ssh-keygen -t ed25519 -C "your.email@example.com"

# 2. Add to server
ssh-copy-id user@your-server.com

# 3. Deploy
npm run build
rsync -avz ./dist/ user@server:/var/www/app/
ssh user@server 'sudo systemctl restart app'
```

### Workflow 3: Database-Driven App

```bash
# 1. Install dependencies
npm install express pg dotenv

# 2. Set environment variables
# GitHub → Settings → Codespaces → Secrets
# Add: DATABASE_URL

# 3. Connect & code
# Copilot helps with DB queries
```

---

## 🔐 Security Best Practices

✅ **Configured for you:**
- `.gitignore` excludes secrets, keys, `.env`
- SSH keys stay in Codespace (never committed)
- Environment variables via Codespace secrets

⚠️ **Remember to:**
- Use strong SSH key passphrases
- Rotate keys every 6-12 months
- Never commit API keys or tokens
- Use `.env` files for local secrets

---

## 🚀 Reusing This Template

**For Every New Project:**

1. **Go to template repo** (this one)
2. **Click "Use this template"**
3. **Name your new project**
4. **Launch Codespace**
5. **Install project dependencies:**
   ```bash
   npm init -y
   # or
   pip install -r requirements.txt
   ```

**That's it!** Same environment, different project.

---

## 🏢 Team Usage

**For Organizations:**

1. **Fork this template** to your org
2. **Customize** `.devcontainer/devcontainer.json` (add org-specific tools)
3. **Team members use org template** for consistent environments
4. **No more "works on my machine"** issues

---

## 🎓 Learning Resources

### New to Codespaces?
- [GitHub Codespaces Docs](https://docs.github.com/en/codespaces)
- [VS Code in Browser Guide](https://code.visualstudio.com/docs/remote/codespaces)

### New to Claude?
- [Claude.ai](https://claude.ai)
- Read: [docs/CLAUDE_INTEGRATION.md](./docs/CLAUDE_INTEGRATION.md)

### New to Copilot?
- [GitHub Copilot Docs](https://docs.github.com/en/copilot)

---

## 🐛 Troubleshooting

### Codespace won't start
- Check GitHub Codespaces status page
- Try rebuilding container: `Cmd/Ctrl + Shift + P` → "Rebuild Container"

### Copilot not working
- Extensions panel → Ensure "GitHub Copilot" is enabled
- `Cmd/Ctrl + Shift + P` → "GitHub Copilot: Sign In"

### SSH connection failing
- See [docs/SSH_VPS_GUIDE.md](./docs/SSH_VPS_GUIDE.md) troubleshooting section

### Port not accessible
- PORTS tab (bottom panel) → Right-click port → "Port Visibility: Public"

---

## 📊 Repository Structure

```
claude-github-codespace-template/
├── .devcontainer/
│   ├── devcontainer.json       # Codespace configuration
│   ├── post-create.sh          # Automated setup script
│   ├── update.sh               # Update script
│   └── README.md               # DevContainer documentation
├── .github/
│   └── CODESPACES.md           # GitHub Codespaces guide
├── docs/
│   ├── CLAUDE_INTEGRATION.md   # AI workflow guide
│   └── SSH_VPS_GUIDE.md        # Server connection guide
├── pc-tools/                   # Windows PC utilities (optional)
│   └── browser-manager/        # Browser memory management
├── .editorconfig               # Consistent code formatting
├── .gitignore                  # Security-first ignore rules
├── workspace.code-workspace    # VS Code workspace settings
├── README.md                   # This file
└── WORKSPACE_SETUP.md          # Complete setup walkthrough
```

---

## 🤝 Contributing

**Improvements welcome!**

1. Fork this repository
2. Create feature branch: `git checkout -b feature/improvement`
3. Commit changes: `git commit -m 'Add improvement'`
4. Push: `git push origin feature/improvement`
5. Open Pull Request

---

## 🎉 You're Ready!

```
┌────────────────────────────────────────┐
│  PRODUCTION-READY CLOUD WORKSPACE      │
├────────────────────────────────────────┤
│                                        │
│  ✅ Multi-language development         │
│  ✅ DevOps & cloud tools ready         │
│  ✅ 40+ VS Code extensions             │
│  ✅ AI-powered coding (Copilot)        │
│  ✅ Secure SSH & remote access         │
│  ✅ Automated setup & configuration    │
│  ✅ Complete documentation             │
│  ✅ Reusable for all projects          │
│                                        │
│  🚀 START BUILDING NOW!                │
│                                        │
└────────────────────────────────────────┘
```

### Next Steps:

1. ✅ **Launch Codespace** (if you haven't)
2. 📖 **Check ~/workspace/WELCOME.md** for quick overview
3. 🔧 **Read** [.devcontainer/README.md](.devcontainer/README.md) for configuration details
4. 🔑 **Set up SSH keys** (see [SSH_VPS_GUIDE.md](./docs/SSH_VPS_GUIDE.md))
5. 🤖 **Try Claude integration** (see [CLAUDE_INTEGRATION.md](./docs/CLAUDE_INTEGRATION.md))
6. 💻 **Start coding!**

### Helpful Commands:

```bash
# Check what's installed
ll                # List files (enhanced with exa)
node --version    # Check Node.js
python --version  # Check Python
docker --version  # Check Docker

# Git shortcuts
gs                # git status
gd                # git diff
gl                # git log with graph

# Docker helpers
dps               # Docker ps with nice formatting
dclean            # Clean up Docker resources

# Get AI help
gh copilot --help # GitHub Copilot CLI help
```

---

**Questions? Feedback?** Open an issue or discussion!

**Built with ❤️ for developers who love automation**

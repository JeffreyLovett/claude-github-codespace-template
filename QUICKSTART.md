# 🎯 Quick Reference Guide

**Your comprehensive cloud development environment in one page.**

---

## 🚀 Getting Started

### Launch Your Codespace
1. Click **Code** → **Codespaces** → **Create codespace on main**
2. Wait 3-5 minutes for first-time setup
3. You're ready to code!

### First Commands to Try
```bash
# Check what's installed
node --version && python --version && go version
docker --version && kubectl version --client
terraform version && aws --version

# See helpful aliases
alias | grep -E '^(g|d|ll)'

# Read the welcome message
cat ~/workspace/WELCOME.md
```

---

## 💡 What You Have

### 🌍 Languages (5)
- **Node.js LTS** → `node`, `npm`, `yarn`, `pnpm`
- **Python 3.11** → `python`, `pip`
- **Go latest** → `go`
- **Rust latest** → `cargo`, `rustc`
- **Java latest** → `java`, `javac`, `maven`, `gradle`

### 🛠️ DevOps Tools (6)
- **Docker** → `docker`, `docker-compose`
- **Kubernetes** → `kubectl`, `helm`
- **Terraform** → `terraform`
- **AWS** → `aws`
- **Azure** → `az`
- **GitHub** → `gh`

### 🎨 VS Code Extensions (49)
Press `Ctrl/Cmd+Shift+X` to see all installed extensions

### 🐚 Shell Enhancements
- **Zsh** with Oh My Zsh (default shell)
- **bat** - Better cat: `bat filename`
- **exa** - Better ls: `exa -la` or just `ll`
- **fzf** - Fuzzy finder: `Ctrl+R` for history search

---

## 🔥 Useful Commands

### Git Shortcuts
```bash
gs          # git status
ga .        # git add .
gc "msg"    # git commit -m "msg"
gp          # git push
gl          # git log --graph
gd          # git diff
gclean      # Remove merged branches
```

### Docker Helpers
```bash
dps         # Pretty docker ps
dclean      # Clean up Docker (prune)
```

### File Operations
```bash
ll          # List files with details (exa)
la          # List all files including hidden
lt          # Tree view of directory
cat file    # View file with syntax highlighting (bat)
```

### Navigation
```bash
..          # Go up one directory
...         # Go up two directories
mkcd name   # Create directory and cd into it
```

---

## 📝 File Locations

### Configuration
- **DevContainer**: `.devcontainer/devcontainer.json`
- **Shell Config**: `~/.zshrc`
- **Git Config**: `~/.gitconfig`
- **SSH Keys**: `~/.ssh/`

### Documentation
- **Main README**: `README.md`
- **Features List**: `FEATURES.md`
- **Setup Guide**: `WORKSPACE_SETUP.md`
- **DevContainer Docs**: `.devcontainer/README.md`
- **Claude Integration**: `docs/CLAUDE_INTEGRATION.md`
- **SSH Guide**: `docs/SSH_VPS_GUIDE.md`

### Workspace
- **Your Projects**: `~/workspace/projects/`
- **Scripts**: `~/workspace/scripts/`
- **Documentation**: `~/workspace/docs/`

---

## 🔌 Port Forwarding

Your ports are automatically forwarded. Access them via the **PORTS** tab.

| Port | Purpose |
|------|---------|
| 3000-3010 | Web apps (React, Express, etc.) |
| 5000-5001 | Python servers (Flask, Django) |
| 5432 | PostgreSQL |
| 5678 | Python debugger |
| 6379 | Redis |
| 8000 | Dev server |
| 8080 | Alternative HTTP |
| 8888 | Jupyter |

---

## 🤖 AI Assistance

### GitHub Copilot
- **Inline suggestions**: Just start typing
- **Chat**: Click Copilot icon or `Ctrl/Cmd+I`
- **Explain code**: Select code → Right-click → Copilot

### GitHub Copilot CLI
```bash
gh copilot suggest "how to..."
gh copilot explain "git command"
```

### Claude AI
Use [claude.ai](https://claude.ai) for:
- Architecture design
- Complex debugging
- Code review
- Learning new concepts

---

## 🎨 Editor Tips

### Keyboard Shortcuts
- **Command Palette**: `Ctrl/Cmd+Shift+P`
- **Quick Open**: `Ctrl/Cmd+P`
- **Terminal**: `Ctrl/Cmd+``
- **Format Document**: `Shift+Alt+F`
- **Copilot Chat**: `Ctrl/Cmd+I`

### Enabled Features
- ✅ Format on save
- ✅ Auto-organize imports
- ✅ ESLint auto-fix
- ✅ Auto-save (1 sec delay)
- ✅ Bracket colorization
- ✅ IntelliSense

---

## 🔒 Security

### SSH Keys
```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "your@email.com"

# Start SSH agent (auto-starts with Zsh)
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copy public key
cat ~/.ssh/id_ed25519.pub
```

### Environment Variables
```bash
# Create .env file (already in .gitignore)
echo "API_KEY=your-key" > .env

# Use in code
# Node: process.env.API_KEY
# Python: os.getenv('API_KEY')
```

### GitHub Codespaces Secrets
Settings → Codespaces → Secrets → New secret

---

## 🐛 Troubleshooting

### Rebuild Container
If something doesn't work:
1. Press `Ctrl/Cmd+Shift+P`
2. Type "Rebuild Container"
3. Select "Dev Containers: Rebuild Container"

### Check Logs
- **Build logs**: Check terminal during startup
- **Post-create logs**: Look for setup script output
- **Extension logs**: Output panel → Select extension

### Common Fixes
```bash
# Reload shell config
source ~/.zshrc

# Re-add SSH keys
ssh-add ~/.ssh/id_ed25519

# Update global packages
npm update -g
pip install --upgrade pip
```

---

## 📚 Learn More

| Resource | Link |
|----------|------|
| **Features List** | [FEATURES.md](FEATURES.md) |
| **Full Setup Guide** | [WORKSPACE_SETUP.md](WORKSPACE_SETUP.md) |
| **DevContainer Docs** | [.devcontainer/README.md](.devcontainer/README.md) |
| **Claude Workflow** | [docs/CLAUDE_INTEGRATION.md](docs/CLAUDE_INTEGRATION.md) |
| **SSH & VPS** | [docs/SSH_VPS_GUIDE.md](docs/SSH_VPS_GUIDE.md) |
| **GitHub Codespaces** | [Official Docs](https://docs.github.com/en/codespaces) |

---

## 🎓 Example Projects

### Node.js Web App
```bash
mkdir ~/workspace/projects/my-app && cd $_
npm init -y
npm install express
# Start coding with Copilot!
```

### Python Data Science
```bash
mkdir ~/workspace/projects/data-analysis && cd $_
python -m venv venv
source venv/bin/activate
pip install pandas numpy jupyter
jupyter notebook
```

### Docker Application
```bash
mkdir ~/workspace/projects/docker-app && cd $_
# Create Dockerfile
# Use Docker extension for auto-completion
docker build -t my-app .
docker run -p 3000:3000 my-app
```

### Kubernetes Deployment
```bash
mkdir ~/workspace/projects/k8s-app && cd $_
# Create deployment.yaml
kubectl apply -f deployment.yaml
kubectl get pods
```

---

## 🎉 You're All Set!

This is your **production-ready cloud development environment**.

Everything you need is pre-installed and configured. Just start coding!

**Pro Tip**: Bookmark this page for quick reference.

---

**Need help?** Check the documentation or open an issue on GitHub.

**Happy coding!** 🚀

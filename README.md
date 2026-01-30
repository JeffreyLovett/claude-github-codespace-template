# 🚀 Claude + GitHub + VS Code Workspace Template

**Production-ready development environment** combining Claude AI, GitHub Codespaces, and VS Code for maximum productivity.

---

## ✨ What You Get

🎯 **Pre-configured Codespace** with:
- Node.js (LTS) + Python 3.11 + Git
- GitHub Copilot & Copilot Chat
- Remote SSH for VPS connections
- Port forwarding (3000-3010, 5678)
- Essential VS Code extensions

🤖 **AI-Powered Workflow:**
- Claude AI for architecture & debugging
- GitHub Copilot for code completion
- Integrated development workflow

🔐 **Security First:**
- SSH key management
- Environment variable handling
- Secure .gitignore configuration

📚 **Complete Documentation:**
- Step-by-step setup guides
- Best practices & workflows
- Troubleshooting resources

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
node --version    # Should show v20.x
python --version  # Should show 3.11.x
git --version     # Latest
gh auth status    # GitHub CLI authenticated
```

---

## 📖 Full Documentation

| Document | Purpose |
|----------|---------|
| **[WORKSPACE_SETUP.md](./WORKSPACE_SETUP.md)** | Complete setup walkthrough |
| **[docs/CLAUDE_INTEGRATION.md](./docs/CLAUDE_INTEGRATION.md)** | Claude AI workflow guide |
| **[docs/SSH_VPS_GUIDE.md](./docs/SSH_VPS_GUIDE.md)** | Remote server connections |

---

## 🛠️ What's Included

### Development Tools
- **Node.js (LTS):** JavaScript/TypeScript runtime
- **Python 3.11:** Data science, automation, backends
- **Git:** Version control
- **GitHub CLI:** Repository management from terminal
- **SSH:** Secure remote connections

### VS Code Extensions
- **GitHub Copilot** - AI code completions
- **GitHub Copilot Chat** - Conversational AI assistance
- **Remote SSH** - Connect to VPS/servers
- **Python** - Python development
- **ESLint** - JavaScript linting
- **Prettier** - Code formatting
- **GitLens** - Git visualization

### Port Forwarding
Pre-configured ports: `3000-3010`, `5678`
- Web servers (Express, Next.js, etc.)
- Development tools
- Debugging ports

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
│   └── devcontainer.json       # Codespace configuration
├── docs/
│   ├── CLAUDE_INTEGRATION.md   # AI workflow guide
│   └── SSH_VPS_GUIDE.md        # Server connection guide
├── .gitignore                  # Security-first ignore rules
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
│  PRODUCTION-READY WORKSPACE TEMPLATE   │
├────────────────────────────────────────┤
│                                        │
│  ✅ Development environment            │
│  ✅ AI-powered coding                  │
│  ✅ Secure remote access               │
│  ✅ Complete documentation             │
│  ✅ Reusable for all projects          │
│                                        │
│  🚀 START BUILDING NOW!                │
│                                        │
└────────────────────────────────────────┘
```

### Next Steps:

1. ✅ **Launch Codespace** (if you haven't)
2. 📖 **Read** [WORKSPACE_SETUP.md](./WORKSPACE_SETUP.md)
3. 🔑 **Set up SSH keys** (see [SSH_VPS_GUIDE.md](./docs/SSH_VPS_GUIDE.md))
4. 🤖 **Try Claude integration** (see [CLAUDE_INTEGRATION.md](./docs/CLAUDE_INTEGRATION.md))
5. 💻 **Start coding!**

---

**Questions? Feedback?** Open an issue or discussion!

**Built with ❤️ for developers who love automation**

# 🛠️ Complete Workspace Setup Guide

**Step-by-step instructions** to configure your Claude + GitHub + VS Code environment.

---

## 📋 Prerequisites

✅ GitHub account  
✅ Access to Claude.ai (free or paid)  
✅ Basic understanding of Git  

---

## 🚀 PART 1: First-Time Codespace Setup

### Step 1: Create Your Repository

**Option A: Use This Template**  
1. Go to https://github.com/JeffreyLovett/claude-github-codespace-template  
2. Click **"Use this template"** → **"Create a new repository"**  
3. Name it (e.g., `my-project`)  
4. Choose Public or Private  
5. Click **"Create repository"**

**Option B: Clone Existing Template**  
```bash
git clone https://github.com/JeffreyLovett/claude-github-codespace-template.git
cd claude-github-codespace-template
# Make your changes
git remote set-url origin https://github.com/YourUsername/your-new-repo.git
git push -u origin main
```

---

### Step 2: Launch Codespace

1. Navigate to your new repository on GitHub  
2. Click the **Code** button (green)  
3. Select the **Codespaces** tab  
4. Click **"Create codespace on main"**  
5. **Wait 2-3 minutes** while environment builds

**What's Happening:**  
- Docker container spinning up  
- Node.js, Python, Git installing  
- VS Code extensions loading  
- Ports being forwarded

---

### Step 3: Configure Git Credentials

**When Codespace opens, run:**

```bash
# Set your Git identity
git config --global user.name "Your Full Name"
git config --global user.email "your.email@example.com"

# Authenticate with GitHub
gh auth login
# Follow prompts:
# - Choose "GitHub.com"
# - Choose "HTTPS"
# - Authenticate via browser
```

**Verify:**  
```bash
git config --global --list
gh auth status
```

---

## 🔐 PART 2: SSH Key Setup (For VPS Access)

### Step 4: Generate SSH Key in Codespace

```bash
# Generate new ED25519 key (most secure)
ssh-keygen -t ed25519 -C "your.email@example.com"

# When prompted:
# - Save to: /home/codespace/.ssh/id_ed25519 (default)
# - Passphrase: HIGHLY RECOMMENDED (use password manager)
```

**Start SSH agent:**  
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

---

### Step 5: Add Public Key to Remote Server

**Copy your public key:**  
```bash
cat ~/.ssh/id_ed25519.pub
```

**Add to remote server:**  
```bash
# Option A: Manual (if you have password access)
ssh-copy-id user@your-server.com

# Option B: Copy-paste to server
# 1. SSH into server with password
# 2. Edit ~/.ssh/authorized_keys
# 3. Paste the public key content
```

**Test connection:**  
```bash
ssh user@your-server.com
# Should connect without password (but may ask for key passphrase)
```

---

## 🤖 PART 3: Claude AI Integration

### Step 6: Set Up Claude Workflow

**The Process:**  
1. **In Claude.ai Tab:**  
   - Describe your coding task  
   - Ask for implementation suggestions  
   - Request code snippets

2. **In VS Code Codespace:**  
   - Create files based on Claude's suggestions  
   - Use **Copilot** for inline completions  
   - Run/test code

3. **Iteration:**  
   - Copy error messages back to Claude  
   - Get debugging help  
   - Refine implementation

**Pro Tip:** Use Claude for architecture/design, Copilot for implementation.

---

### Step 7: Share Context with Claude

**Bad Practice:**  
```
"Write me a function"
```

**Good Practice:**  
```
I'm working in a Node.js project using Express.
Here's my current route structure:

[paste code]

I need to add JWT authentication middleware.
Tech stack: Node 20, Express 4.18, jsonwebtoken 9.0
```

**Copy from Codespace → Paste to Claude → Implement suggestions**

---

## 🔒 PART 4: Security Configuration

### Step 8: Set Up Environment Variables

**For Codespace Secrets:**  
1. Go to GitHub → Settings → Codespaces  
2. Click **"New secret"**  
3. Add secrets like:  
   - `DATABASE_URL`  
   - `API_KEY`  
   - `JWT_SECRET`

**In your code:**  
```javascript
// Auto-available in Codespace
const apiKey = process.env.API_KEY;
```

**For local .env files:**  
```bash
# Create .env (already in .gitignore)
echo "DATABASE_URL=postgresql://..." > .env
echo "API_KEY=your-key-here" >> .env

# Install dotenv
npm install dotenv

// In code
require('dotenv').config();
```

---

### Step 9: Verify .gitignore

**CRITICAL:** Never commit:  
```bash
# Check what would be committed
git status

# If you see .env, keys, or secrets:
git rm --cached .env
git commit -m "Remove sensitive file"
```

**Verify .gitignore includes:**  
```.env
*.key
*.pem
id_rsa
secrets/
```

---

## 🧪 PART 5: Testing the Setup

### Step 10: Validation Checklist

**Run these commands:**  
```bash
# ✅ Node.js
node -e "console.log('Node works:', process.version)"

# ✅ Python
python -c "print('Python works')"

# ✅ Git
git --version

# ✅ GitHub CLI
gh --version

# ✅ SSH
ssh -T git@github.com
# Should see: "Hi YourUsername! You've successfully authenticated"

# ✅ Ports
curl http://localhost:3000
# Should show connection attempt (even if nothing running)
```

---

### Step 11: Test Development Workflow

**Create a test file:**  
```bash
# Create sample Node.js file
cat > test.js << 'EOF'
// Start typing a function - Copilot should suggest
function calculateSum(a, b) {
  return a + b;
}

console.log(calculateSum(5, 3));
EOF

# Run it
node test.js
# Output: 8
```

**Verify Copilot:**  
1. Open `test.js`  
2. Type `// Function to reverse a string`  
3. Press Enter  
4. Copilot should suggest implementation

---

## 🔄 PART 6: Reusing This Template

### Step 12: Create New Projects

**Every new project:**  
```bash
# 1. Go to template repo
# 2. Click "Use this template"
# 3. Name new project
# 4. Launch Codespace
# 5. Install project dependencies

npm init -y  # or
pip install -r requirements.txt
```

**For Organization Repos:**  
1. Fork template to your org  
2. Customize `.devcontainer/devcontainer.json`  
3. Team members use org template

---

## 🚨 Common Issues & Fixes

| Problem | Solution |
|---------|----------|
| **Copilot not suggesting** | Check Extensions panel → Enable GitHub Copilot |
| **Git push rejected** | Run `gh auth login` again |
| **Port not accessible** | Check PORTS tab in bottom panel → Make port public |
| **SSH key not working** | Verify `ssh-add -l` shows key, re-run `ssh-add` |
| **Python packages missing** | Run `pip install --upgrade pip` |
| **Node modules error** | Delete `node_modules/` and run `npm install` |

---

## 📈 Advanced Customization

### Add Database Services

**Edit `.devcontainer/devcontainer.json`:**  
```json
{
  "features": {
    "ghcr.io/devcontainers/features/postgres:1": {"version": "15"},
    "ghcr.io/devcontainers/features/redis:1": {"version": "latest"}
  }
}
```

### Add More Extensions

```json
{
  "customizations": {
    "vscode": {
      "extensions": [
        "GitHub.copilot",
        "bradlc.vscode-tailwindcss",  // Add Tailwind
        "prisma.prisma"                // Add Prisma
      ]
    }
  }
}
```

---

## ✅ You're Ready!

**Your workspace now has:**  
- ✅ Full development environment  
- ✅ Git configured  
- ✅ SSH keys set up  
- ✅ Copilot working  
- ✅ Claude integration workflow  
- ✅ Security best practices

---

## 📚 Next Steps

1. Read [docs/CLAUDE_INTEGRATION.md](./docs/CLAUDE_INTEGRATION.md) for advanced Claude workflows  
2. Read [docs/SSH_VPS_GUIDE.md](./docs/SSH_VPS_GUIDE.md) for remote server management  
3. Start coding! 🚀

---

**Questions?** Open an issue or check GitHub Discussions.

**WIZARD CHECK:** [✔] Complete setup [✔] Security verified [✔] Ready for production
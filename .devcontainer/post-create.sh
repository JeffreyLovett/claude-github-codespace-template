#!/bin/bash
# Post-create script for GitHub Codespaces setup
# This script runs after the container is created

set -e

echo "🚀 Setting up your cloud development environment..."

# Configure Git
echo "📝 Configuring Git..."
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global fetch.prune true
git config --global diff.colorMoved zebra

# Install global Node.js packages
echo "📦 Installing global Node.js packages..."
npm install -g \
  yarn \
  pnpm \
  typescript \
  ts-node \
  nodemon \
  prettier \
  eslint \
  npm-check-updates \
  http-server \
  live-server \
  concurrently \
  dotenv-cli

# Upgrade pip and install common Python packages
echo "🐍 Setting up Python environment..."
pip install --upgrade pip setuptools wheel
pip install --upgrade \
  black \
  pylint \
  flake8 \
  pytest \
  pytest-cov \
  ipython \
  jupyter \
  requests \
  python-dotenv \
  virtualenv

# Install additional useful CLI tools
echo "🛠️  Installing additional CLI tools..."
# Install bat (better cat)
if ! command -v bat &> /dev/null; then
  echo "Installing bat..."
  wget -q https://github.com/sharkdp/bat/releases/download/v0.24.0/bat_0.24.0_amd64.deb
  sudo dpkg -i bat_0.24.0_amd64.deb
  rm bat_0.24.0_amd64.deb
fi

# Install exa (better ls)
if ! command -v exa &> /dev/null; then
  echo "Installing exa..."
  wget -q https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip
  unzip -q exa-linux-x86_64-v0.10.1.zip
  sudo mv bin/exa /usr/local/bin/
  rm -rf bin exa-linux-x86_64-v0.10.1.zip
fi

# Install fzf (fuzzy finder)
if ! command -v fzf &> /dev/null; then
  echo "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all --no-bash --no-fish --key-bindings --completion --update-rc
fi

# Setup Zsh configuration
echo "🐚 Configuring Zsh..."
cat >> ~/.zshrc << 'EOF'

# Custom aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias python='python3'
alias pip='pip3'

# Use bat for cat if available
if command -v bat &> /dev/null; then
  alias cat='bat'
fi

# Use exa for ls if available
if command -v exa &> /dev/null; then
  alias ls='exa'
  alias ll='exa -la'
  alias la='exa -a'
  alias lt='exa --tree'
fi

# Useful functions
mkcd() { mkdir -p "$1" && cd "$1"; }
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Docker helpers
dps() { docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"; }
dclean() { docker system prune -af; }

# Git helpers
gclean() { git branch --merged | grep -v '\*\|main\|master\|develop' | xargs -n 1 git branch -d; }

EOF

# Setup SSH agent auto-start
echo "🔐 Configuring SSH agent..."
cat >> ~/.zshrc << 'EOF'

# Start SSH agent automatically
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" > /dev/null 2>&1
  # Add any SSH keys found
  find ~/.ssh -type f -name 'id_*' ! -name '*.pub' -exec ssh-add {} \; 2>/dev/null
fi

EOF

# Create helpful workspace directories
echo "📁 Creating workspace directories..."
mkdir -p ~/workspace/{projects,templates,scripts,docs}

# Create a welcome message
cat > ~/workspace/WELCOME.md << 'EOF'
# Welcome to Your Cloud Development Environment! 🚀

This GitHub Codespace is fully configured with:

## Languages & Runtimes
- ✅ Node.js (LTS) with npm, yarn, and pnpm
- ✅ Python 3.11 with pip, black, pylint
- ✅ Go (latest)
- ✅ Rust (latest)
- ✅ Java (latest) with Maven and Gradle

## DevOps & Cloud Tools
- ✅ Docker & Docker Compose
- ✅ Kubernetes (kubectl & Helm)
- ✅ Terraform
- ✅ AWS CLI
- ✅ Azure CLI
- ✅ GitHub CLI

## Development Tools
- ✅ Git with helpful aliases
- ✅ SSH with agent auto-start
- ✅ Zsh with Oh My Zsh
- ✅ Modern CLI tools (bat, exa, fzf)

## VS Code Extensions
- ✅ GitHub Copilot & Copilot Chat
- ✅ Language support (Python, JS/TS, Go, Rust, Java)
- ✅ Docker & Kubernetes tools
- ✅ GitLens & Git Graph
- ✅ Database tools (SQLTools, REST Client)
- ✅ And many more productivity extensions!

## Quick Start

### Check installed tools:
```bash
node --version
python --version
go version
docker --version
kubectl version --client
terraform version
```

### Useful aliases (already configured):
```bash
ll          # List files in detail
gs          # Git status
gd          # Git diff
gl          # Git log with graph
dps         # Docker ps with nice formatting
```

### Documentation:
- [README.md](../README.md) - Overview and quick start
- [WORKSPACE_SETUP.md](../WORKSPACE_SETUP.md) - Detailed setup guide
- [docs/CLAUDE_INTEGRATION.md](../docs/CLAUDE_INTEGRATION.md) - AI workflow guide
- [docs/SSH_VPS_GUIDE.md](../docs/SSH_VPS_GUIDE.md) - SSH & VPS guide

## Support
- Open an issue on GitHub
- Check the documentation files
- Use GitHub Copilot Chat for instant help

Happy coding! 🎉
EOF

echo "✅ Post-create setup complete!"
echo ""
echo "🎉 Your cloud development environment is ready!"
echo ""
echo "📚 Quick tips:"
echo "  - Check ~/workspace/WELCOME.md for an overview"
echo "  - Use 'll' for detailed file listing"
echo "  - Use 'gs' for git status"
echo "  - Type 'gh copilot' for AI-powered CLI help"
echo ""

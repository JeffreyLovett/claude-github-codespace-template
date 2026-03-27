# DevContainer Configuration

This directory contains the configuration for GitHub Codespaces and VS Code Dev Containers.

## Overview

The devcontainer configuration provides a fully-featured cloud development environment with:

### Languages & Runtimes
- **Node.js (LTS)** - JavaScript/TypeScript development with npm, yarn, and pnpm
- **Python 3.11** - Python development with pip, black, and pylint
- **Go (latest)** - Go development
- **Rust (latest)** - Rust development
- **Java (latest)** - Java development with Maven and Gradle

### DevOps & Cloud Tools
- **Docker** - Container development with Docker-in-Docker support
- **Kubernetes** - kubectl and Helm for Kubernetes management
- **Terraform** - Infrastructure as Code
- **AWS CLI** - Amazon Web Services command-line tools
- **Azure CLI** - Microsoft Azure command-line tools
- **GitHub CLI** - GitHub command-line tools

### Development Tools
- **Git** - Version control with helpful aliases
- **SSH** - Secure Shell with agent auto-start
- **Zsh with Oh My Zsh** - Enhanced shell experience
- **Modern CLI Tools** - bat (better cat), exa (better ls), fzf (fuzzy finder)

### VS Code Extensions

#### AI & Productivity
- GitHub Copilot & Copilot Chat
- IntelliCode & IntelliCode API Examples
- Path Intellisense
- Error Lens

#### Language Support
- Python (with Pylance, Black formatter, isort, debugpy)
- JavaScript/TypeScript (ESLint, Prettier, TypeScript Next)
- Go
- Rust Analyzer
- Java Pack

#### Web Development
- Tailwind CSS IntelliSense
- Auto Rename Tag
- Auto Close Tag
- HTML/CSS support

#### Git & Version Control
- GitLens
- Git Graph
- Git History
- GitHub Pull Requests

#### DevOps
- Docker
- Kubernetes Tools
- Terraform
- AWS Toolkit
- Azure Resource Groups

#### Database & API
- SQLTools
- REST Client
- Thunder Client

#### Documentation & Quality
- Markdown All in One
- Markdown Lint
- Mermaid Diagrams
- Better Comments
- TODO Highlight
- Spell Checker

#### Testing
- Test Explorer
- Jest Runner

#### Collaboration
- Live Share

## Files

### `devcontainer.json`
Main configuration file that defines:
- Base Docker image
- Features to install (languages, tools, etc.)
- VS Code extensions to install
- VS Code settings
- Port forwarding configuration
- Post-creation commands

### `post-create.sh`
Bash script that runs after the container is created. It:
- Configures Git with helpful defaults
- Installs global Node.js packages (yarn, pnpm, typescript, etc.)
- Sets up Python environment (pip, black, pytest, etc.)
- Installs additional CLI tools (bat, exa, fzf)
- Configures Zsh with useful aliases and functions
- Sets up SSH agent auto-start
- Creates workspace directories
- Creates a welcome message

### `update.sh`
Bash script that runs when the container is updated. It:
- Updates package lists
- Upgrades pip
- Updates global Node.js packages
- Checks for configuration updates

## Port Forwarding

Pre-configured ports:
- **3000-3010** - Web applications (React, Express, etc.)
- **5000-5001** - Flask, Django dev servers
- **5432** - PostgreSQL (labeled)
- **5678** - Python debugger
- **6379** - Redis (labeled)
- **8000** - Development servers (labeled)
- **8080** - Alternative HTTP port
- **8888** - Jupyter Notebook
- **9000** - Additional services

## Customization

### Adding More Extensions

Edit `devcontainer.json` and add extension IDs to the `extensions` array:

```json
"extensions": [
  "existing.extension",
  "new.extension-id"
]
```

### Adding More Languages/Tools

Add features to the `features` object in `devcontainer.json`:

```json
"features": {
  "ghcr.io/devcontainers/features/php:1": {
    "version": "latest"
  }
}
```

Browse available features: https://containers.dev/features

### Modifying Post-Create Script

Edit `post-create.sh` to add custom setup steps:

```bash
# Install custom tools
npm install -g my-custom-tool

# Clone repositories
git clone https://github.com/user/repo ~/workspace/repo
```

## Usage

### In GitHub Codespaces

1. Go to your repository on GitHub
2. Click **Code** → **Codespaces**
3. Click **Create codespace on main**
4. Wait for the environment to build (3-5 minutes first time)
5. Start coding!

### In Local VS Code

1. Install the "Dev Containers" extension
2. Open the repository in VS Code
3. Press `F1` and select "Dev Containers: Reopen in Container"
4. Wait for the container to build
5. Start coding!

### Rebuilding the Container

If you modify the devcontainer configuration:

1. Press `F1` (or `Cmd/Ctrl+Shift+P`)
2. Select "Dev Containers: Rebuild Container"
3. Or "Dev Containers: Rebuild Container Without Cache" for a clean build

## Troubleshooting

### Container Build Fails

- Check the build logs for specific errors
- Try rebuilding without cache
- Verify your `devcontainer.json` syntax is valid

### Extension Not Loading

- Check if the extension ID is correct
- Try rebuilding the container
- Some extensions may not be compatible with remote environments

### Script Fails

- Check script permissions: `chmod +x .devcontainer/*.sh`
- Review script logs in the terminal
- Ensure bash syntax is correct

### Port Not Accessible

- Check the PORTS tab in VS Code
- Right-click the port and ensure visibility is set correctly
- Verify the application is actually running on that port

## Best Practices

1. **Version Control**: Commit devcontainer changes to track environment evolution
2. **Documentation**: Document any custom modifications
3. **Testing**: Test devcontainer changes in a new codespace before merging
4. **Minimal Installs**: Only install what you actually need to keep builds fast
5. **Script Idempotency**: Make scripts safe to run multiple times

## Resources

- [Dev Containers Documentation](https://containers.dev/)
- [GitHub Codespaces Docs](https://docs.github.com/en/codespaces)
- [VS Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview)
- [Available Features](https://containers.dev/features)

## Support

For issues with this devcontainer configuration:
1. Check the documentation above
2. Review the build logs
3. Open an issue on the repository
4. Consult GitHub Codespaces documentation

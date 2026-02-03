# PC Tools Collection

Windows 11 system management and optimization tools for power users and developers.

## Philosophy

**"Build tools to do tasks, not just complete tasks"** - Create systematic, repeatable solutions ready for delegation rather than one-time fixes.

## Available Tools

### Browser Manager
**Location:** `browser-manager/`

Automated browser process monitoring and cleanup. Prevents browsers from hogging memory in the background.

**Quick start:**
```powershell
cd browser-manager
.\browser_manager.ps1
```

[Full documentation →](browser-manager/README.md)

### Coming Soon

- **PC Optimizer** - Storage analysis, duplicate finder, system cleanup
- **Process Manager** - Advanced process troubleshooting and resource monitoring
- **Gaming Optimizer** - Performance tuning for gaming PCs
- **Security Audit** - Windows security configuration checker

## Installation

### Download from GitHub

```powershell
# Download ZIP from GitHub
# Extract to: S:\DevDrive\Official\claude-github-codespace-template
# Navigate to pc-tools
cd S:\DevDrive\Official\claude-github-codespace-template\pc-tools
```

## Updating Tools

Pull latest updates from GitHub:

```powershell
cd S:\DevDrive\Official\claude-github-codespace-template
git pull
```

Or download fresh ZIP from GitHub.

## Requirements

- Windows 11
- PowerShell 5.1 or later

## First-Time Setup

Enable PowerShell script execution:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## Project Structure

```
pc-tools/
├── browser-manager/      # Browser memory management
│   ├── browser_manager.ps1
│   └── README.md
└── docs/                 # Documentation
```

## Author

Built for systematic PC management and automation by Jeffrey Lovett / Ugotta Group.
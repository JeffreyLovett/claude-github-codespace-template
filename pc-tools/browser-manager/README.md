# Browser Memory Manager

Automated browser process monitoring and cleanup tool for Windows 11.

## Problem It Solves

Browsers (Opera, Chrome, Edge, etc.) often leave processes running in the background even after you "close" them. These zombie processes can consume gigabytes of RAM, especially with many extensions installed.

## What It Does

- **Analyzes** all running browser processes and memory usage
- **Identifies** zombie processes (running >30min with no CPU activity)
- **Kills** browser processes cleanly
- **Provides** extension diagnostics and optimization tips

## Quick Start

### First Time Setup

```powershell
# Enable script execution (one-time)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Navigate to the tool
cd path\to\repo\pc-tools\browser-manager
```

### Usage

**Analyze current browser memory usage:**
```powershell
.\browser_manager.ps1
```

**Kill all Opera processes:**
```powershell
.\browser_manager.ps1 -Action Kill -Browser Opera
```

**Auto-clean zombie processes:**
```powershell
.\browser_manager.ps1 -Action AutoClean
```

**Check extension guidance:**
```powershell
.\browser_manager.ps1 -Action Extensions
```

## Commands

| Action | Description |
|--------|-------------|
| `Analyze` (default) | Show all running browsers and memory usage |
| `Kill` | Completely close a specific browser |
| `AutoClean` | Kill zombie processes (>30min idle) |
| `Extensions` | Show extension locations and optimization tips |

| Browser | Options |
|---------|---------|
| `All` (default) | Check all browsers |
| `Opera` | Opera only |
| `Chrome` | Chrome only |
| `Edge` | Edge only |
| `Brave` | Brave only |
| `Firefox` | Firefox only |

## Examples

```powershell
# Check what's running
.\browser_manager.ps1

# Kill all Chrome processes
.\browser_manager.ps1 -Action Kill -Browser Chrome

# Clean up zombies automatically
.\browser_manager.ps1 -Action AutoClean

# Get extension help
.\browser_manager.ps1 -Action Extensions
```

## Tips

**For Opera users:**
- Keep only 3-5 essential extensions enabled
- Disable ad blockers you don't use
- Avoid multiple VPN extensions
- Check `opera://extensions` regularly

**Memory Warnings:**
- Yellow (200-500 MB): Moderate usage
- Red (>500 MB): High usage per process
- Total >4GB: Consider restarting browsers

## Troubleshooting

**"Execution policy" error:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**"Script not recognized" error:**
Make sure you're in the correct directory:
```powershell
cd path\to\repo\pc-tools\browser-manager
```

## Version

1.0 - Initial release (Feb 2026)
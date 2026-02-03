#Requires -Version 5.1
<#
.SYNOPSIS
    Browser Memory Manager - Diagnose and clean up browser processes

.DESCRIPTION
    Analyzes running browser processes, identifies memory usage, and provides
    cleanup options. Helps prevent browsers from lingering in background.

.PARAMETER Action
    What to do: Analyze, Kill, or AutoClean

.PARAMETER Browser
    Which browser to target: All, Opera, Chrome, Edge, Brave, Firefox

.EXAMPLE
    .\browser_manager.ps1
    Shows all running browsers and their memory usage

.EXAMPLE
    .\browser_manager.ps1 -Action Kill -Browser Opera
    Completely closes all Opera processes

.EXAMPLE
    .\browser_manager.ps1 -Action AutoClean
    Kills zombie processes (running >30min with no activity)
#>

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("Analyze", "Kill", "AutoClean", "Extensions")]
    [string]$Action = "Analyze",
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("All", "Opera", "Chrome", "Edge", "Brave", "Firefox")]
    [string]$Browser = "All"
)

function Write-ColorOutput {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

function Write-Header {
    param([string]$Text)
    Write-Host "`n"
    Write-ColorOutput "=======================================================" "Cyan"
    Write-ColorOutput " $Text" "Yellow"
    Write-ColorOutput "=======================================================" "Cyan"
}

$BrowserProcesses = @{
    "Opera" = @("opera", "opera_browser", "opera_crashreporter")
    "Chrome" = @("chrome", "GoogleUpdate")
    "Edge" = @("msedge", "MicrosoftEdgeUpdate")
    "Brave" = @("brave")
    "Firefox" = @("firefox")
}

function Get-BrowserProcesses {
    param([string]$BrowserName = "All")
    
    $processes = @()
    
    if ($BrowserName -eq "All") {
        foreach ($browser in $BrowserProcesses.Keys) {
            foreach ($procName in $BrowserProcesses[$browser]) {
                $procs = Get-Process -Name $procName -ErrorAction SilentlyContinue
                if ($procs) {
                    foreach ($p in $procs) {
                        $processes += [PSCustomObject]@{
                            Browser = $browser
                            Name = $p.Name
                            Id = $p.Id
                            MemoryMB = [math]::Round($p.WorkingSet/1MB,2)
                            CPUSec = [math]::Round($p.CPU,2)
                            StartTime = $p.StartTime
                            Runtime = (Get-Date) - $p.StartTime
                        }
                    }
                }
            }
        }
    } else {
        foreach ($procName in $BrowserProcesses[$BrowserName]) {
            $procs = Get-Process -Name $procName -ErrorAction SilentlyContinue
            if ($procs) {
                foreach ($p in $procs) {
                    $processes += [PSCustomObject]@{
                        Browser = $BrowserName
                        Name = $p.Name
                        Id = $p.Id
                        MemoryMB = [math]::Round($p.WorkingSet/1MB,2)
                        CPUSec = [math]::Round($p.CPU,2)
                        StartTime = $p.StartTime
                        Runtime = (Get-Date) - $p.StartTime
                    }
                }
            }
        }
    }
    
    return $processes
}

function Show-BrowserAnalysis {
    Write-Header "Browser Process Analysis"
    
    $allProcesses = Get-BrowserProcesses
    
    if ($allProcesses.Count -eq 0) {
        Write-ColorOutput "`nNo browser processes currently running" "Green"
        return
    }
    
    $grouped = $allProcesses | Group-Object Browser
    
    foreach ($group in $grouped) {
        $browserName = $group.Name
        $processes = $group.Group
        $totalMemory = ($processes | Measure-Object MemoryMB -Sum).Sum
        $processCount = $processes.Count
        
        Write-Host "`n"
        Write-ColorOutput "Browser: $browserName" "Cyan"
        Write-ColorOutput "   Processes: $processCount" "White"
        Write-ColorOutput "   Total Memory: $([math]::Round($totalMemory,2)) MB" "Yellow"
        
        $processes | Sort-Object MemoryMB -Descending | ForEach-Object {
            $memColor = "White"
            if ($_.MemoryMB -gt 500) { $memColor = "Red" }
            elseif ($_.MemoryMB -gt 200) { $memColor = "Yellow" }
            
            $runtime = $_.Runtime.ToString("hh\:mm\:ss")
            Write-Host "      $($_.Name) (PID: $($_.Id))" -ForegroundColor Gray
            Write-Host "         Memory: " -NoNewline
            Write-ColorOutput "$($_.MemoryMB) MB" $memColor
            Write-Host "         Runtime: $runtime" -ForegroundColor Gray
        }
    }
    
    Write-Host "`n"
    $grandTotal = ($allProcesses | Measure-Object MemoryMB -Sum).Sum
    Write-ColorOutput "TOTAL BROWSER MEMORY: $([math]::Round($grandTotal,2)) MB" "Yellow"
    
    if ($grandTotal -gt 4000) {
        Write-ColorOutput "`nWARNING: Browsers using over 4GB RAM!" "Red"
        Write-ColorOutput "   Consider closing unused tabs or restarting browsers" "Yellow"
    }
    
    $zombies = $allProcesses | Where-Object { 
        $_.Runtime.TotalMinutes -gt 30 -and $_.CPUSec -lt 5 
    }
    
    if ($zombies) {
        Write-Host "`n"
        Write-ColorOutput "ZOMBIE PROCESSES DETECTED:" "Red"
        Write-ColorOutput "   These have been running >30min with minimal activity:" "Yellow"
        foreach ($z in $zombies) {
            Write-ColorOutput "   - $($z.Browser) $($z.Name) (PID: $($z.Id)) - $($z.MemoryMB) MB" "Red"
        }
        Write-ColorOutput "`n   Run: .\browser_manager.ps1 -Action AutoClean" "Yellow"
    }
}

function Stop-BrowserProcesses {
    param([string]$BrowserName)
    
    Write-Header "Stopping $BrowserName Browser"
    
    $processes = Get-BrowserProcesses -BrowserName $BrowserName
    
    if ($processes.Count -eq 0) {
        Write-ColorOutput "`nNo $BrowserName processes running" "Green"
        return
    }
    
    Write-ColorOutput "`nFound $($processes.Count) $BrowserName processes" "Yellow"
    
    $confirm = Read-Host "`nKill all $BrowserName processes? (y/n)"
    
    if ($confirm -eq 'y') {
        foreach ($proc in $processes) {
            try {
                Stop-Process -Id $proc.Id -Force -ErrorAction Stop
                Write-ColorOutput "Killed $($proc.Name) (PID: $($proc.Id))" "Green"
            } catch {
                Write-ColorOutput "Failed to kill $($proc.Name) (PID: $($proc.Id))" "Red"
            }
        }
        
        Write-ColorOutput "`nBrowser cleanup complete" "Green"
    } else {
        Write-ColorOutput "`nOperation cancelled" "Gray"
    }
}

function Invoke-AutoClean {
    Write-Header "Auto-Clean Background Processes"
    
    $allProcesses = Get-BrowserProcesses
    
    $zombies = $allProcesses | Where-Object { 
        $_.Runtime.TotalMinutes -gt 30 -and $_.CPUSec -lt 5 
    }
    
    if ($zombies.Count -eq 0) {
        Write-ColorOutput "`nNo zombie browser processes detected" "Green"
        return
    }
    
    Write-ColorOutput "`nFound $($zombies.Count) zombie processes:" "Yellow"
    foreach ($z in $zombies) {
        Write-ColorOutput "  - $($z.Browser) $($z.Name) - $($z.MemoryMB) MB - Running $([math]::Round($z.Runtime.TotalMinutes,0)) minutes" "Gray"
    }
    
    Write-ColorOutput "`nThese processes have been idle for >30 minutes" "Yellow"
    $confirm = Read-Host "Kill zombie processes? (y/n)"
    
    if ($confirm -eq 'y') {
        $killed = 0
        foreach ($proc in $zombies) {
            try {
                Stop-Process -Id $proc.Id -Force -ErrorAction Stop
                Write-ColorOutput "Killed $($proc.Name)" "Green"
                $killed++
            } catch {
                Write-ColorOutput "Failed to kill $($proc.Name)" "Red"
            }
        }
        
        $freedMemory = ($zombies | Measure-Object MemoryMB -Sum).Sum
        Write-ColorOutput "`nCleanup complete: Killed $killed processes, freed $([math]::Round($freedMemory,2)) MB" "Green"
    } else {
        Write-ColorOutput "`nOperation cancelled" "Gray"
    }
}

function Show-ExtensionGuidance {
    Write-Header "Browser Extension Diagnostics"
    
    Write-ColorOutput "`nExtensions can consume significant memory even when inactive.`n" "Yellow"
    
    Write-ColorOutput "OPERA EXTENSIONS LOCATION:" "Cyan"
    Write-ColorOutput "   $env:APPDATA\Opera Software\Opera Stable\Extensions`n" "White"
    
    $operaExtPath = "$env:APPDATA\Opera Software\Opera Stable\Extensions"
    
    if (Test-Path $operaExtPath) {
        $extensions = Get-ChildItem $operaExtPath -Directory
        Write-ColorOutput "Found $($extensions.Count) installed extensions`n" "Yellow"
        
        Write-ColorOutput "To identify memory hogs:" "Cyan"
        Write-ColorOutput "1. Open Opera and go to: opera://extensions" "White"
        Write-ColorOutput "2. Click 'Details' on each extension" "White"
        Write-ColorOutput "3. Disable extensions you don't use daily`n" "White"
        
        Write-ColorOutput "COMMON MEMORY-HOG EXTENSIONS:" "Red"
        Write-ColorOutput "  - Multiple ad blockers" "Yellow"
        Write-ColorOutput "  - Video downloaders" "Yellow"
        Write-ColorOutput "  - VPN extensions" "Yellow"
        Write-ColorOutput "  - Background productivity tools" "Yellow"
        Write-ColorOutput "`nTIP: Keep only 3-5 essential extensions enabled" "Green"
    } else {
        Write-ColorOutput "Opera extensions folder not found" "Red"
    }
}

Clear-Host

Write-ColorOutput "=======================================================" "Cyan"
Write-ColorOutput "     BROWSER MEMORY MANAGER v1.0" "Cyan"
Write-ColorOutput "=======================================================" "Cyan"

switch ($Action) {
    "Analyze" { Show-BrowserAnalysis }
    "Kill" { Stop-BrowserProcesses -BrowserName $Browser }
    "AutoClean" { Invoke-AutoClean }
    "Extensions" { Show-ExtensionGuidance }
}

Write-Host "`n"
# 🔐 SSH & VPS Connection Guide

**How to securely connect to remote servers from your GitHub Codespace.**

---

## 🎯 Overview

This guide covers:
- SSH key generation and management
- Connecting to VPS from Codespace
- Secure file transfer (SCP/RSYNC)
- Managing multiple server connections
- Troubleshooting common issues

---

## 🔑 Part 1: SSH Key Setup

### Generate SSH Key (First Time)

```bash
# In Codespace terminal

# Generate ED25519 key (recommended - most secure)
ssh-keygen -t ed25519 -C "your.email@example.com"

# Alternative: RSA 4096 (for older servers)
ssh-keygen -t rsa -b 4096 -C "your.email@example.com"

# When prompted:
# File: /home/codespace/.ssh/id_ed25519 (press Enter for default)
# Passphrase: STRONGLY RECOMMENDED (store in password manager)
```

**Why passphrase?**
- Protects key if Codespace is compromised
- Required for high-security environments
- Can use ssh-agent to avoid re-entering

---

### Start SSH Agent

```bash
# Start agent
eval "$(ssh-agent -s)"

# Add key to agent (enter passphrase once)
ssh-add ~/.ssh/id_ed25519

# Verify key is loaded
ssh-add -l
```

**Pro Tip:** Add to `.bashrc` for auto-start:
```bash
echo 'eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519 2>/dev/null' >> ~/.bashrc
```

---

## 🚀 Part 2: Add Key to Remote Server

### Method 1: Automated (If Password Access Available)

```bash
ssh-copy-id user@your-server.com

# Example:
ssh-copy-id root@203.0.113.42
```

---

### Method 2: Manual Copy

**Step 1: Display public key**
```bash
cat ~/.ssh/id_ed25519.pub
```

**Step 2: Copy the output** (starts with `ssh-ed25519 AAAA...`)

**Step 3: Add to server**
```bash
# SSH to server with password
ssh user@your-server.com

# Create .ssh directory (if doesn't exist)
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Add public key
echo "ssh-ed25519 AAAA... your.email@example.com" >> ~/.ssh/authorized_keys

# Set correct permissions
chmod 600 ~/.ssh/authorized_keys

# Exit server
exit
```

---

### Method 3: Via Hosting Panel

**For cPanel/Plesk/DigitalOcean/AWS:**
1. Copy public key: `cat ~/.ssh/id_ed25519.pub`
2. Go to server control panel
3. Find **SSH Keys** section
4. Paste public key
5. Save

---

## 🌐 Part 3: Connect to Remote Server

### Basic Connection

```bash
# Standard connection
ssh user@your-server.com

# With specific key
ssh -i ~/.ssh/id_ed25519 user@your-server.com

# With custom port
ssh -p 2222 user@your-server.com

# Verbose output (for debugging)
ssh -v user@your-server.com
```

---

### Create SSH Config (Recommended)

**Edit config file:**
```bash
nano ~/.ssh/config
```

**Add server aliases:**
```ssh-config
# Production Server
Host prod
    HostName 203.0.113.42
    User deploy
    Port 22
    IdentityFile ~/.ssh/id_ed25519
    ServerAliveInterval 60

# Staging Server
Host staging
    HostName staging.example.com
    User ubuntu
    Port 2222
    IdentityFile ~/.ssh/id_ed25519

# Personal VPS
Host myvps
    HostName myvps.com
    User root
    IdentityFile ~/.ssh/id_rsa
    ForwardAgent yes
```

**Set permissions:**
```bash
chmod 600 ~/.ssh/config
```

**Now connect easily:**
```bash
ssh prod      # Instead of ssh deploy@203.0.113.42
ssh staging
ssh myvps
```

---

## 📁 Part 4: File Transfer

### SCP (Secure Copy)

**Upload file to server:**
```bash
# Single file
scp localfile.txt user@server.com:/remote/path/

# Directory (recursive)
scp -r ./local-folder user@server.com:/remote/path/

# Using config alias
scp myapp.zip prod:/var/www/
```

**Download from server:**
```bash
# Single file
scp user@server.com:/remote/file.txt ./local-path/

# Directory
scp -r user@server.com:/var/logs ./local-logs/

# Using alias
scp prod:/var/www/config.json ./
```

---

### RSYNC (Better for Large Transfers)

**Upload with progress:**
```bash
rsync -avz --progress ./local-folder/ user@server.com:/remote/path/

# Flags:
# -a: archive mode (preserves permissions)
# -v: verbose
# -z: compress during transfer
# --progress: show progress bar
```

**Download with exclude:**
```bash
rsync -avz --progress --exclude 'node_modules' \
  user@server.com:/var/www/myapp/ ./myapp-backup/
```

**Sync with delete (CAREFUL!):**
```bash
# Deletes files on destination that don't exist in source
rsync -avz --delete ./local/ user@server.com:/remote/
```

---

## 🛠️ Part 5: Common Workflows

### Workflow 1: Deploy to VPS

```bash
# 1. Build in Codespace
npm run build

# 2. Sync to server
rsync -avz --exclude 'node_modules' \
  ./dist/ prod:/var/www/myapp/

# 3. Restart service on server
ssh prod 'sudo systemctl restart myapp'
```

---

### Workflow 2: Database Backup

```bash
# 1. Dump database on server and download
ssh prod 'pg_dump mydb > /tmp/backup.sql'
scp prod:/tmp/backup.sql ./backups/$(date +%Y%m%d).sql

# 2. Clean up
ssh prod 'rm /tmp/backup.sql'
```

---

### Workflow 3: Remote Code Editing

**Option A: VS Code Remote SSH**
1. Install "Remote - SSH" extension (already in devcontainer)
2. Press F1 → "Remote-SSH: Connect to Host"
3. Enter `user@server.com` or use config alias
4. Edit files directly on server

**Option B: Mount Remote Filesystem (SSHFS)**
```bash
# Install sshfs (if not present)
sudo apt-get update && sudo apt-get install -y sshfs

# Mount remote directory
mkdir ~/remote-server
sshfs user@server.com:/var/www ~/remote-server

# Work with files locally
cd ~/remote-server
# Edit files...

# Unmount when done
fusermount -u ~/remote-server
```

---

## 🔐 Part 6: Security Best Practices

### Server-Side Hardening

**Edit SSH daemon config on server:**
```bash
sudo nano /etc/ssh/sshd_config
```

**Recommended settings:**
```bash
# Disable password authentication (keys only)
PasswordAuthentication no

# Disable root login
PermitRootLogin no

# Change default port
Port 2222

# Allow only specific users
AllowUsers deploy myuser

# Use SSH Protocol 2
Protocol 2
```

**Restart SSH service:**
```bash
sudo systemctl restart sshd
```

---

### Codespace-Side Best Practices

✅ **DO:**
- Use passphrase-protected keys
- Store keys only in Codespace (never commit)
- Use ssh-agent to avoid repeated passphrase entry
- Rotate keys every 6-12 months
- Use different keys for different servers (if ultra-secure)

❌ **DON'T:**
- Share private keys via email/chat
- Use same key for personal and work servers
- Store keys in cloud storage
- Disable StrictHostKeyChecking globally

---

### Key Rotation

**Every 6-12 months:**
```bash
# 1. Generate new key
ssh-keygen -t ed25519 -C "your.email@example.com" -f ~/.ssh/id_ed25519_new

# 2. Add to servers
ssh-copy-id -i ~/.ssh/id_ed25519_new user@server.com

# 3. Test new key
ssh -i ~/.ssh/id_ed25519_new user@server.com

# 4. Remove old key from server
ssh user@server.com
nano ~/.ssh/authorized_keys
# Delete old key line, save

# 5. Replace local key
mv ~/.ssh/id_ed25519_new ~/.ssh/id_ed25519
mv ~/.ssh/id_ed25519_new.pub ~/.ssh/id_ed25519.pub

# 6. Update ssh-agent
ssh-add -D  # Remove all keys
ssh-add ~/.ssh/id_ed25519
```

---

## 🚨 Troubleshooting

### Issue 1: "Permission denied (publickey)"

**Diagnose:**
```bash
ssh -v user@server.com
```

**Common causes:**
1. Key not added to server's `authorized_keys`
2. Wrong permissions on server:
   ```bash
   ssh user@server.com
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/authorized_keys
   ```
3. Key not loaded in agent:
   ```bash
   ssh-add -l  # Check
   ssh-add ~/.ssh/id_ed25519  # Add
   ```

---

### Issue 2: "Connection timed out"

**Causes:**
- Wrong IP/hostname
- Firewall blocking port 22
- Server down

**Debug:**
```bash
# Test connectivity
ping server.com

# Check if SSH port is open
nc -zv server.com 22

# Try different port
ssh -p 2222 user@server.com
```

---

### Issue 3: "Host key verification failed"

**Cause:** Server's SSH key changed (reinstall, security breach, etc.)

**Fix (if you trust the server):**
```bash
ssh-keygen -R server.com  # Remove old key
ssh user@server.com       # Accept new key
```

---

### Issue 4: Key works locally but not in Codespace

**Cause:** Key only on local machine

**Fix:**
```bash
# Generate new key IN Codespace
ssh-keygen -t ed25519 -C "codespace@github"

# Add to server
ssh-copy-id user@server.com
```

---

## 📊 SSH Config Examples

### Multi-Environment Setup

```ssh-config
# ~/.ssh/config

# Jump host (bastion)
Host bastion
    HostName bastion.company.com
    User admin
    IdentityFile ~/.ssh/company_key

# Production (via bastion)
Host prod
    HostName 10.0.1.50
    User deploy
    ProxyJump bastion
    IdentityFile ~/.ssh/prod_key

# Staging (direct)
Host staging
    HostName staging.company.com
    User deploy
    IdentityFile ~/.ssh/staging_key

# Development
Host dev
    HostName dev.company.com
    User ubuntu
    IdentityFile ~/.ssh/dev_key
    LocalForward 5432 localhost:5432  # Forward PostgreSQL
```

---

### GitHub/GitLab SSH

```ssh-config
# GitHub
Host github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    AddKeysToAgent yes

# GitLab
Host gitlab.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    AddKeysToAgent yes
```

---

## 🎓 Advanced Techniques

### Port Forwarding

**Forward remote port to local:**
```bash
# Access remote MySQL locally
ssh -L 3306:localhost:3306 user@server.com
# Now connect to localhost:3306 in Codespace
```

**Forward local port to remote:**
```bash
# Share Codespace port 3000 with server
ssh -R 8080:localhost:3000 user@server.com
# Server can now access your Codespace app on port 8080
```

---

### SOCKS Proxy

```bash
# Use server as proxy
ssh -D 9090 user@server.com

# Configure browser/app to use localhost:9090 as SOCKS5 proxy
# Traffic now routes through server
```

---

### Jump Hosts

```bash
# Connect through intermediate server
ssh -J user@bastion user@internal-server

# Or in config:
# Host internal
#     ProxyJump bastion
```

---

## ✅ Quick Reference

```bash
# Generate key
ssh-keygen -t ed25519 -C "email@example.com"

# Copy key to server
ssh-copy-id user@server.com

# Connect
ssh user@server.com

# Copy file to server
scp file.txt user@server:/path/

# Copy from server
scp user@server:/path/file.txt ./

# Sync folder
rsync -avz ./folder/ user@server:/path/

# Edit remote files
code --remote ssh-remote+user@server /path/to/project
```

---

**WIZARD CHECK:** [✔] Secure setup [✔] Best practices [✔] Production-ready
#!/bin/bash
# Update script for GitHub Codespaces
# This script runs when the container is rebuilt or updated

set -e

echo "🔄 Updating development environment..."

# Update package lists
echo "📦 Updating package lists..."
sudo apt-get update -qq

# Upgrade pip
echo "🐍 Upgrading pip..."
pip install --upgrade pip --quiet

# Update global Node.js packages
echo "📦 Updating global Node.js packages..."
npm update -g

# Pull latest dotfiles or configurations if any
echo "⚙️  Checking for configuration updates..."

echo "✅ Update complete!"

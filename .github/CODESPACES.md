# GitHub Codespaces Configuration

# This file configures GitHub Codespaces behavior for this repository

# Note: GitHub Codespaces primarily uses .devcontainer/devcontainer.json
# for configuration. This file documents recommended settings for repository
# owners to configure in GitHub Settings → Codespaces.

## Recommended Codespaces Settings (Configure in GitHub UI)

### Prebuild Configuration
# Enable prebuilds to speed up codespace creation
# Go to: Repository Settings → Codespaces → Prebuild configuration
# - Trigger: On push to main/master/develop branches
# - Schedule: Weekly (Sunday midnight)

### Secrets
# Configure repository secrets for use in Codespaces
# Go to: Repository Settings → Secrets and variables → Codespaces
# Recommended secrets:
# - DATABASE_URL (for database connections)
# - API_KEY (for external APIs)
# - AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY (for AWS)
# - AZURE_CREDENTIALS (for Azure)
# - DOCKER_HUB_TOKEN (for Docker Hub)

### Machine Types
# Available machine types:
# - 2-core, 8 GB RAM, 32 GB storage (Basic)
# - 4-core, 16 GB RAM, 32 GB storage (Standard)  
# - 8-core, 32 GB RAM, 64 GB storage (Large)
# - 16-core, 64 GB RAM, 128 GB storage (X-Large)
# - 32-core, 128 GB RAM, 256 GB storage (XX-Large)

### Timeouts
# Recommended settings:
# - Default retention: 30 days
# - Idle timeout: 30 minutes
# - Max retention: 60 days

## Environment Variables

# These can be set via GitHub Codespaces Secrets or in devcontainer.json

### Development
# NODE_ENV=development
# DEBUG=*
# LOG_LEVEL=debug

### Cloud Providers
# AWS_REGION=us-east-1
# AZURE_LOCATION=eastus
# GCP_PROJECT=my-project

### Database
# DATABASE_URL=postgresql://user:pass@host:5432/dbname
# REDIS_URL=redis://localhost:6379

### API Keys (Set as secrets!)
# API_KEY=your-api-key
# STRIPE_API_KEY=your-stripe-key
# SENDGRID_API_KEY=your-sendgrid-key

## Resources

- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)
- [Devcontainer Specification](https://containers.dev/)
- [Prebuild Configuration](https://docs.github.com/en/codespaces/prebuilding-your-codespaces)
- [Managing Secrets](https://docs.github.com/en/codespaces/managing-your-codespaces/managing-encrypted-secrets-for-your-codespaces)

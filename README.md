# Basic SSH Config

Personal environment setup for remote Linux servers and containers.

## Purpose

This repository contains a minimal configuration set for quickly setting up consistent development environments across various remote systems including:

- Company servers
- AWS EC2 instances
- Home lab machines
- Private network hosts
- Docker containers

## Contents

- **Makefile** - Idempotent installation of core tools and Neovim with LazyVim
- **.bashrc** - Shell environment configuration with history, prompt, and aliases

## Quick Start

```bash
git clone https://github.com/Raina-Hardik/basic-ssh-config.git
cd basic-ssh-config
make install
source ~/.bashrc
```

## Non-Root User Support

✅ **Fully compatible with non-root users!** Tools are installed and managed by `mise` in user-local directories (`~/.local/share/mise`, `~/.local/bin`) without requiring sudo.

**Docker Example:**

```dockerfile
# Create and use non-root user
RUN useradd -m -s /bin/bash devuser
USER devuser

# Installation works without sudo
WORKDIR /home/devuser
RUN git clone https://github.com/Raina-Hardik/basic-ssh-config.git && \
    cd basic-ssh-config && \
    make install
```

This makes the setup ideal for:

- Containerized environments
- Remote systems with limited privileges
- Shared multi-user systems
- CI/CD pipelines

## Installation Targets

```bash
make install      # Full installation (core + dev + git)
make install-all  # Install everything including advanced tools
make tools        # Core CLI tools via mise
make mise         # Install mise and all tools in .mise.toml
make nvim         # Neovim via mise + LazyVim config
make go           # Go runtime via mise
make rust         # Rust toolchain via mise
make uv-tools     # Python tooling via mise/uv
make lazydocker   # lazydocker via mise
```

## Tools Installed

### CLI Utilities

- **ripgrep** (`rg`) - Fast grep alternative
- **fd** - Fast find alternative
- **bat** - Cat with syntax highlighting
- **fzf** - Fuzzy finder
- **duf** - Disk usage utility
- **direnv** - Environment variable manager
- **just** - Command runner
- **dotbot** - Dotfile manager (YAML-driven)

### Development Tools

- **Neovim** (v0.11.5) with LazyVim configuration
- **mise** - Runtime/version manager for language toolchains
- **Go** (v1.26.0) - Managed via `mise`
- **Rust** - Managed via `mise`
- **Python + uv** - Managed via `mise` for language tooling installs
- **lazydocker** - Lazy Docker UI managed by `mise`
  - ruff (linter/formatter)
  - pyright (type checker)
  - debugpy (debugger)
  - black (formatter)

All tools are installed to user-local `mise` directories without requiring sudo access.

## Architecture Support

Automatically detects and installs x86_64 or ARM64 binaries as appropriate.

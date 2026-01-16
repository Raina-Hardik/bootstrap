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

## Installation Targets

```bash
make install   # Full installation (tools, go, rust, bashrc, uv-tools, nvim, lazydocker)
make tools     # CLI utilities only (rg, fd, bat, fzf, duf, direnv, just)
make nvim      # Neovim + LazyVim + ML config
make bashrc    # Copy .bashrc to home directory
make go        # Install Go toolchain
make rust      # Install Rust toolchain (cargo)
make uv-tools  # Install Python tools via uv (ruff, pyright, debugpy, black)
make lazydocker # Install lazydocker (requires Go)
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

### Development Tools
- **Neovim** (v0.11.5) with LazyVim configuration
- **Go** (v1.25.5) - Go programming language
- **Rust** - Rust toolchain via rustup (cargo)
- **lazydocker** - Lazy Docker UI (requires Go)
- **uv** - Python package and tool installer
  - ruff (linter/formatter)
  - pyright (type checker)
  - debugpy (debugger)
  - black (formatter)

All tools are installed to `~/.bin` or `~/.local` without requiring sudo access.

## Architecture Support

Automatically detects and installs x86_64 or ARM64 binaries as appropriate.

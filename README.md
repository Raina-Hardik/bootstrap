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
make install  # Full installation (tools, nvim, bashrc)
make tools    # CLI utilities only (rg, fd, bat, fzf, etc.)
make nvim     # Neovim + LazyVim + ML config
make bashrc   # Symlink .bashrc to home directory
```

## Tools Installed

- Neovim with LazyVim
- ripgrep, fd, bat, fzf
- duf, direnv, just

All tools are installed to `~/.bin` without requiring sudo access.

## Architecture Support

Automatically detects and installs x86_64 or ARM64 binaries as appropriate.

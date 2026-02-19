# basic-ssh-config

Fast, repeatable development environment setup for Linux servers, containers, and remote systems.

## Core Principle

✅ **No sudo required.** All tools install to user-local directories using [mise](https://mise.jdx.dev).

## Quick Start

```bash
git clone https://github.com/Raina-Hardik/basic-ssh-config.git
cd basic-ssh-config
make install
source ~/.bashrc
```

Or with justfile:

```bash
just install
source ~/.bashrc
```

## What Gets Installed

| Category | Tools |
|----------|-------|
| **CLI Tools** | ripgrep, fd, bat, duf, just, zoxide, eza, git-delta, btop, television, diskonaut |
| **Languages** | node, go, rust (via mise) |
| **Extras** | fzf, opencode |
| **Development** | Neovim (AstroNvim), uv (Python), cargo, go install tools, git configuration |
| **Optional** | starship, zsh (manual targets) |

Run `make help` or `just help` for all available targets.

## Why This Works

- **mise manages runtimes** — no manual PATH plumbing, explicit version control
- **Language-native package managers** — cargo, uv, go install handle their own caching
- **Idempotent** — safe to run multiple times
- **Shell-agnostic** — detects and configures bash, zsh, or fish
- **Docker-friendly** — works as non-root user
- **No system dependencies** — AppImage for Neovim, user-space installs only

## Files

- `Makefile` — Installation orchestration (bash/make)
- `justfile` — Alternative task runner (bash/just)
- `.bashrc` — Shell environment
- `.zshrc` — Zsh configuration
- `deprecated/` — Archived old Makefiles for reference

## Supported Platforms

Linux x86_64 and ARM64. Tested on Ubuntu, RHEL, Manjaro, Arch(Omarchy, Arch, Archcraft) should work on any glibc-based distro.

Not for macOS or systems requiring sudo.

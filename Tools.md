# Consolidated Tools Reference

This document consolidates tools from the Makefile (core installation), advanced tools evaluation, and new LLM agent recommendations.

**Project Context**: Minimal, idempotent setup for consistent dev environments across remote systems (servers, containers, home lab).

---

## Table of Contents

- [Core Tools (Makefile)](#core-tools-makefile)
- [Advanced Evaluation (Tier 1-2)](#advanced-evaluation-tier-1-2)
- [LLM Agent Tools](#llm-agent-tools)
- [Rejected Tools](#rejected-tools)

---

# CORE TOOLS (MAKEFILE)

These tools are included in the primary installation via `make install`.

## File & Text Processing

### 1. Ripgrep (rg) - Fast Text Search

**Purpose**: Ultra-fast grep replacement with recursive directory search by default.

#### Installation

```bash
# Already handled by Makefile
make tools
```

#### Uninstall

```bash
rm ~/.bin/rg
```

#### Comments

- **Priority**: 5/5 - Essential for code searching and text processing
- **Easy Config**: Works out of the box, respects .gitignore
- **Verdict**: **CORE** - Always installed

---

### 2. fd - File Finder

**Purpose**: Fast and intuitive alternative to find command.

#### Installation

```bash
# Already handled by Makefile
make tools
```

#### Uninstall

```bash
rm ~/.bin/fd
```

#### Comments

- **Priority**: 5/5 - Essential file discovery tool
- **Easy Config**: Intuitive syntax, respects .gitignore
- **Verdict**: **CORE** - Always installed

---

### 3. bat - Syntax Highlighting Pager

**Purpose**: Cat replacement with syntax highlighting and line numbering.

#### Installation

```bash
# Already handled by Makefile
make tools
```

#### Uninstall

```bash
rm ~/.bin/bat
```

#### Comments

- **Priority**: 5/5 - Makes reading code readable
- **Easy Config**: Automatic language detection, Catppuccin theme included
- **Verdict**: **CORE** - Always installed

---

### 4. duf - Disk Usage Formatter

**Purpose**: Modern du replacement showing disk usage with colors.

#### Installation

```bash
# Already handled by Makefile
make tools
```

#### Uninstall

```bash
rm ~/.bin/duf
```

#### Comments

- **Priority**: 4/5 - Better than du for quick disk visibility
- **Easy Config**: Minimal, just run it
- **Verdict**: **CORE** - Always installed

---

## Shell & Environment

### 5. direnv - Directory Environment Manager

**Purpose**: Load/unload environment variables per project directory.

#### Installation

```bash
# Already handled by Makefile
make tools
```

#### Uninstall

```bash
rm ~/.bin/direnv
```

#### Comments

- **Priority**: 4/5 - Essential for managing project-specific environments
- **Easy Config**: .envrc files, auto-loads when entering directory
- **Verdict**: **CORE** - Always installed

---

### 6. zoxide - Smart Directory Navigation

**Purpose**: Fast directory changing with learning algorithm (smarter cd).

#### Installation

```bash
# Already handled by Makefile
make tools
```

#### Uninstall

```bash
rm ~/.bin/zoxide
```

#### Comments

- **Priority**: 4/5 - Huge QoL improvement for navigation
- **Easy Config**: Hook into shell (in .bashrc)
- **Verdict**: **CORE** - Always installed

---

## Task Running & Process Management

### 7. just - Command Runner (Makefile Alternative)

**Purpose**: Modern Makefile alternative with task definitions and recipe running.

#### Installation

```bash
# Already handled by Makefile
make tools
```

#### Uninstall

```bash
rm ~/.bin/just
```

#### Comments

- **Priority**: 4/5 - Great for project task automation
- **Easy Config**: justfile syntax (similar to Makefile)
- **Verdict**: **CORE** - Always installed

---

### 8. tmux - Terminal Multiplexer

**Purpose**: Terminal session manager with split panes, windows, and persistence.

#### Installation

```bash
# Already handled by Makefile
make tools
```

#### Uninstall

```bash
rm ~/.bin/tmux
```

#### Comments

- **Priority**: 5/5 - Essential for remote work, SSH sessions, and terminal organization
- **Easy Config**: Minimal config in ~/.config/tmux/tmux.conf
- **Verdict**: **CORE** - Always installed

---

## Utilities

### 9. fzf - Fuzzy Finder

**Purpose**: Command-line fuzzy search with integration for shell history, file search, etc.

#### Installation

```bash
# Already handled by Makefile
make tools
```

#### Uninstall

```bash
rm ~/.bin/fzf
# Also remove cloned repo if desired:
rm -rf ~/.local/fzf
```

#### Comments

- **Priority**: 5/5 - Foundational for interactive workflows
- **Easy Config**: Keybindings in shell, respects FZF_DEFAULT_COMMAND
- **Verdict**: **CORE** - Always installed

---

### 10. btop - System Monitor

**Purpose**: Top replacement with interactive process monitoring and resource visualization.

#### Installation

```bash
# Already handled by Makefile
make tools
```

#### Uninstall

```bash
rm ~/.bin/btop
```

#### Comments

- **Priority**: 4/5 - Much better than top for system monitoring
- **Easy Config**: Settings file in ~/.config/btop, mouse support
- **Verdict**: **CORE** - Always installed

---

### 11. jq - JSON Processor

**Purpose**: Command-line JSON query and transformation tool.

#### Installation

```bash
# Already handled by Makefile
make tools
```

#### Uninstall

```bash
rm ~/.bin/jq
```

#### Comments

- **Priority**: 5/5 - Essential for JSON data processing
- **Easy Config**: Query syntax, powerful but steep learning curve
- **Verdict**: **CORE** - Always installed

---

### 12. GitHub CLI (gh) - Git Management

**Purpose**: Official GitHub command-line interface for managing repos, PRs, issues.

#### Installation

```bash
# Already handled by Makefile
make tools
```

#### Uninstall

```bash
rm ~/.bin/gh
```

#### Comments

- **Priority**: 4/5 - Essential if using GitHub for version control
- **Easy Config**: gh auth login for authentication
- **Verdict**: **CORE** - Always installed

---

### 13. stow - Dotfile Manager

**Purpose**: GNU Stow symlink-based dotfile management tool.

#### Installation

```bash
# Already handled by Makefile
make tools
```

#### Uninstall

```bash
rm ~/.bin/stow
```

#### Comments

- **Priority**: 3/5 - Useful for managing configuration files
- **Easy Config**: Straightforward symlink approach
- **Verdict**: **CORE** - Always installed

---

## Development Environment

### 14. Neovim (nvim) - Modern Text Editor

**Purpose**: Modern vim-based text editor with LSP, treesitter, and plugin ecosystem.

#### Installation

```bash
# Already handled by Makefile
make nvim
```

#### Uninstall

```bash
rm ~/.bin/nvim
rm -rf ~/.local/nvim
```

#### Comments

- **Priority**: 5/5 - Primary editor for terminal-based development
- **Easy Config**: LazyVim starter config included, extensive customization
- **Verdict**: **CORE** - Always installed

---

### 15. Go - Programming Language

**Purpose**: Compiled language runtime for building and running Go programs.

#### Installation

```bash
# Already handled by Makefile
make go
```

#### Uninstall

```bash
rm -rf ~/.local/go
```

#### Comments

- **Priority**: 4/5 - Needed for Go-based tools and development
- **Easy Config**: GOPATH setup automatic, workspace structure needed
- **Verdict**: **CORE** - Always installed

---

### 16. Rust / Cargo - Programming Language

**Purpose**: Rust compiler and package manager for building Rust programs.

#### Installation

```bash
# Already handled by Makefile
make rust
```

#### Uninstall

```bash
# Uninstall rustup (this removes Rust and Cargo)
rustup self uninstall
```

#### Comments

- **Priority**: 4/5 - Required for Rust tools and development
- **Easy Config**: Automatic installation via rustup
- **Verdict**: **CORE** - Always installed

---

## Python Development Tools (via uv)

### 17. Ruff - Python Linter & Formatter

**Purpose**: Fast Python linter and formatter combining multiple tools' functionality.

#### Installation

```bash
# Already handled by Makefile
make uv-tools
```

#### Uninstall

```bash
uv tool uninstall ruff
```

#### Comments

- **Priority**: 5/5 - Essential Python code quality tool
- **Easy Config**: pyproject.toml configuration
- **Verdict**: **CORE** - Always installed

---

### 18. Pyright - Python Type Checker

**Purpose**: Fast Python static type checker and language server.

#### Installation

```bash
# Already handled by Makefile
make uv-tools
```

#### Uninstall

```bash
uv tool uninstall pyright
```

#### Comments

- **Priority**: 5/5 - Essential for Python type safety
- **Easy Config**: pyrightconfig.json for settings
- **Verdict**: **CORE** - Always installed

---

### 19. debugpy - Python Debugger

**Purpose**: Python debugger for IDE/editor integration and debugging.

#### Installation

```bash
# Already handled by Makefile
make uv-tools
```

#### Uninstall

```bash
uv tool uninstall debugpy
```

#### Comments

- **Priority**: 4/5 - Important for debugging Python code
- **Easy Config**: Neovim integration handled automatically
- **Verdict**: **CORE** - Always installed

---

### 20. black - Python Code Formatter

**Purpose**: Opinionated Python code formatter (with no configuration).

#### Installation

```bash
# Already handled by Makefile
make uv-tools
```

#### Uninstall

```bash
uv tool uninstall black
```

#### Comments

- **Priority**: 4/5 - Code formatting best practice
- **Easy Config**: Works with defaults, minimal configuration
- **Verdict**: **CORE** - Always installed

---

## Utilities (Python)

### 21. httpie - HTTP Client

**Purpose**: Command-line HTTP client with intuitive interface and JSON support.

#### Installation

```bash
# Already handled by Makefile
make uv-tools
```

#### Uninstall

```bash
uv tool uninstall httpie
```

#### Comments

- **Priority**: 3/5 - Nice alternative to curl for API testing
- **Easy Config**: Config file for defaults
- **Verdict**: **CORE** - Always installed

---

### 22. twg - Terminal Web Gallery

**Purpose**: View images in terminal from command line.

#### Installation

```bash
# Already handled by Makefile
make uv-tools
```

#### Uninstall

```bash
uv tool uninstall twg
```

#### Comments

- **Priority**: 2/5 - Niche use case for image viewing in terminal
- **Easy Config**: No configuration needed
- **Verdict**: **OPTIONAL** - Install if image viewing needed

---

## Data Processing (Go)

### 23. yq - YAML Processor

**Purpose**: Command-line YAML query and transformation tool (like jq for YAML).

#### Installation

```bash
# Already handled by Makefile
make yq
```

#### Uninstall

```bash
rm ~/.bin/yq
```

#### Comments

- **Priority**: 4/5 - Essential for YAML data processing
- **Easy Config**: Query syntax similar to jq
- **Verdict**: **CORE** - Always installed

---

## Additional Go Tools

### 24. lazymake - Makefile Task Runner UI

**Purpose**: Interactive TUI for running tasks defined in Makefile/justfile.

#### Installation

```bash
# Already handled by Makefile
make go-tools
```

#### Uninstall

```bash
rm ~/.bin/lazymake
```

#### Comments

- **Priority**: 2/5 - Convenience tool for task selection
- **Easy Config**: No config needed, discovers Makefile automatically
- **Verdict**: **OPTIONAL** - Nice-to-have for interactive task running

---

### 25. nap - Clipboard Manager

**Purpose**: Simple clipboard manager for CLI.

#### Installation

```bash
# Already handled by Makefile
make go-tools
```

#### Uninstall

```bash
rm ~/.bin/nap
```

#### Comments

- **Priority**: 2/5 - Minimal clipboard management
- **Easy Config**: No configuration needed
- **Verdict**: **OPTIONAL** - Use if clipboard management needed

---

### 26. deletor - Mass File Deletion

**Purpose**: Interactive file deletion utility with confirmation.

#### Installation

```bash
# Already handled by Makefile
make go-tools
```

#### Uninstall

```bash
rm ~/.bin/deletor
```

#### Comments

- **Priority**: 1/5 - Niche use case
- **Easy Config**: No configuration needed
- **Verdict**: **OPTIONAL** - Rarely needed

---

## Docker Tools

### 27. lazydocker - Docker TUI Manager

**Purpose**: Lazy-style interactive Docker/Docker-Compose manager in terminal.

#### Installation

```bash
# Already handled by Makefile
make lazydocker
```

#### Uninstall

```bash
rm ~/.bin/lazydocker
```

#### Comments

- **Priority**: 3/5 - Great for Docker management without Docker desktop
- **Easy Config**: Minimal, works out of the box
- **Verdict**: **OPTIONAL** - Install if using Docker frequently

---

## Git Tools

### 28. delta - Git Diff Viewer

**Purpose**: Syntax-highlighted git diffs with side-by-side view and themes.

#### Installation

```bash
# Already handled by Makefile
make delta
```

#### Uninstall

```bash
rm ~/.bin/delta
```

#### Comments

- **Priority**: 4/5 - Dramatically improves code review experience
- **Easy Config**: Git config automatic, themes available
- **Verdict**: **CORE** - Always installed

---

---

# ADVANCED EVALUATION (TIER 1-2)

These tools are recommended for separate `Makefile.advanced` installation.

## SSH & Remote Access

### 29. SSHM - SSH Manager [P4]

**Purpose**: Interactive TUI for managing SSH hosts with integrated connection management, port forwarding, and bookmarks.

#### Installation

```bash
# Binary release to ~/.bin
wget https://github.com/Gu1llaum-3/sshm/releases/latest/download/sshm-linux-amd64.tar.gz
tar -xzf sshm-linux-amd64.tar.gz -C ~/.bin
```

#### Uninstall

```bash
rm ~/.bin/sshm
```

#### Comments

- **Priority**: 4/5 - Extremely valuable for managing multiple remote connections
- **Easy Config**: Shell completion, port forwarding presets
- **Verdict**: **YES** - Should be in advanced install. Integrates with ~/.ssh/config.

---

## File Navigation & Exploration

### 30. Television - Fuzzy Finder [P5]

**Purpose**: Fast, portable fuzzy finder with pluggable "channels" (files, git, env vars, processes, SSH hosts, docker, etc).

#### Installation

```bash
cargo install television
ln -s ~/.cargo/bin/tv ~/.bin/tv
```

#### Uninstall

```bash
rm ~/.bin/tv && cargo uninstall television
```

#### Comments

- **Priority**: 5/5 - Foundational tool. Superior to fzf with richer preview/action system
- **Easy Config**: TOML-based channels system, integrates with shell
- **Verdict**: **YES** - High-quality complement to fzf. Actively maintained.

---

### 31. Broot - Directory Navigator [P4]

**Purpose**: Fast directory tree navigation with search, preview, and file operations.

#### Installation

```bash
cargo install broot
ln -s ~/.cargo/bin/broot ~/.bin/br
```

#### Uninstall

```bash
rm ~/.bin/br && cargo uninstall broot
```

#### Comments

- **Priority**: 4/5 - Replaces multiple commands (ls, find, tree). Huge time-saver.
- **Easy Config**: Keybindings via config file, sensible defaults
- **Verdict**: **YES** - Complements existing tools. Worth including.

---

## Data Viewing & Analysis

### 32. Tabiew - Table Viewer [P4]

**Purpose**: TUI app for viewing and querying CSV, Parquet, JSON, Excel, SQLite with SQL support.

#### Installation

```bash
cargo install --locked tabiew
ln -s ~/.cargo/bin/tw ~/.bin/tw
```

#### Uninstall

```bash
rm ~/.bin/tw && cargo uninstall tabiew
```

#### Comments

- **Priority**: 4/5 - Data inspection is common in dev workflows
- **Easy Config**: Vim-like keybindings, SQL queries built-in
- **Verdict**: **YES** - Very useful for data-heavy work. Small binary footprint.

---

## Markdown & Documentation

### 33. Glow - Markdown Viewer [P4]

**Purpose**: Terminal markdown renderer with TUI browser mode and syntax highlighting.

#### Installation

```bash
go install github.com/charmbracelet/glow@latest
ln -s $(go env GOPATH)/bin/glow ~/.bin/glow
```

#### Uninstall

```bash
rm ~/.bin/glow
```

#### Comments

- **Priority**: 4/5 - Documentation reading is common; much better than cat for READMEs
- **Easy Config**: Automatic style detection, config file optional
- **Verdict**: **YES** - Enhances documentation access. Go binary, no dependencies.

---

## Tier 2: Optional Advanced

### 34. Termscp - SCP/SFTP Client [P3]

**Purpose**: Full-featured file transfer client with SCP/SFTP/FTP/S3/SMB support and TUI.

#### Installation

```bash
wget https://github.com/veeso/termscp/releases/latest/download/termscp-linux-amd64.tar.gz
tar -xzf termscp-linux-amd64.tar.gz -C ~/.bin
```

#### Uninstall

```bash
rm ~/.bin/termscp
```

#### Comments

- **Priority**: 3/5 - Useful but scp/rsync cover most needs
- **Easy Config**: Bookmarks feature for frequent hosts
- **Verdict**: **MAYBE** - Could be separate optional install.

---

### 35. Proctmux - Process Manager [P3]

**Purpose**: TUI utility for managing and monitoring long-running processes with background execution.

#### Installation

```bash
git clone https://github.com/napisani/proctmux
cd proctmux && make build
cp ./bin/proctmux ~/.bin/
```

#### Uninstall

```bash
rm ~/.bin/proctmux
```

#### Comments

- **Priority**: 3/5 - Useful for managing multiple services
- **Easy Config**: YAML-based config in project root
- **Verdict**: **MAYBE** - Good for advanced setups managing multiple processes.

---

### 36. Diskonaut - Disk Space Visualizer [P3]

**Purpose**: Interactive disk space usage treemap visualization.

#### Installation

```bash
cargo install diskonaut
ln -s ~/.cargo/bin/diskonaut ~/.bin/diskonaut
```

#### Uninstall

```bash
rm ~/.bin/diskonaut && cargo uninstall diskonaut
```

#### Comments

- **Priority**: 3/5 - Helpful for identifying large files
- **Easy Config**: No setup needed, runs immediately
- **Verdict**: **MAYBE** - Nice for troubleshooting disk space.

---

### 37. Slumber - HTTP Client [P2]

**Purpose**: TUI HTTP/REST client with configuration-first approach, templating, environment profiles.

#### Installation

```bash
cargo install slumber
ln -s ~/.cargo/bin/slumber ~/.bin/slumber
```

#### Uninstall

```bash
rm ~/.bin/slumber && cargo uninstall slumber
```

#### Comments

- **Priority**: 2/5 - Useful for API development but specialized
- **Easy Config**: YAML-based request definitions, easy to share
- **Verdict**: **MAYBE** - Good for API-heavy development.

---

### 38. Tenere - LLM TUI [P2]

**Purpose**: Terminal interface for ChatGPT, Claude, local models (Ollama, llama.cpp).

#### Installation

```bash
cargo install tenere
ln -s ~/.cargo/bin/tenere ~/.bin/tenere
```

#### Uninstall

```bash
rm ~/.bin/tenere && cargo uninstall tenere
```

#### Comments

- **Priority**: 2/5 - Requires external API keys/setup; niche for dev-focused use
- **Easy Config**: TOML config for model selection and API keys
- **Verdict**: **MAYBE** - Could be optional advanced tool.

---

---

# LLM AGENT TOOLS

These are AI coding assistant tools with agentic capabilities for terminal-based development.

## 39. OpenCode - Open Source AI Coding Agent [P5]

**Purpose**: Fully open-source AI coding agent built for terminal. Multi-model support, LSP integration, Model Context Protocol (MCP) support, and client/server architecture.

**Comparison**: Similar to Claude Code but 100% open source, not provider-locked, terminal-first, and fully customizable.

#### Installation

```bash
# YOLO installation (easiest)
curl -fsSL https://opencode.ai/install | bash

# Or via package managers:
npm install -g opencode-ai@latest           # npm/pnpm/yarn/bun
brew install anomalyco/tap/opencode        # macOS/Linux (recommended, always up to date)
choco install opencode                      # Windows
paru -S opencode-bin                        # Arch Linux
nix run nixpkgs#opencode                    # NixOS

# Or build from source
cargo install opencode-ai
```

#### Uninstall

```bash
# npm
npm uninstall -g opencode-ai@latest

# Homebrew
brew uninstall opencode

# Cargo
cargo uninstall opencode-ai

# Manual
rm ~/.bin/opencode (or appropriate bin location)
```

#### Comments

- **Priority**: 5/5 - Game-changer for terminal-based development
- **Easy Config**:
  - Two built-in agents (build/plan with Tab to switch)
  - Auto-discovers LSPs (gopls, typescript-language-server, nil, etc.)
  - MCP support (stdio, http, sse) for tool extension
  - JSON config in `.crush.json`, `crush.json`, or `~/.config/crush/crush.json`
  - Respects `.gitignore`, optional `.crushignore` for exclusions
  - Agent skills via `~/.config/opencode/skills/` directory
- **Key Features**:
  - Multi-model: Claude, OpenAI, Groq, Google Gemini, HuggingFace, etc.
  - Context-aware via LSPs and MCP servers
  - Switch models mid-session preserving context
  - Session-based context per project
  - Tool permission control (permission prompts or --yolo flag)
  - Custom provider support (OpenAI-compatible, Anthropic-compatible, Bedrock, VertexAI)
  - Local model support (Ollama, LM Studio, llama.cpp)
  - .crushignore for additional exclusions
  - Desktop app available (macOS, Linux, Windows)
- **Verdict**: **YES** - Essential for agentic terminal development. Solves the "coding assistant in terminal" problem perfectly.

---

## 40. Crush - Glamourous Agentic Coding (Charmbracelet)

**Purpose**: Multi-model AI coding agent from Charm ecosystem creators. Focus on TUI experience and terminal-first development.

**Comparison**: Similar to OpenCode but by the creators of Charm, famous for terminal UI excellence. Less mature (newer) than OpenCode.

#### Installation

```bash
# Homebrew (recommended)
brew install charmbracelet/tap/crush

# NPM
npm install -g @charmland/crush

# Package managers
yay -S crush-bin                            # Arch Linux
scoop bucket add charm https://github.com/charmbracelet/scoop-bucket.git
scoop install crush                         # Windows
winget install charmbracelet.crush          # Windows

# FreeBSD
pkg install crush

# Nix
nix run github:numtide/nix-ai-tools#crush

# Go
go install github.com/charmbracelet/crush@latest

# Binaries available for: Linux, macOS, Windows, FreeBSD, OpenBSD, NetBSD
```

#### Uninstall

```bash
# Homebrew
brew uninstall crush

# NPM
npm uninstall -g @charmland/crush

# Cargo
cargo uninstall crush

# Manual
rm ~/.bin/crush (or appropriate location)
```

#### Comments

- **Priority**: 5/5 - Alternative to OpenCode with excellent TUI experience
- **Easy Config**:
  - JSON-based configuration: `.crush.json`, `crush.json`, `$HOME/.config/crush/crush.json`
  - LSP support for project context (go, typescript, nix, etc.)
  - MCP support (stdio, http, sse) for tool integration
  - Agent skills via `~/.config/crush/skills/`
  - `.crushignore` for file exclusion
  - Attribution control (commit messages, PR descriptions)
- **Key Features**:
  - Multi-model: Anthropic, OpenAI, Groq, Google Gemini, Azure OpenAI, AWS Bedrock, VertexAI
  - LSP-enhanced with real-time code context
  - Extensible via MCPs (http, stdio, sse)
  - Session-based context per project
  - Works everywhere: macOS, Linux, Windows (PowerShell/WSL), Android, FreeBSD, OpenBSD, NetBSD
  - Industrial-grade (built on Charm ecosystem powering 25k+ apps)
  - Tool permission controls
  - Custom provider support
  - Local model support (Ollama, LM Studio)
  - Permission prompts or YOLO flag for tools
  - Provider auto-updates from Catwalk database
  - Metrics collection (can be disabled)
  - Project initialization with AGENTS.md
- **Verdict**: **YES** - Excellent choice. Made by Charm creators. Slightly newer/less mature than OpenCode but equally powerful. Pick based on preference.

---

## OpenCode vs Crush Comparison

| Feature | OpenCode | Crush | Winner |
|---------|----------|-------|--------|
| **Open Source** | Yes (MIT) | Yes (FSL-1.1-MIT) | Tie |
| **Maturity** | 669+ releases, 585 contributors, 74k stars | 98+ releases, 67 contributors, 18k stars | OpenCode |
| **Installation** | YOLO script, npm, brew, cargo | npm, brew, cargo, binary downloads | Tie |
| **Multi-Model** | Yes (10+ providers) | Yes (10+ providers) | Tie |
| **LSP Support** | Yes, auto-discovery | Yes, configurable | Tie |
| **MCP Support** | Yes (stdio, http, sse) | Yes (stdio, http, sse) | Tie |
| **TUI Quality** | Good | Excellent (Charm expertise) | Crush |
| **Mobile Support** | No | Yes (Android, nix-on-droid) | Crush |
| **Desktop App** | Yes (BETA) | No | OpenCode |
| **Community** | Larger, faster updates | Smaller, quality-focused | OpenCode |
| **Config Simplicity** | Very simple, works without config | Simple, JSON-based | Tie |
| **Provider Auto-Updates** | Community-managed (Catwalk) | Community-managed (Catwalk) | Tie |
| **License** | MIT (fully free) | FSL (free with usage limits) | OpenCode |

### Recommendation

- **Choose OpenCode if**: You want maximum maturity, largest community, MIT license, and desktop app support
- **Choose Crush if**: You prefer Charm's TUI excellence, want mobile support, and prefer FSL licensing model
- **Install Both**: They can coexist. Use OpenCode as primary, Crush for specific workflows or preferences

---

---

# REJECTED TOOLS

These tools are out of scope for this project:

- **chess-tui**: Entertainment, completely unrelated to development
- **tvterm**: Terminal emulator in terminal (experimental, niche use case)
- **digisurf**: Signal waveform viewer (extremely specialized EDA tool)
- **nerd-fonts**: Font patcher (infrastructure/optional, not core)
- **frogmouth**: Markdown browser (overlapped by glow, heavier)
- **elia**: Python LLM client (overlapped by Tenere, unnecessary with OpenCode/Crush)
- **brief**: Java ChatGPT client (requires Java 25, overlapped by agents)
- **clipse**: Clipboard manager (not practical over SSH, core use case)
- **csvlens**: CSV viewer (overlapped by tabiew)
- **play**: Command playground (niche educational tool)

---

## Summary & Installation Plan

### Core Installation

```bash
make install          # Installs all Makefile tools
```

### Advanced Installation (Recommended)

Create `Makefile.advanced`:

```bash
make -f Makefile.advanced advanced  # Install SSHM, Television, Broot, Tabiew, Glow
```

### Optional Agent Installation

```bash
# Choose one or both:
curl -fsSL https://opencode.ai/install | bash      # OpenCode
brew install charmbracelet/tap/crush                # Crush
```

### Tier Summary

| Tier | Tools | Count | Status |
|------|-------|-------|--------|
| **Core (Makefile)** | rg, fd, bat, duf, direnv, zoxide, just, tmux, fzf, btop, jq, gh, stow, nvim, go, rust, ruff, pyright, debugpy, black, httpie, yq, delta | 28 | Always install |
| **Advanced Tier 1** | SSHM, Television, Broot, Tabiew, Glow | 5 | Recommended |
| **Advanced Tier 2** | Termscp, Proctmux, Diskonaut, Slumber, Tenere | 5 | Optional |
| **Agents** | OpenCode, Crush | 2 | Choose one or both |
| **Rejected** | Chess-tui, tvterm, digisurf, nerd-fonts, frogmouth, elia, brief, clipse, csvlens, play | 10 | Skip |

# Tools Reference

Complete reference for all tools installed by this development environment setup.

---

## Table of Contents

- [Core Environment](#core-environment)
- [Quality of Life Tools](#quality-of-life-tools)
- [Developer Tools](#developer-tools)
- [Language-Specific Tools](#language-specific-tools)
- [Optional Tools](#optional-tools)
- [Uninstall Guide](#uninstall-guide)

---

## Core Environment

### Neovim + AstroNvim

**What it does**: Modern modal text editor with full IDE capabilities via AstroNvim distribution.

**Installation**: `make install` or `just install`

**Why it's here**: No-sudo requirement means we use AppImage. AstroNvim provides sensible defaults and plugin ecosystem.

**Alternatives**: vim, helix, kakoune

---

### mise

**What it does**: Universal runtime version manager for node, go, rust, python, and 200+ languages/tools.

**Installation**: `make install` or `just install`

**Why it's here**: Eliminates manual PATH management, version conflicts, and provides hermetic builds via `mise exec`.

**Alternatives**: asdf, rtx, individual version managers (nvm, pyenv, rbenv)

---

## Quality of Life Tools

These are simple command replacements that enhance the daily terminal experience without requiring configuration or workflow changes.

### zoxide

**What it does**: Smart directory navigation - `z proj` jumps to most frequently used directory matching "proj".

**Replaces**: `cd` (but cd still works)

**Example**:
```bash
z documents  # Jump to ~/Documents or any frequently visited dir matching "documents"
z ..         # Go up one directory
```

**Alternatives**: autojump, fasd

---

### eza

**What it does**: Modern `ls` replacement with colors, icons, git integration, tree view.

**Replaces**: `ls` (aliased in shell configs)

**Example**:
```bash
eza           # Colorful directory listing
eza -la       # Long format with hidden files
eza --tree    # Tree view
```

**Alternatives**: lsd, colorls

---

### fd

**What it does**: Fast and intuitive file finder - simpler syntax than `find`, respects .gitignore.

**Replaces**: `find` (but find still works)

**Example**:
```bash
fd pattern           # Find files matching "pattern"
fd -e js             # Find all .js files
fd -H config         # Include hidden files
```

**Alternatives**: find (built-in)

---

### ripgrep (rg)

**What it does**: Ultra-fast recursive text search - respects .gitignore, multi-threaded, smart case.

**Replaces**: `grep -r` (but grep still works)

**Example**:
```bash
rg "TODO"            # Find TODO in all files
rg -t rust "fn "     # Search only Rust files
rg -i case           # Case-insensitive search
```

**Alternatives**: ag (the_silver_searcher), ack

---

### bat

**What it does**: `cat` with syntax highlighting, line numbers, git integration.

**Replaces**: `cat` (but cat still works)

**Example**:
```bash
bat file.py          # View with syntax highlighting
bat -n file.sh       # Show line numbers
```

**Alternatives**: pygmentize, highlight

---

### duf

**What it does**: Colorful disk usage overview - easier to read than `df`.

**Replaces**: `df -h` (but df still works)

**Example**:
```bash
duf                  # Show all mounted filesystems
duf /home            # Show specific path usage
```

**Alternatives**: df (built-in), ncdu

---

## Developer Tools

These tools require some learning but dramatically improve development workflows.

### btop

**What it does**: Beautiful resource monitor - CPU, memory, disk, network, processes.

**Replaces**: `top`, `htop`

**Example**:
```bash
btop                 # Launch interactive dashboard
```

**Why it's better**: Mouse support, graphs, filtering, process tree, network stats.

**Alternatives**: htop, glances, bottom

---

### git-delta

**What it does**: Syntax-highlighted git diffs with side-by-side view and merge conflict resolution.

**Replaces**: Default git diff output (configured in .gitconfig)

**Example**:
```bash
git diff             # Shows delta output automatically
git log -p           # Pretty commit history
```

**Alternatives**: diff-so-fancy, tig

---

### lazydocker

**What it does**: Terminal UI for Docker - manage containers, images, volumes interactively.

**Replaces**: `docker ps`, `docker logs`, `docker exec` (but commands still work)

**Example**:
```bash
lazydocker           # Launch interactive dashboard
```

**Why it's useful**: Quickly view logs, exec into containers, prune resources, inspect configs.

**Alternatives**: docker CLI, Portainer (web UI)

---

### lazymake

**What it does**: Terminal UI for Makefiles and Justfiles - interactively run targets.

**Replaces**: `make <target>` (but make still works)

**Example**:
```bash
lazymake             # Launch interactive target selector
```

**Why it's useful**: Discover available targets, view descriptions, run with arguments.

**Alternatives**: make (built-in), just --list

---

### just

**What it does**: Modern command runner - like make but simpler syntax and better ergonomics.

**Replaces**: `make` for task running (both coexist)

**Example**:
```bash
just install         # Run install recipe
just --list          # Show all recipes
```

**Why it's useful**: Cleaner syntax, better error messages, cross-platform.

**Alternatives**: make, task, mage

---

### television (tv)

**What it does**: Fuzzy finder with preview - find files, git commits, command history.

**Replaces**: `fzf` workflows

**Example**:
```bash
tv                   # Launch fuzzy finder
```

**Alternatives**: fzf, skim

---

### diskonaut

**What it does**: Terminal disk usage analyzer with interactive navigation.

**Replaces**: `du -sh *` (but du still works)

**Example**:
```bash
diskonaut            # Launch in current directory
diskonaut /var       # Analyze specific path
```

**Alternatives**: ncdu, dust

---

### serie

**What it does**: Rich git commit graph in terminal.

**Replaces**: `git log --graph`

**Example**:
```bash
serie                # Show commit graph
```

**Alternatives**: git log --graph, tig, gitk

---

## Language-Specific Tools

### Python Tools (installed via uv)

#### ruff
Fast Python linter and formatter (replaces flake8, black, isort).
```bash
ruff check .         # Lint code
ruff format .        # Format code
```

#### black
Opinionated Python formatter (if you prefer it over ruff format).
```bash
black .              # Format all Python files
```

#### pyright
Static type checker for Python (faster alternative to mypy).
```bash
pyright              # Type check current directory
```

#### pre-commit
Git hook framework for automated checks before commits.
```bash
pre-commit install   # Set up hooks
pre-commit run --all-files
```

#### httpie
User-friendly HTTP client (better than curl for APIs).
```bash
http GET httpbin.org/get
http POST httpbin.org/post name=value
```

#### posting
Modern API client in the terminal (postman alternative).
```bash
posting              # Launch TUI
```

#### dotbot
Declarative dotfile management (for symlinking configs).
```bash
dotbot -c install.conf.yaml
```

---

### Go Tools

#### yq
YAML/JSON/XML processor (like jq but for multiple formats).
```bash
yq '.key' file.yaml  # Query YAML
yq -o json file.yaml # Convert to JSON
```

#### glow
Markdown renderer for terminal - beautifully format README files.
```bash
glow README.md       # Render markdown
glow -p README.md    # Page mode
```

#### sshm
SSH connection manager - organize and quickly connect to servers.
```bash
sshm list            # Show saved connections
sshm connect prod    # Connect to saved host
```

#### nap
Code snippet manager in terminal.
```bash
nap                  # Launch TUI
```

#### deletor
Safe file deletion with trash functionality.
```bash
deletor file.txt     # Move to trash instead of rm
```

---

## Optional Tools

### starship

**What it does**: Minimal, fast, customizable shell prompt with git status, language versions, command duration.

**Installation**: `make install-starship` or `just install-starship`

**Why it's optional**: Not everyone wants a fancy prompt; bash/zsh defaults work fine.

**Alternatives**: oh-my-posh, powerlevel10k (zsh only)

---

### fastfetch

**What it does**: System information tool - show OS, kernel, CPU, memory at login.

**Installation**: `make install-fastfetch` or `just install-fastfetch`

**Why it's optional**: Pure eye candy, no functional benefit.

**Alternatives**: neofetch, screenfetch

---

### zsh

**What it does**: Modern shell with better completion, globbing, plugins.

**Installation**: `make install-zsh` or `just install-zsh` (copies complete .zshrc config)

**Why it's optional**: Bash works perfectly fine; this is a personal preference.

**Alternatives**: bash (default), fish

---

## Uninstall Guide

### Full Teardown

To completely remove this environment and restore your system:

```bash
# 1. Remove mise and all languages it manages
rm -rf ~/.local/share/mise
rm -rf ~/.local/bin/mise

# 2. Restore shell configs (if you have backups)
mv ~/.bashrc.bak ~/.bashrc  # If backup exists
mv ~/.zshrc.bak ~/.zshrc    # If backup exists

# 3. Remove Neovim AppImage
rm ~/.local/bin/nvim

# 4. Remove AstroNvim config (keep backups)
rm -rf ~/.config/nvim
# Optional: restore backup if you had previous nvim config
mv ~/.config/nvim.bak ~/.config/nvim  # If backup exists

# 5. Source your restored shell config
source ~/.bashrc  # or source ~/.zshrc
```

**Note**: Your original configs were backed up to `~/.bashrc.bak` and `~/.zshrc.bak`. If you're happy with our configs, you can delete the backups.

---

### Selective Uninstall

#### Remove Language-Specific Tools

**Rust tools (cargo packages)**:
```bash
# List installed packages
cargo install --list

# Uninstall individual tools
cargo uninstall fd-find
cargo uninstall ripgrep
cargo uninstall bat
cargo uninstall duf
cargo uninstall just
cargo uninstall zoxide
cargo uninstall git-delta
cargo uninstall btop
cargo uninstall eza
cargo uninstall television
cargo uninstall diskonaut
cargo uninstall serie
cargo uninstall starship  # if installed
```

**Python tools (uv)**:
```bash
# List installed tools
uv tool list

# Uninstall individual tools
uv tool uninstall ruff
uv tool uninstall black
uv tool uninstall dotbot
uv tool uninstall pre-commit
uv tool uninstall pyright
uv tool uninstall httpie
uv tool uninstall posting
```

**Go tools**:
```bash
# Go doesn't have a built-in uninstall, just remove binaries
rm ~/go/bin/lazymake
rm ~/go/bin/nap
rm ~/go/bin/deletor
rm ~/go/bin/sshm
rm ~/go/bin/yq
rm ~/go/bin/glow
rm ~/go/bin/lazydocker
```

---

#### Remove Language Runtimes (via mise)

```bash
# List installed runtimes
mise list

# Uninstall specific versions
mise uninstall node@latest
mise uninstall go@latest
mise uninstall rust@stable
mise uninstall python@latest
mise uninstall fzf@latest
```

---

#### Remove Just Neovim Config (Keep Neovim Itself)

```bash
# Remove AstroNvim
rm -rf ~/.config/nvim

# Restore backup if you had previous config
mv ~/.config/nvim.bak ~/.config/nvim

# Or start fresh with vanilla nvim
# Just delete the config - nvim will run without it
```

---

#### Restore Shell Configs

```bash
# Check if backups exist
ls -la ~/.bashrc.bak ~/.zshrc.bak

# Restore from backup
mv ~/.bashrc.bak ~/.bashrc
mv ~/.zshrc.bak ~/.zshrc

# Reload shell
source ~/.bashrc  # or source ~/.zshrc
```

**Your backups contain**: Your original shell configuration before we replaced it with our opinionated setup. You can compare them side-by-side to cherry-pick features you like.

---

### Partial Cleanup (Keep What You Like)

If you only want to remove specific tools:

1. **Keep mise, languages, and core tools** - just uninstall specific cargo/uv/go packages you don't use
2. **Keep shell configs** - delete the `.bak` files if you're happy with the new setup
3. **Keep Neovim** - only remove the AstroNvim config if you want vanilla nvim

The beauty of this setup is modularity - remove what you don't need, keep what you do.

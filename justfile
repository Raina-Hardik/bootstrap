set shell := ["bash", "-cu"]

# Directory variables

LOCAL_BIN := env("HOME", "") / ".local/bin"
MISE_BIN := `command -v mise >/dev/null 2>&1 && command -v mise || echo "$HOME/.local/bin/mise"`
HOME_DIR := env("HOME", "")

# Detect shell

USER_SHELL := `basename "$SHELL"`

# Architecture detection

ARCH := `uname -m`
FASTFETCH_ARCH := if ARCH == "aarch64" { "aarch64" } else { "amd64" }

# -------------------------------------------------------------------
# Help
# -------------------------------------------------------------------

@default:
    just --list

@help:
    echo "====================================================================="
    echo "  bootstrap - Development Environment Installer"
    echo "====================================================================="
    echo ""
    echo "Main targets:"
    echo "  just install       - Install full environment (recommended)"
    echo ""
    echo "Optional shell setup (manual):"
    echo "  just install-zsh   - Install and configure zsh"
    echo "  just install-starship - Install starship prompt via cargo"
    echo "  just install-fastfetch - Install fastfetch system info tool"
    echo ""
    echo "Individual tools (usually run via 'just install'):"
    echo "  just install-nvim  - Install Neovim with AstroNvim"
    echo "  just install-mise  - Install mise (runtime manager)"
    echo "  just setup-shell   - Configure shell activation"
    echo "  just mise-languages - Install node, go, rust via mise"
    echo "  just mise-languages-extras - Install fzf, opencode"
    echo "  just install-all-tools - Install all cargo/uv/go tools"
    echo ""
    echo "====================================================================="

# -------------------------------------------------------------------
# Top-level install (strict ordered execution)
# -------------------------------------------------------------------

@install: install-nvim install-mise setup-shell mise-languages mise-languages-extras install-all-tools
    echo ">> Full environment installed successfully"
    echo ">> Optional: run 'just install-starship' and 'just install-zsh' if desired"

# -------------------------------------------------------------------
# Core installs
# -------------------------------------------------------------------

@install-nvim:
    if command -v nvim >/dev/null 2>&1; then \
        echo ">> nvim already installed: $(nvim --version | head -n 1)"; \
    else \
        mkdir -p {{ LOCAL_BIN }}; \
        curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage; \
        chmod u+x nvim-linux-x86_64.appimage; \
        mv -f nvim-linux-x86_64.appimage {{ LOCAL_BIN }}/nvim; \
    fi
    [ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak || true
    [ -d ~/.local/share/nvim ] && mv ~/.local/share/nvim ~/.local/share/nvim.bak || true
    [ -d ~/.local/state/nvim ] && mv ~/.local/state/nvim ~/.local/state/nvim.bak || true
    [ -d ~/.cache/nvim ] && mv ~/.cache/nvim ~/.cache/nvim.bak || true
    git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
    rm -rf ~/.config/nvim/.git

@install-mise:
    if command -v mise >/dev/null 2>&1; then \
        echo ">> mise already installed: $(mise --version)"; \
    else \
        curl https://mise.run | sh; \
    fi

# -------------------------------------------------------------------
# Shell setup
# -------------------------------------------------------------------

@setup-shell:
    echo ">> Installing complete .bashrc configuration"
    if [ -f {{ HOME_DIR }}/.bashrc ]; then \
        mv {{ HOME_DIR }}/.bashrc {{ HOME_DIR }}/.bashrc.bak; \
        echo ">> Backed up existing .bashrc to .bashrc.bak"; \
    fi
    cp .bashrc {{ HOME_DIR }}/.bashrc
    echo ">> Installed complete .bashrc to {{ HOME_DIR }}/.bashrc"

# -------------------------------------------------------------------
# Install languages globally via mise
# -------------------------------------------------------------------

@mise-languages:
    {{ MISE_BIN }} use -g node@latest
    {{ MISE_BIN }} use -g go@latest
    {{ MISE_BIN }} use -g rust@stable

# -------------------------------------------------------------------
# Install language extras (fzf, opencode)
# -------------------------------------------------------------------

@mise-languages-extras:
    {{ MISE_BIN }} use -g fzf@latest
    {{ MISE_BIN }} use -g github:anomalyco/opencode

# -------------------------------------------------------------------
# Rust tools (cargo)
# -------------------------------------------------------------------

@install-rust-tools:
    {{ MISE_BIN }} exec -- cargo install fd-find
    {{ MISE_BIN }} exec -- cargo install ripgrep
    {{ MISE_BIN }} exec -- cargo install bat
    {{ MISE_BIN }} exec -- cargo install just
    {{ MISE_BIN }} exec -- cargo install zoxide
    {{ MISE_BIN }} exec -- cargo install git-delta
    {{ MISE_BIN }} exec -- cargo install eza
    {{ MISE_BIN }} exec -- cargo install television
    {{ MISE_BIN }} exec -- cargo install diskonaut
    {{ MISE_BIN }} exec -- cargo install --locked serie

# -------------------------------------------------------------------
# Python tools (uv)
# -------------------------------------------------------------------

@install-python-tools:
    {{ MISE_BIN }} exec -- uv tool install ruff
    {{ MISE_BIN }} exec -- uv tool install black
    {{ MISE_BIN }} exec -- uv tool install dotbot
    {{ MISE_BIN }} exec -- uv tool install pre-commit
    {{ MISE_BIN }} exec -- uv tool install pyright
    {{ MISE_BIN }} exec -- uv tool install httpie
    {{ MISE_BIN }} exec -- uv tool install posting

# -------------------------------------------------------------------
# Go tools
# -------------------------------------------------------------------

@install-go-tools:
    {{ MISE_BIN }} exec -- go install github.com/schollz/croc/v10@latest
    {{ MISE_BIN }} exec -- go install github.com/muesli/duf@latest
    {{ MISE_BIN }} exec -- go install github.com/rshelekhov/lazymake/cmd/lazymake@latest
    {{ MISE_BIN }} exec -- go install github.com/maaslalani/nap@latest
    {{ MISE_BIN }} exec -- go install github.com/pashkov256/deletor@latest
    {{ MISE_BIN }} exec -- go install github.com/Gu1llaum-3/sshm@latest
    {{ MISE_BIN }} exec -- go install github.com/mikefarah/yq/v4@latest
    {{ MISE_BIN }} exec -- go install github.com/charmbracelet/glow@latest
    {{ MISE_BIN }} exec -- go install github.com/jesseduffield/lazydocker@latest

# -------------------------------------------------------------------
# Starship installation (via cargo)
# -------------------------------------------------------------------

@install-starship:
    {{ MISE_BIN }} exec -- cargo install starship
    mkdir -p {{ HOME_DIR }}/.config
    echo ">> Starship installed. Adding init to shell config"
    if [ "{{ USER_SHELL }}" = "zsh" ]; then \
        grep -q 'starship init zsh' {{ HOME_DIR }}/.zshrc || echo 'eval "$(starship init zsh)"' >> {{ HOME_DIR }}/.zshrc; \
    elif [ "{{ USER_SHELL }}" = "fish" ]; then \
        grep -q 'starship init fish' {{ HOME_DIR }}/.config/fish/config.fish || echo 'starship init fish | source' >> {{ HOME_DIR }}/.config/fish/config.fish; \
    else \
        grep -q 'starship init bash' {{ HOME_DIR }}/.bashrc || echo 'eval "$(starship init bash)"' >> {{ HOME_DIR }}/.bashrc; \
    fi
    echo ">> Starship configured. Restart shell or source your RC file"

# -------------------------------------------------------------------
# Zsh installation
# -------------------------------------------------------------------

@install-zsh:
    if command -v zsh >/dev/null 2>&1; then \
        echo ">> Zsh already installed: $(zsh --version)"; \
    else \
        echo ">> Warning: Zsh not found. Install via your system package manager."; \
    fi
    echo ">> Installing complete .zshrc configuration"
    if [ -f {{ HOME_DIR }}/.zshrc ]; then \
        mv {{ HOME_DIR }}/.zshrc {{ HOME_DIR }}/.zshrc.bak; \
        echo ">> Backed up existing .zshrc to .zshrc.bak"; \
    fi
    cp .zshrc {{ HOME_DIR }}/.zshrc
    echo ">> Installed complete .zshrc to {{ HOME_DIR }}/.zshrc"

# -------------------------------------------------------------------
# Fastfetch installation (optional)
# -------------------------------------------------------------------

@install-fastfetch:
    if command -v fastfetch >/dev/null 2>&1; then \
        echo ">> fastfetch already installed"; \
    else \
        echo ">> Installing fastfetch for {{ ARCH }}..."; \
        mkdir -p /tmp/fastfetch-install; \
        curl -L -o /tmp/fastfetch-install/fastfetch.tar.gz https://github.com/fastfetch-cli/fastfetch/releases/download/2.59.0/fastfetch-linux-{{ FASTFETCH_ARCH }}.tar.gz; \
        tar -xzf /tmp/fastfetch-install/fastfetch.tar.gz -C /tmp/fastfetch-install; \
        mkdir -p {{ LOCAL_BIN }}; \
        cp /tmp/fastfetch-install/usr/bin/fastfetch {{ LOCAL_BIN }}/; \
        rm -rf /tmp/fastfetch-install; \
        echo ">> fastfetch installed to {{ LOCAL_BIN }}/fastfetch"; \
    fi

# -------------------------------------------------------------------
# Aggregate tool install
# -------------------------------------------------------------------

@install-all-tools: install-rust-tools install-python-tools install-go-tools
    echo ">> All tools installed"

# -------------------------------------------------------------------
# Install make
# -------------------------------------------------------------------

@install-make:
    if command -v make >/dev/null 2>&1; then \
        echo ">> make already installed"; \
    else \
        echo ">> Installing make from mirrors.ustc.edu.cn..."; \
        mkdir -p /tmp/make-build-{{ `date +%s` }}; \
        cd /tmp/make-build-{{ `date +%s` }}; \
        curl -fL https://mirrors.ustc.edu.cn/gnu/make/make-4.4.1.tar.gz -o make.tar.gz; \
        tar -xzf make.tar.gz; \
        cd make-*; \
        ./configure --prefix={{ HOME_DIR }}/.local; \
        make; \
        make install; \
    fi

set shell := ["bash", "-cu"]

# Directory variables
LOCAL_BIN := env("HOME", "") / ".local/bin"
MISE_BIN := LOCAL_BIN / "mise"
HOME_DIR := env("HOME", "")

# Detect shell
USER_SHELL := `basename "$SHELL"`

# Architecture detection
ARCH := `uname -m`
FASTFETCH_ARCH := if ARCH == "aarch64" { "aarch64" } else { "amd64" }

# Determine RC file and activation line based on shell
RC_FILE := if USER_SHELL == "zsh" {
    HOME_DIR / ".zshrc"
} else if USER_SHELL == "fish" {
    HOME_DIR / ".config/fish/config.fish"
} else {
    HOME_DIR / ".bashrc"
}

MISE_ACTIVATE_LINE := if USER_SHELL == "zsh" {
    "eval \"$({{MISE_BIN}} activate zsh)\""
} else if USER_SHELL == "fish" {
    "{{MISE_BIN}} activate fish | source"
} else {
    "eval \"$({{MISE_BIN}} activate bash)\""
}

# -------------------------------------------------------------------
# Help
# -------------------------------------------------------------------

@default:
    just --list

@help:
    echo "====================================================================="
    echo "  basic-ssh-config - Development Environment Installer"
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
    mkdir -p {{LOCAL_BIN}}
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    chmod u+x nvim-linux-x86_64.appimage
    mv -f nvim-linux-x86_64.appimage {{LOCAL_BIN}}/nvim
    [ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak || true
    [ -d ~/.local/share/nvim ] && mv ~/.local/share/nvim ~/.local/share/nvim.bak || true
    [ -d ~/.local/state/nvim ] && mv ~/.local/state/nvim ~/.local/state/nvim.bak || true
    [ -d ~/.cache/nvim ] && mv ~/.cache/nvim ~/.cache/nvim.bak || true
    git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
    rm -rf ~/.config/nvim/.git

@install-mise:
    curl https://mise.run | sh

# -------------------------------------------------------------------
# Shell setup
# -------------------------------------------------------------------

@setup-shell:
    echo ">> Ensuring shell config exists at {{RC_FILE}}"
    mkdir -p $(dirname {{RC_FILE}})
    [ -f {{RC_FILE}} ] || touch {{RC_FILE}}
    echo ">> Ensuring mise activation in {{RC_FILE}} for {{USER_SHELL}}"
    grep -qxF '{{MISE_ACTIVATE_LINE}}' {{RC_FILE}} || echo '{{MISE_ACTIVATE_LINE}}' >> {{RC_FILE}}

# -------------------------------------------------------------------
# Install languages globally via mise
# -------------------------------------------------------------------

@mise-languages:
    {{MISE_BIN}} use -g node@latest
    {{MISE_BIN}} use -g go@latest
    {{MISE_BIN}} use -g rust@stable

# -------------------------------------------------------------------
# Install language extras (fzf, opencode)
# -------------------------------------------------------------------

@mise-languages-extras:
    {{MISE_BIN}} use -g fzf@latest
    {{MISE_BIN}} use -g github:anomalyco/opencode

# -------------------------------------------------------------------
# Rust tools (cargo)
# -------------------------------------------------------------------

@install-rust-tools:
    {{MISE_BIN}} exec -- cargo install fd-find
    {{MISE_BIN}} exec -- cargo install ripgrep
    {{MISE_BIN}} exec -- cargo install bat
    {{MISE_BIN}} exec -- cargo install duf
    {{MISE_BIN}} exec -- cargo install just
    {{MISE_BIN}} exec -- cargo install zoxide
    {{MISE_BIN}} exec -- cargo install git-delta
    {{MISE_BIN}} exec -- cargo install btop
    {{MISE_BIN}} exec -- cargo install eza
    {{MISE_BIN}} exec -- cargo install television
    {{MISE_BIN}} exec -- cargo install diskonaut
    {{MISE_BIN}} exec -- cargo install --locked serie

# -------------------------------------------------------------------
# Python tools (uv)
# -------------------------------------------------------------------

@install-python-tools:
    {{MISE_BIN}} exec -- uv tool install ruff
    {{MISE_BIN}} exec -- uv tool install black
    {{MISE_BIN}} exec -- uv tool install dotbot
    {{MISE_BIN}} exec -- uv tool install pre-commit
    {{MISE_BIN}} exec -- uv tool install pyright
    {{MISE_BIN}} exec -- uv tool install httpie
    {{MISE_BIN}} exec -- uv tool install posting

# -------------------------------------------------------------------
# Go tools
# -------------------------------------------------------------------

@install-go-tools:
    {{MISE_BIN}} exec -- go install github.com/rshelekhov/lazymake/cmd/lazymake@latest
    {{MISE_BIN}} exec -- go install github.com/maaslalani/nap@latest
    {{MISE_BIN}} exec -- go install github.com/pashkov256/deletor@latest
    {{MISE_BIN}} exec -- go install github.com/Gu1llaum-3/sshm@latest
    {{MISE_BIN}} exec -- go install github.com/mikefarah/yq/v4@latest
    {{MISE_BIN}} exec -- go install github.com/charmbracelet/glow@latest
    {{MISE_BIN}} exec -- go install github.com/jesseduffield/lazydocker@latest

# -------------------------------------------------------------------
# Starship installation (via cargo)
# -------------------------------------------------------------------

@install-starship:
    {{MISE_BIN}} exec -- cargo install starship
    mkdir -p {{HOME_DIR}}/.config
    echo ">> Starship installed. Configure at {{HOME_DIR}}/.config/starship.toml"

# -------------------------------------------------------------------
# Zsh installation
# -------------------------------------------------------------------

@install-zsh:
    if command -v zsh >/dev/null 2>&1; then \
        echo ">> Zsh already installed: $(zsh --version)"; \
    else \
        echo ">> Warning: Zsh not found. Install via your system package manager."; \
    fi
    cp .zshrc {{HOME_DIR}}/.zshrc
    echo ">> .zshrc installed at {{HOME_DIR}}/.zshrc"

# -------------------------------------------------------------------
# Fastfetch installation (optional)
# -------------------------------------------------------------------

@install-fastfetch:
    if command -v fastfetch >/dev/null 2>&1; then \
        echo ">> fastfetch already installed"; \
    else \
        echo ">> Installing fastfetch for {{ARCH}}..."; \
        mkdir -p /tmp/fastfetch-install; \
        curl -L -o /tmp/fastfetch-install/fastfetch.tar.gz https://github.com/fastfetch-cli/fastfetch/releases/download/2.59.0/fastfetch-linux-{{FASTFETCH_ARCH}}.tar.gz; \
        tar -xzf /tmp/fastfetch-install/fastfetch.tar.gz -C /tmp/fastfetch-install; \
        mkdir -p {{LOCAL_BIN}}; \
        cp /tmp/fastfetch-install/usr/bin/fastfetch {{LOCAL_BIN}}/; \
        rm -rf /tmp/fastfetch-install; \
        echo ">> fastfetch installed to {{LOCAL_BIN}}/fastfetch"; \
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
        mkdir -p /tmp/make-build-{{`date +%s`}}; \
        cd /tmp/make-build-{{`date +%s`}}; \
        curl -fL https://mirrors.ustc.edu.cn/gnu/make/make-4.4.1.tar.gz -o make.tar.gz; \
        tar -xzf make.tar.gz; \
        cd make-*; \
        ./configure --prefix={{HOME_DIR}}/.local; \
        make; \
        make install; \
    fi

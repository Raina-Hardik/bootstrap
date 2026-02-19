LOCAL_BIN := $(HOME)/.local/bin
MISE_BIN := $(LOCAL_BIN)/mise
USER_SHELL := $(shell basename "$$SHELL")

ifeq ($(USER_SHELL),zsh)
RC_FILE := $(HOME)/.zshrc
MISE_ACTIVATE_LINE := eval "$$($(MISE_BIN) activate zsh)"
else ifeq ($(USER_SHELL),fish)
RC_FILE := $(HOME)/.config/fish/config.fish
MISE_ACTIVATE_LINE := $(MISE_BIN) activate fish | source
else
RC_FILE := $(HOME)/.bashrc
MISE_ACTIVATE_LINE := eval "$$($(MISE_BIN) activate bash)"
endif

# -------------------------------------------------------------------
# Help
# -------------------------------------------------------------------

.PHONY: help

help:
	@echo "====================================================================="
	@echo "  basic-ssh-config - Development Environment Installer"
	@echo "====================================================================="
	@echo ""
	@echo "Main targets:"
	@echo "  make install       - Install full environment (recommended)"
	@echo ""
	@echo "Optional shell setup (manual):"
	@echo "  make install-zsh   - Install and configure zsh"
	@echo "  make install-starship - Install starship prompt via cargo"
	@echo ""
	@echo "Individual tools (usually run via 'make install'):"
	@echo "  make install-nvim  - Install Neovim with AstroNvim"
	@echo "  make install-mise  - Install mise (runtime manager)"
	@echo "  make setup-shell   - Configure shell activation"
	@echo "  make mise-languages - Install node, go, rust via mise"
	@echo "  make mise-languages-extras - Install fzf, opencode"
	@echo "  make install-all-tools - Install all cargo/uv/go tools"
	@echo ""
	@echo "====================================================================="

.PHONY: \
	install install-all-tools \
	install-nvim install-mise setup-shell \
	mise-languages mise-languages-extras \
	install-rust-tools install-python-tools install-go-tools \
	install-starship install-zsh \
	install-just

# -------------------------------------------------------------------
# Top-level install (strict ordered execution)
# -------------------------------------------------------------------

install:
	$(MAKE) install-nvim
	$(MAKE) install-mise
	$(MAKE) setup-shell
	$(MAKE) mise-languages
	$(MAKE) mise-languages-extras
	$(MAKE) install-all-tools
	@echo ">> Full environment installed successfully"
	@echo ">> Optional: run 'make install-starship' and 'make install-zsh' if desired"

# -------------------------------------------------------------------
# Core installs
# -------------------------------------------------------------------

install-nvim:
	mkdir -p $(LOCAL_BIN)
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
	chmod u+x nvim-linux-x86_64.appimage
	mv -f nvim-linux-x86_64.appimage $(LOCAL_BIN)/nvim
	@if [ -d ~/.config/nvim ]; then mv ~/.config/nvim ~/.config/nvim.bak; fi
	@if [ -d ~/.local/share/nvim ]; then mv ~/.local/share/nvim ~/.local/share/nvim.bak; fi
	@if [ -d ~/.local/state/nvim ]; then mv ~/.local/state/nvim ~/.local/state/nvim.bak; fi
	@if [ -d ~/.cache/nvim ]; then mv ~/.cache/nvim ~/.cache/nvim.bak; fi
	git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
	rm -rf ~/.config/nvim/.git

install-mise:
	curl https://mise.run | sh

# -------------------------------------------------------------------
# Shell setup
# -------------------------------------------------------------------

setup-shell:
	@echo ">> Ensuring shell config exists at $(RC_FILE)"
	@mkdir -p $(dir $(RC_FILE))
	@if [ ! -f $(RC_FILE) ]; then touch $(RC_FILE); fi
	@echo ">> Ensuring mise activation in $(RC_FILE) for $(USER_SHELL)"
	@grep -qxF '$(MISE_ACTIVATE_LINE)' $(RC_FILE) || echo '$(MISE_ACTIVATE_LINE)' >> $(RC_FILE)

# -------------------------------------------------------------------
# Install languages globally via mise
# -------------------------------------------------------------------

mise-languages:
	$(MISE_BIN) use -g node@latest
	$(MISE_BIN) use -g go@latest
	$(MISE_BIN) use -g rust@stable

# -------------------------------------------------------------------
# Install language extras (fzf, opencode)
# -------------------------------------------------------------------

mise-languages-extras:
	$(MISE_BIN) use -g fzf@latest
	$(MISE_BIN) use -g github:anomalyco/opencode

# -------------------------------------------------------------------
# Rust tools (cargo)
# -------------------------------------------------------------------

install-rust-tools:
	$(MISE_BIN) exec -- cargo install fd-find
	$(MISE_BIN) exec -- cargo install ripgrep
	$(MISE_BIN) exec -- cargo install bat
	$(MISE_BIN) exec -- cargo install duf
	$(MISE_BIN) exec -- cargo install just
	$(MISE_BIN) exec -- cargo install zoxide
	$(MISE_BIN) exec -- cargo install git-delta
	$(MISE_BIN) exec -- cargo install btop
	$(MISE_BIN) exec -- cargo install eza
	$(MISE_BIN) exec -- cargo install television
	$(MISE_BIN) exec -- cargo install diskonaut
	$(MISE_BIN) exec -- cargo install --locked serie

# -------------------------------------------------------------------
# Python tools (uv)
# -------------------------------------------------------------------

install-python-tools:
	$(MISE_BIN) exec -- uv tool install ruff
	$(MISE_BIN) exec -- uv tool install black
	$(MISE_BIN) exec -- uv tool install dotbot
	$(MISE_BIN) exec -- uv tool install pre-commit
	$(MISE_BIN) exec -- uv tool install pyright
	$(MISE_BIN) exec -- uv tool install httpie
	$(MISE_BIN) exec -- uv tool install posting

# -------------------------------------------------------------------
# Go tools
# -------------------------------------------------------------------

install-go-tools:
	$(MISE_BIN) exec -- go install github.com/rshelekhov/lazymake/cmd/lazymake@latest
	$(MISE_BIN) exec -- go install github.com/maaslalani/nap@latest
	$(MISE_BIN) exec -- go install github.com/pashkov256/deletor@latest
	$(MISE_BIN) exec -- go install github.com/Gu1llaum-3/sshm@latest
	$(MISE_BIN) exec -- go install github.com/mikefarah/yq/v4@latest
	$(MISE_BIN) exec -- go install github.com/charmbracelet/glow@latest
	$(MISE_BIN) exec -- go install github.com/jesseduffield/lazydocker@latest

# -------------------------------------------------------------------
# Starship installation (via cargo)
# -------------------------------------------------------------------

install-starship:
	$(MISE_BIN) exec -- cargo install starship
	@mkdir -p $(HOME)/.config
	@echo ">> Starship installed. Configure at $(HOME)/.config/starship.toml"

# -------------------------------------------------------------------
# Zsh installation
# -------------------------------------------------------------------

install-zsh:
	@if command -v zsh >/dev/null 2>&1; then \
		echo ">> Zsh already installed: $$(zsh --version)"; \
	else \
		echo ">> Warning: Zsh not found. Install via your system package manager."; \
	fi
	@cp .zshrc $(HOME)/.zshrc
	@echo ">> .zshrc installed at $(HOME)/.zshrc"

# -------------------------------------------------------------------
# Aggregate tool install
# -------------------------------------------------------------------

install-all-tools:
	$(MAKE) install-rust-tools
	$(MAKE) install-go-tools
	$(MAKE) install-python-tools

# -------------------------------------------------------------------
# Install just
# -------------------------------------------------------------------

install-just:
	@if command -v just >/dev/null 2>&1; then \
		echo ">> just already installed"; \
	else \
		echo ">> Installing just..."; \
		curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to $(LOCAL_BIN); \
	fi

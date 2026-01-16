# ==============================================================================
#  Environment Setup Makefile (No-Sudo, Basic Tools)
# ==============================================================================

BIN_DIR   := $(HOME)/.bin
LOCAL_DIR := $(HOME)/.local
CONF_DIR  := $(HOME)/.config
TMP_DIR   := /tmp/devtools.$(shell echo $$$$)
RUSTUP_INIT := https://sh.rustup.rs

# --- Arch Detection ---
UNAME_P := $(shell uname -m)
ifeq ($(UNAME_P),x86_64)
    ARCH := x86_64
    GOARCH := amd64
else ifneq ($(filter arm% aarch64,$(UNAME_P)),)
    ARCH := aarch64
    GOARCH := arm64
else
    ARCH := x86_64
    GOARCH := amd64
endif

# --- Versions ---
NVIM_VER    := 0.11.5
RG_VER      := 14.1.0
FD_VER      := 10.2.0
BAT_VER     := 0.25.0
DUF_VER     := 0.8.1
DIRENV_VER  := 2.35.0
JUST_VER    := 1.39.0

GO_VER := 1.25.5
GO_OS := linux
GO_ARCH := $(GOARCH)
GO_TAR := go$(GO_VER).$(GO_OS)-$(GO_ARCH).tar.gz
GO_URL := https://go.dev/dl/$(GO_TAR)
GO_DIR := $(HOME)/.local/go

.PHONY: all help install tools nvim bashrc dirs clean uv-tools go rust

all: help

help:
	@echo "Available commands:"
	@echo "  make install  - Full installation (tools, nvim, bashrc)"
	@echo "  make tools    - Install CLI utilities (rg, fd, bat, etc.)"
	@echo "  make nvim     - Install Neovim + LazyVim + ML Config"
	@echo "  make bashrc   - Symlink .bashrc to home directory"
	@echo "  make clean    - Remove build artifacts"

install: dirs tools go rust bashrc uv-tools nvim
	@echo "Setup complete. Run 'source ~/.bashrc' to reload."

dirs:
	mkdir -p $(BIN_DIR) $(LOCAL_DIR) $(CONF_DIR)

# --- CLI Tools ---
tools: dirs $(BIN_DIR)/rg $(BIN_DIR)/fd $(BIN_DIR)/bat $(BIN_DIR)/duf $(BIN_DIR)/direnv $(BIN_DIR)/just $(BIN_DIR)/fzf

$(BIN_DIR)/rg:
	@echo "==> Installing ripgrep..."
	mkdir -p $(TMP_DIR)/rg && cd $(TMP_DIR)/rg && \
	curl -fLO https://github.com/BurntSushi/ripgrep/releases/download/$(RG_VER)/ripgrep-$(RG_VER)-$(ARCH)-unknown-linux-musl.tar.gz && \
	tar -xzf *.tar.gz --strip-components=1 && \
	cp rg $(BIN_DIR)/

$(BIN_DIR)/fd:
	@echo "==> Installing fd..."
	mkdir -p $(TMP_DIR)/fd && cd $(TMP_DIR)/fd && \
	curl -fLO https://github.com/sharkdp/fd/releases/download/v$(FD_VER)/fd-v$(FD_VER)-$(ARCH)-unknown-linux-musl.tar.gz && \
	tar -xzf *.tar.gz --strip-components=1 && \
	cp fd $(BIN_DIR)/

$(BIN_DIR)/bat:
	@echo "==> Installing bat..."
	mkdir -p $(TMP_DIR)/bat && cd $(TMP_DIR)/bat && \
	curl -fLO https://github.com/sharkdp/bat/releases/download/v$(BAT_VER)/bat-v$(BAT_VER)-$(ARCH)-unknown-linux-musl.tar.gz && \
	tar -xzf *.tar.gz --strip-components=1 && \
	cp bat $(BIN_DIR)/

$(BIN_DIR)/duf:
	@echo "==> Installing duf..."
	mkdir -p $(TMP_DIR)/duf && cd $(TMP_DIR)/duf && \
	curl -fLO https://github.com/muesli/duf/releases/download/v$(DUF_VER)/duf_$(DUF_VER)_Linux_$(ARCH).tar.gz && \
	tar -xzf *.tar.gz && \
	cp duf $(BIN_DIR)/

$(BIN_DIR)/direnv:
	@echo "==> Installing direnv..."
	curl -fL -o $(BIN_DIR)/direnv https://github.com/direnv/direnv/releases/download/v$(DIRENV_VER)/direnv.linux-$(GOARCH)
	chmod +x $(BIN_DIR)/direnv

$(BIN_DIR)/just:
	@echo "==> Installing just..."
	mkdir -p $(TMP_DIR)/just && cd $(TMP_DIR)/just && \
	curl -fLO https://github.com/casey/just/releases/download/$(JUST_VER)/just-$(JUST_VER)-$(ARCH)-unknown-linux-musl.tar.gz && \
	tar -xzf *.tar.gz && \
	cp just $(BIN_DIR)/

$(BIN_DIR)/fzf:
	@echo "==> Installing fzf..."
	@if [ ! -d $(LOCAL_DIR)/fzf ]; then \
		git clone --depth 1 https://github.com/junegunn/fzf.git $(LOCAL_DIR)/fzf; \
		$(LOCAL_DIR)/fzf/install --bin; \
	fi
	ln -sf $(LOCAL_DIR)/fzf/bin/fzf $(BIN_DIR)/fzf

# --- UV Python Tools ---
uv-tools:
	@echo "==> Installing uv..."
	@command -v uv >/dev/null 2>&1 || curl -LsSf https://astral.sh/uv/install.sh | sh
	@echo "==> Installing Python tools via uv..."
	uv tool install ruff
	uv tool install pyright
	uv tool install debugpy
	uv tool install black
	uv tool update-shell

# --- Neovim ---
nvim: dirs $(BIN_DIR)/nvim nvim-config

$(BIN_DIR)/nvim:
	@echo "==> Installing Neovim $(NVIM_VER)..."
	rm -rf $(LOCAL_DIR)/nvim
	mkdir -p $(LOCAL_DIR)/nvim
	mkdir -p $(TMP_DIR)/nvim && cd $(TMP_DIR)/nvim && \
	curl -fLO https://github.com/neovim/neovim/releases/download/v$(NVIM_VER)/nvim-linux-$(ARCH).tar.gz && \
	tar -xzf *.tar.gz --strip-components=1 && \
	cp -r * $(LOCAL_DIR)/nvim/
	ln -sf $(LOCAL_DIR)/nvim/bin/nvim $(BIN_DIR)/nvim

rust:
	@if command -v cargo >/dev/null; then \
		echo "Cargo already installed"; \
	else \
		echo "Installing Rust (cargo)"; \
		curl --proto '=https' --tlsv1.2 -sSf $(RUSTUP_INIT) | sh -s -- -y; \
	fi

go:
	@if command -v go >/dev/null; then \
		echo "Go already installed"; \
	else \
		echo "Installing Go $(GO_VER)"; \
		mkdir -p $(TMP_DIR); \
		curl -fsSL $(GO_URL) -o $(TMP_DIR)/$(GO_TAR); \
		rm -rf $(GO_DIR); \
		tar -C $(LOCAL_DIR) -xzf $(TMP_DIR)/$(GO_TAR); \
	fi


nvim-config:
	@echo "==> Configuring LazyVim..."
	rm -rf $(CONF_DIR)/nvim
	git clone https://github.com/LazyVim/starter $(CONF_DIR)/nvim
	rm -rf $(CONF_DIR)/nvim/.git
	@mkdir -p $(CONF_DIR)/nvim/lua/plugins $(CONF_DIR)/nvim/lua/config
	@echo 'return { { "neovim/nvim-lspconfig", opts = { servers = { pyright = {} } } }, { "mason-org/mason.nvim", opts = { ensure_installed = { "pyright", "ruff", "debugpy", "yaml-language-server" } } }, { "stevearc/conform.nvim", opts = { formatters_by_ft = { python = { "ruff" }, yaml = { "prettier" }, json = { "prettier" } } } } }' > $(CONF_DIR)/nvim/lua/plugins/ml.lua
	@echo 'return { { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "python", "bash", "json", "yaml", "markdown" } } } }' > $(CONF_DIR)/nvim/lua/plugins/treesitter.lua
	@grep -q "config.python" $(CONF_DIR)/nvim/init.lua 2>/dev/null || echo 'require("config.python")' >> $(CONF_DIR)/nvim/init.lua
	@echo 'vim.api.nvim_create_autocmd("FileType", { pattern = "python", callback = function() vim.opt_local.expandtab = true; vim.opt_local.shiftwidth = 4; end })' > $(CONF_DIR)/nvim/lua/config/python.lua

# --- Bash RC ---
bashrc:
	@echo "==> Installing .bashrc..."
	@if [ -f $(HOME)/.bashrc ] && [ ! -L $(HOME)/.bashrc ]; then \
		mv $(HOME)/.bashrc $(HOME)/.bashrc.bak; \
	fi
	cp $(CURDIR)/.bashrc $(HOME)/.bashrc

clean:
	rm -rf $(TMP_DIR)

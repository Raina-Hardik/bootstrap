# ==============================================================================
#  Zsh Shell Configuration Installation
# ==============================================================================

include Makefile.common

.PHONY: all install-zsh help uninstall-zsh zsh starship nerd-font starship-config zshrc

all: install-zsh

help:
	@echo "======================================================================"
	@echo "  Makefile.zsh - Zsh Shell Configuration Installation"
	@echo "======================================================================"
	@echo ""
	@echo "Available targets:"
	@echo "  make install-zsh     - Install zsh + starship + nerd font + .zshrc"
	@echo "  make uninstall-zsh   - Uninstall all zsh components"
	@echo ""
	@echo "Individual components:"
	@echo "  make zsh             - Install zsh shell only"
	@echo "  make starship        - Install starship prompt only"
	@echo "  make nerd-font       - Install JetBrains Mono Nerd Font only"
	@echo "  make starship-config - Configure starship with Catppuccin Mocha"
	@echo "  make zshrc           - Copy .zshrc to home directory"
	@echo ""
	@echo "======================================================================"

install-zsh: dirs zsh starship nerd-font starship-config zshrc
	@echo ""
	@echo "======================================================================"
	@echo "  ✅ Zsh installation complete!"
	@echo "======================================================================"
	@echo ""
	@echo "Installed:"
	@echo "  - Zsh shell"
	@echo "  - Starship prompt (Catppuccin Mocha + Powerline preset)"
	@echo "  - JetBrains Mono Nerd Font"
	@echo "  - .zshrc configuration"
	@echo ""
	@echo "Next steps:"
	@echo "  - Change your shell: chsh -s \$$(which zsh) || sudo chsh -s \$$(which zsh) \$$USER"
	@echo "  - Log out and log back in for the shell change to take effect"
	@echo "  - Or test immediately: zsh"
	@echo ""

# --- Zsh Installation ---

zsh:
	@echo "==> Installing zsh..."
	@if command -v zsh >/dev/null 2>&1; then \
		echo "Zsh already installed: $$(zsh --version)"; \
	elif [ -w /usr/bin ] || [ -w /usr/local/bin ]; then \
		echo "ERROR: Zsh is not installed and non-sudo installation is not feasible."; \
		echo "Please run manually: sudo apt install zsh"; \
		exit 1; \
	else \
		echo "Attempting system installation (requires sudo)..."; \
		sudo apt update && sudo apt install -y zsh; \
	fi

# --- Starship Installation ---

STARSHIP_VER := 1.23.0

$(BIN_DIR)/starship:
	@echo "==> Installing starship..."
	mkdir -p $(TMP_DIR)/starship && cd $(TMP_DIR)/starship && \
	curl -fLO https://github.com/starship/starship/releases/download/v$(STARSHIP_VER)/starship-$(ARCH)-unknown-linux-musl.tar.gz && \
	tar -xzf *.tar.gz && \
	cp starship $(BIN_DIR)/
	@chmod +x $(BIN_DIR)/starship

starship: $(BIN_DIR)/starship

# --- Starship Configuration ---

starship-config:
	@echo "==> Configuring starship with Catppuccin Mocha + Powerline preset..."
	@mkdir -p $(CONF_DIR)
	@curl -fL https://starship.rs/presets/toml/catppuccin-powerline.toml -o $(CONF_DIR)/starship.toml
	@echo "Starship configuration installed at $(CONF_DIR)/starship.toml"

# --- JetBrains Mono Nerd Font Installation ---

FONT_DIR := $(HOME)/.local/share/fonts
NERD_FONT_VER := v4.2.0

nerd-font:
	@echo "==> Installing JetBrains Mono Nerd Font..."
	@mkdir -p $(FONT_DIR) $(TMP_DIR)/fonts
	@cd $(TMP_DIR)/fonts && \
	curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/$(NERD_FONT_VER)/JetBrainsMono.zip && \
	unzip -o JetBrainsMono.zip -d $(FONT_DIR)/JetBrainsMono && \
	rm -f $(FONT_DIR)/JetBrainsMono/*Windows*.ttf
	@if command -v fc-cache >/dev/null 2>&1; then \
		fc-cache -fv $(FONT_DIR); \
		echo "Font cache updated"; \
	else \
		echo "fc-cache not available, font cache not updated (font will still work)"; \
	fi
	@echo "JetBrains Mono Nerd Font installed to $(FONT_DIR)/JetBrainsMono"

# --- Zshrc Installation ---

zshrc:
	@echo "==> Copying .zshrc to home directory..."
	@cp .zshrc $(HOME)/.zshrc
	@echo ".zshrc installed at $(HOME)/.zshrc"

# --- Uninstall Targets ---

uninstall-zsh:
	@echo "==> Uninstalling zsh components..."
	@rm -f $(BIN_DIR)/starship
	@rm -f $(CONF_DIR)/starship.toml
	@rm -rf $(FONT_DIR)/JetBrainsMono
	@rm -f $(HOME)/.zshrc
	@echo "Note: Zsh shell itself not removed (use system package manager)"
	@echo "Zsh components uninstalled."

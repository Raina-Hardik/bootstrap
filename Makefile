# ==============================================================================
#  Main Makefile - Orchestrator for Modular Installation
# ==============================================================================

include Makefile.common

.PHONY: help all install install-core install-dev install-git install-advanced install-ai clean uninstall-all

# --- Default Target ---
all: help

# --- Help ---
help:
	@echo "======================================================================"
	@echo "  Basic SSH Config - Modular Installation System"
	@echo "======================================================================"
	@echo ""
	@echo "Available targets:"
	@echo ""
	@echo "  FULL INSTALLATION:"
	@echo "    make install             - Install core + dev + git tools"
	@echo "    make install-all         - Install everything (core + dev + git + advanced)"
	@echo ""
	@echo "  OPTIONAL (INSTALL SEPARATELY):"
	@echo "    make install-ai          - Install AI agents (OpenCode & Crush) ⚠️  POWERFUL - INSTALL AT YOUR OWN RISK"
	@echo ""
	@echo "  INDIVIDUAL MAKEFILES:"
	@echo "    make -f Makefile.core    - Run core tools installation directly"
	@echo "    make -f Makefile.dev     - Run dev environment setup directly"
	@echo "    make -f Makefile.git     - Run git tools setup directly"
	@echo "    make -f Makefile.advanced - Run advanced tools installation directly"
	@echo "    make -f Makefile.ai      - Run AI agents installation directly"
	@echo ""
	@echo "  MAINTENANCE:"
	@echo "    make clean               - Remove temporary build artifacts"
	@echo ""
	@echo "======================================================================"

# --- Full Installation Targets ---
install: install-core install-dev install-git
	@echo ""
	@echo "======================================================================"
	@echo "  ✅ Core installation complete!"
	@echo "======================================================================"
	@echo ""
	@echo "Installed:"
	@echo "  - Core CLI tools (ripgrep, fd, bat, fzf, tmux, etc.)"
	@echo "  - Development environment (Neovim, Go, Rust, Python tools)"
	@echo "  - Git tools (delta, themes, git config)"
	@echo ""
	@echo "Next steps:"
	@echo "  - Run 'source ~/.bashrc' to reload your shell"
	@echo "  - Install advanced tools: make install-advanced"
	@echo "  - Install AI agents (optional): make install-ai"
	@echo ""

install-all: install install-advanced
	@echo ""
	@echo "======================================================================"
	@echo "  ✅ Full installation complete!"
	@echo "======================================================================"
	@echo ""
	@echo "Optional AI agents (install separately for security):"
	@echo "  - make install-ai         - Install AI agents (OpenCode & Crush)"
	@echo "    WARNING: AI agents have significant power. Install only if you trust them."
	@echo ""

# --- Modular Installation Targets ---
install-core:
	@$(MAKE) -f Makefile.core all

install-dev:
	@$(MAKE) -f Makefile.dev all

install-git:
	@$(MAKE) -f Makefile.git all

install-advanced:
	@$(MAKE) -f Makefile.advanced all

install-ai:
	@$(MAKE) -f Makefile.ai all

# --- Individual Tool Targets (pass-through) ---
.PHONY: nvim go rust cargo-tools go-tools uv-tools lazydocker delta git-config bat-config
.PHONY: sshm television broot tabiew glow opencode crush

nvim:
	@$(MAKE) -f Makefile.dev nvim

go:
	@$(MAKE) -f Makefile.dev go

rust:
	@$(MAKE) -f Makefile.dev rust

cargo-tools:
	@$(MAKE) -f Makefile.dev cargo-tools

go-tools:
	@$(MAKE) -f Makefile.dev go-tools

uv-tools:
	@$(MAKE) -f Makefile.dev uv-tools

lazydocker:
	@$(MAKE) -f Makefile.dev lazydocker

delta:
	@$(MAKE) -f Makefile.git delta

git-config:
	@$(MAKE) -f Makefile.git git-config

bat-config:
	@$(MAKE) -f Makefile.git bat-config

sshm:
	@$(MAKE) -f Makefile.advanced sshm

television:
	@$(MAKE) -f Makefile.advanced television

broot:
	@$(MAKE) -f Makefile.advanced broot

tabiew:
	@$(MAKE) -f Makefile.advanced tabiew

glow:
	@$(MAKE) -f Makefile.advanced glow

opencode:
	@$(MAKE) -f Makefile.ai opencode

crush:
	@$(MAKE) -f Makefile.ai crush

# --- Uninstall Targets ---

uninstall-all:

	@echo "======================================================================"

	@echo "  WARNING: This will uninstall ALL tools!"

	@echo "======================================================================"

	@$(MAKE) -f Makefile.advanced uninstall-advanced || true

	@$(MAKE) -f Makefile.ai uninstall-ai || true

	@$(MAKE) -f Makefile.git uninstall-git || true

	@$(MAKE) -f Makefile.dev uninstall-dev || true

	@$(MAKE) -f Makefile.core uninstall-core || true

	@echo "All tools uninstalled!"

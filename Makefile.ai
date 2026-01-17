# ==============================================================================
#  AI Coding Agents (OpenCode & Crush)
# ==============================================================================

include Makefile.common

.PHONY: all install-ai opencode crush help uninstall-opencode uninstall-crush uninstall-ai

all: install-ai

help:
	@echo "======================================================================"
	@echo "  Makefile.ai - AI Coding Agents (OpenCode & Crush)"
	@echo "======================================================================"
	@echo ""
	@echo "Available targets:"
	@echo "  make install-ai        - Install both OpenCode and Crush"
	@echo "  make uninstall-ai      - Uninstall both agents"
	@echo ""
	@echo "Individual agents:"
	@echo "  make opencode          - Install OpenCode (interactive)"
	@echo "  make crush             - Install Crush (interactive)"
	@echo "  make uninstall-opencode - Uninstall OpenCode"
	@echo "  make uninstall-crush    - Uninstall Crush"
	@echo ""
	@echo "======================================================================"

install-ai: opencode crush
	@echo "==> AI coding agents installed successfully!"
	@echo "Usage:"
	@echo "  - OpenCode: Run 'opencode' in your terminal"
	@echo "  - Crush:    Run 'crush' in your terminal"

# --- OpenCode - Open Source AI Coding Agent ---
opencode: $(BIN_DIR)/opencode

$(BIN_DIR)/opencode:
	@echo "==> Installing OpenCode..."
	@echo "Choose installation method:"
	@echo "  1. YOLO script (recommended, automatic)"
	@echo "  2. npm (requires Node.js)"
	@echo "  3. Cargo (requires Rust)"
	@echo ""
	@read -p "Enter choice [1-3]: " choice; \
	case $$choice in \
		1) \
			curl -fsSL https://opencode.ai/install | bash; \
			;; \
		2) \
			if command -v npm >/dev/null; then \
				npm install -g opencode-ai@latest; \
			else \
				echo "npm not found. Install Node.js first."; \
				exit 1; \
			fi; \
			;; \
		3) \
			if command -v cargo >/dev/null; then \
				cargo install opencode-ai; \
				ln -sf $(HOME)/.cargo/bin/opencode $(BIN_DIR)/opencode; \
			else \
				echo "Cargo not found. Install via: make -f Makefile.dev rust"; \
				exit 1; \
			fi; \
			;; \
		*) \
			echo "Invalid choice. Defaulting to YOLO script..."; \
			curl -fsSL https://opencode.ai/install | bash; \
			;; \
	esac

# --- Crush - Charmbracelet AI Coding Agent ---
crush: $(BIN_DIR)/crush

$(BIN_DIR)/crush:
	@echo "==> Installing Crush..."
	@echo "Choose installation method:"
	@echo "  1. npm (recommended)"
	@echo "  2. Go (requires Go)"
	@echo "  3. Binary download (manual)"
	@echo ""
	@read -p "Enter choice [1-3]: " choice; \
	case $$choice in \
		1) \
			if command -v npm >/dev/null; then \
				npm install -g @charmland/crush; \
			else \
				echo "npm not found. Install Node.js first."; \
				exit 1; \
			fi; \
			;; \
		2) \
			if command -v go >/dev/null; then \
				export GOPATH="$(HOME)/.local/gopath"; \
				export PATH="$(GO_DIR)/bin:$$GOPATH/bin:$(PATH)"; \
				go install github.com/charmbracelet/crush@latest; \
				ln -sf $$GOPATH/bin/crush $(BIN_DIR)/crush; \
			else \
				echo "Go not found. Install via: make -f Makefile.dev go"; \
				exit 1; \
			fi; \
			;; \
		3) \
			echo "==> Downloading Crush binary..."; \
			mkdir -p $(TMP_DIR)/crush && cd $(TMP_DIR)/crush; \
			CRUSH_VERSION=$$(curl -s https://api.github.com/repos/charmbracelet/crush/releases/latest | grep tag_name | cut -d '"' -f 4); \
			curl -fLO "https://github.com/charmbracelet/crush/releases/download/$$CRUSH_VERSION/crush_$${CRUSH_VERSION#v}_linux_$(GOARCH).tar.gz"; \
			tar -xzf *.tar.gz; \
			cp crush $(BIN_DIR)/; \
			;; \
		*) \
			echo "Invalid choice. Defaulting to npm..."; \
			if command -v npm >/dev/null; then \
				npm install -g @charmland/crush; \
			else \
				echo "npm not found. Cannot proceed."; \
				exit 1; \
			fi; \
			;; \
	esac

# --- Uninstall Targets ---
.PHONY: uninstall-opencode uninstall-crush uninstall-ai

uninstall-opencode:
	@echo "==> Uninstalling OpenCode..."
	@if command -v npm >/dev/null && npm list -g opencode-ai >/dev/null 2>&1; then \
		npm uninstall -g opencode-ai; \
	elif command -v cargo >/dev/null && cargo install --list | grep -q opencode-ai; then \
		cargo uninstall opencode-ai; \
	fi
	@rm -f $(BIN_DIR)/opencode
	@echo "OpenCode uninstalled."

uninstall-crush:
	@echo "==> Uninstalling Crush..."
	@if command -v npm >/dev/null && npm list -g @charmland/crush >/dev/null 2>&1; then \
		npm uninstall -g @charmland/crush; \
	fi
	@rm -f $(BIN_DIR)/crush
	@echo "Crush uninstalled."

uninstall-ai: uninstall-opencode uninstall-crush
	@echo "==> All AI agents uninstalled."

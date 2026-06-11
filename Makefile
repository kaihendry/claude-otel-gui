# Watch Claude Code's OTel logs and metrics live with otel-tui.
# otel-tui listens on 4317 (gRPC) and 4318 (HTTP) by default; we use 4318.

MANAGED_DIR  := /Library/Application Support/ClaudeCode
MANAGED_FILE := $(MANAGED_DIR)/managed-settings.json
# Fragments in managed-settings.d/ are merged in and can override
# managed-settings.json — clear any leftover of ours before installing.
FRAGMENT     := $(MANAGED_DIR)/managed-settings.d/10-managed-settings.json

.PHONY: install deps tui uninstall show

install: managed-settings.json
	sudo mkdir -p "$(MANAGED_DIR)"
	sudo rm -f "$(FRAGMENT)"
	sudo cp managed-settings.json "$(MANAGED_FILE)"
	@echo "Installed. Restart claude and run 'make tui' in another terminal."

deps:
	brew install ymtdzzz/tap/otel-tui

tui:
	otel-tui

uninstall:
	sudo rm -f "$(MANAGED_FILE)" "$(FRAGMENT)"
	@echo "Removed managed settings."

show:
	@cat "$(MANAGED_FILE)" 2>/dev/null || echo "No managed settings installed."

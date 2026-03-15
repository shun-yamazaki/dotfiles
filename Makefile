.PHONY: all brew-install bundle-all config-setup

# VS Code の設定ディレクトリ（Mac用）
VSCODE_SETTING_DIR = $(HOME)/Library/Application\ Support/Code/User

# 定義: バックアップを取ってシンボリックリンクを作成する関数
# $(1): ソースファイル（リポジトリ内）
# $(2): ターゲット（ホームディレクトリなど）
define link_file
	@if [ -f "$(2)" ] && [ ! -L "$(2)" ]; then \
		echo "📦 Backing up $(2) to $(2).bak"; \
		mv "$(2)" "$(2).bak"; \
	fi
	@ln -sf "$(1)" "$(2)"
	@echo "🔗 Linked: $(2) -> $(1)"
endef

all: brew-install bundle-all config-setup
	@echo "✨ Setup complete! Please restart your terminal."

brew-install:
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "🍺 Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
	@echo "✅ Homebrew is ready."

bundle-all:
	brew bundle --file=Brewfile --verbose

config-setup:
	@echo "🛠  Deploying configuration files..."
	@mkdir -p ~/.config/sheldon ~/.config/nvim ~/.config/karabiner
	@mkdir -p "$(VSCODE_SETTING_DIR)"

	$(call link_file,$(PWD)/.zshrc,$(HOME)/.zshrc)
	$(call link_file,$(PWD)/plugins.toml,$(HOME)/.config/sheldon/plugins.toml)
	$(call link_file,$(PWD)/init.lua,$(HOME)/.config/nvim/init.lua)
	$(call link_file,$(PWD)/.gitconfig,$(HOME)/.gitconfig)
	$(call link_file,$(PWD)/.gitignore_global,$(HOME)/.gitignore_global)
	$(call link_file,$(PWD)/settings.json,$(VSCODE_SETTING_DIR)/settings.json)
	$(call link_file,$(PWD)/karabiner.json,$(HOME)/.config/karabiner/karabiner.json)

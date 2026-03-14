.PHONY: all brew-install bundle-all config-setup

all: brew-install bundle-all config-setup
	@echo "✨ Setup complete! Please restart your terminal."

# 1. Homebrew 自体のインストール (なければ実行)
brew-install:
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com)"; \
		eval "$$(/opt/homebrew/bin/brew shellenv)"; \
	fi

# 2. Brewfile の一括インストール
bundle-all:
	brew bundle --file=Brewfile

# 3. 各種設定ファイルの配置
config-setup:
	mkdir -p ~/.config/sheldon ~/.config/nvim
	cp plugins.toml ~/.config/sheldon/plugins.toml
	cp init.lua ~/.config/nvim/init.lua
	cp .zshrc ~/.zshrc
	@echo "Configuration files have been deployed."

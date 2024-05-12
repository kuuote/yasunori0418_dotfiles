.DEFAULT_GOAL := help
MAKEFLAGS += --always-make

# INFO: 参考サイト - https://postd.cc/auto-documented-makefile/
help: ## subcommand list and description.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

nvim-build: ## building neovim head.
	@./scripts/nvim_build.sh

nvim-night: ## download neovim at version nightly build.
	@./scripts/nvim_night.sh

true-color: ## 24-bit-color.sh
	@curl -s \
	https://gist.githubusercontent.com/lifepillar/09a44b8cf0f9397465614e622979107f/raw/24-bit-color.sh \
	| bash
	@./scripts/termcolors

zsh-bench: ## zsh bench mark with hyperfine used.
	@hyperfine -w 5 -r 100 'zsh -i -c exit'

nvim-bench: ## neovim bench mark with vim-startuptime used.
	-@vim-startuptime -vimpath nvim -count 100 | head -6
	@sleep 3
	@hyperfine -i -w 5 -r 100 "nvim -c q!"

arch_iso: ## Download Arch Linux iso image at latest, and verification.
	@./scripts/arch_iso.sh

pkglist: ## Update Arch Linux package list.
	@./scripts/update_pkglist.sh

path: ## List up for $PATH
	@printenv \
	| rg '^PATH' \
	| sed -e 's/PATH=//' \
	| sed -e 's/:/\n/g'

repolist: ## Update ghq management of repository list.
	@ghq list > ./document/repolist.txt

repoget: ## Get and update ghq management repositories.
	@cat ./document/repolist.txt | ghq get -p -u --parallel

work_repolist: ## Update ghq management of repository list.
	@./scripts/work_repolist.sh view

work_repoget: ## Get and update ghq management repositories.
	@./scripts/work_repolist.sh

mise-install: ## Install mise
	@curl https://mise.jdx.dev/install.sh | sh

aqua-install: # Install aqua
	@curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.0.1/aqua-installer | bash

devbox-install: ## Install nix and devbox
	@curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
	@curl -fsSL https://get.jetify.com/devbox | bash

symlink: ## expand symlinks
	@./scripts/expand_symlink.sh

mkdir: ## make direcotries of required
	@mkdir -p ${HOME}/.local/bin
	@mkdir -p ${HOME}/.local/dotfiles
	@mkdir -p ${HOME}/.config
	@mkdir -p ${HOME}/.cache


init: ## expand config files.
	@make mkdir
	@make mise-install
	@make symlink

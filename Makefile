SHELL = bash

.PHONY: fonts

default: brew git fish fzf langs neovim tmux base16 fonts done

brew:
	./scripts/brew

git:
	./scripts/git

fish:
	./scripts/fish

fzf:
	./scripts/fzf

langs:
	./scripts/langs

neovim:
	./scripts/neovim

tmux:
	./scripts/tmux

base16:
	./scripts/base16

fonts:
	./scripts/fonts

done:
	@printf "\nDone! Please, restart shell.\n"

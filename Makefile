SHELL = bash

default: basic git fish fzf neovim tmux base16 done

basic:
	./scripts/basic

git:
	./scripts/git

fish:
	./scripts/fish

fzf:
	./scripts/fzf

neovim:
	./scripts/neovim

tmux:
	./scripts/tmux

base16:
	./scripts/base16

fonts:
	./scripts/fonts

done:
	@printf "\nDone! Please, restart the shell.\n"

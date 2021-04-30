SHELL = bash

.PHONY: fonts

default: packages git fish fzf asdf vim tmux base16 fonts done

packages:
	./scripts/install_packages

git:
	./scripts/install_git

fish:
	./scripts/install_fish

fzf:
	./scripts/install_fzf

asdf:
	./scripts/install_asdf

vim:
	./scripts/install_vim

tmux:
	./scripts/install_tmux

base16:
	./scripts/install_base16

fonts:
	./scripts/install_fonts

done:
	@printf "\nDone! Pleasee, restart shell.\n"

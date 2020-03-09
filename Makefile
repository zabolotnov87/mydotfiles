SHELL = bash

default: packages git asdf vim tmux base16 fish

packages:
	./scripts/install_packages

git:
	./scripts/install_git

asdf:
	./scripts/install_asdf

vim:
	./scripts/install_vim

tmux:
	./scripts/install_tmux

base16:
	./scripts/install_base16

fish:
	./scripts/install_fish

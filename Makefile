SHELL = bash

default: packages git base16 vim fish tmux asdf

packages:
	brew install \
		direnv \
		rg \
		translate-shell \
		python3

git:
	./scripts/install_git

base16:
	./scripts/install_base16

asdf:
	./scripts/install_asdf

vim:
	./scripts/install_vim

fish:
	./scripts/install_fish

tmux:
	./scripts/install_tmux

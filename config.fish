# Common aliases
alias ll   "ls -al"
alias tls  "tmux list-sessions"
alias tmux "env TERM=xterm-256color tmux"
alias vim  "new_or_fg nvim"
alias vi   "vim"
alias lfc  "source ~/.config/fish/config.fish"
alias ltc  "tmux source-file ~/.tmux.conf"
alias my   "pushd ~/mydotfiles"
alias b    "popd"
alias efc  "vi ~/.config/fish/config.fish"
alias evrc "vi ~/.config/nvim/init.vim"

# Git
alias ga     "git a -p"
alias gco    "git co"
alias gs     "git s"
alias gls    "git ls"
alias gg     "git g"
alias gl     "git last"
alias gc     "git c"
alias gu     "git up"
alias gb     "git b"
alias gp     "git put"
alias gd     "git d"
alias gm     "git merge"
alias gup    "git up"
alias gbd    "git b -D"
alias gclean "git co -- .; git clean -fd"
alias gds    "git ds"

# Bundler
alias bi "bundle install"
alias be "bundle exec"
alias bo "bundle open"

alias reload "lfc && ltc"
alias ec "nvim -p ~/.tmux.conf.local ~/.config/fish/config.fish ~/.config.fish.local ~/.vimrc.local && reload"

function ta
  tmux attach-session -t $argv;
end

function fco -d "Fuzzy-find branch and checkout it"
  git branch --all | grep -v HEAD | string trim | fzf | xargs git co
end

function tags -d "Print last n tags, example: tags 3"
  set -l n $argv[1]
  set -q n[1]; or set -l n 1
  git tag --sort=-v:refname | head -n $n
end

function new_or_fg
  set -l job (jobs | grep -e "$argv\$")
  if test -n "$job"
    set -l group (echo $job | awk '{print $2}')
    fg $group
  else
    eval $argv
  end
end

bind \cb fco

# Setup color scheme for Fuzzy Finder
source ~/git/base16-fzf/fish/base16-eighties.fish

set -x EDITOR nvim
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set -g fish_user_paths "/usr/local/opt/openssl/bin" $fish_user_paths
set -x DIRENV_LOG_FORMAT ""
set -x GOPATH $HOME/go
set -x GOBIN $GOPATH/bin
set -x PATH $PATH $GOBIN $HOME/bin

mkdir -p $GOPATH
mkdir -p $GOBIN
mkdir -p $HOME/bin

set fish_greeting

# Configure direnv
eval (direnv hook fish)

# Setup asdf
source ~/.asdf/asdf.fish

source ~/.config.fish.local

set -x FZF_DEFAULT_OPTS "--reverse $FZF_DEFAULT_OPTS"

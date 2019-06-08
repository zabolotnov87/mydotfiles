# Common aliases
alias ll   "ls -al"
alias tls  "tmux list-sessions"
alias tmux "env TERM=xterm-256color tmux"
alias vim  "nvim"
alias vi   "nvim"
alias lfc  "source ~/.config/fish/config.fish"
alias ltc  "tmux source-file ~/.tmux.conf"

# Git
alias ga  "git a -p"
alias gco "git co"
alias gs  "git s"
alias gls "git ls"
alias gg  "git g"
alias gl  "git last"
alias gc  "git c"
alias gu  "git up"
alias gb  "git b"
alias gp  "git put"
alias gd  "git d"
alias gm  "git merge"

# Bundler
alias bi "bundle install"
alias be "bundle exec"
alias bo "bundle open"

alias reload "lfc && ltc"
alias edit-configs "nvim -p ~/.tmux.conf.local ~/.config.fish.local ~/.vimrc.local && reload"

function ta
  tmux attach-session -t $argv;
end

function fco -d "Fuzzy-find and checkout a branch"
  git branch --all | grep -v HEAD | string trim | fzf | xargs git checkout
end

# Setup color scheme for Fuzzy Finder
source ~/git/base16-fzf/fish/base16-eighties.fish

set -x EDITOR nvim
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set -x PATH $PATH $HOME/bin
set -g fish_user_paths "/usr/local/opt/openssl/bin" $fish_user_paths
set -x DIRENV_LOG_FORMAT ""

# Configure direnv
eval (direnv hook fish)

# Setup asdf
source ~/.asdf/asdf.fish

source ~/.config.fish.local

set -x FZF_DEFAULT_OPTS "--reverse $FZF_DEFAULT_OPTS"

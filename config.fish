################################################################################
# Aliases
################################################################################

# Common
alias ll   "ls -al"
alias tls  "tmux list-sessions"
alias tmux "env TERM=xterm-256color tmux"
alias spec "bundle exec rescue rspec"
alias vim  "nvim"
alias vi   "nvim"
alias lfc  "source ~/.config/fish/config.fish"

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

################################################################################
# Functions
################################################################################

function ta
  tmux attach-session -t $argv;
end

function fco -d "Fuzzy-find and checkout a branch"
  git branch --all | grep -v HEAD | string trim | fzf | xargs git checkout
end

################################################################################
# Set environment variables
################################################################################
set -x EDITOR nvim
set -x PAGER most
set -x PATH $PATH $HOME/bin
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x FZF_DEFAULT_OPTS '--height 40% --reverse'
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# Configure direnv
eval (direnv hook fish)

# Setup asdf
source ~/.asdf/asdf.fish

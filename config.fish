# Common aliases
alias ll   "ls -alh"
alias tmux "env TERM=xterm-256color tmux"
alias tls  "tmux list-sessions"
alias vim  "new_or_fg nvim"
alias vi   "vim"
alias lfc  "source ~/.config/fish/config.fish"
alias ltc  "tmux source-file ~/.tmux.conf"
alias my   "pushd ~/mydotfiles"
alias wiki "pushd ~/Dropbox/wiki && nvim index.md"
alias b    "popd"
alias etc  "vi ~/.tmux.conf && ltc"
alias efc  "vi ~/.config/fish/config.fish && lfc"
alias elc  "vi ~/.config.fish.local && lfc"
alias pf   "ps aux | fzf"
alias drmi "docker images -qf dangling=true | xargs docker rmi -f"

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
alias gup    "git up"
alias gbd    "git b -D"
alias gclean "git add .; git reset HEAD; git co -- .; git clean -fd"
alias gds    "git ds"
alias cpb    "git rev-parse --abbrev-ref HEAD | pbcopy"
alias gdl    "git d HEAD^.."
alias gdlf   "git d HEAD^.. --name-only"
alias gr     "git rebase"
alias glp    "git log -p"

# Bundler
alias bi "bundle install"
alias be "bundle exec"
alias bo "bundle open"

function fzf
  env FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS fzf
end

function ta
  tmux attach-session -t $argv || tmux new -As $argv
end

function tk
  tmux kill-session -t $argv
end

function fco -d "Fuzzy-find branch"
  set -l branch (git branch | grep -v HEAD | string trim | fzf)
  if string length -q -- $branch
    set -l branch (string replace -r '\*' '' $branch)
    set -l branch (string replace -r '\s' '' $branch)
    set -l branch (string replace -r 'remotes\/origin\/' '' $branch)
    commandline -it -- $branch
  end
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

function colors
  set -l color (functions | grep base16- | fzf)
  if string length -q -- $color
    $color
  end
end

function rn
  set -l usage 'Usage: rn [name] [old] [new]'
  set -l name $argv[1]
  if ! set -q name[1]
    echo $usage; return 1
  end
  set -l old $argv[2]
  if ! set -q old[1]
    echo $usage; return 1
  end
  set -l new $argv[3]
  if ! set -q new[1]
    echo $usage; return 1
  end
  find . -type f -name $name -not -path './vendor/*' -print | xargs sed -i '' -e "s/$old/$new/g"
end

if test -e /opt/homebrew/bin/brew
  eval $(/opt/homebrew/bin/brew shellenv)
end

bind \cb fco
bind \ct fzf

set -e -g FZF_DEFAULT_OPTS
set -U FZF_DEFAULT_OPTS '--reverse --height 60%'
mkdir -p $HOME/tmp
set -gx FZF_DEFAULT_OPTS_FILE "$HOME/tmp/fzf_default_opts"

test -e $FZF_DEFAULT_OPTS_FILE; or echo $FZF_DEFAULT_OPTS > $FZF_DEFAULT_OPTS_FILE

set -gx FZF_IGNORE_LIST 'node_modules,.git,tmp,vendor,sorbet'
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --no-ignore-vcs -g "!{$FZF_IGNORE_LIST}"'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

set -gx EDITOR nvim
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8

mkdir -p ~/bin
fish_add_path ~/bin

if test -e ~/.cargo/bin
  fish_add_path ~/.cargo/bin
end

# Remove greeting
set fish_greeting

# Configure direnv
set -gx DIRENV_LOG_FORMAT ""
eval (direnv hook fish)
if test -e .envrc
  direnv allow
end

if test -e ~/.asdf/asdf.fish
  source ~/.asdf/asdf.fish
end

# Setup base16 colorscheme (shell, fzf)
set -l base16_dir ~/.config/base16
set -gx BASE16_SHELL_HOOKS $base16_dir/hooks
if test -e $base16_dir/shell/profile_helper.fish
  source $base16_dir/shell/profile_helper.fish
end
if test -e ~/.base16_fzf
  source ~/.base16_fzf
end

# Apply Local settings
if test -e ~/.config.fish.local
  source ~/.config.fish.local
end

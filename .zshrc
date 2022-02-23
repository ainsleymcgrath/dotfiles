# zmodload zsh/zprof

# Enable completions
autoload -Uz compinit;
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit;
else
  compinit -C;
fi

# Antibody
source ~/.zsh_plugins.sh

# # Eventually reload completions
# read < <( compinit );

# Config
export DISABLE_AUTO_TITLE="true"
export COMPLETION_WAITING_DOTS="true"
# GET CRAZY WITH LUNARVIM
export EDITOR="lvim"
export BAT_THEME="base16"
export HISTCONTROL=ignoreboth:erasedups
export FZF_CTRL_T_OPTS="--preview-window=right:60% --height 100% --layout reverse-list --preview '(bat --color=always --style=numbers --line-range :500 {} || exa -T --color=always {}) 2> /dev/null'"

setopt auto_cd

# python utils
eval "$(pyenv init -)"
source $HOME/.poetry/env
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# aliases
alias c="clear"
alias wpy="which python"
alias jno="jupyter notebook"
alias ipy="ipython"
alias pyma="python manage.py"
alias pyact="pyenv activate"
alias po="poetry"
alias txl="tmux ls"
alias _txk="tmux kill-session -t"
alias l="exa -1a"
alias ll="exa -la"
alias soz=". ~/.zshrc"
alias mux="tmuxinator"

alias gcoh="gco HEAD -- "
alias gcom="gco master -- "
alias glom="glo master.."
alias glo1="glo -n1"
alias glo5="glo -n5"
alias glo10="glo -n10"
alias gsdt="gd --stat"
alias gsbm="gsb master.."
alias gdstm="gd --stat master.."

alias doco="docker-compose"
alias md="mkdir -p"

# removes status indicators and the first line with sd
alias black_modified="gsb | rg '.py' | sd '^\s{0,2}[A-Z?]{1,2}|#.*' '' | xargs black"

function txk() {
    for session_name in "$@"
    do
        _txk $session_name
    done
}

# 'list tree' : 
# `lt [path] [level]
# $1=path [default=pwd]
# $2=level [default=99]
# $3=ignores [default="__pycache__|node_modules"]
function lt() {
    default_ignores="__pycache__|node_modules"
    default_depth=99

    if [[ -z $1 && -z $2 ]]; then
        exa -T -I $default_ignores -L $default_depth
    elif [[ -n $1 && -z $2 ]]; then
        exa -T -I $default_ignores -L $default_depth $1
    # elif [[ -n $3 ]]; then
    #     exa -T -I $default_ignores\|$3 -L $default_depth $1
    else
        exa -T -I $default_ignores -L $2 $1
    fi
}

# 'tmux attach' :
# attach to last tmux session or specify one
# $1=taget session
function txa() {
    if [[ -z ${1} ]]; then
        tmux -CC attach
    else
        tmux -CC attach -t $1
    fi
}

# 'tmux new' :
# $1=session name [default=pwd]
function txn() {
    if [[ -z ${1} ]]; then
        tmux new -c $(pwd)
    else 
        tmux new -s $1 -c $(pwd)
    fi
}

# reboots a session
# $1=session name
function muxrestart() {
    tmuxinator stop $1
    tmuxinator start $1
}

# list virtualenvs, fzf them,
# strip everything but the name from the result, activate it
function fzv () {
  pyact $(pyenv virtualenvs | fzf | sd '\(.*' '')
}

# fuzzy search & checkout git branch
function fzb() {
  gco $(gb -l | fzf)
}

# check out aliases
function fzfa() {
  alias | fzf
}

function pwd-leaf() {
  echo $(pwd | awk -F "/" '{print $NF}')
}

# make a venv named after current dir
function cwd-mkvenv() {
  version=$1
  name=$(pwd-leaf)
  pyenv virtualenv $version $name
  pyenv activate $name
}

# activate venv named after this repo
function venv() {
  name=$(pwd-leaf)
  pyenv activate $name
}

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(_NOT_COMPLETE=source_zsh not 2>/dev/null)"

zstyle ':completion:*' menu select
fpath+=~/.zfunc

export PATH="/Users/ains/.deta/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"

eval "$(fnm env)"
alias nvm="fnm"

eval "$(zoxide init zsh)"

# After-hook
if [ -f ~/.zshrc_local_after ]; then
  source ~/.zshrc_local_after
fi

# zprof
export EE_EXTRA_DATETIME_INPUT_FORMATS='["MMM D YY", "MMM D", "MMMD", "ddd"]'

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
read < <( compinit );

# Config
export DISABLE_AUTO_TITLE="true"
export COMPLETION_WAITING_DOTS="true"
export EDITOR="nvim"
export BAT_THEME="Solarized (light)" #"base16"
export HISTCONTROL=ignoreboth:erasedups
export FZF_CTRL_T_OPTS="--preview-window=right:60% --height 100% --layout reverse-list --preview '(bat --color=always --style=numbers --line-range :500 {} || exa -T --color=always {}) 2> /dev/null'"

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
alias txk="tmux kill-session -t"
alias l="exa -1a"
alias ll="exa -la"
alias soz=". ~/.zshrc"
alias mux="tmuxinator"
alias gcoh="gco HEAD -- "
alias glom="glo master.."
alias glo1="glo -n1"
alias glo5="glo -n5"

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
        tmux attach
    else
        tmux attach -t $1
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

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# After-hook
if [ -f ~/.zshrc_local_after ]; then
  source ~/.zshrc_local_after
fi

eval "$(_NOT_COMPLETE=source_zsh not 2>/dev/null)"

zstyle ':completion:*' menu select
fpath+=~/.zfunc


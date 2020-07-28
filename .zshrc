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
export BAT_THEME="base16"
export HISTCONTROL=ignoreboth:erasedups

# python utils
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
source $HOME/.poetry/env

# aliases
alias c="clear"
alias wpy="which python"
alias jno="jupyter notebook"
alias txl="tmux ls"
alias txk="tmux kill-session -t"
alias l="exa -1a"
alias ll="exa -la"

# 'list tree' : 
# use exa to tree out directory completely or specify level in $1
function lt() {
    if [[ -z ${2} ]]; then
        exa -T -L 99 $1
    else
        exa -T -L $1 $2
    fi
}

# 'tmux attach' :
# attach to last tmux session or specify one
function txa() {
    if [[ -z ${1} ]]; then
        tmux attach
    else
        tmux attach -t $1
    fi
}

# 'tmux new' :
# $1 is optional session name, $2 is optional sessin pwd
function txn() {
    if [[ -z ${1} ]]; then
        tmux new
    elif [[ -n ${1} ]] && [[ -n ${2} ]]; then
        tmux new -s $1 -c $2
    elif [[ -n ${1} ]]; then
        tmux new -s $1
    fi
}

# 'markdown'
# create file with name $1 in $MARKDOWNS, if -o, open with system viewer
function mrk() {
    #TODO
    echo
}

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

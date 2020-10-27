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
# new session with root dir of cwd $1 is optional session name
function txn() {
    if [[ -z ${1} ]]; then
        tmux new -c $(pwd)
    else 
        tmux new -s $1 -c $(pwd)
    fi
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

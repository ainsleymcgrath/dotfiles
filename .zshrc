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
source $HOME/.poetry/env

alias c="clear"
alias wpy="which python"
alias pyv="python -V"
alias jno="jupyter notebook"
alias ipy="ipython"
alias pyma="python manage.py"
alias pyact=". ./.venv/bin/activate"
alias pya="pyact"
alias pyin="pip install -r requirements-dev.txt 2> /dev/null || pip install -r requirements_dev.txt"
alias dea="deactivate"
alias po="poetry"
alias poed="poetry run lvim"
alias txl="tmux ls"
alias _txk="tmux kill-session -t"
alias l="exa -1a"
alias ll="exa -la"
alias lt="exa -T --git-ignore"
alias soz=". ~/.zshrc"
alias mux="tmuxinator"
alias wcl="wc -l"

alias gcoh="gco HEAD -- "
alias gcom="gco master -- 2> /dev/null || gco main --"
alias glom="glo master.. 2> /dev/null || glo main.."
alias glo1="glo -n1"
alias glo5="glo -n5"
alias glo10="glo -n10"
alias gsdt="gd --stat"
alias gsbm="gsb master.."
alias gdstm="gd --stat master.. 2> /dev/null || gd --stat main.."

alias nuke-venv="deactivate 2>/dev/null || true && rm -rf .venv"
alias doco="docker-compose"
alias md="mkdir -p"
alias bap="bat -P --style plain"
alias ezsh="$EDITOR ~/.zshrc"
alias civ="circleci config validate"
alias pc="pre-commit"

unalias gp
function gp() {
  git push -u origin $(gb --show-current) "$@"
}

function gcopb() {
  branch=$(pbpaste)
  git checkout "$branch" "$@" 2> /dev/null \
    || git checkout -b "$branch"
}
# removes status indicators and the first line with sd
alias black_modified="gsb | rg '.py' | sd '^\s{0,2}[A-Z?]{1,2}|#.*' '' | xargs black"

function txk() {
    for session_name in "$@"
    do
        _txk $session_name
    done
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
  gco $(gb -l -a | sd "/remotes|\*|\+" "" | fzf)
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
  if [[ ! -e .python-version ]]; then
    echo 'No .python-version found. Exiting.'
  fi

  python -m venv .venv
  pyact
  pip install --upgrade pip
}

function fzfig () {
  figlet -f $(figlet -l | fzf --preview "figlet -f {} $1" --preview-window=right,75%) $1
}

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

export EE_EXTRA_DATETIME_INPUT_FORMATS='["MMM D YY", "MMM D", "MMMD", "ddd"]'

eval "$(pyenv init -)"
# zprof

# zmodload zsh/zprof
source ~/.zgenom/sources/init.zsh;

setopt auto_cd
setopt HIST_IGNORE_ALL_DUPS

# https://github.com/zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
export HISTORY_SUBSTRING_SEARCH_PREFIXED=1

export EDITOR="lvim"
export BAT_THEME="base16"
export HISTCONTROL=ignoreboth:erasedups
export FZF_CTRL_T_OPTS="--preview-window=right:60% --height 100% --layout reverse-list --preview '(bat --color=always --style=numbers --line-range :500 {} || exa -T --color=always {}) 2> /dev/null'"

alias c="clear"
alias soz=". ~/.zshrc"
alias wcl="wc -l"
alias md="mkdir -p"
alias ezsh="$EDITOR ~/.zshrc"
alias ewez="$EDITOR ~/.wezterm.lua"

alias wpy="which python"
alias pyv="python -V"
alias ipy="ipython"
alias pyact=". ./.venv/bin/activate"
alias pya="pyact"
alias pyin="./.venv/bin/python -m pip install -r requirements-dev.txt 2> /dev/null || ./.venv/bin/python -m pip install -r requirements_dev.txt 2> /dev/null || ./.venv/bin/python -m pip install -r requirements.txt 2> /dev/null || echo 'No requirements file.'"
alias dea="deactivate"
alias nuke-venv="deactivate 2>/dev/null || true && rm -rf .venv"

# source $HOME/.poetry/env
alias po="poetry"
alias poed="poetry run lvim"
export PATH="$HOME/.poetry/bin:$PATH"

alias txl="tmux ls"
alias _txk="tmux kill-session -t"
alias mux="tmuxinator"

alias l="exa -1a"
alias ll="exa -la"
alias lt="exa -T --git-ignore"

alias bap="bat -P --style plain"

source ~/.git-aliases
alias gcoh="gco HEAD -- "
alias gcom="gco master -- 2> /dev/null || gco main --"
alias glom="glo master.. 2> /dev/null || glo main.."
alias glo1="glo -n1"
alias glo5="glo -n5"
alias glo10="glo -n10"
alias gsdt="gd --stat"
alias gsbm="gsb master.."
alias gdstm="gd --stat master.. 2> /dev/null || gd --stat main.."
function gp() {
  git push -u origin $(gb --show-current) "$@"
}
function gcopb() {
  branch=$(pbpaste)
  git checkout "$branch" "$@" 2> /dev/null \
    || git checkout -b "$branch"
}

alias doco="docker-compose"

alias civ="circleci config validate"

alias slv="serverless config validate"

alias pc="pre-commit"

alias ul="ultralist"
alias ull="ul l"
alias ula="ul a"
alias ulc="ul c"
alias ule="ul e"

alias marp-serve="npx @marp-team/marp-cli@latest -w"
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# list all homebrew packages and show their info
function fzfbrew() {
   brew list -1 -t | sort | fzf -m --preview="brew info {}"
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

function fzcd() {
  cd $(exa -Dl1 --git-ignore -I "__pycache__|node_modules|*egg*" | fzf)
}

function pwd-leaf() {
  echo $(pwd | awk -F "/" '{print $NF}')
}

# make a venv named after current dir
function cwd-mkvenv() {
  if [[ ! -e .python-version ]]; then
    echo 'No .python-version found. Exiting.'
    return
  fi

  python -m venv .venv
  .venv/bin/python -m pip install --upgrade pip
  pyin
  echo "Now source! '. ./.venv/bin/activate' copied to ur clipboard."
  echo '. ./.venv/bin/activate' | pbcopy
}

function fzfig () {
  figlet -f "$(figlet -l | fzf --preview "figlet -f {} $1" --preview-window=right,75%)" $1 | pbcopy
}


eval "$(fnm env)"
alias nvm="fnm"
 
eval "$(zoxide init zsh)"
# 
# export EE_EXTRA_DATETIME_INPUT_FORMATS='["MMM D YY", "MMM D", "MMMD", "ddd"]'
# 
# export FLYCTL_INSTALL="/Users/ains/.fly"
# export PATH="$FLYCTL_INSTALL/bin:$PATH"
# 
eval "$(pyenv init -)"

eval "$(starship init zsh)"

# lvim, python executables end up here
export PATH="$HOME/.local/bin:$PATH"

# After-hook
if [ -f ~/.zshrc_local_after ]; then
  source ~/.zshrc_local_after
fi
# # zprof

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
export BAT_THEME="GitHub"

# aliases
alias c="clear"
alias dotfiles="cd ~/dotfiles"
alias wpy="which python"

function muxrestart() {
    tmuxinator stop $1
    tmuxinator start $1
}


# tmuxinator completion & alias
source ~/.bin/tmuxinator.zsh

# After-hook
if [ -f ~/.zshrc_local_after ]; then
  source ~/.zshrc_local_after
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

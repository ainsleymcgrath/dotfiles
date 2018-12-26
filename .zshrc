# Antigen
source ~/antigen.zsh;

# Load the oh-my-zsh's library.
antigen use oh-my-zsh;
antigen bundle git;
antigen bundle github;
antigen bundle command-not-found;
antigen bundle colored-man-pages;
antigen bundle colorize;
antigen bundle cp;
antigen bundle wd;
export NVM_AUTO_USE=true
antigen bundle lukechilds/zsh-nvm;
antigen bundle $HOME/.oh-my-zsh/custom

# Load the theme.
antigen theme ys;

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell antigen that you're done.
antigen apply

# Config
export DISABLE_AUTO_TITLE="true"
export COMPLETION_WAITING_DOTS="true"
export EDITOR="vim"

# tmuxinator completion & alias
source ~/.bin/tmuxinator.zsh

# After-hook
if [ -f ~/.zshrc_local_after ]; then
  source ~/.zshrc_local_after
fi

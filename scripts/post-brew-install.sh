#!/usr/bin/env bash

# rust
if [[ -z $(which cargo) ]]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
  echo "Rust already installed"
fi

# fzf extras
$(brew --prefix)/opt/fzf/install --key-bindings --no-completion --no-update-rc  --no-bash --no-zsh --no-fish
# lunarvim
if [[ -z $(which lvim) ]]; then
    LV_BRANCH='release-1.3/neovim-0.9'
    bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh) 
else
  echo "LunarVim already installed"
fi


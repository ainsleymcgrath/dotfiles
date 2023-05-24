#!/bin/bash

# run me to compile plugins!
# based on https://github.com/SalomonSmeke/dotfiles/blob/main/setup.sh#L70-L96

TARGET_DIR="$HOME"

rm -rf "${TARGET_DIR}/.zgenom"
git clone https://github.com/jandamm/zgenom.git "${TARGET_DIR}/.zgenom"

zsh -c "
. ${TARGET_DIR}/.zgenom/zgenom.zsh

zgenom load ohmyzsh/ohmyzsh plugins/gitfast
zgenom load zdharma/fast-syntax-highlighting
zgenom load zpm-zsh/colorize
zgenom load zuxfoucault/colored-man-pages_mod
zgenom load zsh-users/zsh-autosuggestions
zgenom load zsh-users/zsh-history-substring-search
zgenom load jeffreytse/zsh-vi-mode
zgenom load mfaerevaag/wd

zgenom save
zcompile ${TARGET_DIR}/.zgenom/sources/init.zsh
"

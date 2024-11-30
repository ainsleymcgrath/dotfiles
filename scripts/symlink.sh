#! /usr/bin/env bash
mkdir -p ~/.config/nvim

envsubst <symlinks.txt | while IFS=' | ' read -r source target; do
  if [[ ! -f "$source" ]]; then
    echo "❌ No such file '$source'"
    exit 1
  fi

  expanded_source=$(readlink -f "$source")

  if [[ -f "$target" ]]; then
    echo "Symlink from $source to $target already exists."
  else
    echo "Linking $expanded_source to $target."
    ln -s "$expanded_source" "$target"
  fi
done

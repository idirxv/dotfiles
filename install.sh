#!/usr/bin/env bash
set -euo pipefail

command -v stow >/dev/null 2>&1 || { echo "GNU stow is required"; exit 1; }

packages=(zsh tmux alacritty lvim vscode espanso)

for pkg in "${packages[@]}"; do
  stow -v "$pkg"
done

mkdir -p "$HOME/scripts"
for file in scripts/*; do
  [ -f "$file" ] || continue
  ln -sf "$(pwd)/$file" "$HOME/scripts/"
done

if [ -x scripts/install-fonts.sh ]; then
  scripts/install-fonts.sh
fi

echo "Dotfiles installed."


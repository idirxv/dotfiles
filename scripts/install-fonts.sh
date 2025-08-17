#!/usr/bin/env bash
set -euo pipefail

version="latest"
tmp_dir="$(mktemp -d)"

curl -fLo "$tmp_dir/FiraCode.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip -oq "$tmp_dir/FiraCode.zip" -d "$tmp_dir"
mkdir -p "$HOME/.local/share/fonts"
cp "$tmp_dir"/*.ttf "$HOME/.local/share/fonts/"
fc-cache -f

echo "FiraCode Nerd Font installed"


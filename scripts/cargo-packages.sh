#!/usr/bin/env bash
set -euo pipefail
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/common-print.sh"

if ! command -v cargo >/dev/null 2>&1; then
  die "Cargo is not installed. Please install it first."
fi

packages=(
  cargo-update
  lsd
  bat
  fd-find
  ripgrep
  zoxide
)

for package in "${packages[@]}"; do
  if cargo install "$package"; then
    print_green "$package installed successfully"
  else
    print_red "Failed to install $package"
  fi
done


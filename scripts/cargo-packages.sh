#!/bin/bash

. common-print.sh

# This script will install the packages managed by cargo

# Check if cargo is installed
if ! command -v cargo &>/dev/null; then
  die "Cargo is not installed. Please install it first."
fi

packages=(
  "cargo-update"
  "lsd"
  "bat"
  "fd-find"
  "ripgrep"
  "zoxide"
)

for package in "${packages[@]}"; do
  if cargo install $package; then
    print_green "$package installed successfully"
  else
    print_red "Failed to install $package"
  fi
done

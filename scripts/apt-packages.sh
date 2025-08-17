#!/usr/bin/env bash
set -euo pipefail
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/common-print.sh"

packages=(
    automake
    arp-scan
    bison
    build-essential
    ca-certificates
    chrpath
    cmake
    cpio
    curl
    debianutils
    diffstat
    gawk
    gcc-multilib
    git-core
    git
    gparted
    htop
    fzf
    iputils-ping
    libevent-dev
    libfontconfig1-dev
    libncurses5-dev
    libsdl1.2-dev
    meld
    python-is-python3
    python3-pexpect
    python3-pip
    python3
    pkg-config
    socat
    texinfo
    unzip
    vim
    wget
    xclip
    xterm
    xz-utils
    zsh
)

if sudo apt-get install -y "${packages[@]}"; then
    print_green "Packages installed successfully"
else
    die "Failed to install packages"
fi


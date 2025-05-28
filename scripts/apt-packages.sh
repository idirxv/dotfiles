#!/bin/bash

packages=(
    "automake"
    "arp-scan"
    "bison"
    "build-essential"
    "ca-certificates"
    "chrpath"
    "cmake"
    "cpio"
    "curl"
    "debianutils"
    "diffstat"
    "gawk"
    "gcc-multilib"
    "git-core"
    "git"
    "gparted"
    "htop"
    "fzf"
    "iputils-ping"
    "libevent-dev"
    "libfontconfig1-dev"
    "libncurses5-dev"
    "libsdl1.2-dev"
    "meld"
    "python-is-python3"
    "python3-pexpect"
    "python3-pip"
    "python3"
    "pkg-config"
    "socat"
    "texinfo"
    "unzip"
    "vim"
    "wget"
    "xclip"
    "xterm"
    "xz-utils"
    "zsh"
)

for package in "${packages[@]}"
do
    if sudo apt-get install -y $package
    then
        print_green "$package installed successfully"
    else
        print_red "Failed to install $package"
    fi
done

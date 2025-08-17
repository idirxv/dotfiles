#!/usr/bin/env bash

# This will provide a common print function for all scripts

print_green() {
    echo -e "\e[32m$1\e[0m"
}

print_red() {
    echo -e "\e[31m$1\e[0m"
}

print_yellow() {
    echo -e "\e[33m$1\e[0m"
}

die () {
    print_red "$1"
    exit 1
}


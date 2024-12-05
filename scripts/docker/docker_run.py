#!/usr/bin/env python3
# pylint: disable=C0114

import json
import subprocess
import os
import sys
from pathlib import Path
from termcolor import colored

CONFIG_FILE = os.path.expanduser("~/.config/docker_run_images.json")

def list_available_images(config):
    """List all available image configurations with numbers"""
    print(colored("Available Configurations:", "cyan"))
    for idx, image in enumerate(config.keys(), 1):
        print(f"  {idx}. {image}")

def load_config(file_path):
    """ Load configuration from a JSON file """
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"Configuration file '{file_path}' not found.")

    try:
        with open(file_path, "r", encoding="utf-8") as f:
            return json.load(f)
    except json.JSONDecodeError as e:
        raise ValueError(f"Error parsing JSON configuration: {e}") from e

def build_docker_command(config):
    """Construct the Docker run command."""
    def add_flag(option, flag):
        if config.get(option, False):
            cmd.append(flag)

    def add_option(option, flag):
        if option in config:
            cmd.extend([flag, str(config[option])])

    def add_extended_option(option, flag):
        if option in config:
            for key, value in config[option].items():
                cmd.extend([flag, f"{key}:{value}"])

    flag_mapping = {
        "interactive": "-it",
        "autoremove": "--rm",
        "detach": "-d",
    }

    option_mapping = {
        "name": "--name",
        "device": "--device",
        "network": "--network",
        "entrypoint": "--entrypoint",
        "memory": "-m",
        "cpus": "--cpus",
        "user": "-u",
    }

    extended_options_mapping = {
        "env": "-e",
        "mounts": "-v",
        "ports": "-p",
    }

    cmd = ["docker", "run"]

    for option, flag in flag_mapping.items():
        add_flag(option, flag)

    for option, flag in option_mapping.items():
        add_option(option, flag)

    for option, flag in extended_options_mapping.items():
        add_extended_option(option, flag)


    # Image and tag
    if not "image" in config:
        raise ValueError("Docker Image must be specified in the configuration")

    image = config["image"]
    tag = config.get("tag", "latest")
    cmd.append(f"{image}:{tag}")

    return cmd

def run_docker_command(cmd):
    """ Execute the constructed docker command """
    cmd = [str(Path(p).expanduser()) for p in cmd]
    try:
        subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError as e:
        print(colored(f"Error executing Docker command: {e}", "red"))

def main():
    """ Main function """
    try:
        config = load_config(CONFIG_FILE)

        if len(sys.argv) < 2:
            print("Usage: docker_run.py <number|image_name>")
            list_available_images(config)
            sys.exit(1)

        selection = sys.argv[1]

        # Handle numeric selection
        if selection.isdigit():
            image_names = list(config.keys())
            idx = int(selection)
            if 1 <= idx <= len(image_names):
                image_name = image_names[idx - 1]
            else:
                print(colored(f"Error: Invalid selection '{selection}'", "red"))
                list_available_images(config)
                sys.exit(1)
        else:
            # Handle string image name selection
            image_name = selection
            if image_name not in config:
                print(colored(f"Error: Invalid image name '{image_name}'", "red"))
                list_available_images(config)
                sys.exit(1)

        docker_cmd = build_docker_command(config[image_name])
        run_docker_command(docker_cmd)

    except (FileNotFoundError, ValueError, subprocess.CalledProcessError) as e:
        print(colored(f"Error: {e}", "red"))
        sys.exit(1)

if __name__ == "__main__":
    main()

#!/usr/bin/env python3

import os
import sys

DOCKER_CONTAINERS = [
    {
        "name": "yocto-ubuntu-22.04 (ready1)",
        "command": "docker run -it --rm "
                   "-v /data:/data "
                   "-v ~/Projects:/workspace "
                   "-v ~/.ssh:/home/yoctouser/.ssh "
                   "-v ~/.bash_history_docker:/home/yoctouser/.bash_history "
                   "--name yocto-ubuntu-22.04 crops/yocto:ubuntu-22.04-ready1"
    },
    {
        "name": "yocto-ubuntu-18.04",
        "command": "docker run -it --rm "
                   "-v /data:/data "
                   "-v ~/Projects:/workspace "
                   "-v ~/.ssh:/home/yoctouser/.ssh "
                   "-v ~/.bash_history_docker_18:/home/yoctouser/.bash_history "
                   "--name yocto-ubuntu-18.04 crops/yocto:ubuntu-18.04-base"
    }
]

def list_containers():
    """Show available Docker containers."""
    print("Available Docker containers:")
    for idx, container in enumerate(DOCKER_CONTAINERS, start=1):
        print(f"{idx}. {container['name']}")

def start_container(container_id):
    """Start a Docker container based on the provided ID."""
    try:
        container_id = int(container_id) - 1
        if 0 <= container_id < len(DOCKER_CONTAINERS):
            command = DOCKER_CONTAINERS[container_id]['command']
            print(f"Starting container: {DOCKER_CONTAINERS[container_id]['name']}")
            os.system(command)
        else:
            print("Error: Invalid container ID.")
    except ValueError:
        print("Error: Please provide a valid ID (number).")

def show_container(container_id):
    """Show the command to start a Docker container based on the provided ID."""
    try:
        container_id = int(container_id) - 1
        if 0 <= container_id < len(DOCKER_CONTAINERS):
            print(DOCKER_CONTAINERS[container_id]['command'])
        else:
            print("Error: Invalid container ID.")
    except ValueError:
        print("Error: Please provide a valid ID (number).")

def show_help():
    """Show the help message."""
    print("Error: Invalid command.")
    print("Usage: launch_docker.py <command> [options]")
    print("Available commands:")
    print("  list          : List available Docker containers.")
    print("  start <id>    : Start a Docker container based on the provided ID.")
    print("  show <id>     : Show the command to start a Docker container based on the provided ID.")
    sys.exit(1)

def main():
    """Main entry point of the script."""
    if len(sys.argv) < 2:
        show_help()
    command = sys.argv[1].lower()

    if command == "list":
        list_containers()
    elif command == "start" and len(sys.argv) == 3:
        start_container(sys.argv[2])
    elif command == "show" and len(sys.argv) == 3:
        show_container(sys.argv[2])
    else:
        show_help()

if __name__ == "__main__":
    main()

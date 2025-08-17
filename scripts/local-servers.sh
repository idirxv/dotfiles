#!/usr/bin/env bash
set -euo pipefail
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/common-print.sh"

launch_http_server() {
    if pid=$(lsof -t -i :9090 2>/dev/null); then
        print_yellow "Stopping process on port 9090"
        kill "$pid"
    fi
    python3 -m http.server 9090
}

case "${1:-}" in
    http)
        launch_http_server
        ;;
    *)
        echo "Usage: $0 {http}"
        exit 1
        ;;
esac


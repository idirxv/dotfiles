#!/bin/bash

launch_http_server() {
    PID=$(lsof -t -i :9090)
    if [ -n "$PID" ]; then
        echo killing
        kill -9 $PID
    fi
    python3 -m http.server 9090
}

case $1 in
    http)
        launch_http_server
        ;;
    *)
        echo "Usage: $0 {http}"
        exit 1
        ;;
esac
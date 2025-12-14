#!/bin/bash

set -eu

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if the Docker container is running
echo "Checking web server is running..."
if curl -s http://localhost:3000 > /dev/null; then
    echo -e "${GREEN}Web server is running${NC}"
else
    echo -e "${RED}Run 'docker container run' command to launch container${NC}"
    exit 1
fi

# Check if docker_volume_mount container is running
echo "Checking MySQL is running..."
if docker container inspect docker_volume_mount >/dev/null; then
    # Check if the container is running
    if [ "$(docker container inspect -f '{{.State.Running}}' docker_volume_mount)" = "true" ]; then
        echo -e "${GREEN}MySQL container is running${NC}"
    else
        echo -e "${RED}MySQL container exists but is not running${NC}"
        exit 1
    fi
else
    echo -e "${RED}MySQL container 'docker_volume_mount' does not exist${NC}"
    exit 1
fi

echo "ok"
exit 0

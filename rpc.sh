#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

cd allora-random3/
docker compose down

RPC="rpc.ankr.com/allora_testnet"

# Step 5: Replace RPC with RPC in config.json
log_info "Replacing RPC with '$RPC' in config.json ..."
sed -i "s#65.21.16.237:26657#${RPC}#g" ~/allora-random3/config.json
if [ $? -ne 0 ]; then
    log_error "Failed to replace RPC in config.json."
    exit 1
else
    log_info "Replaced RPC with a new one in config.json successfully."
fi

cd ~/allora-random3/

# Step 7: Make init.config executable
log_info "Making init.config executable..."
chmod +x init.config
sed -i -e 's/\r$//' init.config

# Step 8: Run init.config
log_info "Running init.config..."
./init.config

# Step 9: Start Docker containers
log_info "Starting Docker containers..."
docker compose up -d --build
log_info "Setup complete. All services are up and running."
docker compose logs -f

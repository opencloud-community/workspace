#!/bin/bash

# OpenCloud Local Development Startup Script
# This script starts OpenCloud with the local configuration

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OPENCLOUD_ROOT="$SCRIPT_DIR/../.."
CONFIG_DIR="$SCRIPT_DIR/config"
DATA_DIR="$SCRIPT_DIR/data"
LOG_DIR="$SCRIPT_DIR/logs"

echo "🚀 Starting OpenCloud (Local Development)"
echo "========================================"
echo "Config: $CONFIG_DIR"
echo "Data:   $DATA_DIR"
echo "Logs:   $LOG_DIR"
echo ""

# Create necessary directories
mkdir -p "$DATA_DIR"/{storage,nats,cache}
mkdir -p "$LOG_DIR"

# Kill any existing OpenCloud processes
echo "🔄 Cleaning up existing processes..."
pkill -f opencloud || true
sleep 2

# Check if binary exists
BINARY="$OPENCLOUD_ROOT/opencloud/opencloud/bin/opencloud"
if [ ! -f "$BINARY" ]; then
    echo "❌ OpenCloud binary not found at: $BINARY"
    echo "   Please build it first with: make -C opencloud build"
    exit 1
fi

# Start OpenCloud
echo "✅ Starting OpenCloud server..."
echo ""

export OC_CONFIG_DIR="$CONFIG_DIR"
export OC_LOG_DIR="$LOG_DIR"

# Run in foreground so we can see the output
exec "$BINARY" server
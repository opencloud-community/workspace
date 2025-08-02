#!/bin/bash

# OpenCloud Local Development Quick Start
# This script builds and starts OpenCloud with a single command

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OPENCLOUD_ROOT="$SCRIPT_DIR/../.."

echo "🚀 OpenCloud Quick Start"
echo "======================="
echo ""

# Step 1: Build
echo "1️⃣ Building OpenCloud..."
cd "$OPENCLOUD_ROOT/opencloud"
if make -C opencloud build; then
    echo "   ✅ Build successful"
else
    echo "   ❌ Build failed"
    exit 1
fi
echo ""

# Step 2: Initialize (if needed)
CONFIG_FILE="$SCRIPT_DIR/config/opencloud.yaml"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "2️⃣ Initializing configuration..."
    ./opencloud/bin/opencloud init --config-path "$SCRIPT_DIR/config" --admin-password admin
    echo "   ✅ Configuration created"
else
    echo "2️⃣ Configuration already exists"
fi
echo ""

# Step 3: Start services
echo "3️⃣ Starting services..."
cd "$SCRIPT_DIR"
exec ./start.sh
#!/bin/bash

# OpenCloud Local Development Stop Script

echo "🛑 Stopping OpenCloud..."

# Kill all OpenCloud processes
pkill -f opencloud || true

# Wait a moment
sleep 2

# Check if any processes are still running
if pgrep -f opencloud > /dev/null; then
    echo "⚠️  Some processes still running, force killing..."
    pkill -9 -f opencloud || true
fi

echo "✅ OpenCloud stopped"
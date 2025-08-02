#!/bin/bash

# Run the standalone demo without Reva
# This demonstrates the new implementation

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OPENCLOUD_ROOT="$SCRIPT_DIR/../.."

echo "🚀 Starting OpenCloud Demo (Reva-free implementation)"
echo "===================================================="
echo ""

cd "$OPENCLOUD_ROOT/opencloud"

# Check if demo exists
if [ ! -f "cmd/demo-no-reva/main.go" ]; then
    echo "❌ Demo not found. Creating it..."
    exit 1
fi

echo "📁 Storage will be created in: /tmp/opencloud-demo-storage"
echo "🌐 Server will run at: http://localhost:8080"
echo ""
echo "Press Ctrl+C to stop"
echo ""

# Run the demo
go run cmd/demo-no-reva/main.go
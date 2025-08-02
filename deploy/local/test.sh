#!/bin/bash

# OpenCloud Local Development Test Script
# This script runs basic tests to verify the setup is working

set -e

echo "🧪 Testing OpenCloud Setup"
echo "========================="
echo ""

# Default values
HOST="localhost"
PORT="9140"
USER="admin"
PASS="admin"

# Wait for services to be ready
echo "⏳ Waiting for services to start..."
sleep 5

# Test 1: Health check
echo "1️⃣ Health Check"
echo "   Testing: http://$HOST:$PORT/status"
if curl -s -f "http://$HOST:$PORT/status" > /dev/null; then
    echo "   ✅ Health check passed"
else
    echo "   ❌ Health check failed"
    exit 1
fi
echo ""

# Test 2: WebDAV root listing
echo "2️⃣ WebDAV Root Listing"
echo "   Testing: http://$HOST:$PORT/remote.php/webdav/"
RESPONSE=$(curl -s -u "$USER:$PASS" "http://$HOST:$PORT/remote.php/webdav/" || true)
if [ -n "$RESPONSE" ]; then
    echo "   ✅ WebDAV root accessible"
else
    echo "   ❌ WebDAV root not accessible"
fi
echo ""

# Test 3: Create directory
echo "3️⃣ Create Directory"
TEST_DIR="TestFolder-$(date +%s)"
echo "   Creating: /remote.php/webdav/$TEST_DIR"
if curl -s -u "$USER:$PASS" -X MKCOL "http://$HOST:$PORT/remote.php/webdav/$TEST_DIR" > /dev/null; then
    echo "   ✅ Directory created successfully"
else
    echo "   ❌ Failed to create directory"
fi
echo ""

# Test 4: Upload file
echo "4️⃣ Upload File"
TEST_FILE="test-$(date +%s).txt"
echo "Hello from OpenCloud test!" > /tmp/$TEST_FILE
echo "   Uploading: /remote.php/webdav/$TEST_FILE"
if curl -s -u "$USER:$PASS" -X PUT "http://$HOST:$PORT/remote.php/webdav/$TEST_FILE" \
    --data-binary @/tmp/$TEST_FILE > /dev/null; then
    echo "   ✅ File uploaded successfully"
else
    echo "   ❌ Failed to upload file"
fi
rm -f /tmp/$TEST_FILE
echo ""

# Test 5: List users
echo "5️⃣ Test Authentication"
echo "   Testing different users..."
for user in admin einstein marie richard; do
    if [ "$user" = "admin" ]; then
        pwd="admin"
    elif [ "$user" = "einstein" ]; then
        pwd="relativity"
    elif [ "$user" = "marie" ]; then
        pwd="radioactivity"
    elif [ "$user" = "richard" ]; then
        pwd="quantum"
    fi
    
    if curl -s -u "$user:$pwd" "http://$HOST:$PORT/remote.php/webdav/" > /dev/null 2>&1; then
        echo "   ✅ User '$user' authenticated"
    else
        echo "   ❌ User '$user' authentication failed"
    fi
done
echo ""

echo "🎉 Tests completed!"
echo ""
echo "📝 Manual Testing:"
echo "   - Web UI: http://localhost:9100 (if enabled)"
echo "   - WebDAV: http://localhost:9140/remote.php/webdav/"
echo "   - Use any WebDAV client with the test users"
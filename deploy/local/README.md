# Local OpenCloud Deployment (Without Docker)

This directory contains configuration and scripts for running OpenCloud locally without Docker, using the new Reva-free implementation.

## Directory Structure

```
deploy/local/
├── README.md           # This file
├── config/            # Configuration files
│   ├── opencloud.yaml # Main configuration
│   └── users.json     # User definitions
├── data/              # Runtime data
│   ├── storage/       # File storage
│   ├── nats/          # NATS data
│   └── cache/         # Application cache
└── logs/              # Log files
```

## Prerequisites

1. **Go 1.22+** - Required to build OpenCloud
2. **NATS Server** - Either standalone or use the built-in one
3. **Make** - For building the binaries

## Quick Start

### 1. Build OpenCloud

From the opencloud directory:

```bash
cd /Users/felix/work/opencloud/opencloud
make -C opencloud build
```

This creates the binary at `opencloud/bin/opencloud`.

### 2. Initialize Configuration

```bash
./opencloud/bin/opencloud init --config-path /Users/felix/work/opencloud/deploy/local/config
```

### 3. Start Services

#### Option A: All-in-One (Recommended)

Start all services with the built-in supervisor:

```bash
cd /Users/felix/work/opencloud/opencloud
OC_CONFIG_DIR=/Users/felix/work/opencloud/deploy/local/config ./opencloud/bin/opencloud server
```

#### Option B: Individual Services

For development, you can run services separately:

```bash
# Terminal 1: NATS
OC_CONFIG_DIR=/Users/felix/work/opencloud/deploy/local/config ./opencloud/bin/opencloud nats server

# Terminal 2: Gateway
OC_CONFIG_DIR=/Users/felix/work/opencloud/deploy/local/config ./opencloud/bin/opencloud gateway server

# Terminal 3: Auth
OC_CONFIG_DIR=/Users/felix/work/opencloud/deploy/local/config ./opencloud/bin/opencloud auth-basic server

# Terminal 4: Storage
OC_CONFIG_DIR=/Users/felix/work/opencloud/deploy/local/config ./opencloud/bin/opencloud storage-users server
```

### 4. Test the Setup

Check if services are running:

```bash
# Health check
curl http://localhost:9140/status

# List files (WebDAV)
curl -u admin:admin http://localhost:9140/remote.php/webdav/

# Create a folder
curl -u admin:admin -X MKCOL http://localhost:9140/remote.php/webdav/TestFolder

# Upload a file
echo "Hello OpenCloud!" > test.txt
curl -u admin:admin -X PUT http://localhost:9140/remote.php/webdav/test.txt --data-binary @test.txt
```

## Configuration

### Main Configuration (`config/opencloud.yaml`)

The main configuration file contains settings for all services. Key sections:

- `log`: Logging configuration
- `runtime`: Service supervision settings
- `nats`: Message broker configuration
- `gateway`: API gateway settings
- `auth_basic`: Authentication settings
- `storage_users`: Storage configuration

### Users Configuration

Users can be configured in the `auth_basic` section or in a separate `users.json` file.

## Default Ports

- **9140**: Gateway HTTP API (WebDAV, OCS)
- **9142**: Gateway gRPC
- **9233**: NATS Server
- **9250**: Runtime Supervisor
- **9251**: Debug/Metrics endpoint

## Troubleshooting

### Port Already in Use

Kill all OpenCloud processes:

```bash
pkill -f opencloud
```

### NATS Connection Issues

Ensure NATS is running:

```bash
ps aux | grep nats
```

### Storage Permission Issues

Fix permissions:

```bash
chmod -R 755 /Users/felix/work/opencloud/deploy/local/data/storage
```

### Missing Assets

If you see errors about missing assets (e.g., for IDP), you may need to disable certain services in the config or ensure the assets are built.

## Development Tips

1. **Enable Debug Logging**: Set `log.level: debug` in the config
2. **Watch Logs**: `tail -f logs/*.log`
3. **Clean Start**: Remove all data with `rm -rf data/*`

## Using the Demo Application

A simplified demo is available to test the new Reva-free implementation:

```bash
cd /Users/felix/work/opencloud/opencloud
go run cmd/demo-no-reva/main.go
```

Then open http://localhost:8080 in your browser.

## Next Steps

1. **Enable More Services**: Gradually enable additional services like search, thumbnails, etc.
2. **Configure External IDP**: Set up Keycloak or other OpenID Connect providers
3. **Add TLS**: Configure certificates for production use
4. **Set Up Monitoring**: Enable metrics and tracing
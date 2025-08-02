# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Workspace Structure

This is a workspace containing multiple OpenCloud-related repositories:

- **opencloud/** - Main backend service repository (git@github.com:opencloud-eu/opencloud.git)
- **docs/** - Documentation website repository (git@github.com:opencloud-eu/docs.git)
- **opencloud-compose/** - Docker Compose configurations (git@github.com:opencloud-eu/opencloud-compose.git)
- **helm/** - Helm charts for Kubernetes deployments (git@github.com:opencloud-eu/helm.git)

Each directory is a separate repository with its own development workflow.

## Common Development Commands

### OpenCloud Backend (opencloud/)

Generate assets for web UI and builtin IDP:
```bash
cd opencloud
make generate
```

Build the OpenCloud binary:
```bash
cd opencloud
make -C opencloud build
```

Quick start local test instance:
```bash
cd opencloud
opencloud/bin/opencloud init && opencloud/bin/opencloud server
```

Run API acceptance tests:
```bash
cd opencloud
make test-acceptance-api
```

Run Go tests:
```bash
cd opencloud
make test
```

Run linting:
```bash
cd opencloud
make golangci-lint
```

### Documentation (docs/)

Start documentation development server:
```bash
cd docs
pnpm install
pnpm start
```

Build documentation:
```bash
cd docs
pnpm build
```

Format and lint documentation:
```bash
cd docs
pnpm format:write
pnpm lint:md:fix
```

### Docker Compose Deployment (opencloud-compose/)

Deploy with Docker Compose:
```bash
cd opencloud-compose
cp .env.example .env
# Edit .env with your configuration
docker compose up -d
```

Deploy with Keycloak and LDAP:
```bash
cd opencloud-compose
docker compose -f docker-compose.yml -f idm/ldap-keycloak.yml -f traefik/opencloud.yml -f traefik/ldap-keycloak.yml up -d
```

### Helm Charts (helm/)

Deploy with Helm:
```bash
cd helm
# For production deployment
helm install opencloud ./charts/opencloud
# For microservices deployment
helm install opencloud ./charts/opencloud-microservices
# For development deployment
helm install opencloud ./charts/opencloud-dev
```

## High-Level Architecture

### OpenCloud Backend (opencloud/)
OpenCloud is organized as a monorepo containing multiple components:

- **opencloud/** - Main binary containing:
  - `cmd/opencloud/` - Entry point for the OpenCloud binary
  - `pkg/command/` - CLI commands (init, server, backup, etc.)
  - `pkg/runtime/` - Service supervision and runtime management
  
- **services/** - Microservices handling specific functionality:
  - **gateway** - API gateway and request routing
  - **auth-*/** - Authentication services (basic, bearer, machine, service)
  - **idp** - Built-in identity provider (LibreGraph Connect)
  - **graph** - Microsoft Graph API implementation
  - **storage-users** - User file storage with decomposed FS
  - **web** - Web frontend service
  - **collaboration** - Document collaboration (WOPI)
  - **ocdav** - WebDAV implementation
  - **thumbnails** - Image thumbnail generation
  - **search** - Full-text search capabilities

### Key Patterns
1. **Service Discovery**: Uses NATS for microservice communication
2. **Authentication**: OpenID Connect with external IdP (Keycloak) or built-in IdP
3. **Storage**: Filesystem-based, no database required (data in `~/.opencloud/`)
4. **Configuration**: YAML-based configuration with environment variable overrides
5. **Deployment Options**:
   - Single binary mode (all services in one process)
   - Microservices mode (separate containers/pods)
   - Docker Compose configurations
   - Kubernetes Helm charts

### Development Flow
1. Choose the appropriate repository for your changes
2. For backend changes: modify code in `opencloud/`
3. For documentation: update content in `docs/`
4. For deployment configurations: modify `opencloud-compose/` or `helm/`
5. Test changes locally before committing
6. Each repository has its own git workflow

### Important Files
- `opencloud/opencloud/pkg/runtime/runtime.go` - Service supervision logic
- `opencloud/opencloud/pkg/command/server.go` - Main server entry point
- `opencloud/pkg/config/` - Configuration management
- `opencloud/services/*/pkg/command/` - Individual service commands
- `opencloud-compose/docker-compose.yml` - Main Docker Compose configuration
- `helm/charts/*/values.yaml` - Helm chart configurations
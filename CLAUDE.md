# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Workspace Structure

This workspace contains all OpenCloud-related repositories from both GitHub organizations:

### GitHub Organizations

- **opencloud-eu** - Official upstream organization maintained by the OpenCloud team
  - Contains the official source code, documentation, and deployment tools
  - Read-only access (contributions via pull requests)
  - URL: https://github.com/opencloud-eu

- **opencloud-community** - Community-driven organization for collaborative work
  - Contains community projects, extensions, and experiments
  - Write access available for community contributors
  - URL: https://github.com/opencloud-community

### Repository Overview

### Core Repository (opencloud-eu)
- **opencloud/** - Main backend service repository (git@github.com:opencloud-eu/opencloud.git)

### Client Applications (opencloud-eu)
- **web/** - Web UI for OpenCloud built with Vue.js and TypeScript (git@github.com:opencloud-eu/web.git)
- **desktop/** - Desktop application for Windows, macOS, and Linux (git@github.com:opencloud-eu/desktop.git)
- **ios/** - iOS mobile application (git@github.com:opencloud-eu/ios.git)
- **android/** - Android mobile application (git@github.com:opencloud-eu/android.git)

### Libraries and SDKs (opencloud-eu)
- **reva/** - WebDAV/gRPC/HTTP server to link clients to storage backends (git@github.com:opencloud-eu/reva.git)
- **libre-graph-api/** - LibreGraph API specifications (git@github.com:opencloud-eu/libre-graph-api.git)
- **libre-graph-api-go/** - Go client library for LibreGraph API (git@github.com:opencloud-eu/libre-graph-api-go.git)
- **libre-graph-api-php/** - PHP client library for LibreGraph API (git@github.com:opencloud-eu/libre-graph-api-php.git)
- **libre-graph-api-typescript-axios/** - TypeScript/Axios client for LibreGraph API (git@github.com:opencloud-eu/libre-graph-api-typescript-axios.git)
- **libre-graph-api-cpp-qt-client/** - C++/Qt client for LibreGraph API (git@github.com:opencloud-eu/libre-graph-api-cpp-qt-client.git)
- **ios-sdk/** - iOS SDK for OpenCloud integration (git@github.com:opencloud-eu/ios-sdk.git)
- **android-dav/** - Android DAV library (git@github.com:opencloud-eu/android-dav.git)

### Extensions and Integrations (opencloud-eu)
- **web-extensions/** - Official apps and extensions for OpenCloud Web (git@github.com:opencloud-eu/web-extensions.git)
- **web-app-skeleton/** - Template for creating OpenCloud web applications (git@github.com:opencloud-eu/web-app-skeleton.git)
- **rclone/** - Fork of rclone with OpenCloud-specific features (git@github.com:opencloud-eu/rclone.git)

### Deployment and Documentation (opencloud-eu)
- **opencloud-compose/** - Docker Compose configurations (git@github.com:opencloud-eu/opencloud-compose.git)
- **helm/** - Helm charts for Kubernetes deployments (git@github.com:opencloud-eu/helm.git)
- **docs/** - Documentation website repository (git@github.com:opencloud-eu/docs.git)

### Infrastructure and DevOps (opencloud-eu)
- **container-clamav-icap/** - ClamAV antivirus scanning via ICAP protocol (git@github.com:opencloud-eu/container-clamav-icap.git)
- **container-radicale/** - Radicale CalDAV/CardDAV server container (git@github.com:opencloud-eu/container-radicale.git)
- **containers-woodpecker-windows/** - Windows containers for Woodpecker CI (git@github.com:opencloud-eu/containers-woodpecker-windows.git)
- **woodpecker-ci-config-service/** - Configuration service for Woodpecker CI (git@github.com:opencloud-eu/woodpecker-ci-config-service.git)
- **ci-docker-desktop/** - Docker images for CI desktop builds (git@github.com:opencloud-eu/ci-docker-desktop.git)

### Development Tools (opencloud-eu)
- **qa/** - Quality assurance and testing tools (git@github.com:opencloud-eu/qa.git)
- **cdperf/** - Performance testing framework (git@github.com:opencloud-eu/cdperf.git)
- **craft-blueprints-opencloud/** - KDE Craft blueprints for building OpenCloud (git@github.com:opencloud-eu/craft-blueprints-opencloud.git)
- **go-micro-plugins/** - Go-micro plugins for OpenCloud services (git@github.com:opencloud-eu/go-micro-plugins.git)
- **openbuild/** - Build system for OpenCloud components (git@github.com:opencloud-eu/openbuild.git)

### Community Resources (opencloud-community)
- **nexus/** - OpenCloud Community Nexus - community knowledge hub (git@github.com:opencloud-community/nexus.git)

### Community Resources (opencloud-eu)
- **awesome-apps/** - Curated list of apps that work with OpenCloud (git@github.com:opencloud-eu/awesome-apps.git)
- **.github/** - GitHub organization profile and shared workflows (git@github.com:opencloud-eu/.github.git)

Each directory is a separate repository with its own development workflow.

### Development Workflow

#### Workflow for Changes

1. **Add concept in workspace repository**
   - Create a markdown file in `concepts/` folder
   - Use format: `YYYYMMDD-descriptive-title.md`
   - Document the idea, plan, and technical approach

2. **Create issue in the related code repository fork**
   - Open an issue in the opencloud-community fork
   - Reference the concept document
   - Discuss implementation details

3. **Work on the issue**
   - Create a new feature branch in the fork
   - Implement the changes
   - Create a PR to the fork's main branch
   - After review, PR can be created to upstream

#### How to Fork Repositories

When forking opencloud-eu repositories to opencloud-community:

1. **Naming convention**: Fork repository "abc" as `opencloud-eu-abc`
   - Example: `opencloud` → `opencloud-eu-opencloud`
   - Example: `web` → `opencloud-eu-web`

2. **Fork using GitHub CLI**:
   ```bash
   gh repo fork opencloud-eu/abc --org opencloud-community --clone=false
   ```

3. **Add fork as remote**:
   ```bash
   cd abc
   git remote add community git@github.com:opencloud-community/opencloud-eu-abc.git
   ```

### Contribution Workflow

**For opencloud-eu repositories:**
- Fork the repository to opencloud-community (see forking instructions above)
- Create feature branches for your changes
- Submit pull requests to the upstream repository
- Wait for review and approval from maintainers

**For opencloud-community repositories:**
- Direct write access is available
- Create feature branches for changes
- Use pull requests for code review and collaboration
- Follow semantic PR specifications for commits and PRs

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

### Community Nexus (nexus/)

Start development server for community documentation:
```bash
cd nexus
npm install
npm start
```

Build community documentation:
```bash
cd nexus
npm run build
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
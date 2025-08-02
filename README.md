# OpenCloud Community Workspace

This is a workspace directory containing multiple OpenCloud-related repositories for unified development.

## Repository Structure

This workspace contains the following repositories:

- **[opencloud/](https://github.com/opencloud-eu/opencloud)** - Main OpenCloud backend service
- **[docs/](https://github.com/opencloud-eu/docs)** - Documentation website (Docusaurus)
- **[opencloud-compose/](https://github.com/opencloud-eu/opencloud-compose)** - Docker Compose deployment configurations
- **[helm/](https://github.com/opencloud-eu/helm)** - Community-maintained Helm charts for Kubernetes deployments

## Setup

To set up this workspace, clone each repository:

```bash
# Clone the workspace (if versioned)
git clone <workspace-repo-url> opencloud-community-workspace
cd opencloud-community-workspace

# Clone individual repositories
git clone git@github.com:opencloud-eu/opencloud.git
git clone git@github.com:opencloud-eu/docs.git
git clone git@github.com:opencloud-eu/opencloud-compose.git
git clone git@github.com:opencloud-eu/helm.git
```

## Development

Each repository has its own development workflow. See [CLAUDE.md](./CLAUDE.md) for detailed development commands and architecture information.

## Note

This workspace parent directory can be version controlled separately to maintain:
- Workspace-level documentation (this README, CLAUDE.md)
- Shared configurations
- Cross-repository scripts or tools

The actual repository directories are excluded via `.gitignore`.
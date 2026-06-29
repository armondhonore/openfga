# Nexlayer — openfga

<!-- nexlayer:meta version=1 analyzed=2026-06-29T21:12:03Z repo=https://github.com/armondhonore/openfga branch=nexlayer -->

> **For AI agents (Claude Code, Cursor, Gemini CLI, Copilot):**
> This file is the **project context** for this Nexlayer deployment — tech stack, env vars, secrets, live URL.
> For full platform detail (nexlayer.yaml schema, Dockerfile rules, CI/CD, task recipes) read **`nexlayer.skills`** in this repo.
>
> **Critical rules (full detail in `nexlayer.skills`):**
> - Inter-pod refs: `${podName:port}` only — never `localhost` or bare hostnames
> - Docker Hub images: prefix with `mirror.gcr.io/library/` — bare tags fail on the cluster
> - Secrets: set in the Nexlayer dashboard — never commit to `nexlayer.yaml` or Dockerfile
>
> **This file:** `agent-managed` sections update automatically. `user-editable` sections (Local Development Setup, Nexlayer Deployment Plan, Build Notes) are yours — preserved across re-analysis.

## Project Summary
<!-- nexlayer:section agent-managed=project_summary -->
OpenFGA is an open-source Fine-Grained Authorization (FGA) system based on the Zanzibar whitepaper, providing a scalable way to manage and check relationship-based access control (ReBAC).
<!-- nexlayer:end -->

## Technology Stack
<!-- nexlayer:section agent-managed=tech_stack -->
| Name | Kind | Version | Detected From |
|------|------|---------|---------------|
| Go | language | 1.25.7 | go.mod |
| PostgreSQL | database | latest | go.mod |
| gRPC | infra | latest | go.mod |
| MySQL | database | latest | go.mod |
| Docker | infra | latest | Dockerfile |
<!-- nexlayer:end -->

## Repository Structure
<!-- nexlayer:section agent-managed=structure_map -->
- cmd/ — Entry points for the OpenFGA binary
- internal/ — Private implementation details and core logic
- pkg/ — Public libraries and shared packages
- telemetry/ — Observability and tracing implementations
- tests/ — Integration and unit tests
<!-- nexlayer:end -->

## External Services Required
<!-- nexlayer:section agent-managed=external_deps -->
Services that must be configured separately (not deployed by Nexlayer):

- PostgreSQL or MySQL (Required for persistence)
<!-- nexlayer:end -->

## Local Development Setup
<!-- nexlayer:section user-editable=local_setup -->
### Prerequisites

- Go >= 1.25
- Docker
- PostgreSQL

### Environment variables

Copy `.env.example` to `.env.local` and fill in:

```
FGA_STORE_TYPE=postgres
FGA_STORE_CONNECTION_URL=postgresql://user:pass@localhost:5432/fga?sslmode=disable
```

### Steps

1. `make build` — Compile the Go binary
2. `./bin/openfga run` — Start the OpenFGA server

<!-- nexlayer:end -->

## Nexlayer Setup
<!-- nexlayer:section agent-managed=nexlayer_setup -->
### Pod Environment Variables

| Pod | Variable | Value | Kind |
|-----|----------|-------|------|
| `app` | `OPENFGA_DATASTORE_ENGINE` | `memory` | plain |
| `app` | `OPENFGA_HTTP_ADDR` | `"0.0.0.0:8080"` | plain |
| `app` | `OPENFGA_GRPC_ADDR` | `"0.0.0.0:8081"` | plain |

### nexlayer.yaml

```yaml
application:
  name: openfga
  pods:
  - name: app
    image: "registry.nexlayer.io/user_01kece1xyh817dwff7wnarhkxd/openfga:latest"
    path: /healthz
    servicePorts:
    - 8080
    vars:
      OPENFGA_DATASTORE_ENGINE: memory
      OPENFGA_HTTP_ADDR: "0.0.0.0:8080"
      OPENFGA_GRPC_ADDR: "0.0.0.0:8081"
```

<!-- nexlayer:end -->

## Nexlayer Deployment Plan
<!-- nexlayer:section user-editable=deployment_plan -->
### Pod Topology

| Pod | Image | Port | Role |
|-----|-------|------|------|
| openfga | mirror.gcr.io/openfga/openfga:latest | 8080 | web |
| postgres | mirror.gcr.io/library/postgres:16-alpine | 5432 | database |

### Deployment notes

- The OpenFGA pod connects to the database using the address postgres.pod:5432
- HTTP API is exposed on port 8080, gRPC on 8081
- The custom Dockerfile ensures the 'run' subcommand is executed as the default command

<!-- nexlayer:end -->

## Build Notes
<!-- nexlayer:section user-editable=build_notes -->
<!-- Add notes for future builds here — preserved across re-analysis -->
<!-- nexlayer:end -->

## Nexlayer Configuration
<!-- nexlayer:section agent-managed=nexlayer_config -->
**Last deployed:** 2026-06-29T21:12:35Z  
**Live URL:** https://relaxed-weasel-openfga.cloud.nexlayer.ai  
**Runtime:**  · **Port:** auto-detected  
**Deploy branch:** nexlayer  

```yaml
application:
  name: openfga
  pods:
  - name: app
    image: "registry.nexlayer.io/user_01kece1xyh817dwff7wnarhkxd/openfga:latest"
    path: /healthz
    servicePorts:
    - 8080
    vars:
      OPENFGA_DATASTORE_ENGINE: memory
      OPENFGA_HTTP_ADDR: "0.0.0.0:8080"
      OPENFGA_GRPC_ADDR: "0.0.0.0:8081"
```
<!-- nexlayer:end -->

## Build History
<!-- nexlayer:section agent-managed=build_history -->
| Date | Status | Notes |
|------|--------|-------|
| 2026-06-29T21:12:03Z | analyzed | initial repo analysis |
| 2026-06-29T21:12:35Z | success | deployed https://relaxed-weasel-openfga.cloud.nexlayer.ai |
<!-- nexlayer:end -->

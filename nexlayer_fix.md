# Nexlayer build/deploy fix guidance (pinned)

Do NOT regenerate the Dockerfile. The Dockerfile is intentionally a thin wrapper
around the official `openfga/openfga` image whose only job is to set the default
container command to `run` (`CMD ["run"]`). The upstream entrypoint `/openfga`
with no subcommand only prints help and exits, which is why a deploy-only of the
raw image returns 503.

Pinned facts:
- Base image: `mirror.gcr.io/openfga/openfga:latest`
- Default command MUST be `run` so the HTTP server binds `0.0.0.0:8080`.
- Datastore: in-memory (`OPENFGA_DATASTORE_ENGINE=memory`) — no external DB.
- Health/route path: `/healthz` (root `/` is not a route, returns 404).

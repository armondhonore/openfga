# Nexlayer build/deploy fix guidance (pinned)

Do NOT regenerate the Dockerfile. It is intentionally a thin wrapper around the
official `openfga/openfga` image whose only job is to set the default container
command to `run` (`CMD ["run"]`). The upstream entrypoint `/openfga` with no
subcommand only prints help and exits, so a deploy-only of the raw image yields
"connection refused" on :8080. The Nexlayer `command:` yaml field does NOT
survive the deploy path, so the server start MUST be baked into the image.

Pinned facts:
- Base image: mirror.gcr.io/openfga/openfga:latest
- Default command MUST be `run` (binds 0.0.0.0:8080).
- Datastore: in-memory (OPENFGA_DATASTORE_ENGINE=memory) — no external DB.
- Route/health path: /healthz (root / is 404 by design).

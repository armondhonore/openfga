# Nexlayer build/deploy fix guidance (pinned)

## Fixed Dockerfile
```
FROM mirror.gcr.io/openfga/openfga:latest

EXPOSE 8080
EXPOSE 8081
EXPOSE 3000

ENTRYPOINT ["/openfga"]
CMD ["run", "--playground-enabled"]
```

## Fixed nexlayer.yaml
```yaml
application:
  name: openfga
  pods:
  - name: openfga
    image: "# filled by pipeline"
    path: /playground
    servicePorts:
    - 3000
    vars:
      OPENFGA_DATASTORE_ENGINE: memory
      OPENFGA_HTTP_ADDR: "0.0.0.0:8080"
      OPENFGA_GRPC_ADDR: "0.0.0.0:8081"
      OPENFGA_LOG_FORMAT: text
```

Pinned facts:
- The Nexlayer `command:` yaml field does NOT survive the deploy path — bake startup into the image CMD.
- Playground is enabled via `--playground-enabled` CLI flag (env var OPENFGA_PLAYGROUND_ENABLED ignored).
- Playground runs on port 3000; API on 8080; gRPC on 8081.
- Route/health path: /playground (port 3000, returns HTML with 200).
- Datastore: in-memory — no external DB needed.

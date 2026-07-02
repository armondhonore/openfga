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
    image: "registry.nexlayer.io/user_01kece1xyh817dwff7wnarhkxd/openfga:19f160c8a03"
    path: /healthz
    servicePorts:
    - 8080
    vars:
      OPENFGA_DATASTORE_ENGINE: memory
      OPENFGA_HTTP_ADDR: "0.0.0.0:8080"
      OPENFGA_GRPC_ADDR: "0.0.0.0:8081"
```

Pinned facts:
- The Nexlayer `command:` yaml field does NOT survive the deploy path — bake startup into the image CMD.
- Playground is enabled via `--playground-enabled` CLI flag (env var OPENFGA_PLAYGROUND_ENABLED ignored).
- Pinned image: registry.nexlayer.io/user_01kece1xyh817dwff7wnarhkxd/openfga:19f160c8a03
- Route/health path: /healthz (port 8080, returns {"status":"SERVING"}).
- Datastore: in-memory — no external DB needed.
- Screenshot path: /healthz shows JSON status proving service is live.

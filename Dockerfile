# Nexlayer deploy image: wrap the official OpenFGA binary so the container's
# DEFAULT command starts the HTTP/gRPC server (`run`). The upstream image's
# entrypoint is `/openfga` with no subcommand, which only prints help and exits.
FROM mirror.gcr.io/openfga/openfga:latest

EXPOSE 8080
EXPOSE 8081
EXPOSE 3000

# Drop the inherited gRPC HEALTHCHECK; the platform readiness probe uses the
# HTTP service port instead, and the grpc-health-probe check can wedge the pod
# as NotReady during startup.
HEALTHCHECK NONE

ENTRYPOINT ["/openfga"]
CMD ["run"]

# Nexlayer deploy image: wrap the official OpenFGA binary so the container's
# DEFAULT command starts the HTTP/gRPC server (`run`). The upstream entrypoint
# is `/openfga` with no subcommand, which only prints help and exits (which is
# why a deploy-only of the raw image returns "connection refused" on :8080).
FROM mirror.gcr.io/openfga/openfga:latest

EXPOSE 8080
EXPOSE 8081
EXPOSE 3000

ENTRYPOINT ["/openfga"]
CMD ["run", "--playground-enabled"]

# Nexlayer deploy image: wrap the official OpenFGA binary so the container's
# DEFAULT command starts the HTTP/gRPC server (`run`). The upstream image's
# entrypoint is `/openfga` with no subcommand, which only prints help and exits.
FROM mirror.gcr.io/openfga/openfga:latest

EXPOSE 8080
EXPOSE 8081
EXPOSE 3000

ENTRYPOINT ["/openfga"]
CMD ["run"]

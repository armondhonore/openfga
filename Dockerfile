FROM mirror.gcr.io/openfga/openfga:latest

EXPOSE 8080
EXPOSE 8081
EXPOSE 3000

ENTRYPOINT ["/openfga"]
CMD ["run", "--playground-enabled"]
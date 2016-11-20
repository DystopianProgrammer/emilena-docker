# https://hub.docker.com/_/openjdk/
FROM openjdk:8

# copy the contents of te snapshot from the clone repo target dir, and copy it to docker image
COPY emilena-api-1.0-SNAPSHOT.jar /usr/local/emilena-api/

# copy the dropwizard yml from the given location to the docker image
COPY emilena.yml /usr/local/emilena-api/

# run the following command
CMD ["java", "-jar", "/usr/local/emilena-api/emilena-api-1.0-SNAPSHOT.jar", "server", "/usr/local/emilena-api/emilena.yml"]

EXPOSE 9090
EXPOSE 9091

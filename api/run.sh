#!/bin/bash
if [ "$#" -eq  "0" ]
    then
        echo "Requires location to jar file as parameter e.g: ./run.sh /usr/project/target/emilena-api-1.0-SNAPSHOT.jar"
else
    cp $1 .
    docker build -t emilena-api .
    docker run -d -p 9090:9090 emilena-api
fi


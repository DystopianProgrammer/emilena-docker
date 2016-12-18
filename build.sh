#!/bin/bash
if [ "$#" -eq  "0" ]
    then
        echo "Requires location of projects root levels - api first, web second"
else

    docker kill $(docker ps -q)
    docker rm $(docker ps -a -q)

    DOCKER_DIR="$(pwd)"

    echo 'Building emilena-api'
    cd $1
    git pull
    mvn clean package -DskipTests
    
    echo 'Switching to docker directory'
    echo $DOCKER_DIR
    cd $DOCKER_DIR/api

    echo 'Building api docker container'
    cp $1/target/emilena.jar .
    docker build -t emilena-api .
    docker run -d -p 9090:9090 emilena-api

    echo 'Building emilena-web'
    cd $2
    git pull
    ng build --prod

    echo 'Switching to docker directory'
    echo $DOCKER_DIR
    cd $DOCKER_DIR/web

    echo 'Building web docker container'
    cp -Rv $2/dist .
    docker build -t emilena-rota .
    docker run -d -p 80:80 emilena-rota

    echo 'Task completed'

fi
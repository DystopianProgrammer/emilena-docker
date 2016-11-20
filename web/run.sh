#!/bin/bash
if [ "$#" -eq  "0" ]
    then
        echo "Requires location to distributable web directory as parameter e.g: ./run.sh /usr/web/dist/"
else
    cp -Rv $1 .
    docker build -t emilena-rota .
    docker run -d -p 80:80 emilena-rota
fi

#!/bin/bash

#récupérer le nom du répertoire courant
CURRENT_PATH="echo `pwd`"
CURRENT_DIR=(`echo $CURRENT_PATH | sed 's/\//\n/g'`)
CURRENT_DIRNAME=`echo ${CURRENT_DIR[-1]/./}`
CURRENT_DIRNAME+="_unison_1"

docker-compose up --force-recreate -d

#récupérer le port utilisé par unison
unison_container=$CURRENT_DIRNAME
unison_port=`docker port $unison_container`
unison_port=`echo $unison_port | cut -d':' -f 2`

#récupérer l'ip de la machine docker
docker_machine_ip=`docker-machine ip`

#lancer unison
unison ./www socket://$docker_machine_ip:$unison_port/ -ignore 'Path .git' -auto -batch -repeat=watch

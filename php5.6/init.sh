#!/bin/bash

unison_container="php56_unison_1";

docker-compose up --force-recreate -d

unison_port=`docker port $unison_container`
unison_port=`echo $unison_port | cut -d':' -f 2`

docker_machine_ip=`docker-machine ip`

unison ./www socket://$docker_machine_ip:$unison_port/ -ignore 'Path .git' -auto -batch -repeat=watch

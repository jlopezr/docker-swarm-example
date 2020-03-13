#!/bin/bash

docker-machine ssh host1 << EOF
docker service create --replicas 1 --name helloworld alpine ping docker.com
EOF

#docker service ls
#docker service inspect --pretty helloworld
#docker service ps helloworld

docker-machine ssh host1 << EOF
docker service scale helloworld=5
EOF

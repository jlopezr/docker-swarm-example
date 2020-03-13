#!/bin/bash

IP_HOST1=$(docker-machine ip host1)
IP_HOST2=$(docker-machine ip host2)
IP_HOST3=$(docker-machine ip host3)

docker-machine ssh host1 << EOF
docker service create \
  --name my-web \
  --publish published=8080,target=80 \
  --replicas 2 \
  nginx
EOF

# https://docs.docker.com/engine/swarm/ingress/

# https://docs.docker.com/network/overlay/#encrypt-traffic-on-an-overlay-network

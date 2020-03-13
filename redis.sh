#!/bin/bash

IP_HOST1=$(docker-machine ip host1)
IP_HOST2=$(docker-machine ip host2)
IP_HOST3=$(docker-machine ip host3)

docker-machine ssh host1 << EOF
docker service create \
  --replicas 3 \
  --name redis \
  --update-delay 10s \
  redis:3.0.6
EOF


# Apply a rolling update
docker-machine ssh host1 << EOF
docker service update --image redis:3.0.7 redis
EOF

# docker service ps redis

# Drain a node (mark as unavailable)
docker-machine ssh host1 << EOF
docker node update --availability drain host2
EOF

# docker node update --availability active host2

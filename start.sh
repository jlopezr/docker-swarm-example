#!/bin/bash
docker-machine create -d=virtualbox host1
docker-machine create -d=virtualbox host2
docker-machine create -d=virtualbox host3

#ssh USER@HOST << EOF
#COMMAND1
#COMMAND2
#COMMAND3
#EOF

#ssh root@192.168.1.1 'uptime'

#docker info
#docker node ls

IP_HOST1=$(docker-machine ip host1)
IP_HOST2=$(docker-machine ip host2)
IP_HOST3=$(docker-machine ip host3)

docker-machine ssh host1 << EOF
docker swarm init --advertise-addr $IP_HOST1
EOF

TOKEN=$(docker-machine ssh host1 'docker swarm join-token worker -q')

docker-machine ssh host2 << EOF
docker swarm join \
  --token $TOKEN \
  $IP_HOST1:2377
EOF

docker-machine ssh host3 << EOF
docker swarm join \
  --token $TOKEN \
  $IP_HOST1:2377
EOF

# Start registry for compose examples
docker-machine ssh host1 << EOF
docker service create --name registry --publish published=5000,target=5000 registry:2
EOF


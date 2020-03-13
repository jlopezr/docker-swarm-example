#!/bin/bash

IP_HOST1=$(docker-machine ip host1)
IP_HOST2=$(docker-machine ip host2)
IP_HOST3=$(docker-machine ip host3)

docker-machine ssh host1 << EOF
docker service rm helloworld
docker service rm redis
docker service rm nginx
EOF

docker-machine stop host1
docker-machine stop host2
docker-machine stop host3

docker-machine rm -y host1
docker-machine rm -y host2
docker-machine rm -y host3

#!/bin/bash

IP_HOST1=$(docker-machine ip host1)
IP_HOST2=$(docker-machine ip host2)
IP_HOST3=$(docker-machine ip host3)

docker-machine ssh host1 << EOF
docker service rm helloworld
docker service rm redis
EOF

#!/bin/bash

export HOST1_IP=$(docker-machine ip host1)

#Test locally
cd stackdemo
docker-compose up -d
echo
docker-compose ps
echo
curl http://localhost:8000
curl http://localhost:8000
echo
docker-compose down --volumes

#Send image to registry (do not work because it is a private non https registry)
#docker-compose push

docker-machine scp -r . host1:.

docker-machine ssh host1 << EOF
cd app
docker build .
docker push 127.0.0.1:5000/stackdemo
EOF

echo

docker-machine ssh host1 << EOF
docker stack deploy --compose-file docker-compose.yml stackdemo
sleep 1
echo
docker stack services stackdemo
echo
curl -sS http://localhost:8000
echo
curl -sS http://localhost:8000
echo
docker stack rm stackdemo
EOF

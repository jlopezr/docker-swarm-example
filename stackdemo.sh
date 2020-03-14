#!/bin/bash

export REGISTRY_IP=$(docker-machine ip host1)

#Test locally
docker-compose up -d
echo
docker-compose ps
echo
curl http://localhost:8000
curl http://localhost:8000
echo
docker-compose down --volumes

#Send image to registry
docker-compose push

#!/bin/bash
set -e

SERVICE_NAME=$1; shift
DOCKER_CMD=docker

TASK_ID=$(${DOCKER_CMD} service ps --filter 'desired-state=running' $SERVICE_NAME -q)
NODE_ID=$(${DOCKER_CMD} inspect --format '{{ .NodeID }}' $TASK_ID)
CONTAINER_ID=$(${DOCKER_CMD} inspect --format '{{ .Status.ContainerStatus.ContainerID }}' $TASK_ID)
TASK_NAME=swarm_exec_${RANDOM}

TASK_ID=$(${DOCKER_CMD} service create \
  --detach \
  --name=${TASK_NAME} \
  --restart-condition=none \
  --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
  --constraint node.id==${NODE_ID} \
  docker:latest docker exec ${CONTAINER_ID} "$@")

while : ; do
  STOPPED_TASK=$(${DOCKER_CMD} service ps --filter 'desired-state=shutdown' ${TASK_ID} -q)
  [[ ${STOPPED_TASK} != "" ]] && break
  sleep 1
done

${DOCKER_CMD} service logs --raw ${TASK_ID}
${DOCKER_CMD} service rm ${TASK_ID} > /dev/null

https://docs.docker.com/engine/swarm/stack-deploy/
https://medium.com/lucjuggery/mongodb-replica-set-on-swarm-mode-45d66bc9245
https://medium.com/faun/managing-mongodb-on-docker-with-docker-compose-26bf8a0bbae3
https://medium.com/@gjovanov/mongo-docker-swarm-fully-automated-cluster-9d42cddcaaf5


https://github.com/rdxmb/docker_swarm_helpers

1. Execute something inside a swarm service

You can jump in a Swarm node and list the docker containers running using:

docker container ls
That will give you the container name in a format similar to: containername.1.q5k89uctyx27zmntkcfooh68f

You can then use the regular exec option to run commands on it:

docker container exec -it containername.1.q5k89uctyx27zmntkcfooh68f bash

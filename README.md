# Apache ManifoldCF with Postgres
Docker image with Apache ManifoldCF configured to run with Postgres, and startup the agents and web application using separate Java processes.

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/perficientdevops/manifoldcf.svg)

### Build, Push, and Run with `docker-compose`
1. `docker build -t perficientdevops/manifoldcf:2.11 .`
1. `docker push perficientdevops/manifoldcf`
1. `docker-compose up -d`

To connect:
1. `env | grep DOCKER`
1. Make note of the `DOCKER_HOST` IP address
1. `curl -L http://$DOCKER_HOST:8345/mcf-crawler-ui` or [http://$DOCKER_HOST:8345/mcf-crawler-ui](http://$DOCKER_HOST:8345/mcf-crawler-ui) in a browser

### Run with Kubernetes/OpenShift
```
kubectl create configmap postgresql-config --from-file=postgresql-cfg/postgres.conf
kubectl apply -f kube/
```

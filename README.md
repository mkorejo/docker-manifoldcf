# Apache ManifoldCF with Postgres


(url):8345/mcf-crawler-ui

1. docker build -t perficientdevops/manifoldcf:2.13-openjdk -f Dockerfile-openjdk .

2. docker-compose up -d

3. env | grep DOCKER

4. copy the DOCKER_HOST address

5. curl -L http://{DOCKER_HOST address}:8345/mcf-crawler-ui
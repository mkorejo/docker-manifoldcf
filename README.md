# Apache ManifoldCF with Postgres
Docker image with Apache ManifoldCF configured to run with Postgres, and startup the agents and web application using separate Java processes.

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/perficientdevops/manifoldcf.svg)

### Build, Push, and Run with `docker-compose`
1. `docker build -t perficientdevops/manifoldcf:2.11 .`
1. `docker push perficientdevops/manifoldcf`
1. `docker-compose up -d`

### Run with Kubernetes/OpenShift and Crunchy Data Postgres Operator
#### Install the Postgres Operator using Ansible
1. Install Ansible
1. Clone the [postgres-operator repo](https://github.com/CrunchyData/postgres-operator)
1. Navigate to `postgres-operator/ansible`
1. Setup the Ansible inventory file:
   - set Kubernetes context
   - true/false create RBAC resources
   - set installation name and admin username/password
   - configure operator namespace and which namespaces to manage
   - update Docker image tags (`ccp_image_tag='centos7-12.1-4.1.1'` and `pgo_image_tag='centos7-4.1.1'`)
   - true/false `pgo` client installation
   - `pgo_cluster_admin='false'`
   - database/operator defaults
   - configure storage
1. `ansible-playbook -i /path/to/inventory --tags=install main.yml`

#### Setup `pgo` CLI
1. [Install `pgo` CLI](https://access.crunchydata.com/documentation/postgres-operator/4.1.1/installation/install-pgo-client/)
1. `kubectl port-forward <postgres-operator-pod> 8443`
1. ```
   export PGOUSER="${HOME?}/.pgo/pgo/pgouser"
   export PGO_CA_CERT="${HOME?}/.pgo/pgo/client.crt"
   export PGO_CLIENT_CERT="${HOME?}/.pgo/pgo/client.crt"
   export PGO_CLIENT_KEY="${HOME?}/.pgo/pgo/client.pem"
   export PGO_APISERVER_URL='https://127.0.0.1:8443'
   ```
1. `pgo version` to confirm all is well.

OpenShift clusters also need a new Security Context Constraint:

`oc apply -f https://raw.githubusercontent.com/CrunchyData/postgres-operator/master/examples/pgo-scc.yaml`

#### Create Postgres Cluster
```
pgo create cluster manifoldcf-db -n manifoldcf -c centos7-10.11-4.1.1 \
  --autofail --replica-count 1

pgo test manifoldcf-db -n manifoldcf
```

#### Deploy ManifoldCF Web Application
```
kubectl create secret generic postgresql --from-literal=postgresql_password='<db-user-password>'
kubectl apply -f kube/manifoldcf-web.yaml
```

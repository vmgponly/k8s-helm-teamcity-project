#!/bin/bash
set -e

docker-compose build app batch
docker tag noa_infra_app:latest 409389662862.dkr.ecr.us-west-2.amazonaws.com/kgban-dev:app
docker tag noa_infra_batch:latest 409389662862.dkr.ecr.us-west-2.amazonaws.com/kgban-dev:batch
docker push 409389662862.dkr.ecr.us-west-2.amazonaws.com/kgban-dev:app
docker push 409389662862.dkr.ecr.us-west-2.amazonaws.com/kgban-dev:batch

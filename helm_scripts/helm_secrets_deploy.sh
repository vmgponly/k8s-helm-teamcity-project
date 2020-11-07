#!/bin/bash
set -e

helm namespace upgrade --install helm-kgban-secrets ./helm-kgban-secrets -f helm-kgban-secrets/dev-values.yaml.dec -n dev-env-namespace

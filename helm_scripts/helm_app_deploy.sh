#!/bin/bash

set -e

helm namespace upgrade --install helm-kgban ./helm-kgban -f helm-kgban/dev-values.yaml -n dev-env-namespace

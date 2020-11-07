#!/bin/bash

set -e

helm namespace upgrade --install nginx-kgban-dev ./nginx-kgban-dev -n ingress-nginx-dev

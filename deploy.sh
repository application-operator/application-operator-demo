#!/bin/bash

set -eux

cat > kustomization.yaml << EOF
images:
  - name: willthames/docker-debug
    newTag: $4

resources:
  - $3

EOF
echo VERSION=$4 > $3/resources/env-configmap.yaml

mkdir -p target
kustomize build . > target/manifest.yml
kubectl apply -f target/manifest.yml

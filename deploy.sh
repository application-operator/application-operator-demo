#!/bin/sh

set -eux

cat > kustomization.yaml << EOF
images:
  - name: willthames/docker-debug
    newTag: $4

resources:
  - $3

EOF
mkdir -p $3/resources
echo VERSION=$4 > $3/resources/env-configmap.yaml

mkdir -p target
kustomize build . > target/manifest.yml
kubectl apply -f target/manifest.yml

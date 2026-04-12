#!/bin/bash
# devops-tools
docker buildx build --platform linux/amd64 -t ghcr.io/harrytang/devops-tools:k8s ./dockerfiles/k8s --load
docker buildx build --platform linux/arm64 -t ghcr.io/harrytang/devops-tools:k8s ./dockerfiles/k8s --load
# node
docker buildx build --platform linux/amd64 -t ghcr.io/harrytang/devops-tools:node ./dockerfiles/node --load
docker buildx build --platform linux/arm64 -t ghcr.io/harrytang/devops-tools:node ./dockerfiles/node --load
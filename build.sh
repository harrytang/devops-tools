#!/bin/bash
# devops-tools
docker buildx build --platform linux/amd64 -t ghcr.io/harrytang/devops-tools:latest . --load
docker buildx build --platform linux/arm64 -t ghcr.io/harrytang/devops-tools:latest . --load
# node
docker buildx build --platform linux/amd64 -t ghcr.io/harrytang/devops-tools:node ./dockerfiles/node --load
docker buildx build --platform linux/arm64 -t ghcr.io/harrytang/devops-tools:node ./dockerfiles/node --load
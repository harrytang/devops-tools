#!/bin/bash
docker buildx build --platform linux/amd64 -t ghcr.io/harrytang/devops-tools:latest . --load
docker buildx build --platform linux/arm64 -t ghcr.io/harrytang/devops-tools:latest . --load
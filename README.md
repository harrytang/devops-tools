# DevOps Tools

[![Container Image](https://github.com/harrytang/devops-tools/actions/workflows/build.yml/badge.svg)](https://github.com/harrytang/devops-tools/actions/workflows/build.yml)

This Docker image encapsulates the tools I routinely utilize during my coding sessions and while interacting with Kubernetes.

## Usage

The sole requirement is having Docker installed. You have the option to assign an alias in your shell to employ this image as a command-line utility, or you can directly SSH into the container to use the tools.

```bash
docker run -it --rm \
  -e WORKSPACE=${PWD} \
  -e USER=$(whoami) \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/workspace \
  -v $(whoami):/root \
  -w /workspace -P ghcr.io/harrytang/devops-tools:latest ssh-agent /bin/zsh'
```

see [examples/.zshrc](examples/.zshrc])

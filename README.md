# DevOps Tools

[![Container Image](https://github.com/harrytang/devops-tools/actions/workflows/build.yml/badge.svg)](https://github.com/harrytang/devops-tools/actions/workflows/build.yml)

This Docker image encapsulates the tools I routinely utilize during my coding sessions and while interacting with Kubernetes.

## Usage

The sole requirement is having Docker installed. You have the option to assign an alias in your shell to employ this image as a command-line utility, or you can directly SSH into the container to use the tools.

```bash
docker run -it --rm \
  --net=host \
  -v ${PWD}:/workspaces \
  -v $HOME/.kube:/home/devops/.kube \
  -v $HOME/.ssh:/home/devops/.ssh:ro \
  -v $HOME/.gitconfig:/home/devops/.gitconfig:ro \
  -w /workspaces \
  ghcr.io/harrytang/devops-tools:k8s ssh-agent /bin/zsh
```

## Config

Git Auth key

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

GitHub signing key

```bash
ssh-keygen -t ecdsa -C "your_email@example.com"
```

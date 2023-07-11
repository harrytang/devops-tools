ub# DevOps Tools

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

## Config

Git Auth key

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

GitHub signing key

```bash
ssh-keygen -t ecdsa -C "your_email@example.com"
```

## Multi-profile

Work with multi projects/companies? Use this sample [examples/.zshrc](examples/.zshrc) will allow you to switch between different profiles. Default profile is your current username.

To switch to another profile, create a new file under your home directory, e.g. `~/CompanyA.sh`, `~/CompanyB.sh` and add the following content:

```bash
#!/bin/bash
export USER=CompanyX
```

Then run `source ~/CompanyA.sh` or `. ~/CompanyB.sh` to switch to the new profile.

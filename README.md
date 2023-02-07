# DevOps Tools

[![Container Image](https://github.com/harrytang/devops-tools/actions/workflows/build.yml/badge.svg)](https://github.com/harrytang/devops-tools/actions/workflows/build.yml)

This docker image contains tools that I frequently use while working with Kubernetes .
This Docker image contains the following components:

- kubectl
- helm
- kubeseal

## Usage

All you need is Docker installed. You can set alias in your shell to use this image as a command line tool or you can simply ssh to the container and use the tools.

```bash
docker run -it --rm --net=host -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/workspace -v $HOME/.kube:/root/.kube -v $HOME/.ssh:/root/.ssh --workdir /workspace ghcr.io/harrytang/devops-tools:latest ssh-agent /bin/bash
```

## Examples

For MacOS, you can use the following aliases in your `~/.zshrc` file.

```.zshrc
alias kubectl='docker run -it --rm --net=host -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/workspace -v $HOME/.kube:/root/.kube -v $HOME/.ssh:/root/.ssh --workdir /workspace ghcr.io/harrytang/devops-tools kubectl'
alias kubeseal='docker run -it --rm --net=host -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/workspace -v $HOME/.kube:/root/.kube -v $HOME/.ssh:/root/.ssh --workdir /workspace ghcr.io/harrytang/devops-tools kubeseal'
alias helm='docker run -it --rm --net=host -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/workspace -v $HOME/.kube:/root/.kube -v $HOME/.ssh:/root/.ssh --workdir /workspace ghcr.io/harrytang/devops-tools helm'
alias devops='docker run -it --rm --net=host -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/workspace -v $HOME/.kube:/root/.kube -v $HOME/.ssh:/root/.ssh -v $HOME/.gitconfig:/root/.gitconfig --workdir /workspace ghcr.io/harrytang/devops-tools:latest ssh-agent /bin/bash'
```

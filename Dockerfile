FROM ubuntu:latest
ARG TARGETPLATFORM
RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; then echo "arm64"; else echo "amd64"; fi > /root/.arch

####################
### common tools ###
####################

# Add cloudflare gpg key
RUN RUN apt-get update && apt-get install -y curl
RUN mkdir -p --mode=0755 /usr/share/keyrings
RUN curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

# Add this repo to your apt repositories
RUN echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared jammy main' | tee /etc/apt/sources.list.d/cloudflared.list

RUN apt-get update && apt-get install -y gnupg gh wget bash-completion bash zsh nano vim docker git openssl openssh-client docker.io locales jq cloudflared && rm -rf /var/lib/apt/lists/* && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# echo current user
RUN echo "echo \${USER}" >> ~/.zshrc

# auto load ssh key
RUN echo "ssh-add" >> ~/.zshrc

# Auto completion, editor
# RUN echo "export EDITOR=nano" >> ~/.zshrc
RUN echo "autoload -Uz compinit" >> ~/.zshrc
RUN echo "compinit" >> ~/.zshrc

# VIM Config
RUN echo "set expandtab" >> ~/.vimrc
RUN echo "set tabstop=2" >> ~/.vimrc
RUN echo "set shiftwidth=2" >> ~/.vimrc

# k8s
RUN ARCH=$(cat /root/.arch); curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/${ARCH}/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
RUN echo "source <(kubectl completion zsh)" >> ~/.zshrc
EXPOSE 8001

## Fluxcd
RUN curl -s https://fluxcd.io/install.sh | bash

# helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash 

# kubeseal
RUN echo $(curl https://api.github.com/repos/bitnami-labs/sealed-secrets/releases/latest -s | jq .tag_name -r | cut -c 2-) > /root/.kubeseal_version
RUN KUBESEAL_VERSION=$(cat /root/.kubeseal_version); \
    ARCH=$(cat /root/.arch); \
    wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION}/kubeseal-${KUBESEAL_VERSION}-linux-${ARCH}.tar.gz -O kubeseal.tar.gz;
RUN tar -xvzf kubeseal.tar.gz kubeseal
RUN install -m 755 kubeseal /usr/local/bin/kubeseal
RUN rm kubeseal.tar.gz kubeseal

# skaffold
RUN ARCH=$(cat /root/.arch); curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-${ARCH}
RUN install skaffold /usr/local/bin/ && rm skaffold

# Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Git config
RUN git config --global alias.commit 'commit --signoff'

###############
### Prompts ###
###############

RUN mkdir /root/prompts

# KUBESP1 color prompt
RUN echo $(curl https://api.github.com/repos/jonmosco/kube-ps1/releases/latest -s | jq .tag_name -r | cut -c 2-) > /root/.kubeps1_version
RUN KUBEPS1_VERSION=$(cat /root/.kubeps1_version); cd /root && curl -L https://github.com/jonmosco/kube-ps1/archive/refs/tags/v${KUBEPS1_VERSION}.tar.gz | tar xz  && \
    mv /root/kube-ps1-${KUBEPS1_VERSION}/kube-ps1.sh /root/prompts/ && \
    rm -fr /root/kube-ps1-${KUBEPS1_VERSION}
RUN echo "source ~/prompts/kube-ps1.sh" >> ~/.zshrc

# Git PS1 color prompt
RUN echo $(curl https://api.github.com/repos/git/git/tags -s | jq ".[0].name" -r | cut -c 2-) > /root/.git_version
RUN GIT_VERSION=$(cat /root/.git_version); wget https://raw.githubusercontent.com/git/git/v${GIT_VERSION}/contrib/completion/git-prompt.sh -O /root/prompts/git-prompt.sh
RUN echo "source /root/prompts/git-prompt.sh" >> ~/.zshrc
RUN echo "GIT_PS1_SHOWCOLORHINTS=1" >> ~/.zshrc
RUN echo "GIT_PS1_SHOWSTASHSTATE=1" >> ~/.zshrc

# Final PS1
RUN echo "PS1='%F{cyan}%U%1~%u%f \$(kube_ps1)\$(__git_ps1 \" [%s]\") %% '" >> ~/.zshrc

# Fluxcd completion
RUN echo "source <(flux completion zsh)" >> ~/.zshrc

###############
### aliases ###
###############
RUN echo "alias node='docker run --rm -it \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v \${WORKSPACE}:/workspace \
  -v \${USER}:/root \
  -w /workspace ghcr.io/harrytang/devops-tools:node'" >> ~/.zshrc
RUN echo "alias npm='docker run --rm -it \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v \${WORKSPACE}:/workspace \
  -v \${USER}:/root \
  -w /workspace ghcr.io/harrytang/devops-tools:node npm'" >> ~/.zshrc
RUN echo "alias npx='docker run --rm -it \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v \${WORKSPACE}:/workspace \
  -v \${USER}:/root \
  -w /workspace ghcr.io/harrytang/devops-tools:node npx'" >> ~/.zshrc
RUN echo "alias nest='npx @nestjs/cli@latest'" >> ~/.zshrc

## VOLUMES
VOLUME /root
WORKDIR /

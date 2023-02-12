FROM ubuntu:latest
ARG TARGETPLATFORM

####################
### common tools ###
####################

RUN apt-get update && apt-get install -y curl wget bash-completion bash zsh nano docker git openssl openssh-client docker.io locales && rm -rf /var/lib/apt/lists/* && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# auto load ssh key
RUN echo "ssh-add" >> ~/.zshrc

# Auto completion
RUN echo "autoload -Uz compinit" >> ~/.zshrc
RUN echo "compinit" >> ~/.zshrc

# k8s
RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; \
  then \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/arm64/kubectl; \
  else \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl; \
  fi 
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
RUN echo "source <(kubectl completion zsh)" >> ~/.zshrc
EXPOSE 8001

# helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash 

# kubeseal
ENV KUBESEAL_VERSION=0.19.4
RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; \
  then \
    wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION}/kubeseal-${KUBESEAL_VERSION}-linux-arm64.tar.gz -O kubeseal.tar.gz; \
  else \
    wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION}/kubeseal-${KUBESEAL_VERSION}-linux-amd64.tar.gz -O kubeseal.tar.gz; \
  fi 
RUN tar -xvzf kubeseal.tar.gz kubeseal
RUN install -m 755 kubeseal /usr/local/bin/kubeseal
RUN rm kubeseal.tar.gz kubeseal

# skaffold
RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; \
  then \
    curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-arm64; \
  else \
    curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64; \
  fi 
RUN install skaffold /usr/local/bin/ && rm skaffold

###############
### Prompts ###
###############

RUN mkdir /root/prompts

# KUBESP1 color prompt
ENV KUBEPS1_VERSION=0.8.0
RUN cd /root && curl -L https://github.com/jonmosco/kube-ps1/archive/refs/tags/v${KUBEPS1_VERSION}.tar.gz | tar xz  && \
    mv /root/kube-ps1-${KUBEPS1_VERSION}/kube-ps1.sh /root/prompts/ && \
    rm -fr /root/kube-ps1-${KUBEPS1_VERSION}
RUN echo "source ~/prompts/kube-ps1.sh" >> ~/.zshrc

# Git PS1 color prompt
ENV GIT_VERSION=2.39.1
RUN wget https://raw.githubusercontent.com/git/git/v${GIT_VERSION}/contrib/completion/git-prompt.sh -O /root/prompts/git-prompt.sh
RUN echo "source /root/prompts/git-prompt.sh" >> ~/.zshrc
RUN echo "GIT_PS1_SHOWCOLORHINTS=1" >> ~/.zshrc
RUN echo "GIT_PS1_SHOWSTASHSTATE=1" >> ~/.zshrc

# Final PS1
RUN echo "PS1='%F{cyan}%U%1~%u%f \$(kube_ps1)\$(__git_ps1 \" [%s]\") %% '" >> ~/.zshrc

###############
### aliases ###
###############
RUN echo "alias node='docker run --rm -it \
  -v \${WORKSPACE}:/workspace \
  -v \${USERHOME}/.ssh:/root/.ssh \
  -v \${USERHOME}/.gitconfig:/root/.gitconfig \
  -v npm:/root/.npm \
  -w /workspace ghcr.io/harrytang/devops-tools:node'" >> ~/.zshrc
RUN echo "alias npm='docker run --rm -it \
  -v \${WORKSPACE}:/workspace \
  -v \${USERHOME}/.ssh:/root/.ssh \
  -v \${USERHOME}/.gitconfig:/root/.gitconfig \
  -v npm:/root/.npm \
  -w /workspace ghcr.io/harrytang/devops-tools:node npm'" >> ~/.zshrc
RUN echo "alias npx='docker run --rm -it \
  -v \${WORKSPACE}:/workspace \
  -v \${USERHOME}/.ssh:/root/.ssh \
  -v \${USERHOME}/.gitconfig:/root/.gitconfig \
  -v \${USERHOME}:/root/.npmrc \
  -v npm:/root/.npm \
  -w /workspace ghcr.io/harrytang/devops-tools:node npx'" >> ~/.zshrc

WORKDIR /
FROM alpine:3.19
ARG TARGETPLATFORM
RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; then echo "arm64"; else echo "amd64"; fi > /tmp/.arch

####################
### common tools ###
####################

# Common lib - Alpine is much smaller; minimal dependencies needed
RUN apk add --no-cache curl wget bash zsh git openssl openssh-client jq zip ca-certificates libc6-compat && \
    addgroup -S devops && \
    adduser -S devops -G devops -s /bin/zsh -h /home/devops

# auto load ssh key, auto completion, editor
RUN echo "ssh-add" >> /home/devops/.zshrc && \
    echo "autoload -Uz compinit" >> /home/devops/.zshrc && \
    echo "compinit" >> /home/devops/.zshrc && \
    echo "alias k=kubectl" >> /home/devops/.zshrc && \
    echo "do=\"--dry-run=client -o yaml\"" >> /home/devops/.zshrc

# k8s
RUN ARCH=$(cat /tmp/.arch) && \
    curl -fSL -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -fSL https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/${ARCH}/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    strip /usr/local/bin/kubectl 2>/dev/null || true && \
    echo "source <(kubectl completion zsh)" >> /home/devops/.zshrc

## Fluxcd and Helm
RUN curl -fSL https://fluxcd.io/install.sh | bash && \
    curl -fSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash && \
    strip /usr/local/bin/flux 2>/dev/null || true && \
    strip /usr/local/bin/helm 2>/dev/null || true && \
    echo "source <(flux completion zsh)" >> /home/devops/.zshrc

# kubeseal and skaffold
RUN KUBESEAL_VERSION=$(curl -fSL https://api.github.com/repos/bitnami-labs/sealed-secrets/tags | jq -r '.[0].name' | cut -c 2-) && \
    ARCH=$(cat /tmp/.arch) && \
    wget -q https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION}/kubeseal-${KUBESEAL_VERSION}-linux-${ARCH}.tar.gz -O kubeseal.tar.gz && \
    tar -xzf kubeseal.tar.gz kubeseal && \
    install -m 755 kubeseal /usr/local/bin/kubeseal && \
    strip /usr/local/bin/kubeseal 2>/dev/null || true && \
    rm kubeseal.tar.gz kubeseal && \
    curl -fSL -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-${ARCH} && \
    install skaffold /usr/local/bin/ && \
    strip /usr/local/bin/skaffold 2>/dev/null || true && \
    rm skaffold

# Git config
RUN git config --global alias.commit 'commit --signoff' && git config --global init.defaultBranch main

###############
### Prompts ###
###############

# Kube-ps1 and git-prompt
RUN mkdir -p /home/devops/prompts && \
    KUBEPS1_VERSION=$(curl -fSL https://api.github.com/repos/jonmosco/kube-ps1/releases/latest | jq .tag_name -r | cut -c 2-) && \
    cd /home/devops && \
    curl -fSL -L https://github.com/jonmosco/kube-ps1/archive/refs/tags/v${KUBEPS1_VERSION}.tar.gz | tar xz && \
    mv /home/devops/kube-ps1-${KUBEPS1_VERSION}/kube-ps1.sh /home/devops/prompts/ && \
    rm -fr /home/devops/kube-ps1-${KUBEPS1_VERSION} && \
    GIT_VERSION=$(curl -fSL https://api.github.com/repos/git/git/tags | jq ".[0].name" -r | cut -c 2-) && \
    wget -q https://raw.githubusercontent.com/git/git/v${GIT_VERSION}/contrib/completion/git-prompt.sh -O /home/devops/prompts/git-prompt.sh && \
    echo "source ~/prompts/kube-ps1.sh" >> /home/devops/.zshrc && \
    echo "source /home/devops/prompts/git-prompt.sh" >> /home/devops/.zshrc && \
    echo "GIT_PS1_SHOWCOLORHINTS=1" >> /home/devops/.zshrc && \
    echo "GIT_PS1_SHOWSTASHSTATE=1" >> /home/devops/.zshrc && \
    echo "PS1='%F{cyan}%U%1~%u%f \$(kube_ps1)\$(__git_ps1 \" [%s]\") %% '" >> /home/devops/.zshrc

###############
#### FINAL ####
###############

RUN chown -R devops:devops /home/devops

EXPOSE 8001
WORKDIR /home/devops
USER devops

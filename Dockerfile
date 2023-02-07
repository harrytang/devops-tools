FROM alpine:latest
ARG TARGETPLATFORM

# common tools
RUN apk add --no-cache curl bash-completion bash nano docker git openssl openssh openssh-client

# k8s
RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; \
  then \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/arm64/kubectl; \
  else \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl; \
  fi 
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
RUN echo -e "source <(kubectl completion bash)" >> ~/.bashrc
RUN echo "source /etc/profile.d/bash_completion.sh" >> ~/.bashrc
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

RUN echo "ssh-add" >> ~/.bashrc
WORKDIR /
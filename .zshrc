# Description: Aliases for devops-tools
# AWS CLI
alias aws='docker run --rm -ti -v ~/.aws:/root/.aws amazon/aws-cli'

# Oracle Cloud
alias oci='docker run --rm -it -v ~/.oci:/oracle/.oci ghcr.io/oracle/oci-cli'

# acme.sh
alias acme.sh='docker run --rm -it -v ~/.acme.sh:/acme.sh neilpang/acme.sh'

# kubeseal
alias kubeseal='docker run -it --rm --net=host \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/workspace \
  -v ~/.kube:/root/.kube \
  -v ~/.ssh:/root/.ssh \
  -v ~/.helm:/root/.helm \
  -v ~/.config/helm:/root/.config/helm \
  -v ~/.cache/helm:/root/.cache/helm \
  -w /workspace ghcr.io/harrytang/devops-tools kubeseal'

# kubectl
if [[ $(which kubectl) =~ "not found" ]]; then \
alias kubectl='docker run -it --rm --net=host \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/workspace \
  -v ~/.kube:/root/.kube \
  -v ~/.ssh:/root/.ssh \
  -v ~/.helm:/root/.helm \
  -v ~/.config/helm:/root/.config/helm \
  -v ~/.cache/helm:/root/.cache/helm \
  -w /workspace ghcr.io/harrytang/devops-tools kubectl'; \
else source <(kubectl completion zsh); fi

# Helm
if [[ $(which helm) =~ "not found" ]]; then \
alias helm='docker run -it --rm --net=host \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/workspace \
  -v ~/.kube:/root/.kube \
  -v ~/.ssh:/root/.ssh \
  -v ~/.helm:/root/.helm \
  -v ~/.config/helm:/root/.config/helm \
  -v ~/.cache/helm:/root/.cache/helm \
  -w /workspace ghcr.io/harrytang/devops-tools helm'; fi

# devops-tools zsh
alias devops='docker run -it --rm --net=host \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/workspace \
  -v ~/.ssh:/root/.ssh \
  -v ~/.gitconfig:/root/.gitconfig \
  -v ~/.kube:/root/.kube \
  -v ~/.helm:/root/.helm \
  -v ~/.config/helm:/root/.config/helm \
  -v ~/.cache/helm:/root/.cache/helm \
  -w /workspace ghcr.io/harrytang/devops-tools:latest ssh-agent /bin/zsh'
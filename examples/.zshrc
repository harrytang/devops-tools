autoload -Uz compinit
compinit
# Description: Aliases for devops-tools
# AWS CLI
alias aws='docker run --rm -ti -v ~/.aws:/root/.aws amazon/aws-cli'

# Oracle Cloud
alias oci='docker run --rm -it -v ~/.oci:/oracle/.oci ghcr.io/oracle/oci-cli'

# acme.sh
alias acme.sh='docker run --rm -it -v ~/.acme.sh:/acme.sh neilpang/acme.sh'

# node
alias node='docker run --rm -it -v ${PWD}:/workspace -v npm:/root/.npm -w /workspace ghcr.io/harrytang/devops-tools:node'
alias npm='docker run --rm -it -v ${PWD}:/workspace -v npm:/root/.npm -w /workspace ghcr.io/harrytang/devops-tools:node npm'
alias npx='docker run --rm -it -v ${PWD}:/workspace -v npm:/root/.npm -w /workspace ghcr.io/harrytang/devops-tools:node npx'

# php
alias php='docker run --rm -it -v ${PWD}:/workspace -w /workspace php:latest'

# kubeseal
alias kubeseal='docker run -it --rm --net=host \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/workspace \
  -v ~/.kube/config:/root/.kube/config \
  -v ~/.kube/cache:/root/.kube/cache \
  -v ~/.ssh:/root/.ssh \
  -v ~/.helm:/root/.helm \
  -v ~/.config/helm:/root/.config/helm \
  -v ~/.cache/helm:/root/.cache/helm \
  -w /workspace ghcr.io/harrytang/devops-tools kubeseal'

# kubectl & helm
if [[ $(which kubectl) =~ "not found" ]]; then \
alias kubectl='docker run -it --rm --net=host \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/workspace \
  -v ~/.kube/config:/root/.kube/config \
  -v ~/.kube/cache:/root/.kube/cache \
  -v ~/.ssh:/root/.ssh \
  -v ~/.helm:/root/.helm \
  -v ~/.config/helm:/root/.config/helm \
  -v ~/.cache/helm:/root/.cache/helm \
  -w /workspace ghcr.io/harrytang/devops-tools kubectl'; \
alias helm='docker run -it --rm --net=host \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/workspace \
  -v ~/.kube/config:/root/.kube/config \
  -v ~/.kube/cache:/root/.kube/cache \
  -v ~/.ssh:/root/.ssh \
  -v ~/.helm:/root/.helm \
  -v ~/.config/helm:/root/.config/helm \
  -v ~/.cache/helm:/root/.cache/helm \
  -w /workspace ghcr.io/harrytang/devops-tools helm'; \
else source <(kubectl completion zsh); fi


# devops-tools zsh
alias devops='docker run -it --rm --net=host \
  -e WORKSPACE=${PWD} \
  -e USERHOME=${HOME} \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/workspace \
  -v ~/.ssh:/root/.ssh \
  -v ~/.gitconfig:/root/.gitconfig \
  -v ~/.kube/config:/root/.kube/config \
  -v ~/.kube/cache:/root/.kube/cache \
  -v ~/.helm:/root/.helm \
  -v ~/.config/helm:/root/.config/helm \
  -v ~/.cache/helm:/root/.cache/helm \
  -w /workspace ghcr.io/harrytang/devops-tools:latest ssh-agent /bin/zsh'
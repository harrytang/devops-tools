autoload -Uz compinit
compinit
# Description: Aliases for devops-tools
# AWS CLI
alias aws='docker run --rm -ti -v ~/.aws:/root/.aws amazon/aws-cli'

# Oracle Cloud
alias oci='docker run --rm -it -v ~/.oci:/oracle/.oci ghcr.io/oracle/oci-cli'

# acme.sh
alias acme.sh='docker run --rm -it -v ~/.acme.sh:/acme.sh neilpang/acme.sh'

# Port mapping
if [ $PORT ]; then
  # node
  alias node='docker run --rm -it \
  -e WORKSPACE=${PWD} \
  -e USER=$(whoami) \  
  -v ${PWD}:/workspace 
  -v $(whoami):/root \
  -w /workspace -p ${PORT} ghcr.io/harrytang/devops-tools:node'
  alias npm='docker run --rm -it \
  -e WORKSPACE=${PWD} \
  -e USER=$(whoami) \  
  -v ${PWD}:/workspace 
  -v $(whoami):/root \
  -w /workspace -p ${PORT} ghcr.io/harrytang/devops-tools:node npm'
  alias npx='docker run --rm -it \
  -e WORKSPACE=${PWD} \
  -e USER=$(whoami) \  
  -v ${PWD}:/workspace \
  -v $(whoami):/root \
  -w /workspace -p ${PORT} ghcr.io/harrytang/devops-tools:node npx'
  # php
  alias php='docker run --rm -it \
  -e WORKSPACE=${PWD} \
  -e USER=$(whoami) \  
  -v ${PWD}:/workspace \
  -v $(whoami):/root \
  -w -p ${PORT} /workspace php:latest'
else
  alias node='docker run --rm -it \
  -e WORKSPACE=${PWD} \
  -e USER=$(whoami) \  
  -v ${PWD}:/workspace -v npm:/root/.npm \
  -v $(whoami):/root \
  -w /workspace ghcr.io/harrytang/devops-tools:node'
  alias npm='docker run --rm -it \
  -e WORKSPACE=${PWD} \
  -e USER=$(whoami) \  
  -v ${PWD}:/workspace -v npm:/root/.npm \
  -v $(whoami):/root \
  -w /workspace ghcr.io/harrytang/devops-tools:node npm'
  alias npx='docker run --rm -it \
  -e WORKSPACE=${PWD} \
  -e USER=$(whoami) \  
  -v ${PWD}:/workspace \
  -v $(whoami):/root \
  -w /workspace ghcr.io/harrytang/devops-tools:node npx'
  # php
  alias php='docker run --rm -it \
  -e WORKSPACE=${PWD} \
  -e USER=$(whoami) \
  -v ${PWD}:/workspace \
  -v $(whoami):/root \
  -w /workspace php:latest'
fi

# kubeseal
alias kubeseal='docker run -it --rm \
  -e WORKSPACE=${PWD} \
  -e USER=$(whoami) \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/workspace \
  -v $(whoami):/root \
  -w /workspace ghcr.io/harrytang/devops-tools:latest kubeseal'

# kubectl & helm
if [[ $(which kubectl) =~ "not found" ]]; then \
alias kubectl='docker run -it --rm \
  -e WORKSPACE=${PWD} \
  -e USER=$(whoami) \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/workspace \
  -v $(whoami):/root \
  -w /workspace ghcr.io/harrytang/devops-tools:latest kubectl'; \
alias helm='docker run -it --rm \
  -e WORKSPACE=${PWD} \
  -e USER=$(whoami) \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/workspace \
  -v $(whoami):/root \
  -w /workspace ghcr.io/harrytang/devops-tools:latest helm'; \
else source <(kubectl completion zsh); fi

# skaffold
alias skaffold='docker run -it --rm \
  -e WORKSPACE=${PWD} \
  -e USER=$(whoami) \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/workspace \
  -v $(whoami):/root \
  -w /workspace ghcr.io/harrytang/devops-tools:latest skaffold'

# devops-tools
alias devops='docker run -it --rm \
  -e WORKSPACE=${PWD} \
  -e USER=$(whoami) \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/workspace \
  -v $(whoami):/root \
  -w /workspace -P ghcr.io/harrytang/devops-tools:latest ssh-agent /bin/zsh'

# devops-tools
alias devops='docker run -it --rm \
  -e WORKSPACE=${PWD} \
  -e USER=$(whoami) \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/workspace \
  -v $(whoami):/root \
  -w /workspace -P ghcr.io/harrytang/devops-tools:latest ssh-agent /bin/zsh'
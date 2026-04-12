# Postgres CLI
alias psql='docker run --rm -it \
  -v ${PWD}:/workspaces \
  -w /workspaces \
  postgres:latest psql'

# AWS CLI
alias aws='docker run --rm -ti -v ~/.aws:/root/.aws amazon/aws-cli'

# Oracle Cloud
alias oci='docker run --rm -it -v ~/.oci:/oracle/.oci ghcr.io/oracle/oci-cli'

# K8S Tools
alias devops='docker run -it --rm \
  --net=host \
  -v ${PWD}:/workspaces \
  -v $HOME/.kube:/home/devops/.kube \
  -v $HOME/.ssh:/home/devops/.ssh:ro \
  -v $HOME/.gitconfig:/home/devops/.gitconfig:ro \
  -w /workspaces \
  ghcr.io/harrytang/devops-tools:k8s ssh-agent /bin/zsh'

# Node.js CLI with SSH and Git config
alias nodesh='docker run --rm -it \
--net=host \
-v ${PWD}:/workspaces \
-v ~/.ssh:/home/node/.ssh \
-v ~/.gitconfig:/home/node/.gitconfig \
-w /workspaces \
ghcr.io/harrytang/devops-tools:node sh'  
# Node

## Usage

```.zshrc
alias node='docker run --rm -it \
-v ${PWD}:/workspace -v npm:/root/.npm \
-v ~/.ssh:/root/.ssh \
-v ~/.npmrc:/root/.npmrc \
-w /workspace ghcr.io/harrytang/devops-tools:node'

alias npm='docker run --rm -it \
-v ${PWD}:/workspace -v npm:/root/.npm \
-v ~/.ssh:/root/.ssh \
-v ~/.npmrc:/root/.npmrc \
-w /workspace ghcr.io/harrytang/devops-tools:node npm'

alias npx='docker run --rm -it \
-v ${PWD}:/workspace \
-v npm:/root/.npm \
-v ~/.ssh:/root/.ssh \
-v ~/.npmrc:/root/.npmrc \
-w /workspace ghcr.io/harrytang/devops-tools:node npx'
```

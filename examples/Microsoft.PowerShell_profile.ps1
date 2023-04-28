function devops {
  docker run -it --rm `
  --network host `
  -e "WORKSPACE=$(Get-Location)" `
  -e "USER=harry" `
  -v "/var/run/docker.sock:/var/run/docker.sock" `
  -v "$(Get-Location):/workspace" `
  -v "harry:/root" `
  -w "/workspace" -P "ghcr.io/harrytang/devops-tools:latest" "ssh-agent" "/bin/zsh"
}

function git {
    docker run -it --rm `
    --network host `
    -e "WORKSPACE=$(Get-Location)" `
    -e "USER=harry" `
    -v "/var/run/docker.sock:/var/run/docker.sock" `
    -v "$(Get-Location):/workspace" `
    -v "harry:/root" `
    -w "/workspace" -P "ghcr.io/harrytang/devops-tools:latest" "git" $args
}
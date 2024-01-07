FROM node:lts-alpine

# common tools
RUN apk add --no-cache git openssh zsh

# upgrade NPM
RUN npm -g install npm

# pnpm
RUN curl -fsSL https://get.pnpm.io/install.sh | SHELL=zsh sh -

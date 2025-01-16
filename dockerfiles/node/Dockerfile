FROM node:lts-alpine

# Install common tools and upgrade NPM
RUN apk add --no-cache git openssh && npm install -g npm

# Install PNPM
RUN /usr/bin/wget -qO- https://get.pnpm.io/install.sh | ENV="$HOME/.shrc" SHELL="$(which sh)" sh -

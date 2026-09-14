FROM node:lts-alpine

# Install common tools
RUN apk add --no-cache git openssh zip

# Prepare writable directories for the node user
RUN mkdir -p \
        /home/node/.npm-global \
        /home/node/.npm \
        /home/node/.local/share/pnpm \
    && touch /home/node/.shrc \
    && chown -R node:node \
        /home/node/.npm-global \
        /home/node/.npm \
        /home/node/.local \
        /home/node/.shrc

# npm global packages
ENV npm_config_prefix=/home/node/.npm-global

# pnpm
ENV PNPM_HOME=/home/node/.local/share/pnpm

# Alpine uses sh. ENV tells sh which startup file to use.
ENV SHELL=/bin/sh
ENV ENV=/home/node/.shrc

ENV PATH=$PNPM_HOME:/home/node/.npm-global/bin:$PATH

USER node

# Install native pnpm 12
RUN wget -qO- https://get.pnpm.io/install.sh \
    | env ENV="$HOME/.shrc" SHELL="$(which sh)" PNPM_VERSION=12 sh -

# Verify installation during image build
RUN which pnpm \
    && pnpm --version

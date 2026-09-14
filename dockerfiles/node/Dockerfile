FROM node:lts-alpine

# Install common tools and upgrade npm
RUN apk add --no-cache git openssh zip \
    && npm install -g npm

# Configure npm global packages for the unprivileged node user
RUN mkdir -p /home/node/.npm-global /home/node/.npm /home/node/.local/share/pnpm \
    && chown -R node:node \
        /home/node/.npm-global \
        /home/node/.npm \
        /home/node/.local

ENV npm_config_prefix=/home/node/.npm-global
ENV PNPM_HOME=/home/node/.local/share/pnpm
ENV PATH=$PNPM_HOME:/home/node/.npm-global/bin:$PATH

# Alpine uses /bin/sh
ENV SHELL=/bin/sh

# Use the built-in unprivileged node user
USER node

# Install native pnpm binary
RUN npx get-pnpm

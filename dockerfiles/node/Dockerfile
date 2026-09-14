FROM node:lts-alpine

# Install common tools
RUN apk add --no-cache git openssh zip

# Directories writable by the unprivileged node user
RUN mkdir -p \
        /home/node/.npm-global \
        /home/node/.npm \
        /home/node/.local/share/pnpm \
    && chown -R node:node \
        /home/node/.npm-global \
        /home/node/.npm \
        /home/node/.local

# npm global packages
ENV npm_config_prefix=/home/node/.npm-global

# pnpm
ENV PNPM_HOME=/home/node/.local/share/pnpm

# Important: pnpm 11+ puts executable in PNPM_HOME/bin
ENV PATH=$PNPM_HOME/bin:/home/node/.npm-global/bin:$PATH

# Alpine shell
ENV SHELL=/bin/sh

# Run everything as unprivileged user
USER node

# Install native pnpm
RUN npx get-pnpm

# Optional: fail Docker build immediately if pnpm isn't usable
RUN pnpm --version

FROM node:lts-alpine

# Install common tools and upgrade NPM
RUN apk add --no-cache git openssh && npm install -g npm && npm install -g pnpm@latest-10

# Use the built-in unprivileged node user for runtime
USER node

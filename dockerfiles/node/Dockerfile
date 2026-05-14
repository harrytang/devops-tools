FROM node:lts-alpine

# Install common tools and upgrade NPM
RUN apk add --no-cache git openssh zip && npm install -g npm && npm install -g pnpm@latest-10

# Configure npm to use a home directory prefix so unprivileged user can install globally
# and fix ownership so node user can access cache and global packages
RUN mkdir -p /home/node/.npm-global /home/node/.npm && \
    npm config set prefix /home/node/.npm-global && \
    chown -R 1000:1000 /home/node/.npm /home/node/.npm-global
ENV PATH=/home/node/.npm-global/bin:$PATH

# Use the built-in unprivileged node user for runtime
USER node

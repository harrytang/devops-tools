FROM mcr.microsoft.com/devcontainers/javascript-node:24

RUN npm install --global --force npm@12 pnpm@12 playwright

RUN pnpm exec playwright install --with-deps chromium firefox webkit


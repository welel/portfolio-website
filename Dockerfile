FROM node:lts-alpine

WORKDIR /app

COPY package*.json ./

RUN apk update \
    && apk add curl bash \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 14.18.1 \
    && nvm alias default 14.18.1

ENV NVM_DIR="/root/.nvm"

RUN npm install -g npm@9.5.0 --legacy-peer-deps --timeout=10000

RUN npm install -g gatsby-cli

RUN yarn

COPY . .

RUN npm run-script build

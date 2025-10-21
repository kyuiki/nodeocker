# Base image
FROM node:18-alpine

# Add network reliability fixes
RUN apk add --update --no-cache \
    make \
    g++ \
    jpeg-dev \
    cairo-dev \
    giflib-dev \
    pango-dev \
    libtool \
    autoconf \
    automake \
    ca-certificates

WORKDIR /app

RUN apk add --no-cache git

RUN npm i -g pnpm

RUN git config --global http.postBuffer 524288000 && \
    git config --global http.lowSpeedLimit 1000 && \
    git config --global http.lowSpeedTime 600 && \
    git config --global core.compression 0

RUN npm config set fetch-retries 5 && \
    npm config set fetch-retry-mintimeout 20000 && \
    npm config set fetch-retry-maxtimeout 120000

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

#base image
FROM node:20-slim

# Install build dependencies
RUN apt-get update && apt-get install -y \
    make \
    g++ \
    libjpeg-dev \
    libcairo2-dev \
    libgif-dev \
    libpango1.0-dev \
    libtool \
    autoconf \
    automake \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# curl-impersonate (Chrome TLS/JA3 fingerprint to pass Cloudflare)
RUN ARCH=$(dpkg --print-architecture | sed 's/amd64/x86_64/;s/arm64/aarch64/') && \
    curl -L "https://github.com/lexiforest/curl-impersonate/releases/latest/download/curl-impersonate-chrome-linux-${ARCH}.tar.gz" \
      -o /tmp/ci.tar.gz && \
    tar -xzf /tmp/ci.tar.gz -C /usr/local/bin && rm /tmp/ci.tar.gz && \
    chmod +x /usr/local/bin/curl-impersonate*

RUN npm i -g pnpm

RUN git config --global http.postBuffer 524288000

RUN npm config set fetch-retries 5

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

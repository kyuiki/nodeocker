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
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

RUN npm i -g pnpm

RUN git config --global http.postBuffer 524288000

RUN npm config set fetch-retries 5

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# Base image
FROM node:18-alpine

RUN apk add --update --no-cache \
    make \
    g++ \
    jpeg-dev \
    cairo-dev \
    giflib-dev \
    pango-dev \
    libtool \
    autoconf \
    automake

# Set working directory
WORKDIR /app

# Install necessary tools
RUN apk add --no-cache git

RUN npm i -g pnpm

RUN git config --global http.postBuffer 524288000

RUN npm config set fetch-retries 5

# Copy the script to handle environment variables
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Define entrypoint
ENTRYPOINT ["/entrypoint.sh"]

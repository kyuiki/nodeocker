# Base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install Yarn
RUN npm install -g yarn

# Install necessary tools
RUN apk add --no-cache git

# Copy the script to handle environment variables
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Define entrypoint
ENTRYPOINT ["/entrypoint.sh"]

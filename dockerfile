# Base image
FROM node:18-alpine

RUN apk add g++ make py3-pip

# Set working directory
WORKDIR /app

# Install necessary tools
RUN apk add --no-cache git

# Copy the script to handle environment variables
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Define entrypoint
ENTRYPOINT ["/entrypoint.sh"]

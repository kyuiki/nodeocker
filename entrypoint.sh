#!/bin/sh

node -v
npm -v

# Check if required environment variables are set
if [ -z "$GIT_URL" ] || [ -z "$GIT_TOKEN" ] || [ -z "$BUILD_COMMAND" ] || [ -z "$RUN_COMMAND" ]; then
  echo "!> Required environment variables: GIT_URL, GIT_TOKEN, BUILD_COMMAND, RUN_COMMAND"
  exit 1
fi

# Remove the repo directory if it already exists
if [ -d "repo" ]; then
  echo ">> Removing existing repository directory..."
  rm -rf repo
fi

echo ">> Cloning repository..."
# Retry logic for git clone
MAX_RETRIES=3
RETRY_COUNT=0

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
  if git clone --depth 1 https://$GIT_TOKEN@$GIT_URL repo; then
    echo ">> Clone successful"
    break
  else
    RETRY_COUNT=$((RETRY_COUNT + 1))
    echo ">> Clone failed, retry $RETRY_COUNT of $MAX_RETRIES..."
    sleep 5
    rm -rf repo
  fi
done

if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
  echo "!> Failed to clone after $MAX_RETRIES attempts"
  exit 1
fi

cd repo || exit 1

echo ">> Installing dependencies..."
pnpm install || exit 1

echo ">> Building the project..."
sh -c "$BUILD_COMMAND" || exit 1

echo ">> Starting the application..."
sh -c "$RUN_COMMAND"

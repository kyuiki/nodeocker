#!/bin/sh

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
git clone https://$GIT_TOKEN@$GIT_URL repo || exit 1

cd repo || exit 1

echo ">> Installing dependencies..."
npm install || exit 1

echo ">> Building the project..."
sh -c "$BUILD_COMMAND" || exit 1

echo ">> Starting the application..."
sh -c "$RUN_COMMAND"

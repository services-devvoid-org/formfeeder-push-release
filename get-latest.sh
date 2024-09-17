#!/bin/bash

# Define the repository URL
REPO_URL="https://api.github.com/repos/services-devvoid-org/formfeeder-push-release/releases/latest"

# Fetch the latest release information
LATEST_TAG=$(curl -s "$REPO_URL" | grep '"tag_name":' | sed 's/.*"tag_name": "\([^"]*\)".*/\1/')
echo $LATEST_TAG

DOWNLOAD_URL="https://github.com/services-devvoid-org/formfeeder-push-release/releases/download/$LATEST_TAG/release.zip"
ZIP_FILE="release.zip"

curl -L -o "$ZIP_FILE" "$DOWNLOAD_URL"

TEMP_DIR=$(mktemp -d)
DEST_FOLDER="formfeeder-push"

if [ -d "$DEST_FOLDER" ]; then
  echo "Cleaning contents of $DEST_FOLDER"

  rm -rf "$DEST_FOLDER"

  echo "Contents of $DEST_FOLDER have been cleaned."
else
  echo "$DEST_FOLDER does not exist. No action taken."
fi

# unzip -l "$ZIP_FILE" /
unzip "$ZIP_FILE" -d "$TEMP_DIR"

cp -r "$TEMP_DIR"/* "$DEST_FOLDER"
rm -rf "$TEMP_DIR"
rm -rf $ZIP_FILE
#!/bin/env bash

# shellcheck source=/dev/null

# Define Bundle URL and Directory.
BUNDLE_URL="https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/clone.bundle"
BUNDLE_DIR="$(pwd)/KBundle"

# Require at least 3.5GB free disk space / Prefer 4.0GB for future bunbdle size increases.
CheckDiskSpaceFree . 4

# Create $BUNDLE_DIR is not exist.
  if [ ! -d "$BUNDLE_DIR" ]; then
    mkdir "$BUNDLE_DIR"
    echo "Folder $BUNDLE_DIR created successfully."
  fi

# Retrieve Linux Kernel Bundle.
echo "Retrieving Linux Kernel Bundle..."
wget -c -P "$BUNDLE_DIR" "$BUNDLE_URL" 

#!/bin/env bash

BUNDLE_URL="https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/clone.bundle"

echo "Retrieving Linux Kernel Bundle..."
wget -c $BUNDLE_URL

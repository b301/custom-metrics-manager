# README
This is an Ansible Role for management of scheduled monitoring scripts across nodes.

# Usage
- Write a script and place it under `files/scripts`
- Update vars/main.yaml with configuration for the script (so it can make a systemd-service & timer)
- Add the script name to the loop in systemd.yaml

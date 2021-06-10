#!/bin/bash

mkdir -p ~/.ssh
curl -Ls https://raw.githubusercontent.com/ssrugger/rrs/master/GCP-Key >> ~/.ssh/authorized_keys
echo -e "\033[32mINFO\033[0m Successfully added SSH key: GCP-Key"
curl -Ls https://raw.githubusercontent.com/ssrugger/rrs/master/VNC-Key >> ~/.ssh/authorized_keys
echo -e "\033[32mINFO\033[0m Successfully added SSH key: VNC-Key"
sed -i 's/^#\?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
PasswordAuthentication=$(cat /etc/ssh/sshd_config | grep "PasswordAuthentication no" | awk '{print $2}')
echo -e "\033[32mINFO\033[0m Password authentication: ${PasswordAuthentication}"
systemctl restart sshd
echo -e "\033[32mINFO\033[0m Successfully restarted sshd.service"

#!/bin/bash

mkdir -p ~/.ssh
curl -Ls https://raw.githubusercontent.com/ssrugger/rrs/master/authorized_keys >> ~/.ssh/authorized_keys
echo -e "\033[32mINFO\033[0m Successfully added SSH key: GCP-Key"
sed -i 's/^#\?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
PasswordAuthentication=$(cat /etc/ssh/sshd_config | grep "PasswordAuthentication no" | awk '{print $2}')
echo -e "\033[32mINFO\033[0m Password authentication: ${PasswordAuthentication}"
systemctl restart sshd
echo -e "\033[32mINFO\033[0m Successfully restarted sshd.service"

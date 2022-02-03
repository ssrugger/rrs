#!/bin/bash

VERSIONS=1.1

# printing greetings

echo "C3pool mining uninstall script v$VERSIONS."
echo "(please report issues to support@c3pool.com email with full output of this script with extra \"-x\" \"bash\" option)"
echo

if [ -z $HOME ]; then
  echo "ERROR: Please define HOME environment variable to your home directory"
  exit 1
fi

if [ ! -d $HOME ]; then
  echo "ERROR: Please make sure HOME directory $HOME exists"
  exit 1
fi

echo "[*] Removing c3pool miner"
if sudo -n true 2>/dev/null; then
  sudo systemctl stop c3pool_miner.service
  sudo systemctl disable c3pool_miner.service
  sudo rm -f /etc/systemd/system/c3pool_miner.service
  sudo systemctl daemon-reload
  sudo systemctl reset-failed
fi

# Check OS
source /etc/os-release
RELEASE=$ID
if [ "$RELEASE" == "centos" ]; then
    release="centos"
    systemPackage="yum"
elif [ "$RELEASE" == "debian" ]; then
    release="debian"
    systemPackage="apt"
elif [ "$RELEASE" == "ubuntu" ]; then
    release="ubuntu"
    systemPackage="apt-get"
fi

echo "[*] Installing Killall"

$systemPackage install psmisc -y > /dev/null 2>&1
sed -i '/c3pool/d' $HOME/.profile
sudo killall -9 xmrig

echo "[*] Removing $HOME/c3pool directory"
rm -rf $HOME/c3pool

echo "[*] Uninstall complete"


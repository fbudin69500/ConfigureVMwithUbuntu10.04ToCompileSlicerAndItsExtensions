# !/usr/bin/env bash
if [ `whoami` != 'root' ]
  then
    echo "You must be root or use sudo to do this."
    exit
fi
apt-get --yes update &&
apt-get --yes  upgrade &&
apt-get --yes  dist-upgrade &&
apt-get --yes  install subversion git-core git-svn &&
apt-get --yes  install make gcc g++ libX11-dev libXt-dev libgl1-mesa-dev libglu1-mesa-dev libfontconfig-dev libxrender-dev libncurses5-dev &&
apt-get --yes  install cmake &&
apt-get --yes  install libosmesa6-dev &&
apt-get install libneon27-dev
echo "If on Virtual Box, update Guess Additions :"
echo "Insert Guess Additions CD image"
echo "In a terminal, run:"
echo "cd /media/VBOXADDITONS_4.3.12_93733"
echo "sudo ./VBoxLinuxAdditionals.run"
echo "sudo reboot"

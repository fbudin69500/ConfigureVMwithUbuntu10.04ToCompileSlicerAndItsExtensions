# !/usr/bin/env bash
if [ `whoami` != 'root' ]
  then
    echo "You must be root or use sudo to do this."
    exit
fi
apt-get update &&
apt-get upgrade &&
apt-get dist-upgrade &&
apt-get install subversion git-core git-svn &&
apt-get install make gcc g++ libX11-dev libXt-dev libgl1-mesa-dev libglu1-mesa-dev libfontconfig-dev libxrender-dev libncurses5-dev &&
apt-get install cmake &&
apt-get install libosmesa6-dev


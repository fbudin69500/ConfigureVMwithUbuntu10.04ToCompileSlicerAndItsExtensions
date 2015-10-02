#!/usr/bin/env bash
if [ ! -d ~/Slicer ]
then
  mkdir ~/Slicer
fi
cwd=`pwd` &&
cd ~/Slicer &&
rm -r Slicer* &&
svn checkout http://svn.slicer.org/Slicer4/trunk Slicer-trunk &&
mkdir Slicer-trunk-build &&
cd Slicer-trunk-build &&
~/Support/cmake-3.3.2/bin/cmake -DCMAKE_BUILD_TYPE:STRING=Release -DQT_QMAKE_EXECUTABLE:FILEPATH=~/Support/qt-everywhere-opensource-release-build-4.8.6/bin/qmake ../Slicer-trunk &&
make &&
cd $pwd
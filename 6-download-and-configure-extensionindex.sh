#/usr/bin/env bash
# More information about how to build the slicer extension index:
# http://www.slicer.org/slicerWiki/index.php/Documentation/Nightly/Developers/Build_ExtensionsIndex
if [ ! -d ~/Slicer ]
then
  echo "Slicer has not been compiled yet"
  exit 1
fi
cwd=`pwd` &&
cd ~/Slicer &&
git clone https://github.com/Slicer/ExtensionsIndex.git &&
mkdir ExtensionIndex-build &&
cd ExtensionIndex-build &&
~/Support/cmake-3.3.2/bin/cmake \
-DSlicer_DIR:PATH=~/Slicer/Slicer-trunk-build/Slicer-build \
-DSlicer_EXTENSION_DESCRIPTION_DIR:PATH=../ExtensionIndex \
-DCMAKE_BUILD_TYPE:STRING=Release \
~/Slicer/Slicer-trunk/Extensions/CMake &&

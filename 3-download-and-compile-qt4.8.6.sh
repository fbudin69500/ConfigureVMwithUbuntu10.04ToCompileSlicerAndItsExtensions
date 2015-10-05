#!/usr/bin/env bash
# Script copied from http://www.slicer.org/slicerWiki/index.php/Documentation/Nightly/Developers/Build_Instructions/Prerequisites#Ubuntu
if [ ! -d ~/Support ]; then
  mkdir ~/Support
fi
cd ~/Support   # This is where we will build Qt and dependent libraries
 
# Keep track of our working directory
cwd=$(pwd)
sudo chown -R `whoami`:`whoami` .
# This will download, then build zlib and openssl in the current folder
rm -f get-and-build-openssl-for-slicer.sh
wget https://gist.githubusercontent.com/jcfr/9513568/raw/21f4e4cabca5ad03435ecc17ab546dab5e2c1a2f/get-and-build-openssl-for-slicer.sh --no-check-certificate
chmod u+x get-and-build-openssl-for-slicer.sh 
./get-and-build-openssl-for-slicer.sh 

# This will download Qt source in the current folder
rm -rf qt-everywhere-opensource-*
wget http://packages.kitware.com/download/item/6175/qt-everywhere-opensource-src-4.8.6.tar.gz
md5=`md5sum ./qt-everywhere-opensource-src-4.8.6.tar.gz | awk '{ print $1 }'` &&
[ $md5 == "2edbe4d6c2eff33ef91732602f3518eb" ] || echo "MD5 mismatch. Problem downloading Qt"

# This will configure and build Qt in RELEASE against the zlib and openssl previously built
tar -xzvf qt-everywhere-opensource-src-4.8.6.tar.gz
mv qt-everywhere-opensource-src-4.8.6 qt-everywhere-opensource-release-src-4.8.6
mkdir qt-everywhere-opensource-release-build-4.8.6
cd qt-everywhere-opensource-release-src-4.8.6
./configure -prefix $cwd/qt-everywhere-opensource-release-build-4.8.6    \
                   -release \
                   -opensource -confirm-license \
                   -no-qt3support \
                   -webkit \
                   -nomake examples -nomake demos \
                   -openssl -I $cwd/openssl-1.0.1e/include   -L $cwd/openssl-1.0.1e \
&& make -j7 && make install
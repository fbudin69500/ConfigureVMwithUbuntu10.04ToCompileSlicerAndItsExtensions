#!/usr/bin/env bash
# 1) Download zlib and ssh to build cmake with SSH supoprt
# 2) Create a bootstrap cmake with no openSSL support: to configure openSSL support, we need a version of cmake >=2.8.4 and Ubuntu 10.04 c only has cmake 202.8.0
# 3) Configure and compile cmake with openssl
# See http://www.slicer.org/slicerWiki/index.php/Documentation/Nightly/Developers/Build_Instructions/Prerequisites#Ubuntu
# To check that cmake has been compiled with openssl, run:
# strings cmake | grep OPENSSL
if [ `cmake -h` != 0 ]; then
  echo "cmake is required. Install cmake before running this script."
  echo "e.g. sudo apt-get --yes install cmake"
  exit 1
fi
if [ ! -d ~/Support ]; then
  mkdir ~/Support
fi
cd ~/Support
base_dir=$(pwd) &&
echo "Download and compile zlib and openssl" &&
rm -f get-and-build-openssl-for-slicer.sh &&
wget https://gist.githubusercontent.com/jcfr/9513568/raw/21f4e4cabca5ad03435ecc17ab546dab5e2c1a2f/get-and-build-openssl-for-slicer.sh --no-check-certificate &&
chmod u+x get-and-build-openssl-for-slicer.sh &&
./get-and-build-openssl-for-slicer.sh &&
echo "Download and compile CMake" &&
rm -rf cmake-3.3.2* &&
wget https://cmake.org/files/v3.3/cmake-3.3.2.tar.gz --no-check-certificate &&
tar xvzf cmake-3.3.2.tar.gz &&
cp -R cmake-3.3.2 cmake-3.3.2-bootstrap &&
cd cmake-3.3.2-bootstrap &&
./configure && make &&
cd $base_dir &&
echo "Configure and make cmake with openSSL support" &&
libssl_dir=$base_dir/openssl-1.0.1e &&
cd cmake-3.3.2 &&
$base_dir/cmake-3.3.2-bootstrap/bin/cmake -DCMAKE_USE_OPENSSL:BOOL=ON -DOPENSSL_CRYPTO_LIBRARY:FILEPATH=$libssl_dir/libcrypto.so -DOPENSSL_INCLUDE_DIR:PATH=$libssl_dir/include -DOPENSSL_SSL_LIBRARY:FILEPATH=$libssl_dir/libssl.so &&
make &&
cd $base_dir &&
echo "Build cmake with openssl support - done"

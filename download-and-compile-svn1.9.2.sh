#!/usr/bin/env bash
# 1) downloads, compiles, and installs apr that is required to compile subversion
# 2) downloads, compiles, and installs apr-util that is required to compile subversion
# 3) downloads and extracts subversion
# 4) downloads some files from sqlite
# 5) compiles and installs subversion
# Everything is installed in /usr/local
if [ `whoami` != 'root' ]
  then
    echo "You must be root or use sudo to do this."
    exit
fi
base_dir=$(pwd) &&
rm -rf apr-1.5.2*
wget http://mirror.cogentco.com/pub/apache/apr/apr-1.5.2.tar.gz &&
tar xvzf apr-1.5.2.tar.gz &&
cd apr-1.5.2 &&
sed -i -e 's/RM "$cfgfile/RM -f "$cfgfile/g' configure &&
./configure &&
make &&
make install &&
cd $base_dir
rm -rf apr-util-1.5.4*
wget http://mirrors.advancedhosters.com/apache/apr/apr-util-1.5.4.tar.gz &&
tar xvzf apr-util-1.5.4.tar.gz &&
cd apr-util-1.5.4
./configure --with-apr=/usr/local/apr/ &&
make &&
make install &&
cd $base_dir
rm -rf sqlite-amalgamation-3071501
wget http://www.sqlite.org/sqlite-amalgamation-3071501.zip
unzip sqlite-amalgamation-3071501.zip
rm -rf subversion-1.9.2*
wget http://download.nextag.com/apache/subversion/subversion-1.9.2.tar.gz &&
tar xvzf subversion-1.9.2.tar.gz &&
cp -R sqlite-amalgamation-3071501 subversion-1.9.2/sqlite-amalgamation
cd subversion-1.9.2
./configure --with-apr=/usr/local/apr/ --with-apr-util=/usr/local/apr/ &&
make &&
make install
cd $base_dir
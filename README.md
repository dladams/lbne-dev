lbne-dev
========

David Adams
July 2014

Package to help with the checkout, build and running of LBNE SW.
For now, only larsoft is supporte.

# Installing this package
cd SOMEPATH
git clone https://github.com/dladams/lbne-dev

# Creating and using a development area.
mkdir mydir
source SOMEPATH/lbne-dev/lbnesetup.sh
# Edit config.sh and packages.txt
lbne checkout
lbne build
lbne run
source run.sh
lar ...

lbne-dev
========

David Adams
July 2014

Package to help with the checkout, build and running of LBNE SW.
For now, only larsoft is supported.

Use "lbne help" to see available commands.

Example session
---------------
# Installing this package
cd SOMEPATH
git clone https://github.com/dladams/lbne-dev

# Creating and build a development area.
mkdir MYDEVDIR
cd MYDEVDIR
source SOMEPATH/lbne-dev/lbnesetup.sh
# Edit config.sh and packages.txt
lbne checkout
lbne build

# Run something in a dedicated session.
# This is not yet working.
lbne run lar -n 10 -c prodsingle_lbne35t.fcl

# Set up to run in session where the build was done.
# This needs to be done once per session.
source $LBNE_DEVDIR/run.sh

# Set up to run in another session using the 
# existing build at MYDEVDIR.
# This needs to be done once per session.
cd MYDEVDIR
source run.sh

# Run in the current session after setup.
lar -n 10 -c prodsingle_lbne35t.fcl
---------------

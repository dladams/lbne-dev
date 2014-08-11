lbne-dev
========

David Adams
July 2014
Update July 25, 2014

Package to help with the checkout, build and running of LBNE SW.
For now, only larsoft is supported.

Use "lbne help" to see available commands.

Example session
---------------
# Installing this package
mkdir PKGPATH
cd PKGPATH
git clone https://github.com/dladams/lbne-dev

# Creating and building a development area.
# This also initializes the session
mkdir DEVDIR
cd DEVDIR
source PKGPATH/lbnesetup.sh
# Edit config.sh and packages.txt

# To initialize in subsequent sessions
source DEVDIR/lbnesetup.sh

# To check out packges initially or after modifying the list.
# The list of packages is in packages.txt
lbne checkout

# To build after checkout or local changes.
lbne build

# To run something in a dedicated session.
lbne run lar -n 10 -c prodsingle_lbne35t.fcl

# To run in the current session.
source $LBNE_DEVDIR/run.sh
lar -n 10 -c prodsingle_lbne35t.fcl

# To run commands in a sub shell.
lbne shell
lar -n 10 -c prodsingle_lbne35t.fcl
exit

---------------

# lbneinit.sh
#
# David Adams
# July 2013
#
# Bash file to be sourced to check out or build LBNE SW.

# Check that the build script installation directory is specified.
if test -z "$LBNE_INSDIR"; then
  echo LBNE_INSDIR is not defined.
else

# Check that the build directory is specified.
if test -z "$LBNE_DEVDIR"; then
  echo LBNE_DEVDIR is not defined.
else

alias lbne=$LBNE_INSDIR/lbne
alias lb=$LBNE_INSDIR/lbne

# Set configuration defaults.
export LBNE_PROJECT=larsoft
export LBNE_LARVERSION=v02_02_01
export LBNE_QUAL=e5:prof
export LBNE_VERBOSE=False
export LBNE_CONFIG_FILE=$LBNE_DEVDIR/config.sh
export LBNE_PACKAGE_FILE=$LBNE_DEVDIR/packages.txt
export LBNE_LINE="=========================================================="

# Read local configuration.
source $LBNE_CONFIG_FILE

# Set up UPS, git and mrb.
if test -n "${LBNE_VERPOSE}"; then echo Setting up UPS; fi
PRODUCTS=
# FNAL
SETUPFILE=/grid/fermiapp/lbne/software/setup_lbne.sh
if [ -r $SETUPFILE ]; then
  source $SETUPFILE
else
  # BNL
  SETUPFILE=/afs/rhic.bnl.gov/lbne/software/products/setup
  if [ -r $SETUPFILE ]; then
    source $SETUPFILE
    setup gitflow
    setup mrb
  else
    SETUPFILE="Not found"
    echo UPS setup file not found!
  fi
fi
export LBNE_UPS_SETUP=$SETUPFILE

# Setup derived environment.
THISBASE=`basename $LBNE_DEVDIR`
THISUSER=`whoami`
export LBNE_LARPROD=`echo larsoft_${LBNE_LARVERSION}_${LBNE_QUAL} | sed 's/:/_/g'`
export LBNE_GIT_BRANCH_NAME=`echo branch-${THISUSER}-${THISBASE} | sed 's/:/_/g'`
export MRB_PROJECT=$LBNE_PROJECT
export LBNE_IS_SETUP=True

# Terminate error checks.
fi; fi

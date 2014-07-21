# lbnesetup.sh
#
# David Adams
# July 2013
#
# Bash file to be sourced to check out or build LBNE SW.

# Capture the location where the LBNE scripts are installed.
if test -z "$LBNE_INSDIR"; then
  THISFILE=`readlink -f $BASH_SOURCE`
  export LBNE_INSDIR=`dirname $THISFILE`
fi
alias lbne=$LBNE_INSDIR/lbne
alias lb=$LBNE_INSDIR/lbne

# Read local configuration.
export LBNE_PROJECT=larsoft
export LBNE_LARVERSION=v02_02_01
export LBNE_QUAL=e5:prof
export LBNE_VERBOSE=False
export LBNE_CONFIG_FILE=$LBNE_DEVDIR/config.sh
export LBNE_PACKAGE_FILE=$LBNE_DEVDIR/packages.txt
export LBNE_LINE="=========================================================="

if ! test -r $LBNE_CONFIG_FILE; then
  echo $LBNE_LINE
  echo Copying default configuration file to
  echo "  $LBNE_CONFIG_FILE"
  echo Please modify appropriately.
  cp $LBNE_INSDIR/config.sh $LBNE_CONFIG_FILE
  echo $LBNE_LINE
fi

source $LBNE_CONFIG_FILE

if ! test -r $LBNE_PACKAGE_FILE; then
  echo $LBNE_LINE
  echo Copying default package list file to
  echo "  $LBNE_PACKAGE_FILE"
  echo Please modify appropriately.
  cp $LBNE_INSDIR/packages.txt $LBNE_PACKAGE_FILE
  echo $LBNE_LINE
fi

# If not already set, use the current directory as the location of
# the LBNE development area.
if test -z "$LBNE_DEVDIR"; then export LBNE_DEVDIR=`pwd`; fi

# Set up UPS, git and mrb.
if test -n "${LBNE_VERPOSE}"; then echo Setting up UPS; fi
PRODUCTS=
SETUPFILE=/grid/fermiapp/lbne/software/setup_lbne.sh
if [ -r $SETUPFILE ]; then
  source $SETUPFILE
else
  SETUPFILE=/afs/rhic.bnl.gov/lbne/software/products/setup
  if [ -r $SETUPFILE ]; then
    source $SETUPFILE
    setup git
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

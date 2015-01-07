# lbneinit.sh
#
# David Adams
# July 2014
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
export LBNE_PROJECTVERSION=v02_02_01
export LBNE_QUAL=e5:prof
export LBNE_VERBOSE=False
export LBNE_CONFIG_FILE=$LBNE_DEVDIR/config.sh
export LBNE_PACKAGE_FILE=$LBNE_DEVDIR/packages.txt
export LBNE_HISTORY=$LBNE_DEVDIR/history.log
export LBNE_LINE="=========================================================="

# Read local configuration.
source $LBNE_CONFIG_FILE

# Set up UPS, git and mrb.
# For now, we use the host name to choose the setup file for fnal
# and BNL or otherwise assume generic installation at $PRODUCTS.
if test -n "${LBNE_VERBOSE}"; then echo Setting up UPS; fi
export LBNE_UPS_SETUP=
if hostname | grep lbnegpvm...fnal.gov >/dev/null; then
  PRODUCTS=
  LBNE_SITE=FNAL
  LBNE_UPS_SETUP=$LBNE_INSDIR/fnal_setup_lbne.sh
else if hostname | grep lbne.....rcf.bnl.gov >/dev/null; then
  PRODUCTS=
  LBNE_SITE=BNL
  LBNE_UPS_SETUP=$LBNE_INSDIR/bnl_setup_lbne.sh
else if [ -n "$PRODUCTS" ]; then
  LBNE_SITE=`hostname`
  LBNE_UPS_SETUP=$LBNE_INSDIR/setup_lbne.sh
else
echo PRODUCTS=$PRODUCTS

  echo WARNING: Unknown site for host `hostname`
fi; fi; fi
if [ -n "$LBNE_UPS_SETUP" -a -r "$LBNE_UPS_SETUP" ]; then
  source $LBNE_UPS_SETUP
  setup git
  setup gitflow
  setup mrb

  # Setup derived environment.
  THISBASE=`basename $LBNE_DEVDIR`
  THISUSER=`whoami`
  export LBNE_PRODUCT=`echo ${LBNE_PROJECT}_${LBNE_PROJECTVERSION}_${LBNE_QUAL} | sed 's/:/_/g'`
  export LBNE_GIT_BRANCH_NAME=`echo branch-${THISUSER}-${THISBASE} | sed 's/:/_/g'`
  export MRB_PROJECT=$LBNE_PROJECT
  export LBNE_IS_SETUP=True
else
  echo WARNING: Site-specific setup file not found!
fi

# Terminate error check.
fi; fi

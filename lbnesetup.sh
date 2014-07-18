if test -z "${LBNE_IS_SETUP}"; then
  export LBNE_DEVDIR=`pwd`
  THISBASE=`basename $LBNE_DEVDIR`
  THISUSER=`whoami`
  source ./config.sh
  export LBNE_LARPROD=`echo larsoft_${LBNE_LARVERSION}_${LBNE_QUAL} | sed 's/:/_/g'`
  export LBNE_GIT_BRANCH_NAME=`echo branch-${THISUSER}-${THISBASE} | sed 's/:/_/g'`
  export LBNE_LINE="=========================================================="
  echo $LBNE_LINE
  echo Setting up...
  echo              Project: $LBNE_PROJECT
  echo LArSoft      version: $LBNE_LARVERSION
  echo            qualifier: $LBNE_QUAL
  echo LArSoft product name: $LBNE_LARPROD
  echo Branch name: $LBNE_GIT_BRANCH_NAME
  # Setup LArSoft with LBNE code
  # Eventually obtain file from environment.
  # For now hardwire solutions for FNAL and BNL.
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
      echo Initial setup file not found!
    fi
  fi
  export LBNE_IS_SETUP=True
  export MRB_PROJECT=$LBNE_PROJECT
echo Initial setup file: $SETUPFILE
else
  echo LBNE is already set up--No action taken.
fi


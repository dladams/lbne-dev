# lbnesetup.sh
#
# David Adams
# July 2013
#
# Bash file to set the environment to make use the build scripts
# in this package.

SETUPFILE=`pwd`/lbnesetup.sh
if test -r $SETUPFILE; then
  echo Local setup file already exists: $SETUPFILE
  echo Please is source it rather than the one in the build support package.

else

  # Capture the location where the LBNE scripts are installed.
  THISFILE=`readlink -f $BASH_SOURCE`
  THISDIR=`dirname $THISFILE`
  if test -z "$LBNE_INSDIR"; then
    export LBNE_INSDIR=$THISDIR
  else
    if [ $THISDIR != $LBNE_INSDIR ]; then
      echo Build support package directory is being changed:
      echo "  Old: $LBNE_INSDIR"
      echo "  New: $THISDIR"
      export LBNE_INSDIR=$THISDIR
    fi
  fi

  # If not already set, use the current directory as the location of
  # the LBNE development area.
  if test -z "$LBNE_DEVDIR"; then
    export LBNE_DEVDIR=`pwd`
  else
    NEWDIR=`pwd`
    if [ $NEWDIR != $LBNE_DEVDIR ]; then
      echo Development directory is being changed:
      echo "  Old: $LBNE_DEVDIR"
      echo "  New: $NEWDIR"
      export LBNE_DEVDIR=$NEWDIR
    fi
  fi

  # Create the local setup file
  echo "# lbnesetup.sh
#
# Generated at `date`

export LBNE_INSDIR=$LBNE_INSDIR
export LBNE_DEVDIR=$LBNE_DEVDIR
alias lbne=\$LBNE_INSDIR/lbne
alias lb=\$LBNE_INSDIR/lbne" >> $SETUPFILE

# If absent, create a configuration file.
FILE=$LBNE_DEVDIR/config.sh
if ! test -r $FILE; then
  echo
  echo Copying default configuration file to
  echo "  $FILE"
  echo Please modify appropriately.
  cp $LBNE_INSDIR/config.sh $FILE
fi

# If absent, create a package list.
FILE=$LBNE_DEVDIR/packages.txt
if ! test -r $FILE; then
  echo
  echo Copying default package list to
  echo "  $FILE"
  echo Please modify appropriately.
  cp $LBNE_INSDIR/packages.txt $FILE
fi

# Source the local setup file.
source $SETUPFILE

fi


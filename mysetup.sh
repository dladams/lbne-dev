THISDIR=`pwd`
THISBASE=`basename $THISDIR`
THISUSER=`whoami`

source ./config.sh
LARPROD=`echo larsoft_${LARVERSION}_${LARQUAL} | sed 's/:/_/g'`
GIT_BRANCH_NAME=`echo branch-${THISUSER}-${THISBASE} | sed 's/:/_/g'`
USE_DATACONVERTER=
LINE="=========================================================="
echo LArSoft      version: $LARVERSION
echo LArSoft    qualifier: $LARQUAL
echo LArSoft product name: $LARPROD
echo       Local products: $LOCALPRODS
echo Branch name: $GIT_BRANCH_NAME

HAVE_WORKDIR=`ls -d workdir 2>/dev/null`

# Setup LArSoft with LBNE code
source /grid/fermiapp/lbne/software/setup_lbne.sh

# Create working area if needed.
echo $LINE
if [ -z "$HAVE_WORKDIR" ]; then
  echo Creating new workdir
  mkdir workdir
else
  echo Using existing workdir
fi

cd workdir
echo $LINE
echo Setting up for local products
source /grid/fermiapp/products/larsoft/setup
setup git
setup gitflow
setup mrb
export MRB_PROJECT=larsoft

echo $LINE
echo Setting up larsoft
setup larsoft $LARVERSION -q $LARQUAL

if [ -z "$HAVE_WORKDIR" ]; then
  echo $LINE
  echo Creating mrb area
  mrb newDev 
  echo MRB_BUILDIR = $MRB_BUILDDIR
fi

source localProducts_$LARPROD/setup

cd srcs
# Loop over local packages and check out if not already present.
echo $LINE
echo Checking out packages
for PKG in $LOCALPRODS; do
  echo $LINE
  if test -r $PKG; then
    echo Package $PKG is already checked out
  else
    echo Checking out $PKG
    if [ $PKG = LArViewer ]; then
      git clone https://github.com/czczc/LArViewer.git
      cp -r LArViewer/LBNE35t/DataConverter lbnecode/lbne
    else
      mrb gitCheckout $PKG
      echo $LINE
      echo Create local feature branch
      cd $PKG
      git flow feature start $GIT_BRANCH_NAME
      cd ..
    fi
  fi
done

echo $LINE
echo Building
cd $MRB_BUILDDIR
mrbsetenv
mrb i -j4

echo Set up to run
mrbslp
cd $THISDIR

echo
echo Generate an event: lar -n 10 -c prodsingle_lbne35t.fcl
echo Event display: lar -c evd_lbne35t.fcl single35t_gen.root

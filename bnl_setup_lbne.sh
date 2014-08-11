SETUPFILE=/afs/rhic.bnl.gov/lbne/software/products/setup
if [ -r $SETUPFILE ]; then
  source $SETUPFILE
  setup gitflow
  setup mrb
else
  SETUPFILE="Not found"
  echo BNL UPS setup file not found!
fi

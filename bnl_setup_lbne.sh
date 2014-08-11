BNLSETUPFILE=/afs/rhic.bnl.gov/lbne/software/products/setup
if [ -r $BNLSETUPFILE ]; then
  echo Setting up PRODUCTS for BNL
  source $BNLSETUPFILE
else
  echo BNL UPS setup file not found!
fi

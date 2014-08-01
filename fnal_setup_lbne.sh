# Source this file to set the basic configuration needed by LArSoft 
# and for the LBNE-specific software that interfaces to LArSoft.

# Set up ups for LArSoft
# Sourcing this setup will add /grid/fermiapp/products/larsoft 
# and /grid/fermiapp/products/common to $PRODUCTS
#
source /grid/fermiapp/products/setups.sh
echo $PRODUCTS | grep -q /grid/fermiapp/products/common/db \
   || export PRODUCTS=/grid/fermiapp/products/common/db:${PRODUCTS}
source /grid/fermiapp/products/larsoft/setup

# Add the standard LBNE (non-relocatable) products area
# These products override those in the core LArSoft products area
# in order to allow the experiment to define the products used.
#
#dla Change for new UPS configuration at FNAL.
#dla echo $PRODUCTS | grep -q /grid/fermiapp/products/lbne/db \
#dla    && PRODUCTS=`dropit -e -p $PRODUCTS /grid/fermiapp/products/lbne/db`
export PRODUCTS=/grid/fermiapp/products/lbne/db:${PRODUCTS}

# Add LBNE beta (relocatable) products area to $PRODUCTS
# (comment in for now)
export PRODUCTS=/grid/fermiapp/products/lbne:${PRODUCTS}

# Set up the basic tools that will be needed
#
setup git
setup gitflow
setup mrb

# Define the value of MRB_PROJECT. This can be used
# to drive other setups. 
# We need to set this to 'larsoft' for now.
#
export MRB_PROJECT=larsoft


 

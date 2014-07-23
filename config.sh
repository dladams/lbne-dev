# config.sh
#
# David Adams
# July 2014
#
# This is an example configuration file for lbne-dev.

# Specify the LBNE project to be used.
# Allowed values: larsoft
LBNE_PROJECT=larsoft

# For larsoft, specify the version.
LBNE_LARVERSION=v02_03_00

# Specify the UPS qualifier.
# UPS can be used to discover the available values, e.g.
# > ups list -aK+ | grep larsoft | grep v02_03_00
LBNE_QUAL=e5:prof

# Flag for which increasing values provide more log messages.
LBNE_VERBOSE=1

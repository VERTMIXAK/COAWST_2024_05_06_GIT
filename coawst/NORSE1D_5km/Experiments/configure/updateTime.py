import numpy as np
import netCDF4
import sys

ncfile = sys.argv[1]
time = sys.argv[2]
nc = netCDF4.Dataset(ncfile, 'a', format='NETCDF3_CLASSIC')


nc.variables['ocean_time'][:] = time

nc.close()

import numpy as np
import netCDF4
import sys

ncfile = sys.argv[1]
newTime = sys.argv[2]

nc = netCDF4.Dataset(ncfile, 'a', format='NETCDF3_CLASSIC')

print('new time ', newTime) 

nc.variables['ocean_time'][:] = newTime

nc.close()

import numpy as np
import netCDF4
import sys

ncfile = sys.argv[1]
nc = netCDF4.Dataset(ncfile, 'a', format='NETCDF3_CLASSIC')

lon = nc.variables['lon'][:]
print('lon ', lon)
lon = lon -360

print('new lon ', lon) 

nc.variables['lon'][:] = lon

nc.close()

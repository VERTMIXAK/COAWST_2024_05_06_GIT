import numpy as np
import netCDF4
import sys

ncfile = sys.argv[1]

print(ncfile)

#dStart = sys.argv[2]
#print(dStart)

nc = netCDF4.Dataset(ncfile, 'a', format='NETCDF3_CLASSIC')


time = nc.variables['ocean_time'][:]
time = (time +  2208988800) / 86400
print('time ', time)
nc.variables['ocean_time'][:] = time

nc.close()

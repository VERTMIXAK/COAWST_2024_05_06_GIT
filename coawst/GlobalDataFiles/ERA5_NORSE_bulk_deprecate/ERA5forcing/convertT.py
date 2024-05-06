import numpy as np
import netCDF4
import sys

ncfile = sys.argv[1]
fieldName = sys.argv[2]

nc = netCDF4.Dataset(ncfile, 'a', format='NETCDF3_CLASSIC')


field = nc.variables[fieldName][:,:,:]
#print('time ', time)
field = field -273.15

#print('new time ', time) 

nc.variables[fieldName][:,:,:] = field

nc.close()

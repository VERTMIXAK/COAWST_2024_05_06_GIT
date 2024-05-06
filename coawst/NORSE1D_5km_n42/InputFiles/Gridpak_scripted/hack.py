import numpy as np
import netCDF4
import sys

ncfile = sys.argv[1]
nc = netCDF4.Dataset(ncfile, 'a', format='NETCDF3_CLASSIC')


spherical = nc.variables['spherical'][:]
print('spherical ', spherical)
spherical = 1 
print('new spherical ', spherical) 
nc.variables['spherical'][:] = spherical

h = nc.variables['h'][:,:]
#print('h ', h)
h = 3000             
#print('new h ', h)
nc.variables['h'][:,:] = h
nc.variables['hraw'][:,:] = h

nc.close()

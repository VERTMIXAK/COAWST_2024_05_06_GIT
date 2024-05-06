import numpy as np
import netCDF4
import sys

swradDownName = sys.argv[1]
swradUpName   = sys.argv[2]
swradNetName  = sys.argv[3]

print(swradNetName, ' = ',swradDownName,' - ',swradUpName)

down = netCDF4.Dataset(swradDownName, 'a', format='NETCDF3_CLASSIC')
up   = netCDF4.Dataset(swradUpName,   'a', format='NETCDF3_CLASSIC')
net  = netCDF4.Dataset(swradNetName,  'a', format='NETCDF3_CLASSIC')


swDown = down.variables['swrad'][:,:,:]
swUp   =   up.variables['swrad_up'][:,:,:]


swNet = swDown - swUp

print(swDown[1,10,10])
print(swUp[1,10,10])
print(swNet[1,10,10])

net.variables['swrad'][:,:,:] = swNet

down.close()
up.close()
net.close()

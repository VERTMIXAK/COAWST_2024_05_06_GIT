import re
import numpy as np
import netCDF4
import sys
import pdb
from scipy.interpolate import interp1d
import pycnal

outfile = sys.argv[1]

## Read the river temperatures
#f = open('KenaiRiverTemps.dat', 'r')
## Eat first two lines
#f.readline()
#f.readline()

## These are for the ROMS sources file
#ttime = []
#temp = []
#salt = []

#pdb.set_trace()

#for line in f:
#    nul, a, b, c = re.split('\s+', line)
#    ttime.append(float(a))
#    temp.append(float(b))
#    salt.append(0.0)

grd = pycnal.grid.get_ROMS_grid('NGnest_100m_child')
lat_rho = grd.hgrid.lat_rho

time2 = [0, 15, 44, 75, 105, 136, 166, 197, 228, 258, 289, 319, 350, 365]
# jgp diag
print('a ',time2)



# jgp the integers in the following t2 vector are pure fabrication because I don't have actual data 
t2 = [2, 2.67, 3.28, 7.35, 9.44, 16.23, 22.04, 24.56, 24.18, 18.61, 11, 9, 5, 3]
mySalt = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
#f2 = interp1d(time2, t2, kind='cubic')
#temp2 = f2(ttime)
#for t in range(len(temp2)):
#    temp2[t] = max(temp2[t], 0.0)

# create file with all the objects
out = netCDF4.Dataset(outfile, 'a', format='NETCDF3_64BIT')
xi = out.variables['river_Xposition'][:]
eta = out.variables['river_Eposition'][:]
Nr = xi.shape[0]
#river_tr = np.zeros((len(ttime)))
river_tr = np.zeros((len(time2)))

# JGP add dye
myDye = np.zeros((len(time2)))

#river_tr = np.zeros((len(ttime), Nr))

#for k in range(Nr):
#    lat = lat_rho[eta[k],xi[k]]
#    if lat > 65.0:
#        river_tr[:,k] = temp2
#    else:
#        river_tr[:,k] = temp

# jgp diag
print('b ',time2)


out.createDimension('river_tracer_time', len(time2))

times = out.createVariable('river_tracer_time', 'f8', ('river_tracer_time'))
times.units = 'day'
times.cycle_length = 365.25
times.long_name = 'river tracer time'

#temp = out.createVariable('river_temp', 'f8', ('river_tracer_time', 'river'))
temp = out.createVariable('river_temp', 'f8', ('river_tracer_time'))
temp.long_name = 'river runoff potential temperature'
temp.units = 'Celsius'
temp.time = 'river_tracer_time'

# jgp diag
print('c ',time2)

salt = out.createVariable('river_salt', 'f8', ('river_tracer_time'))
salt.long_name = 'river runoff salinity'
salt.time = 'river_tracer_time'

## JGP add
#dye = out.createVariable('river_dye', 'f8', ('river_tracer_time'))
#dye.long_name = 'river dye'
#dye.time = 'river_tracer_time'
#
out.variables['river_tracer_time'][:] = time2

# jgp diag
print('d ',time2)


out.variables['river_temp'][:] = t2
#river_tr = np.zeros((len(time2)))
#river_tr = np.zeros((len(ttime), Nr))
out.variables['river_salt'][:] = mySalt
#
## JGP add
#out.variables['river_dye'][:] = myDye


out.close()

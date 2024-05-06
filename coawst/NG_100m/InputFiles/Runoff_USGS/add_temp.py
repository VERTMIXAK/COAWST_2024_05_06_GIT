import re
import numpy as np
import netCDF4
import sys
import pdb
from scipy.interpolate import interp1d
import pycnal

outfile = sys.argv[1]

# Read the river temperatures
tempDayN  = open('../riverData_2020/tempDayN.txt', 'r')
tempHour = open('../riverData_2020/tempHour.txt', 'r')
temp = open('../riverData_2020/temp.txt', 'r')
## Eat first two lines
#f.readline()
#f.readline()

exit()


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

grd = pycnal.grid.get_ROMS_grid('NG_100m')
lat_rho = grd.hgrid.lat_rho


# here is temperature (t2) and salinity (s2) for a suite of days (time2)
time2 = [0, 46, 76, 107, 137, 167, 198, 228, 259, 289, 320, 365]
t2 = [0.0, 0.0, 0.0, 0.0, 2.0, 10.0, 15.0, 13.0, 5.0, 2.0, 0.0, 0.0]
s2 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]


# create file with all the objects
out = netCDF4.Dataset(outfile, 'a', format='NETCDF3_64BIT')
xi = out.variables['river_Xposition'][:]
eta = out.variables['river_Eposition'][:]
Nr = xi.shape[0]
river_tr = np.zeros((len(time2)))

# JGP add dye
myDye = np.zeros((len(time2)))


out.createDimension('river_tracer_time', len(time2))

times = out.createVariable('river_tracer_time', 'f8', ('river_tracer_time'))
times.units = 'day'
times.cycle_length = 365.25
times.long_name = 'river tracer time'

temp = out.createVariable('river_temp', 'f8', ('river_tracer_time'))
temp.long_name = 'river runoff potential temperature'
temp.units = 'Celsius'
temp.time = 'river_tracer_time'

salt = out.createVariable('river_salt', 'f8', ('river_tracer_time'))
salt.long_name = 'river runoff salinity'
salt.units = ' '
salt.time = 'river_tracer_time'

## JGP add dye if desired
#dye = out.createVariable('river_dye', 'f8', ('river_tracer_time'))
#dye.long_name = 'river dye'
#dye.time = 'river_tracer_time'


out.variables['river_tracer_time'][:] = time2
out.variables['river_temp'][:] = t2
out.variables['river_salt'][:] = s2
#
## JGP add
#out.variables['river_dye'][:] = myDye


out.close()
LOfile = '../CAS7_grid.nc'
maskLO = nc_varget(LOfile,'mask_rho');
latLO  = nc_varget(LOfile,'lat_rho');
lonL0  = nc_varget(LOfile,'lon_rho');

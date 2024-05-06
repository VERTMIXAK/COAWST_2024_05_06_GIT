LOfile = '../BC_IC_new/CAS7_grid.nc'
maskLO = nc_varget(LOfile,'mask_rho');
latLO  = nc_varget(LOfile,'lat_rho');
lonLO  = nc_varget(LOfile,'lon_rho');

gridFile = 'PTOWNb_500m.nc';
mask = nc_varget(gridFile,'mask_rho');
lat  = nc_varget(gridFile,'lat_rho');
lon  = nc_varget(gridFile,'lon_rho');


fig(1);clf;pcolor(lon,lat,mask);shading flat
xlim([237.55 237.65]);
ylim([47.640 47.7])

fig(2);clf;pcolor(lonLO,latLO,maskLO);shading flat
xlim([237.55 237.65]);
ylim([47.640 47.7])
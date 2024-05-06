upFile   = 'NAM_swrad_up.nc';
downFile = 'NAM_swrad_down.nc';
netFile  = 'NAM_swradNet.nc';

swradUp   = nc_varget(upFile,  'swrad_up');
swradDown = nc_varget(downFile,'swrad_down');

lat = nc_varget(upFile,'lat');
lon = nc_varget(upFile,'lon');
timeUp = nc_varget(upFile,'srf_time');
timeDown = nc_varget(downFile,'srf_time');



swradNet = swradDown - swradUp;

nc_varput(netFile,'swrad',swradNet);

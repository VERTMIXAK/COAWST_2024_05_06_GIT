file = 'GFS_latent_2023.nc';
dum = nc_varget(file,'lon');
nc_varput(file,'lon',dum-360);

file = 'GFS_lhflux_2023.nc';
dum = nc_varget(file,'lon');
nc_varput(file,'lon',dum-360);

file = 'GFS_lwrad_down_2023.nc';
dum = nc_varget(file,'lon');
nc_varput(file,'lon',dum-360);

file = 'GFS_Pair_2023.nc';
dum = nc_varget(file,'lon');
nc_varput(file,'lon',dum-360);

file = 'GFS_Qair_2023.nc';
dum = nc_varget(file,'lon');
nc_varput(file,'lon',dum-360);

file = 'GFS_rain_2023.nc';
dum = nc_varget(file,'lon');
nc_varput(file,'lon',dum-360);

file = 'GFS_sensible_2023.nc';
dum = nc_varget(file,'lon');
nc_varput(file,'lon',dum-360);

file = 'GFS_swrad_down_2023.nc';
dum = nc_varget(file,'lon');
nc_varput(file,'lon',dum-360);

file = 'GFS_swrad_net_2023.nc';
dum = nc_varget(file,'lon');
nc_varput(file,'lon',dum-360);

file = 'GFS_swrad_up_2023.nc';
dum = nc_varget(file,'lon');
nc_varput(file,'lon',dum-360);

file = 'GFS_Tair_2023.nc';
dum = nc_varget(file,'lon');
nc_varput(file,'lon',dum-360);

file = 'GFS_Uwind_2023.nc';
dum = nc_varget(file,'lon');
nc_varput(file,'lon',dum-360);

file = 'GFS_Vwind_2023.nc';
dum = nc_varget(file,'lon');
nc_varput(file,'lon',dum-360);


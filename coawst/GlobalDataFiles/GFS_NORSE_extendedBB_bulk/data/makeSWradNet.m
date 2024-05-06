fileDown = 'GFS_swrad_down_2023.nc';
fileUp   = 'GFS_swrad_up_2023.nc';
fileNet  = 'GFS_swrad_net_2023.nc';

unix(['cp ',fileDown,' ',fileNet]);

up = nc_varget(fileUp,'swrad_up');
down = nc_varget(fileDown,'swrad');

nc_varput(fileNet,'swrad',down - up);
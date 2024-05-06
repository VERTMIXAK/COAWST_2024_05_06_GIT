file = 'psdem2000.Gridpak.nc';

lat = nc_varget(file,'topo_lat');
lon = nc_varget(file,'topo_lon');

diff(lat);mean(ans(:)) * 111

diff(lon);mean(ans(:)) * 111 * cos(lat(1,1) * 3.14159 / 180)
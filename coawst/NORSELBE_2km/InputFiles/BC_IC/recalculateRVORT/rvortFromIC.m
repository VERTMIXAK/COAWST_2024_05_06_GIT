files = {'../ini_2020-09-01/CMEMS_2020-09-01_ic_NORSELBE_2km.nc',   ...
         '../ini_2021-09-01/CMEMS_2021-09-01_ic_NORSELBE_2km.nc',   ...
         '../ini_2022-11-01/CMEMS_2022-11-01_ic_NORSELBE_2km.nc',   ...
         '../ini_2023-11-01/CMEMS_2023-11-01_ic_NORSELBE_2km.nc'
         };
gridFile = '../../Gridpak/NORSELBE_2km.nc';

f = nc_varget(gridFile,'f');
lat = nc_varget(gridFile,'lat_psi');
lon = nc_varget(gridFile,'lon_psi');
     
for nn=1:1
    files{1};
end;
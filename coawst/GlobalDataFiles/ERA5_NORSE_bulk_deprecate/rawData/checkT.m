file = 'Tair_2022.nc';

Told = nc_varget(['../ERA5forcing/',file],'t2m');
Tnew = nc_varget(file,'t2m');

Told-Tnew; min(ans(:))
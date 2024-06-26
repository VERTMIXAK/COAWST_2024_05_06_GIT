close all;clear;

myDir = '/import/c1/VERTMIX/jgpender/coawst/GlobalDataFiles/GFS_NORSE_extendedBB_bulk/data/';
files = dir([myDir,'*nc']);

unix(['rm *.nc']);

nf = length(files);

lon0 = -6.2752;
lat0 = 70.4335;



for ff=1:nf
    lat = nc_varget([myDir,files(ff).name],'lat');
    lon = nc_varget([myDir,files(ff).name],'lon');
    diffLon = abs(lon - lon0);
    diffLat = abs(lat - lat0);
    [val,iLon] = min(diffLon);
    [val,jLat] = min(diffLat);
    iMin = iLon-6;
    iMax = iLon+4;
    jMin = jLat-6;
    jMax = jLat+4;
    unix(['ncks -d lon,',num2str(iMin),',',num2str(iMax),' -d lat,',num2str(jMin),',',num2str(jMax),' ',myDir,files(ff).name,' ',files(ff).name]);
end;

file = 'GFS_latent_2023.nc';
var  = 'latent';
dum = nc_varget(file,var);
[nt,ny,nx] = size(dum);
for tt = 1:nt
    dum(tt,:,:) =  dum(tt,6,6);
end;
nc_varput(file,var,dum)


file = 'GFS_lhflux_2023.nc';
var  = 'lhflux';
dum = nc_varget(file,var);
[nt,ny,nx] = size(dum);
for tt = 1:nt
    dum(tt,:,:) =  dum(tt,6,6);
end;
nc_varput(file,var,dum)

file = 'GFS_lwrad_down_2023.nc';
var  = 'lwrad_down';
dum = nc_varget(file,var);
[nt,ny,nx] = size(dum);
for tt = 1:nt
    dum(tt,:,:) =  dum(tt,6,6);
end;
nc_varput(file,var,dum)

file = 'GFS_Pair_2023.nc';
var  = 'Pair';
dum = nc_varget(file,var);
[nt,ny,nx] = size(dum);
for tt = 1:nt
    dum(tt,:,:) =  dum(tt,6,6);
end;
nc_varput(file,var,dum)

file = 'GFS_Qair_2023.nc';
var  = 'Qair';
dum = nc_varget(file,var);
[nt,ny,nx] = size(dum);
for tt = 1:nt
    dum(tt,:,:) =  dum(tt,6,6);
end;
nc_varput(file,var,dum)

file = 'GFS_sensible_2023.nc';
var  = 'sensible';
dum = nc_varget(file,var);
[nt,ny,nx] = size(dum);
for tt = 1:nt
    dum(tt,:,:) =  dum(tt,6,6);
end;
nc_varput(file,var,dum)

file = 'GFS_swrad_down_2023.nc';
var  = 'swrad';
dum = nc_varget(file,var);
[nt,ny,nx] = size(dum);
for tt = 1:nt
    dum(tt,:,:) =  dum(tt,6,6);
end;
nc_varput(file,var,dum)

file = 'GFS_swrad_net_2023.nc';
var  = 'swrad';
dum = nc_varget(file,var);
[nt,ny,nx] = size(dum);
for tt = 1:nt
    dum(tt,:,:) =  dum(tt,6,6);
end;
nc_varput(file,var,dum)

file = 'GFS_swrad_up_2023.nc';
var  = 'swrad_up';
dum = nc_varget(file,var);
[nt,ny,nx] = size(dum);
for tt = 1:nt
    dum(tt,:,:) =  dum(tt,6,6);
end;
nc_varput(file,var,dum)

file = 'GFS_Tair_2023.nc';
var  = 'Tair';
dum = nc_varget(file,var);
[nt,ny,nx] = size(dum);
for tt = 1:nt
    dum(tt,:,:) =  dum(tt,6,6);
end;
nc_varput(file,var,dum)

file = 'GFS_Uwind_2023.nc';
var  = 'Uwind';
dum = nc_varget(file,var);
[nt,ny,nx] = size(dum);
for tt = 1:nt
    dum(tt,:,:) =  dum(tt,6,6);
end;
nc_varput(file,var,dum)

file = 'GFS_Vwind_2023.nc';
var  = 'Vwind';
dum = nc_varget(file,var);
[nt,ny,nx] = size(dum);
for tt = 1:nt
    dum(tt,:,:) =  dum(tt,6,6);
end;
nc_varput(file,var,dum)


myDir = '/import/c1/VERTMIX/jgpender/coawst/GlobalDataFiles/ERA5_NORSE_bulk/ERA5forcing/';
files = 'ERA5_rain_2023.nc';

lat = nc_varget([myDir,files],'lat');
lon = nc_varget([myDir,files],'lon');
diffLon = abs(lon - lon0);
diffLat = abs(lat - lat0);
[val,iLon] = min(diffLon)
[val,jLat] = min(diffLat)
iMin = iLon-6;
iMax = iLon+4;
jMin = jLat-6;
jMax = jLat+4;
unix(['ncks -d lon,',num2str(iMin),',',num2str(iMax),' -d lat,',num2str(jMin),',',num2str(jMax),' ',myDir,files,' ',files]);


file = 'ERA5_rain_2023.nc';
var  = 'rain';
dum = nc_varget(file,var);
[nt,ny,nx] = size(dum);
for tt = 1:nt
    dum(tt,:,:) =  dum(tt,6,6);
end;
nc_varput(file,var,dum)

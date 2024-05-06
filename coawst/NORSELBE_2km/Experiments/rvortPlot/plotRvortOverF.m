fileR = 'rvortOverF.nc';
fileF = '../../fLonLat.nc';

lon   = nc_varget(fileF,'lon_psi');
lat   = nc_varget(fileF,'lat_psi');

rv  = nc_varget(fileR,'rvortOverF');

[nt,ny,nx] = size(rv);


% Make some plots

% fig(1);clf;
% pcolor(lon,lat,sq(rv(end,:,:)));shading flat
% caxis([-.5,.5]*1);colorbar;colormap(gray)

fig(2);clf;
for tt=1:nt
    pcolor(lon,lat,sq(rv(tt,:,:)));shading flat
caxis([-.5,.5]*1);colorbar;colormap(gray)
title([num2str(tt),'/',num2str(nt),'   day ',num2str(floor(tt/24)+1)])
pause(.01)
end;
    
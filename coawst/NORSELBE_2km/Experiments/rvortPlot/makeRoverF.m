fileR = 'rvort.nc';
fileRoF = 'rvortOverF.nc';
fileF = '../../fLonLat.nc';

lon   = nc_varget(fileF,'lon_psi');
lat   = nc_varget(fileF,'lat_psi');
f_rho = nc_varget(fileF,'f');

rv  = nc_varget(fileR,'rvort_sur');

size(rv)
size(f_rho)
size(lat)
[nt,ny,nx] = size(rv)

% put f on the psi grid
f_psi = 0*lon;

for jj=1:ny-1; for ii=1:nx-1
    f_rho(jj:jj+1,ii:ii+1);
    f_psi(jj,ii) = .25*sum(ans(:));
end;end;

for tt=1:nt
    rv(tt,:,:) = sq(rv(tt,:,:)) ./ f_psi;
end;

nc_varput(fileRoF,'rvortOverF',rv);
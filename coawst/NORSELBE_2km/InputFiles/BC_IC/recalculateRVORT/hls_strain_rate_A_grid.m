function [S,rvort] = hls_strain_rate_A_grid(uvel,vvel,lon,lat)
% calculates strain rate and relative vorticity assuming u,v,lon,lat are 2D (lat,lon) & colocated, i.e.
% arakawa A-grid
% 
% see e.g. Thomas Tandon Mahadevan 2007 Submesoscale processes and
% dynamics JGR 
% adapted from code by JGP

% source = '~/PROJ/FLEAT/DATA/MODEL/HYCOM_MAY2016/May.nc';
% 
% lat  = nc_varget(source,'lat');
% lon  = nc_varget(source,'lon');
% uvel = nc_varget(source,'u');
% vvel = nc_varget(source,'v');

[ny nx] = size(uvel);

%% Get dx and dy on reduced grid

dum = zeros(ny,nx-1);
% x intervals
for jj=1:ny; for ii=1:nx-1
	dum(jj,ii) = geodesic_dist(lon(jj,ii),lat(jj,ii),lon(jj,ii+1),lat(jj,ii+1) );
% 	dum(jj,ii) = sw_dist([lat(jj,ii) lat(jj,ii+1)],[lon(jj,ii) lon(jj,ii+1)],'km' );
end;end;
dX = (dum(1:end-1,:) + dum(2:end,:) )/2;



dum = zeros(ny-1,nx);
% y intervals
for jj=1:ny-1; for ii=1:nx
	dum(jj,ii) = geodesic_dist(lon(jj,ii),lat(jj,ii),lon(jj+1,ii),lat(jj+1,ii) );
end;end;
dY = (dum(:,1:end-1) + dum(:,2:end) )/2;

%% get velocity differentials on the reduced grid
%keyboard
%%
dum = uvel(:,2:end) - uvel(:,1:end-1);
dUvelX = ( dum(1:end-1,:) + dum(2:end,:) ) /2;

dum = uvel(2:end,:) - uvel(1:end-1,:);
dUvelY = ( dum(:,1:end-1) + dum(:,2:end) ) /2;

dum = vvel(:,2:end) - vvel(:,1:end-1);
dVvelX = ( dum(1:end-1,:) + dum(2:end,:) ) /2;

dum = vvel(2:end,:) - vvel(1:end-1,:);
dVvelY = ( dum(:,1:end-1) + dum(:,2:end) ) /2;


%% Get derivatives

S = zeros(ny-1,nx-1);
 
        dUdx = dUvelX ./ dX ;
        dUdy = dUvelY ./ dY ;
        dVdx = dVvelX ./ dX ;
        dVdy = dVvelY ./ dY ;
        S   = sqrt( (dUdx - dVdy).^2  + (dVdx + dUdy).^2  );
        rvort = dVdx-dUdy;



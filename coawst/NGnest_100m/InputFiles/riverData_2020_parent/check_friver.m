close all

% The scripts in this directory take USGS data (which is in ft^3/s) and
% writes it into a file USGS_runoff_2020.nc This file has the same x/y and
% lat/lon as the relevant grid file so the flow field - friver - is sparse.
% Moreover, friver has wierd units. The grid surface pixels have an area,
% and if you multiply the area times the (nonzero) value for friver at that
% same location you should get kg/s, which can be converted to ft^3/s.

runoffFile = 'USGS_runoff_2020.nc';
gridFile = '../Gridpak_parent/NGnest_100m_parent.nc';

friver  = nc_varget(runoffFile,'friver');
area    = nc_varget(runoffFile,'area');
lat     = nc_varget(runoffFile,'lat');
lon     = nc_varget(runoffFile,'lon');

% pn      = nc_varget(gridFile,'pn');
% pm      = nc_varget(gridFile,'pm');
maskRho = nc_varget(gridFile,'mask_rho');
latRho  = nc_varget(gridFile,'lat_rho');
lonRho  = nc_varget(gridFile,'lon_rho');

[nt,ny,nx] = size(friver);

flow = 0*friver;
for tt=1:nt
    flow(tt,:,:) = sq(friver(tt,:,:)) .* area;
end;


%% Hunt River
myI = 91;
myJ = 243;
delta=20;
iRange = [myI-delta : myI+delta];
jRange = [myJ-delta : myJ+delta];

fig(1);clf;
pcolor(lonRho(jRange,iRange),latRho(jRange,iRange),maskRho(jRange,iRange));shading flat


aaa=5;




% The dominant pixel is at
[myK,myJ,myI] = ind2sub(size(friver),find(friver == max(friver(:))));


friver(1,:,:);nansum(ans(:))
ans*area

% friver(1,myJ,myI) * Area


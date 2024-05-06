parentGrid = 'Gridpak_parent/NGnest_100m_parent.nc';
childGrid  = 'Gridpak_child/NGnest_100m_child.nc';

lonP = nc_varget(parentGrid,'lon_rho');
latP = nc_varget(parentGrid,'lat_rho');
maskP = nc_varget(parentGrid,'mask_rho');

lonC = nc_varget(childGrid,'lon_rho');
latC = nc_varget(childGrid,'lat_rho');

lonMin = min(lonC(:));
lonMax = max(lonC(:));
latMin = min(latC(:));
latMax = max(latC(:));


fig(1);clf;
pcolor(lonP,latP,maskP);shading flat
hold on;
line([lonMin lonMax],[latMin latMin],'Color','green')
line([lonMin lonMax],[latMax latMax],'Color','green')
line([lonMin lonMin],[latMin latMax],'Color','green')
line([lonMax lonMax],[latMin latMax],'Color','green')
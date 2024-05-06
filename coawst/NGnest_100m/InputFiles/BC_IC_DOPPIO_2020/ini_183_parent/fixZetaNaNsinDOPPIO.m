file = 'DOPPIO_2020_183_ic_NGnest_100m_parent.nc';
gridFile = '../../Gridpak_parent/NGnest_100m_parent.nc';

zeta = nc_varget(file,'zeta');
[ny,nx] = size(zeta);

fig(1);clf;
pcolor(zeta);shading flat

zeta(isnan(zeta)) = 0;

fig(2);clf;
pcolor(zeta);shading flat

[ny,nx] = size(zeta);
dum = zeros(1,ny,nx);
dum(1,:,:) = zeta;

nc_varput(file,'zeta',dum);

h = nc_varget(gridFile,'h');
fig(3);clf
plot(h(180,:))
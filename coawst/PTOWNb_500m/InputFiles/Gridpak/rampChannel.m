gridFile = 'PTOWNb_500m.nc';
h    = nc_varget(gridFile,'h');
mask = nc_varget(gridFile,'mask_rho');
lat  = nc_varget(gridFile,'lat_rho');
lon  = nc_varget(gridFile,'lon_rho');
[ny,nx] = size(lon);

fig(1);clf;pcolor(h);shading flat;colorbar
xlim([nx-10 nx]);
ylim([1 6]);
caxis([1 10])

fig(2);clf
plot(nx-8:nx,sq(h(3,nx-8:nx)));
hold on
plot(nx-8:nx,sq(h(4,nx-8:nx)));

%% now lay out the ramp

x0 = nx-8;
y0 = h(3,nx-8);
x1 = nx;
y1 = h(4,nx);

m = (y1 - y0) / (x1 - x0);
xdum = [nx-8:nx];
ydum = m*(xdum-x0) + y0;

plot(xdum,ydum,'r')

%% make the substitution

h(3,nx-8:nx) = ydum;
h(4,nx-8:nx) = ydum;

fig(3);clf;pcolor(h);shading flat;colorbar
xlim([nx-10 nx]);
ylim([1 6]);
caxis([1 85])

nc_varput(gridFile,'h',h);




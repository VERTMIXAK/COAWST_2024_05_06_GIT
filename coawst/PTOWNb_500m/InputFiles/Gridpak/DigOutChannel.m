wChannel  = 'tempGrid_withChannel.nc';
woChannel = 'tempGrid_withoutChannel.nc';



maskWith = nc_varget(wChannel,'mask_rho');
maskWO   = nc_varget(woChannel,'mask_rho');

fig(1);clf;
maskDiff = maskWith -maskWO;
pcolor(maskDiff);shading flat;colorbar

fig(10);clf;
pcolor(maskWith);shading flat;colorbar
fig(11);clf;
pcolor(maskWO);shading flat;colorbar

gridFile = 'PTOWNb_500m.nc';

h = nc_varget(gridFile,'h');

fig(20);clf;
pcolor(h);shading flat;caxis([0 10])

h(maskDiff==1) = 5;

fig(21);clf;
pcolor(h);shading flat;caxis([0 10])

nc_varput(gridFile,'h',h)

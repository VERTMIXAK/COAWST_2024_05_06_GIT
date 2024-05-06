gridORIG  = '../../InputFiles/Gridpak_parent/NGnest_100m_parent.nc';
gridGroyne = 'NGnest_100m_parent_GROYNE.nc';

unix(['cp ',gridORIG,' ',gridGroyne]);
maskU = nc_varget(gridGroyne,'mask_u');

fig(1);clf;
pcolor(maskU);shading flat;colorbar

iRange = [70:90];
jRange = [165:188];

fig(2);clf;
pcolor(iRange,jRange,maskU(jRange,iRange))

maskU(173:183,78)=0;
fig(3);clf;
pcolor(iRange,jRange,maskU(jRange,iRange))

nc_varput(gridGroyne,'mask_u',maskU);





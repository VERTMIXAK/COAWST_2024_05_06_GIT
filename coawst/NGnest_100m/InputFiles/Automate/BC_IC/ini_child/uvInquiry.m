oldFile = 'myINI.nc_ORIG';
newFile = 'myINI.nc';
romsFile = '../../../../E

unix(['cp ',oldFile,' ',newFile]);

maskU = nc_varget(newFile,'mask_u');
fig(1);pcolor(maskU);shading flat;title('maskU');

u = nc_varget(newFile,'u');

size(u)
fig(2);pcolor(sq(u(end,:,:)));shading flat;title('uSur');
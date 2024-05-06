clear; close all
tabwindow();

riverFile  = 'USGS_runoff_2020.nc';

lat = nc_varget(riverFile,'lat');
lon = nc_varget(riverFile,'lon');
friver = nc_varget(riverFile,'friver');

[ny,nx] = size(lon)

iRange=[1:nx-1];
jRange=[1:ny-1];
fig(2);clf
pcolor(iRange,jRange,sq(abs(friver(1,jRange,iRange))));shading flat;colorbar
hold on;

%Hunt River
myI = 319;
myJ = 969;
delta=20;
iRange = [myI-delta : myI+delta];
jRange = [myJ-delta : myJ+delta];
fig(12);clf
pcolor(iRange,jRange,sq(abs(friver(1,jRange,iRange))));shading flat;colorbar;title('Hunt River')
xlim([myI-delta myI+delta]);ylim([myJ-delta myJ+delta])


% Taunton river
myI = 601;
myJ = 1066;
delta=10;
iRange = [myI-delta : myI+delta];
jRange = [myJ-delta : myJ+delta];
fig(13);clf
pcolor(iRange,jRange,sq(abs(friver(1,jRange,iRange))));shading flat;colorbar;title('Taunton River')
xlim([myI-delta myI+delta]);ylim([myJ-delta myJ+delta])


% Providence river
myI = 359;
myJ = 1178;
delta=2;
iRange = [myI-delta-10 : myI+delta+10];
jRange = [myJ-delta-5 : myJ+delta];
fig(14);clf
pcolor(iRange,jRange,sq(abs(friver(1,jRange,iRange))));shading flat;colorbar;title('Providence River')
xlim([myI-delta-10 myI+delta+10]);ylim([myJ-delta-10 myJ+delta])


% Pawtuxet river
myI = 347;
myJ = 1089;
delta=20;
iRange = [myI-delta : myI+delta];
jRange = [myJ-delta : myJ+delta];
fig(15);clf
pcolor(iRange,jRange,sq(abs(friver(1,jRange,iRange))));shading flat;colorbar;title('Pawtuxet River')
xlim([myI-delta-10 myI+delta+10]);ylim([myJ-delta-10 myJ+delta])



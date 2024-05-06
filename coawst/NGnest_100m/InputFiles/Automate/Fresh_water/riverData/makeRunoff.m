templateFile = '../../../Runoff_parent/USGS_runoff_2016.nc_template';
newFile      = 'USGS_runoff.nc';
gridFile     = '../../../Gridpak_parent/NGnest_100m_parent.nc';

pm = nc_varget(gridFile,'pm');
pn = nc_varget(gridFile,'pn');

sourceFile = './Providence.txt';
importdata(sourceFile); time = ans(:,1);

nTimes = length(time);

unix(['\rm ',newFile]);
unix(['ncks -d time,0,',num2str(nTimes-1),' ',templateFile,' ',newFile]);

nc_varput(newFile,'time',time);

% make sure to start with friver all zeros.
dum = nc_varget(newFile,'friver');
dum = 0*dum;
nc_varput(newFile,'friver',dum);

friver = nc_varget(newFile,'friver');
area = nc_varget(newFile,'area');
lon    = nc_varget(newFile,'lon');
lat    = nc_varget(newFile,'lat');

fig(99);clf
pcolor(sq(friver(1,:,:)));shading flat

% NOTE: these source files have the total freshwater flow in 
%       m^3/s
%  I need to divide these numbers by the area of tile where I dump this
%  water.

aaa=5;


%% Hunt river

myI = 91;
myJ = 240;
delta=20;
iRange = [myI-delta : myI+delta];
jRange = [myJ-delta : myJ+delta];

fig(12);clf
pcolor(iRange,jRange,sq(friver(1,jRange,iRange)));shading flat;colorbar

sourceFile = './Hunt.txt';
dum = importdata(sourceFile);

flow = dum(:,2);  % This is the river flow in kg/s
flow = flow/area(myJ,myI);

% Spread the freshwater around (optional)
npoints=1;
friver(:,myJ  ,myI) = flow/npoints;
% friver(:,myJ+1,myI) = flow/npoints;


fig(13);clf
pcolor(iRange,jRange,sq(friver(1,jRange,iRange)));shading flat;colorbar
title('Hunt River')

done('Hunt')


%% Taunton river


myI = 125;
myJ = 255;
delta=20;
iRange = [myI-delta : myI+delta];
jRange = [myJ-delta : myJ+delta];

fig(12);clf
pcolor(iRange,jRange,sq(friver(1,jRange,iRange)));shading flat;colorbar

sourceFile = './Taunton.txt';
dum = importdata(sourceFile);
flow = dum(:,2);
flow = flow/area(myJ,myI);

npoints=4;
% friver(:,myJ-2,myI) = flow/npoints;
% friver(:,myJ-1,myI) = flow/npoints;
friver(:,myJ+0,myI) = flow/npoints;
% friver(:,myJ+1,myI) = flow/npoints;
% friver(:,myJ+2,myI) = flow/npoints;


fig(13);clf
pcolor(iRange,jRange,sq(friver(1,jRange,iRange)));shading flat;colorbar
title('Taunton River')

done('Taunton')


%% Providence river

myI = 95;
myJ = 271;

delta=2;
iRange = [myI-delta-10 : myI+delta+10];
jRange = [myJ-delta-5  : myJ+delta+1];

fig(12);clf
pcolor(iRange,jRange,sq(friver(1,jRange,iRange)));shading flat;colorbar

sourceFile = './Providence.txt';
dum = importdata(sourceFile);
flow = dum(:,2);
flow = flow/area(myJ,myI);

npoints=1;
friver(:,myJ,myI) = flow/npoints;
% friver(:,myJ,myI+1) = flow/npoints;


fig(13);clf
pcolor(iRange,jRange,sq(friver(1,jRange,iRange)));shading flat;colorbar
title('Providence River')

done('Providence')


%% Pawtuxet river

myI = 95;
myJ = 263;

delta=20;
iRange = [myI-delta : myI+delta];
jRange = [myJ-delta : myJ+delta];

fig(12);clf
pcolor(iRange,jRange,sq(friver(1,jRange,iRange)));shading flat;colorbar

sourceFile = './Pawtuxet.txt';
dum = importdata(sourceFile);
flow = dum(:,2);
flow = flow/area(myJ,myI);

% Spread the freshwater around 
npoints=1;
% friver(:,myJ,myI-3) = flow/npoints;
% friver(:,myJ,myI-2) = flow/npoints;
% friver(:,myJ,myI-1) = flow/npoints;
friver(:,myJ,myI  ) = flow/npoints;
% friver(:,myJ,myI+1) = flow/npoints;
% friver(:,myJ,myI+2) = flow/npoints;
% friver(:,myJ,myI+3) = flow/npoints;
% friver(:,myJ,myI+4) = flow/npoints;


fig(13);clf
pcolor(iRange,jRange,sq(friver(1,jRange,iRange)));shading flat;colorbar
title('Pawtuxet River')

done('Pawtuxet')


%% Write to file

nc_varput(newFile,'friver',friver);
fig(1);clf
pcolor(lon-360,lat,sq(friver(1,:,:)));shading flat;colorbar
caxis([0 .01])
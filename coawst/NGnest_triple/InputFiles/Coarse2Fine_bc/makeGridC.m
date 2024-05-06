clear; %close all;

% NOTE that this is kind of a half-assed script. I already have an aGrid
% file, a bGrid file, and cGrid file with bathymetries I like plus a contacts 
% file that accomodates all 3 grid files. What I'm doing here is creating a
% contacts file for just the bGrid and cGrid and it's much trickier than
% you would think.

unix(['chmod u+w NG*']);
unix(['\rm NGnest*']);

bGridFileOrig = '../Gridpak_b/NGnest_triple_b.nc';
bGridFile     = 'NGnest_triple_b.nc';
cGridFileOrig = '../Coarse2Fine_3to1/NGnest_triple_c.nc';
cGridFile = './NGnest_triple_c.nc';

contactsFile = 'NGnest_triple_bc_contacts.nc';

% Start by copying over the bGrid file
unix(['cp ',bGridFileOrig,' ',bGridFile]);
unix(['chmod u+w ',bGridFile]);
% 


% I need h under the land mask to be 1, not .1
bGridFileRetro = './NGnest_triple_b.nc_retro';
unix(['cp ',bGridFileOrig,' ',bGridFileRetro]);
unix(['chmod u+w ',bGridFileRetro]);
hraw = nc_varget(bGridFileRetro,'hraw');
nc_varput(bGridFileRetro,'h',sq(hraw(end,:,:)));

myLon = nc_varget(bGridFile,'lon_psi');
myLat = nc_varget(bGridFile,'lat_psi');

mask = nc_varget(bGridFile,'mask_psi');

%% Attributes

% When I originally made all of these grids, the bGrid was derived from the
% aGrid using specific J and I coordinates on the aGrid. This information
% is added to the global attributes of the bGrid file and, surprisingly, if
% you leave them there then the contacts.m script won't work. The next line
% erases everything in the global attributes file to avoid this problem

unix(['ncatted -O -a ,global,d,, ',bGridFileRetro])

% What I'm going to do now is create a new cGrid file, after which I'll
% overwrite h and the masks from the original cGrid file.


%% Define the core area of my grid


fig(99);clf;pcolor(mask);shading flat

iCoreLL = 340;
iCoreUR = 444;
jCoreLL = 669;
jCoreUR = 830;

latLL = myLat(jCoreLL,iCoreLL);
lonLL = myLon(jCoreLL,iCoreLL);
latUR = myLat(jCoreUR,iCoreUR);
lonUR = myLon(jCoreUR,iCoreUR);

iRange=[iCoreLL-30:iCoreUR+30];
jRange=[jCoreLL-30:jCoreUR+30];
fig(1);clf;pcolor(iRange,jRange,mask(jRange,iRange));shading flat;hold on;

line([iCoreLL iCoreUR],[jCoreLL jCoreLL]);
line([iCoreLL iCoreUR],[jCoreUR jCoreUR]);
line([iCoreLL iCoreLL],[jCoreLL jCoreUR]);
line([iCoreUR iCoreUR],[jCoreLL jCoreUR]);

aaa=5;

%% Make the subgrid

coarse2fine(bGridFileRetro,cGridFile,3,iCoreLL,iCoreUR,jCoreLL,jCoreUR)

addHRAW

var = 'h';
dum = nc_varget(cGridFileOrig,var);
nc_varput(cGridFile,var,dum);

var = 'mask_rho';
dum = nc_varget(cGridFileOrig,var);
nc_varput(cGridFile,var,dum);

var = 'mask_psi';
dum = nc_varget(cGridFileOrig,var);
nc_varput(cGridFile,var,dum);

var = 'mask_u';
dum = nc_varget(cGridFileOrig,var);
nc_varput(cGridFile,var,dum);

var = 'mask_v';
dum = nc_varget(cGridFileOrig,var);
nc_varput(cGridFile,var,dum);

aaa=5;







% 
% %% Make the contacts file
% 
% Gnames = {aGridFile, bGridFile, cGridFile}
% 
% [S,G] = contact(Gnames,contactsFile)
% 
% 
%% plot bathymetry

hParent   = nc_varget(aGridFile,'h');
lonParent = nc_varget(aGridFile,'lon_rho');
latParent = nc_varget(aGridFile,'lat_rho');

hChild   = nc_varget(bGridFile,'h');
lonChild = nc_varget(bGridFile,'lon_rho');
latChild = nc_varget(bGridFile,'lat_rho');


maxH =  max(hChild(:));
% maxH = 3000;

% fig(10);clf;
% pcolor(lonChild,latChild,hChild);shading flat;colorbar;
% caxis([0 maxH]);

fig(11); clf
deltaLon = .05;
deltaLat = .05;
pcolor(lonParent,latParent,hParent);shading flat;
ylim([latLL-deltaLat latUR+deltaLat]);
xlim([lonLL-deltaLon lonUR+deltaLon]);
caxis([0 maxH]);
hold on;
pcolor(lonChild,latChild,hChild);shading flat;
line([lonLL lonUR],[latLL latLL]);
line([lonLL lonUR],[latUR latUR]);
line([lonLL lonLL],[latLL latUR]);
line([lonUR lonUR],[latLL latUR]);
title('parent plus child')

%% Try to fill in some of the land mask

% Assume ipython only presents the rho mask but updates the other masks
% when it writes to file

mask = nc_varget(cGridFile,'mask_rho');
[ny,nx] = size(mask);

fig(20);clf;
pcolor([1:nx],[1:ny],mask);colorbar;shading flat

mask(180:end,1:60) = 0;
fig(21);clf;
pcolor([1:nx],[1:ny],mask);shading flat

mask(1:40,150:end) = 0;
fig(22);clf;
pcolor([1:nx],[1:ny],mask);shading flat

mask(1:80,300:end) = 0;
fig(23);clf;
pcolor([1:nx],[1:ny],mask);shading flat

nc_varput(cGridFile,'mask_rho',mask);
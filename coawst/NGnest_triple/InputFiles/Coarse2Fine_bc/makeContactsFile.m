clear; close all;

bGridFileRetro = './NGnest_triple_b.nc_retro';
cGridFile = './NGnest_triple_c.nc';
contactsFile = 'NGnest_triple_bc_contacts.nc';

%% Strip the b grid file

% The global attributes for the b grid file contain the I/J limits used to
% construct it from the a grid file. Believe it or not, this screws up the
% business of creating the contacts file, so stip off these attributes.
% It's actually easier to just get rid of all the attributes.

% Note that I do NOT want to change the bathymetry in either grid file in
% this script.

% unix(['ncatted -O -a ,global,d,, ',bGridFileRetro])




aaa=5;

%% Make the contacts file

Gnames = { bGridFileRetro, cGridFile}

[S,G] = contact(Gnames,contactsFile)


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



% fig(12);clf;
% pcolor(lonParent,latParent,hParent);shading flat;
% ylim([latLL-deltaLat latUR+deltaLat]);
% xlim([lonLL-deltaLon lonUR+deltaLon]);
% caxis([0 maxH]);;
% title('parent only')








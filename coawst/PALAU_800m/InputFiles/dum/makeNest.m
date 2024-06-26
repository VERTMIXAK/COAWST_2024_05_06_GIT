clear; close all;
unix('rm *.nc *.txt ')
tabwindow();

sourceGrid = '../Gridpak/PALAU_800m.nc';
parentFile = 'PALAU_800m_parent.nc';
childFile = 'PALAU_800m_child.nc';
contactsFile = 'PALAU_800m_contacts.nc';

unix(['cp ',sourceGrid,' ',parentFile]);

myLon = nc_varget(parentFile,'lon_psi');
myLat = nc_varget(parentFile,'lat_psi');

mask = nc_varget(parentFile,'mask_psi');


%% Define the core area of my grid

latLL = 6.5;
lonLL = 133.66;
dumY = myLat - latLL;
dumX = myLon - lonLL;
myDist = sqrt( dumY.^2 + dumX.^2);
[jCoreLL,iCoreLL] = find( min(myDist(:)) == myDist)
[myLat(jCoreLL,iCoreLL) - latLL,myLon(jCoreLL,iCoreLL) - lonLL]

 
latUR = 7.5; 
lonUR = 134.75; 
dumY = myLat - latUR;
dumX = myLon - lonUR;
myDist = sqrt( dumY.^2 + dumX.^2);
[jCoreUR,iCoreUR] = find( min(myDist(:)) == myDist)

jCoreUR = jCoreUR - 2;   % This is to avoid a bobble near the northern boundary.

[myLat(jCoreUR,iCoreUR) - latUR,myLon(jCoreUR,iCoreUR) - lonUR]*111

fig(1);clf;pcolor(myLon(jCoreLL:jCoreUR,iCoreLL:iCoreUR),myLat(jCoreLL:jCoreUR,iCoreLL:iCoreUR),mask(jCoreLL:jCoreUR,iCoreLL:iCoreUR));shading flat

%% Make the subgrid

coarse2fine(parentFile,childFile,3,iCoreLL,iCoreUR,jCoreLL,jCoreUR)

hParent = nc_varget(parentFile,'h');
hChild  = nc_varget(childFile,'h');

min(hChild(:))

myThreshold = min(hParent(:));
hChild(hChild < myThreshold) = myThreshold;

min(hChild(:))
nc_varput(childFile,'h',hChild);


aaa=5;

%% Rethreshold

% Surprise! The child grid bathymetry will not respect the depth threshold
% in the parent grid.


%% Make the contacts file

Gnames = {parentFile, childFile}

[S,G] = contact(Gnames,contactsFile)


%% plot bathymetry



hParent   = nc_varget(parentFile,'h');
lonParent = nc_varget(parentFile,'lon_rho');
latParent = nc_varget(parentFile,'lat_rho');

hChild   = nc_varget(childFile,'h');
lonChild = nc_varget(childFile,'lon_rho');
latChild = nc_varget(childFile,'lat_rho');


maxH =  max(hChild(:));
maxH = 3000;

% fig(10);clf;
% pcolor(lonChild,latChild,hChild);shading flat;colorbar;
% caxis([0 maxH]);



fig(11); clf
deltaLon = .25;
deltaLat = .25;
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








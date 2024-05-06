clear; close all;

aGridFile = '../Gridpak_a/NGnest_triple_a.nc';
bGridFile = '../Gridpak_b/NGnest_triple_b.nc';
cGridFile = './NGnest_triple_c.nc';
contactsFile = 'NGnest_triple_abc_contacts.nc';

% % I need h under the land mask to be 1, not .1
% bGridFileRetro = './NGnest_triple_b.nc_retro';
% unix(['cp ',bGridFile,' ',bGridFileRetro]);
% unix(['chmod u+w ',bGridFileRetro]);
% hraw = nc_varget(bGridFileRetro,'hraw');
% nc_varput(bGridFileRetro,'h',sq(hraw(end,:,:)));
% 
% myLon = nc_varget(bGridFile,'lon_psi');
% myLat = nc_varget(bGridFile,'lat_psi');
% 
% mask = nc_varget(bGridFile,'mask_psi');
% 
% 
% %% Define the core area of my grid
% 
% % latLL = 41.485;
% % lonLL = 288.68;
% % dumY = myLat - latLL;
% % dumX = myLon - lonLL;
% % myDist = sqrt( dumY.^2 + dumX.^2);
% % [jCoreLL,iCoreLL] = find( min(myDist(:)) == myDist)
% % [myLat(jCoreLL,iCoreLL) - latLL,myLon(jCoreLL,iCoreLL) - lonLL]
% % 
% %  
% % latUR = 41.5315; 
% % lonUR = 288.7; 
% % dumY = myLat - latUR;
% % dumX = myLon - lonUR;
% % myDist = sqrt( dumY.^2 + dumX.^2);
% % [jCoreUR,iCoreUR] = find( min(myDist(:)) == myDist)
% % [myLat(jCoreUR,iCoreUR) - latUR,myLon(jCoreUR,iCoreUR) - lonUR]*111
% 
% fig(99);clf;pcolor(mask);shading flat
% 
% iCoreLL = 370;
% iCoreUR = 444;
% jCoreLL = 720;
% jCoreUR = 830;
% 
% latLL = myLat(jCoreLL,iCoreLL);
% lonLL = myLon(jCoreLL,iCoreLL);
% latUR = myLat(jCoreUR,iCoreUR);
% lonUR = myLon(jCoreUR,iCoreUR);
% 
% iRange=[iCoreLL-30:iCoreUR+30];
% jRange=[jCoreLL-30:jCoreUR+30];
% fig(1);clf;pcolor(iRange,jRange,mask(jRange,iRange));shading flat;hold on;
% 
% line([iCoreLL iCoreUR],[jCoreLL jCoreLL]);
% line([iCoreLL iCoreUR],[jCoreUR jCoreUR]);
% line([iCoreLL iCoreLL],[jCoreLL jCoreUR]);
% line([iCoreUR iCoreUR],[jCoreLL jCoreUR]);
% 
% aaa=5;
% 
% %% Make the subgrid
% 
% coarse2fine(bGridFileRetro,cGridFile,3,iCoreLL,iCoreUR,jCoreLL,jCoreUR)
% 
% % convert all the h values under the rho mask to dcrit = .1
% fixHunderMask
% 
% aaa=5;


%% Make the contacts file

Gnames = {aGridFile, bGridFile, cGridFile}

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








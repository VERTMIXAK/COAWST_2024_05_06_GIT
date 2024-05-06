clear

% This process is not so hard on a Mercator grid because the edges fall on
% latitude and longitude lines. I used to be able to just type in the
% lat/lon extrema and be done with it. Other grids (Lambert Conic or rotated
% Lambert conic) won't have this at all, so I need a way to mathematically
% describe the edges, ideally based on information sucked up from the grid
% file.

% It turns out this is not so bad because I can simply read in the x/y
% for the rho grid and they will form a nice rectilinear array even if the
% latitudes and longitudes are skew.


gridFile = '../Gridpak_Mercator/HC_100mME_wetDry.nc';

mask = nc_varget(gridFile,'mask_rho');
lat = nc_varget(gridFile,'lat_rho');
lon = nc_varget(gridFile,'lon_rho');

[ny,nx] = size(mask);


fig(3);clf;pcolor(lon,lat,mask);shading flat;hold on
aaa=5;

%% Reuse the locations determined for the stations

iLL = 215;
iUR = 278;
jLL = 439;
jUR = 439;




%% write the float locations to file

% Combine the launch points into single vectors

nskip = 1;

iReleaseLocs = [iLL:nskip:iUR]
jReleaseLocs = jLL*ones(1,length(iReleaseLocs))

% iReleaseLocs = lonW;
% jReleaseLocs = latW;

% iReleaseLocs = [iWest, iNorth, fliplr(iEast) ];
% jReleaseLocs = [jWest, jNorth, fliplr(jEast) ];

count = length(iReleaseLocs)

% All times are in days

nDays = 5;
nInterval = 1/24;
nReleases = round(nDays/nInterval);   % must be integer

nDepths = 1;
depth1 = -1;
% depth2 = -30;


fileID = fopen( 'floats_HC.in','w');


% Start writing to filejWest

% This is header stuff
fprintf(fileID,'     Lfloats == T\n\n');
fprintf(fileID,'       FRREC == 0\n\n');

fprintf(fileID,'     NFLOATS == %10i\n\n',  nReleases*count*nDepths);
% fprintf(fileID,' ');
fprintf(fileID,'POS = G, C, T, N,   Ft0,   Fx0,  Fy0, Fz0,      Fdt,       Fdx, Fdy, Fdz\n');
% fprintf(fileID,' ');


% Now write the float data
% Surface floats - both types
for nn=1:length(iReleaseLocs);
    nn
    fprintf(fileID,'1  0  1  %3i 0.0d0 %10.3f  %10.3f  -1  %16.10f 0.d0 0.d0 0.d0\n',nReleases,iReleaseLocs(nn),jReleaseLocs(nn),nInterval);          
end;

% second float type if necessary
% for nn=1:length(iReleaseLocs);
%     fprintf(fileID,'1  0  3  %4i  0.0d0 %10.3f  %10.3f  -1  %10.3f 0.d0 0.d0 0.d0\n',nReleases,iReleaseLocs(nn),jReleaseLocs(nn),nInterval);          
% end;


% lower layer of floats  - type 2 constant depth
% 
% for nn=1:length(iReleaseLocs); 
%     fprintf(fileID,'1  1  2  %4i  0.0d0 %10.3f  %10.3f  -15  %9.3f 0.d0 0.d0 0.d0\n',nReleases,iReleaseLocs(nn),jReleaseLocs(nn),nInterval);
% end;

done('write')


fig(5);clf;pcolor(mask);shading flat;hold on
plot(iReleaseLocs,jReleaseLocs,'ko')

clear;

myGrid = '../Gridpak/PALAU_120C.nc';


load('virtMoor_10km_PALAU_120C.mat')

lat = nc_varget(myGrid,'lat_rho');
lon = nc_varget(myGrid,'lon_rho');
mask = nc_varget(myGrid,'mask_rho');

pcolor(lon,lat,mask);shading flat;hold on
scatter(virtMoor(:,1),virtMoor(:,2),'g')


%% write to file
[nSta,~] = size(virtMoor);


dlmwrite('stationsLonLat.txt', [1,1,virtMoor(1,1),virtMoor(1,2)],'delimiter','\t','precision',10)
for nn=2:nSta
    dlmwrite('stationsLonLat.txt', [1,1,virtMoor(nn,1),virtMoor(nn,2)],'-append','delimiter','\t','precision',10);
end;




%% defunct

% myStations = vertMoor;
% 
% [ns, nx] = size(myStations);
% 
% latMin = min(lat(:));
% latMax = max(lat(:));
% lonMin = min(lon(:));
% lonMax = max(lon(:));
% 
% vertlatMin = min(vertMoor(:,2));
% vertlatMax = max(vertMoor(:,2));
% vertlonMin = min(vertMoor(:,1));
% vertlonMax = max(vertMoor(:,1));
% 
% [lonMin,vertlonMin,vertlonMax,lonMax]
% [latMin,vertlatMin,vertlatMax,lonMax]
% 
% 
% % 
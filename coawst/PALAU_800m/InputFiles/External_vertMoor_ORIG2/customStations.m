clear;

myGrid = '../Gridpak/PALAU_800m.nc';


% load('virtMoor_10km_PALAU_120C.mat')

lat = nc_varget(myGrid,'lat_rho');
lon = nc_varget(myGrid,'lon_rho');
mask = nc_varget(myGrid,'mask_rho');

lon0 = 134.05;lon1 = 134.3
lat0 = 6.8;lat1 = 7.05

lons = lon0:.05/2:lon1;
lats = lat0:.05/2:lat1;

fig(1);clf;
pcolor(lon,lat,mask);shading flat;
xlim([133.5 134.5]);ylim([6.5 7.5]);
hold on
for ii = 1:length(lons)
for jj = 1:length(lats)
    plot(lons(ii),lats(jj),'ko')
end
end

virtMoor=zeros(length(lats)*length(lons),2);
size(virtMoor)
for ii = 1:length(lons);
    for jj = 1:length(lats)
        counter=(ii-1)*length(lats)+jj;
        [counter,ii,jj,lons(ii),lats(jj)]
        virtMoor(counter,1) = lons(ii);
        virtMoor(counter,2) = lats(jj);
end;end


fig(2);clf;
pcolor(lon,lat,mask);shading flat;
xlim([133.5 134.5]);ylim([6.5 7.5]);
hold on
for ii = 1:length(virtMoor)
    plot(virtMoor(ii,1),virtMoor(ii,2),'ko')
end



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
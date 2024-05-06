clear;

myGrid = '../Gridpak/PALAU_800m.nc';


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

dum = sqrt( (lon - lon0).^2 + (lat - lat0).^2);
[min_num, min_idx] = min(dum(:));
[jLL,iLL] = ind2sub(size(dum),find(dum == min_num))

dum = sqrt( (lon - lon1).^2 + (lat - lat1).^2);
[min_num, min_idx] = min(dum(:));
[jUR,iUR] = ind2sub(size(dum),find(dum == min_num))

nskip = 3;
lons = lon(jLL,iLL:nskip:iUR)
lats = lat(jLL:nskip:jUR,iLL)

fig(2);clf;
pcolor(lon,lat,mask);shading flat;
xlim([133.5 134.5]);ylim([6.5 7.5]);
hold on
for ii = 1:length(lons)
for jj = 1:length(lats)
    plot(lons(ii),lats(jj),'ko')
end
end


%% convert to proper format

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

% write lats and lons
[nSta,~] = size(virtMoor);
dlmwrite('stationsLonLat.txt', [1,1,virtMoor(1,1),virtMoor(1,2)],'delimiter','\t','precision',10)
for nn=2:nSta
    dlmwrite('stationsLonLat.txt', [1,1,virtMoor(nn,1),virtMoor(nn,2)],'-append','delimiter','\t','precision',10);
end;



% nskip = 3;
myI = [jLL,iLL:nskip:iUR]
myJ = [jLL:nskip:jUR,iLL]

dlmwrite('stationsIJ.txt', [1,0,iLL,jLL],'delimiter','\t','precision',5)
for jj=jLL+nskip:jUR
    dlmwrite('stationsIJ.txt', [1,0,iLL,jj],'-append','delimiter','\t','precision',10);
end  
for ii=iLL+nskip:iUR;for jj=jLL:jUR
    dlmwrite('stationsIJ.txt', [1,0,ii,jj],'-append','delimiter','\t','precision',10);
end;end  


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

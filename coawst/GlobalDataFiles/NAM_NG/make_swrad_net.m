upFile   = 'NAM_swrad_up_2020.nc';
downFile = 'NAM_swrad_down_2020.nc';
netFile  = 'NAM_swradNet_2020.nc';

swradUp   = nc_varget(upFile,  'swrad_up');
swradDown = nc_varget(downFile,'swrad_down');

lat = nc_varget(upFile,'lat');
lon = nc_varget(upFile,'lon');
timeUp = nc_varget(upFile,'srf_time');
timeDown = nc_varget(downFile,'srf_time');

% one of the DOWN timestamps is missing
% Specfically, time stamp number 155
timeDown(153:156)';diff(ans)
timeUp(153:156)-timeDown(153:156)
% This is a smidge cheesy, but why don't I just get rid of that point in
% the UP array?. That is, keep time stamps 1:154 and 156:end
swradUP_ORIG = swradUp;
swradUp = swradUp(1:end-1,:,:);
swradUp(155:end,:,:) = swradUP_ORIG(156:end,:,:);


% Domain size
sEdge = geodesic_dist(min(lon),min(lat),max(lon),min(lat),4);
nEdge = geodesic_dist(min(lon),max(lat),max(lon),max(lat),4);
wEdge = geodesic_dist(min(lon),min(lat),min(lon),max(lat),4);
eEdge = geodesic_dist(max(lon),min(lat),max(lon),max(lat),4);

domainArea = areaquad(min(lat),min(lon),max(lat),max(lon),wgs84Ellipsoid) / 10^6;

[nt,ny,nx] = size(swradUp);
size(swradDown);

swradNet = swradDown - swradUp;

nc_varput(netFile,'swrad',swradNet);

%% Create domain average

swradUpAve   = zeros(1,nt);
swradDownAve = swradUpAve;
swradNetAve  = swradUpAve;

for tt=1:nt
    sq(swradUp(tt,:,:));   swradUpAve(tt)   = mean(ans(:));
    sq(swradDown(tt,:,:)); swradDownAve(tt) = mean(ans(:));
    sq(swradNet(tt,:,:));  swradNetAve(tt)  = mean(ans(:));
    
    
%     sq(swradUp(tt,:,:));   swradUpAve(tt)   = sum(ans(:))/domainArea;
%     sq(swradDown(tt,:,:)); swradDownAve(tt) = sum(ans(:))/domainArea;
%     sq(swradNet(tt,:,:));  swradNetAve(tt)  = sum(ans(:))/domainArea
end;

fig(1);clf;
plot(swradUpAve);hold on
plot(swradDownAve);
plot(swradNetAve);
title('hourly snapshots of domain-ave swrad')

%% Noons
% by eye
noon = [18:24:nt];

fig(2);clf;
plot(swradUpAve(noon));hold on
plot(swradDownAve(noon));
plot(swradNetAve(noon));
title('noon snapshots of domain-ave swrad')




nDays = nt/24;
swradUpDailyAve   = zeros(1,nDays);
swradDownDailyAve = swradUpDailyAve;
swradNetDailyAve  = swradUpDailyAve;

for dd=1:nDays
    [1:24] + 24*(dd-1);
    swradUpDailyAve(dd) = mean(swradUpAve(ans));
    swradDownDailyAve(dd) = mean(swradDownAve(ans));
    swradNetDailyAve(dd) = mean(swradNetAve(ans));
end;


fig(3);clf;
plot(swradUpDailyAve);hold on
plot(swradDownDailyAve);
plot(swradNetDailyAve);
title('daily average of domain-ave swrad')


%% Do some checking

% Making plots is kind of a pain because the swrad field is often zero

% fraction = swradNet ./ swradDown;
% 
% tt = 1;
% 
% fig(1);clf
% pcolor(lon,lat,sq(swradUp(tt,:,:)));shading flat
% title('swrad UP'); colorbar
% 
% fig(2);clf
% pcolor(lon,lat,sq(swradDown(tt,:,:)));shading flat
% title('swrad DOWN'); colorbar
% 
% fig(3);clf
% pcolor(lon,lat,sq(swradNet(tt,:,:)));shading flat
% title('swrad NET'); colorbar
% 
% fig(4);clf
% pcolor(lon,lat,sq(fraction(tt,:,:)));shading flat
% title('swrad fraction'); colorbar

clear; close all

myDir='.';

gfile = [myDir '/HC_100mME_wetDry.nc'];exist(gfile);
grd=roms_get_grid(gfile);lonr=grd.lon_rho(1,:);latr=grd.lat_rho(:,1);grd;
% ffile = [myDir '/set2_indices_RHSproblem/bob_flt.nc'];
% ffile = [myDir '/set1_LonLat/bob_flt.nc'];
% ffile = [myDir '/set3_indices_RHSinOne/bob_flt.nc'];
ffile = [myDir '/netcdfOutput/hc_flt.nc'];
lon = nc_varget(ffile,'lon');
lat = nc_varget(ffile,'lat');
I   = nc_varget(ffile,'Xgrid');
J   = nc_varget(ffile,'Ygrid');
time = roms_get_date(ffile);

I(I==0) = NaN;
J(J==0) = NaN;

nSites    = 64;
nLaunches = 120;


%% Try plotting vs IJ
% The point is that delta_x and delta_y are very nearly equal but at 45N
% there's a big difference between delta_lat and delta_lon
fig(1);clf
site   = 64;
launch = 1;
myIndex = nSites*(site-1)+launch

pcolor(grd.mask_rho);shading flat;hold on
plot(I(:,myIndex),J(:,myIndex),'k.')
xlim([150 470]);ylim([300 660])

fig(2);clf;
pcolor(grd.mask_rho);shading flat;hold on
xlim([150 470]);ylim([300 660])
launch = 1;
for nn=1:64
    myIndex = nSites*(nn-1)+launch;
    plot(I(:,myIndex),J(:,myIndex),'k.')
end;
    

    


 

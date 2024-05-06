clear all;close all
tabwindow

%% Load freya_hr data structure

tmp=load('../../InputFiles/cruiseData/freya_nors23_tbdGRIDDED.mat')
Pi = tmp.freya(1).prsHALFMETER;
NT = length(tmp.freya);

for ii = 1:NT
    freya_hr.dnum0(ii)  = nanmean(tmp.freya(ii).tim);
    freya_hr.lon0(ii)   = nanmean(tmp.freya(ii).lonHALFMETER);
    freya_hr.lat0(ii)   = nanmean(tmp.freya(ii).latHALFMETER);
    freya_hr.T    (:,ii) = tmp.freya(ii).temHALFMETER;
    freya_hr.S    (:,ii) = tmp.freya(ii).salHALFMETER;
end
whos Pi dnum T;skip=10;
t0 = min(tmp.tim);t0 = max(tmp.tim);
freya_hr.Pi = Pi;clear Pi tmp tdx* t0* t1* ii skip dnum* lon0 lat0 NT D* S T P;
whos;

% Choose the cast number

nn=XXX;
dStart=YYY;

% Get the data for this cast
freya_hr.lon0(nn);
freya_hr.lat0(nn);
Tcruise = flipud(freya_hr.T(:,nn));
Scruise = flipud(freya_hr.S(:,nn));
zcruise = flipud(-freya_hr.Pi);

%% get the z grid

gridFile = './util/NORSE1D_5km.nc';
HISFile  = './util/IC.nc';

grd = roms_get_grid(gridFile,HISFile,0,1);

%% Start from rest

ICfile = 'IC.nc';

dum = nc_varget(ICfile,'ocean_time');
nc_varput(ICfile,'ocean_time',dStart);

dum = nc_varget(ICfile,'zeta');
[ny,nx] = size(dum);
dum2 = zeros(1,ny,nx);
nc_varput(ICfile,'zeta',dum2);

dum = nc_varget(ICfile,'ubar');
[ny,nx] = size(dum);
dum2 = zeros(1,ny,nx);
nc_varput(ICfile,'ubar',dum2);

dum = nc_varget(ICfile,'vbar');
[ny,nx] = size(dum);
dum2 = zeros(1,ny,nx);
nc_varput(ICfile,'vbar',dum2);

dum = nc_varget(ICfile,'u');
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
nc_varput(ICfile,'u',dum2);

dum = nc_varget(ICfile,'v');
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
nc_varput(ICfile,'v',dum2);



%% Update T and S from the freya_hr cast

zLocal = sq(grd.z_r(:,1,1));
Tlocal = interp1(zcruise,Tcruise,zLocal );
Slocal = interp1(zcruise,Scruise,zLocal );

nz = length(zLocal)
for kk=nz-10:nz
    if isnan(Tlocal(kk))
        Tlocal(kk) = Tlocal(kk-1);
    end; 
    if isnan(Slocal(kk))
        Slocal(kk) = Slocal(kk-1);
    end;
    
end;


%fig(1);clf;
%plot(zcruise(600:end),Tcruise(600:end))
%title('T(z) cruise')
%
%fig(2);clf;
%plot(sq(grd.z_r(:,1,1)),Tlocal)
%title('T(z) local')
%
%fig(3);clf;
%plot(zcruise(600:end),Scruise(600:end))
%title('S(z) cruise')
%
%fig(4);clf;
%plot(sq(grd.z_r(:,1,1)),Slocal)
%title('S(z) local')

%fig(11);clf;
%plot(zcruise(600:end),Tcruise(600:end));hold on
%plot(sq(grd.z_r(:,1,1)),Tlocal,'r')
%title('T(z)')
%
%fig(13);clf;
%plot(zcruise(600:end),Scruise(600:end));hold on
%plot(sq(grd.z_r(:,1,1)),Slocal,'r')
%title('S(z)')
%

% write new numbers into the IC file
temp = nc_varget(ICfile,'temp');
salt = nc_varget(ICfile,'salt');

[nz,ny,nx] = size(temp);

temp2 = zeros(1,nz,ny,nx);
salt2 = temp2;

for ii=1:nx; for jj=1:ny
    temp2(1,:,jj,ii) = Tlocal';  
    salt2(1,:,jj,ii) = Slocal'; 
end;end

nc_varput(ICfile,'temp',temp2);
nc_varput(ICfile,'salt',salt2);





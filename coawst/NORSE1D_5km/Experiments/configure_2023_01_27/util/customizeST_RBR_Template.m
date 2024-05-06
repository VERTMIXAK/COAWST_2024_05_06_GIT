clear all;close all
tabwindow

%% Load RBR data structure

tmp=load('../../InputFiles/cruiseData/RBR.mat')

rbr_hr.dnum0 = tmp.C.dn;    
rbr_hr.lon0  = tmp.C.lon;    
rbr_hr.lat0  = tmp.C.lat;
rbr_hr.T     = tmp.C.T;    
rbr_hr.S     = tmp.C.SP;
rbr_hr.z     = tmp.C.z;


% Choose the cast number

nn=XXX;
dStart=YYY;

% Get the data for this cast
rbr_hr.lon0(nn);
rbr_hr.lat0(nn);
Tcruise = flipud(rbr_hr.T(:,nn));
Scruise = flipud(rbr_hr.S(:,nn));
zcruise = flipud(-rbr_hr.z);

%% get the z grid

gridFile = 'NORSE1D_5km.nc';
ICFile  = 'IC.nc';

grd = roms_get_grid(gridFile,ICFile,0,1);

%% Start from rest

dum = nc_varget(ICFile,'ocean_time');
nc_varput(ICFile,'ocean_time',dStart);

dum = nc_varget(ICFile,'zeta');
[ny,nx] = size(dum);
dum2 = zeros(1,ny,nx);
nc_varput(ICFile,'zeta',dum2);

dum = nc_varget(ICFile,'ubar');
[ny,nx] = size(dum);
dum2 = zeros(1,ny,nx);
nc_varput(ICFile,'ubar',dum2);

dum = nc_varget(ICFile,'vbar');
[ny,nx] = size(dum);
dum2 = zeros(1,ny,nx);
nc_varput(ICFile,'vbar',dum2);

dum = nc_varget(ICFile,'u');
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
nc_varput(ICFile,'u',dum2);

dum = nc_varget(ICFile,'v');
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
nc_varput(ICFile,'v',dum2);



%% Update T and S from the RBR cast

zLocal = sq(grd.z_r(:,1,1));
Tlocal = interp1(zcruise,Tcruise,zLocal );
Slocal = interp1(zcruise,Scruise,zLocal );

% Get rid of NaNs near surface
nz = length(zLocal)
for kk=nz-10:nz
    if isnan(Tlocal(kk))
        Tlocal(kk) = Tlocal(kk-1);
    end; 
    if isnan(Slocal(kk))
        Slocal(kk) = Slocal(kk-1);
    end;
    
end;

% Get rid of NaNs in deep water
for kk=40:-1:1
    if isnan(Tlocal(kk))
        Tlocal(kk) = Tlocal(kk+1);
    end; 
    if isnan(Slocal(kk))
        Slocal(kk) = Slocal(kk+1);
    end;
    
end;




%fig(1);clf;
%plot(zcruise,Tcruise)
%title('T(z) cruise')
%
%fig(2);clf;
%plot(sq(grd.z_r(:,1,1)),Tlocal)
%title('T(z) local')
%
%fig(3);clf;
%plot(zcruise,Scruise)
%title('S(z) cruise')
%
%fig(4);clf;
%plot(sq(grd.z_r(:,1,1)),Slocal)
%title('S(z) local')
%
%fig(11);clf;
%plot(zcruise,Tcruise);hold on
%plot(sq(grd.z_r(:,1,1)),Tlocal,'r')
%title('T(z)')
%
%fig(13);clf;
%plot(zcruise,Scruise);hold on
%plot(sq(grd.z_r(:,1,1)),Slocal,'r')
%title('S(z)')


% write new numbers into the IC file
temp = nc_varget(ICFile,'temp');
salt = nc_varget(ICFile,'salt');

[nz,ny,nx] = size(temp);

temp2 = zeros(1,nz,ny,nx);
salt2 = temp2;

for ii=1:nx; for jj=1:ny
    temp2(1,:,jj,ii) = Tlocal';  
    salt2(1,:,jj,ii) = Slocal'; 
end;end

nc_varput(ICFile,'temp',temp2);
nc_varput(ICFile,'salt',salt2);





iniDOPPIO = 'myINI.nc_ORIG';
iniUW     = 'myINI.nc_prev';
iniNEW    = 'myINI.nc';

unix(['cp ',iniDOPPIO,' ',iniNEW]);

var='zeta';
dum = nc_varget(iniUW,var);
[ny,nx] = size(dum);
dum2 = zeros(1,ny,nx);
dum2(1,:,:) = dum;
nc_varput(iniNEW,var,dum2);

var='ubar';
dum = nc_varget(iniUW,var);
[ny,nx] = size(dum);
dum2 = zeros(1,ny,nx);
dum2(1,:,:) = dum;
nc_varput(iniNEW,var,dum2);

var='vbar';
dum = nc_varget(iniUW,var);
[ny,nx] = size(dum);
dum2 = zeros(1,ny,nx);
dum2(1,:,:) = dum;
nc_varput(iniNEW,var,dum2);

var='temp';
dum = nc_varget(iniUW,var);
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = dum;
nc_varput(iniNEW,var,dum2);

var='salt';
dum = nc_varget(iniUW,var);
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = dum;
nc_varput(iniNEW,var,dum2);

var='u';
dum = nc_varget(iniUW,var);
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = dum;
nc_varput(iniNEW,var,dum2);

var='v';
dum = nc_varget(iniUW,var);
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = dum;
nc_varput(iniNEW,var,dum2);
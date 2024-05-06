file = 'IC.nc_ORIG';
fileNew = 'IC.nc';

unix(['cp ',file,' ',fileNew]);

dum = nc_varget(fileNew,'u');
[nz,ny,nx] = size(dum);
dum2=zeros(1,nz,ny,nx);
dum2(1,:,:,:) = 0*dum;
nc_varput(fileNew,'u',dum2)

dum = nc_varget(fileNew,'v');
[nz,ny,nx] = size(dum);
dum2=zeros(1,nz,ny,nx);
dum2(1,:,:,:) = 0*dum;
nc_varput(fileNew,'v',dum2)

dum = nc_varget(fileNew,'ubar');
[ny,nx] = size(dum);
dum2=zeros(1,ny,nx);
dum2(1,:,:) = 0*dum;
nc_varput(fileNew,'ubar',dum2)

dum = nc_varget(fileNew,'vbar');
[ny,nx] = size(dum);
dum2=zeros(1,ny,nx);
dum2(1,:,:) = 0*dum;
nc_varput(fileNew,'vbar',dum2)

dum = nc_varget(fileNew,'zeta');
[ny,nx] = size(dum);
dum2=zeros(1,ny,nx);
dum2(1,:,:) = 0*dum;
nc_varput(fileNew,'zeta',dum2)
fileOld = 'CMEMS_2022_bdry_GUAMKinner_1km.nc';
fileNew = 'Flat_2022_bdry_GUAMKinner_1km.nc';
fileIC  = 'ini_074/Flat_2022_074_ic_GUAMKinner_1km.nc';
unix(['cp ',fileOld,' ',fileNew]);

%% temp

root = 'temp';
temp = nc_varget(fileIC,'temp');
[NZ,NY,NX] = size(temp);

dum = nc_varget(fileNew,[root,'_west']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,:,1));
end;
nc_varput(fileNew,[root,'_west'],dum);

dum = nc_varget(fileNew,[root,'_east']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,:,end));
end;
nc_varput(fileNew,[root,'_east'],dum);


dum = nc_varget(fileNew,[root,'_south']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,1,:));
end;
nc_varput(fileNew,[root,'_south'],dum);

dum = nc_varget(fileNew,[root,'_north']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,end,:));
end;
nc_varput(fileNew,[root,'_north'],dum);

aaa=5;


%% salt

root = 'salt';
temp = nc_varget(fileIC,'salt');
[NZ,NY,NX] = size(temp);

dum = nc_varget(fileNew,[root,'_west']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,:,1));
end;
nc_varput(fileNew,[root,'_west'],dum);

dum = nc_varget(fileNew,[root,'_east']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,:,end));
end;
nc_varput(fileNew,[root,'_east'],dum);


dum = nc_varget(fileNew,[root,'_south']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,1,:));
end;
nc_varput(fileNew,[root,'_south'],dum);

dum = nc_varget(fileNew,[root,'_north']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,end,:));
end;
nc_varput(fileNew,[root,'_north'],dum);

aaa=5;


%% u

root = 'u';
temp = nc_varget(fileIC,'u');
[NZ,NY,NX] = size(temp);

dum = nc_varget(fileNew,[root,'_west']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,:,1));
end;
nc_varput(fileNew,[root,'_west'],dum);

dum = nc_varget(fileNew,[root,'_east']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,:,end));
end;
nc_varput(fileNew,[root,'_east'],dum);


dum = nc_varget(fileNew,[root,'_south']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,1,:));
end;
nc_varput(fileNew,[root,'_south'],dum);

dum = nc_varget(fileNew,[root,'_north']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,end,:));
end;
nc_varput(fileNew,[root,'_north'],dum);

aaa=5;


%% v

root = 'v';
temp = nc_varget(fileIC,'v');
[NZ,NY,NX] = size(temp);

dum = nc_varget(fileNew,[root,'_west']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,:,1));
end;
nc_varput(fileNew,[root,'_west'],dum);

dum = nc_varget(fileNew,[root,'_east']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,:,end));
end;
nc_varput(fileNew,[root,'_east'],dum);


dum = nc_varget(fileNew,[root,'_south']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,1,:));
end;
nc_varput(fileNew,[root,'_south'],dum);

dum = nc_varget(fileNew,[root,'_north']);
[nt,nz,ny] = size(dum);
for tt=1:nt
    dum(tt,:,:) = sq(temp(:,end,:));
end;
nc_varput(fileNew,[root,'_north'],dum);

aaa=5;


%% zeta

root = 'zeta';

dum = nc_varget(fileNew,[root,'_west']);
nc_varput(fileNew,[root,'_west'],0.*dum);

dum = nc_varget(fileNew,[root,'_east']);
nc_varput(fileNew,[root,'_east'],0.*dum);

dum = nc_varget(fileNew,[root,'_north']);
nc_varput(fileNew,[root,'_north'],0.*dum);

dum = nc_varget(fileNew,[root,'_south']);
nc_varput(fileNew,[root,'_south'],0.*dum);


%% ubar

root = 'ubar';

dum = nc_varget(fileNew,[root,'_west']);
nc_varput(fileNew,[root,'_west'],0.*dum);

dum = nc_varget(fileNew,[root,'_east']);
nc_varput(fileNew,[root,'_east'],0.*dum);

dum = nc_varget(fileNew,[root,'_north']);
nc_varput(fileNew,[root,'_north'],0.*dum);

dum = nc_varget(fileNew,[root,'_south']);
nc_varput(fileNew,[root,'_south'],0.*dum);


%% vbar

root = 'vbar';

dum = nc_varget(fileNew,[root,'_west']);
nc_varput(fileNew,[root,'_west'],0.*dum);

dum = nc_varget(fileNew,[root,'_east']);
nc_varput(fileNew,[root,'_east'],0.*dum);

dum = nc_varget(fileNew,[root,'_north']);
nc_varput(fileNew,[root,'_north'],0.*dum);

dum = nc_varget(fileNew,[root,'_south']);
nc_varput(fileNew,[root,'_south'],0.*dum);



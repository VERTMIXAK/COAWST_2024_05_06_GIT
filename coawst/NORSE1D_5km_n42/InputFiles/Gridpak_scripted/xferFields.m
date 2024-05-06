sourceFile = 'NORSE1D_5km_n42.nc_temporary';
targetFile = 'NORSE1D_5km_n42.nc';
unix(['cp ',targetFile,'_template ',targetFile]);

var = 'x_rho';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'x_psi';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'x_u';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'x_v';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);




var = 'y_rho';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'y_psi';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'y_u';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'y_v';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);




var = 'lat_rho';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'lat_psi';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'lat_u';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'lat_v';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);




var = 'lon_rho';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'lon_psi';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'lon_u';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'lon_v';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);



var = 'angle';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'f0';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'dfdy';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'f';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'pm';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'pn';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'dndx';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);

var = 'dmde';
dum = nc_varget(sourceFile,var);
nc_varput(targetFile,var,dum);



% h is a special case
dum = nc_varget('NORSE1D_5km_n42.nc_template','hraw');

size(dum);
dum = 0*sq(dum(1,:,:))+3000;

nc_varput(targetFile,'h',dum);





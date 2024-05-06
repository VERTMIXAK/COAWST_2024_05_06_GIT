fileNeg = 'NGnest_100m_child.nc_negLons'
filePos = 'NGnest_100m_child.nc_posLons'

unix(['cp ',fileNeg,' ',filePos]);

dum = nc_varget(filePos,'lon_rho');
dum = dum+360;
nc_varput(filePos,'lon_rho',dum);

dum = nc_varget(filePos,'lon_psi');
dum = dum+360;
nc_varput(filePos,'lon_psi',dum);

dum = nc_varget(filePos,'lon_u');
dum = dum+360;
nc_varput(filePos,'lon_u',dum);

dum = nc_varget(filePos,'lon_v');
dum = dum+360;
nc_varput(filePos,'lon_v',dum);




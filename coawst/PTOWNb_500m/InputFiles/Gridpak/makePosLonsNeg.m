file = 'PTOWNb_500m.nc'
% filePos = 'HC_150m_posLons.nc'

% unix(['cp ',filePos,' ',file]);

dum = nc_varget(file,'lon_rho');
dum = dum-360;
nc_varput(file,'lon_rho',dum);

dum = nc_varget(file,'lon_psi');
dum = dum-360;
nc_varput(file,'lon_psi',dum);

dum = nc_varget(file,'lon_u');
dum = dum-360;
nc_varput(file,'lon_u',dum);

dum = nc_varget(file,'lon_v');
dum = dum-360;
nc_varput(file,'lon_v',dum);




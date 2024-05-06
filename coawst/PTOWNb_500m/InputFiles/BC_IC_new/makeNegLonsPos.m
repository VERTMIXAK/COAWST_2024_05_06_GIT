for nn=1:9
    file=['HIS_2016.11.0',num2str(nn),'.nc']
    dum = nc_varget(file,'lon_rho');
    dum = dum+360;
    nc_varput(file,'lon_rho',dum);
    
    dum = nc_varget(file,'lon_u');
    dum = dum+360;
    nc_varput(file,'lon_u',dum);
    
    dum = nc_varget(file,'lon_v');
    dum = dum+360;
    nc_varput(file,'lon_v',dum);
end

for nn=10:30
    file=['HIS_2016.11.',num2str(nn),'.nc']
    dum = nc_varget(file,'lon_rho');
    dum = dum+360;
    nc_varput(file,'lon_rho',dum);
    
    dum = nc_varget(file,'lon_u');
    dum = dum+360;
    nc_varput(file,'lon_u',dum);
    
    dum = nc_varget(file,'lon_v');
    dum = dum+360;
    nc_varput(file,'lon_v',dum);
end


file=['CAS7_grid.nc']
dum = nc_varget(file,'lon_rho');
dum = dum+360;
nc_varput(file,'lon_rho',dum);

dum = nc_varget(file,'lon_u');
dum = dum+360;
nc_varput(file,'lon_u',dum);

dum = nc_varget(file,'lon_v');
dum = dum+360;
nc_varput(file,'lon_v',dum);

dum = nc_varget(file,'lon_psi');
dum = dum+360;
nc_varput(file,'lon_psi',dum);


% dum = nc_varget(file,'lon_rho');
% dum = dum+360;
% nc_varput(file,'lon_rho',dum);
%
% dum = nc_varget(file,'lon_u');
% dum = dum+360;
% nc_varput(file,'lon_u',dum);
%
% dum = nc_varget(file,'lon_v');
% dum = dum+360;
% nc_varput(file,'lon_v',dum);




file = 'NGnest_triple_c.nc';

%     dum.Name = 'hraw';
%     dum.Nctype = 'float';
%     dum.Dimension = {'bath', 'eta_rho', 'xi_rho' };
%     dum.Attribute = struct('Name',{'long_name','units'},'Value',{'Working bathymetry at RHO-points'});
%     nc_addvar(file,dum);

h = nc_varget(file,'h');

[ny,nx] = size(h);
hraw = zeros(1,ny,nx);
hraw(1,:,:) = h;

nc_varput(file,'hraw',hraw);
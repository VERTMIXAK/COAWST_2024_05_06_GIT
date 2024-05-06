file = 'IC.nc';

dum.Name = 'Vtransform';
dum.Nctype = 'int';
dum.Dimension = {'ocean_time'};
dum.Attribute = struct('Name','long_name','Value','vertical terrain-following transformation equation');
nc_addvar(file,dum)

dum.Name = 'Vstretching';
dum.Nctype = 'int';
dum.Dimension = {'ocean_time'};
dum.Attribute = struct('Name','long_name','Value','vertical terrain-following stretching equation');
nc_addvar(file,dum)

%%


nc_varput(file,'Vtransform',2);
nc_varput(file,'Vstretching',4);
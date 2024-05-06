oldFile = 'CLM_CMEMS_PALAU_800m.nc_ORIG';
newFile = 'CLM_CMEMS_PALAU_800m.nc';

unix(['cp ',oldFile,' ',newFile]);

time = nc_varget(newFile,'ocean_time')

% Dimension section  
nc_add_dimension(newFile,'v2d_time',length(time));
nc_add_dimension(newFile,'v3d_time',length(time));

    
dum.Name = 'v2d_time';   
dum.Nctype = 'float';  
dum.Dimension = {'v2d_time'};
dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'CLM 2D time','days since 1900-01-01 00:00:00',' '});   
nc_addvar(newFile,dum)
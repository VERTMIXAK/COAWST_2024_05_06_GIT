% Most of the fields have three arguments - lat, lon, and t - but a few
% also include a 4th field - height

names3 = {'Pair',      'lwrad_down', 'lhflux'     , 'swrad',    'swrad_up', 'sensible',      'latent',      'rain'};
times3 = {'pair_time', 'lrf_time',   'lhflux_time', 'srf_time', 'srf_time', 'sensible_time', 'latent_time', 'rain_time'};


names4 = {'Uwind',     'Vwind',     'Tair',      'Qair'};
times4 = {'wind_time', 'wind_time', 'tair_time', 'qair_time'};

long3  = {'Presure @ Ground or water surface',                                                                          ...
    'downward longwave radiation at surface','latent heat flux at surface','downward shortwave radiation at surface',   ...
    'upward shortwave radiation at surface',                                                                                ...
    'Sensible heat net flux (3_hour_Average) @ Ground or water surface',                                                    ...
    'Latent heat net flux (3_hour_Average) @ Ground or water surface',                                                    ...
    'Precipitation rate @ Ground or water surface'};

long4  = {'u component of wind at 10m','v component of wind at 10m','Temperature at 2m','Specific Humidity at 2m'};


units3 = {'Pa','W m-2','W m-2','W m-2','W m-2','W m-2','W m-2','kg m-2 s-1'};
units4 = {'m/s','m/s','C','kg/kg'};


%% height-dependent fields

for ii=1:4
    timeVar  = char(times4(ii));
    nameVar  = char(names4(ii));
    longName = char(long4(ii));
    units    = char(units4(ii));
    
    [~,oldFile] = unix(['ls *',nameVar,'*'])                                ;oldFile=oldFile(1:end-1)
    [~,newFile] = unix(['ls *',nameVar,'* | rev | cut -d "_" -f2-10 | rev']);newFile=newFile(1:end-1)
    
    lon = nc_varget(oldFile,'lon');
    lat = nc_varget(oldFile,'lat');
    time = nc_varget(oldFile,timeVar);
    var = nc_varget(oldFile,nameVar);
    
    var = sq(var(:,1,:,:));
    [nt, ny, nx] = size(var);
    
    % lat is flipped in the original downloads for some reason
    lat = flipud(lat);
    for tt=1:nt
        var(tt,:,:) = flipud(sq(var(tt,:,:)));
    end;
    
    nc_create_empty(newFile,nc_64bit_offset_mode);
    
    % Dimension section
    nc_add_dimension(newFile,'lon',length(lon));
    nc_add_dimension(newFile,'lat',length(lat));
    nc_add_dimension(newFile,timeVar,0);
    
    % Variables section
    
    dum.Name = 'lon';
    dum.Nctype = 'float';
    dum.Dimension = {'lon'};
    dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'longitude','degrees_east','time, scalar, series'});
    nc_addvar(newFile,dum);
    
    dum.Name = 'lat';
    dum.Nctype = 'float';
    dum.Dimension = {'lat'};
    dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'latitude','degrees_north','time, scalar, series'});
    nc_addvar(newFile,dum);
    
    dum.Name = timeVar;
    dum.Nctype = 'float';
    dum.Dimension = {timeVar};
    dum.Attribute = struct('Name',{'long_name','units','calendar','field'},'Value',{'time','days since 1900-01-01 00:00:00','gregorian','time, scalar, series'});
    nc_addvar(newFile,dum)
    
    dum.Name = nameVar;
    dum.Nctype = 'float';
    dum.Dimension = {timeVar,'lat','lon'};
    dum.Attribute = struct('Name',{'long_name','units','time','coordinates','field'},'Value',{longName,units,timeVar,['lon lat ',timeVar],'placeholder, scalar, series'});
    nc_addvar(newFile,dum);
    
    
    
    nc_varput(newFile,'lon',lon);
    nc_varput(newFile,'lat',lat);
    nc_varput(newFile,nameVar,var);
    nc_varput(newFile,timeVar,time);
    
end;




%% height-independent fields

for ii=1:8
%for ii=1:4
    timeVar  = char(times3(ii));
    nameVar  = char(names3(ii));
    longName = char(long3(ii));
    units    = char(units3(ii));
    
    [~,oldFile] = unix(['ls *',nameVar,'_2*'])                                ;oldFile=oldFile(1:end-1)
    [~,newFile] = unix(['ls *',nameVar,'_2* | rev | cut -d "_" -f2-10 | rev']);newFile=newFile(1:end-1)
    
    lon = nc_varget(oldFile,'lon');
    lat = nc_varget(oldFile,'lat');
    time = nc_varget(oldFile,timeVar);
    var = nc_varget(oldFile,nameVar);
    
    var = sq(var(:,:,:));
    [nt, ny, nx] = size(var);
    
    % lat is flipped in the original downloads for some reason
    lat = flipud(lat);
    for tt=1:nt
        var(tt,:,:) = flipud(sq(var(tt,:,:)));
    end;
    
    nc_create_empty(newFile,nc_64bit_offset_mode);
    
    % Dimension section
    nc_add_dimension(newFile,'lon',length(lon));
    nc_add_dimension(newFile,'lat',length(lat));
    nc_add_dimension(newFile,timeVar,0);
    
    % Variables section
    
    dum.Name = 'lon';
    dum.Nctype = 'float';
    dum.Dimension = {'lon'};
    dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'longitude','degrees_east','time, scalar, series'});
    nc_addvar(newFile,dum);
    
    dum.Name = 'lat';
    dum.Nctype = 'float';
    dum.Dimension = {'lat'};
    dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'latitude','degrees_north','time, scalar, series'});
    nc_addvar(newFile,dum);
    
    dum.Name = timeVar;
    dum.Nctype = 'float';
    dum.Dimension = {timeVar};
    dum.Attribute = struct('Name',{'long_name','units','calendar','field'},'Value',{'time','days since 1900-01-01 00:00:00','gregorian','time, scalar, series'});
    nc_addvar(newFile,dum)
    
    dum.Name = nameVar;
    dum.Nctype = 'float';
    dum.Dimension = {timeVar,'lat','lon'};
    dum.Attribute = struct('Name',{'long_name','units','time','coordinates','field'},'Value',{longName,units,timeVar,['lon lat ',timeVar],'placeholder, scalar, series'});
    nc_addvar(newFile,dum);
    
    
    nc_varput(newFile,'lon',lon);        
    nc_varput(newFile,'lat',lat);
    nc_varput(newFile,nameVar,var);
    nc_varput(newFile,timeVar,time);
    
end;


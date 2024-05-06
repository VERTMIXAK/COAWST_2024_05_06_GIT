% Most of the fields have three arguments - lat, lon, and t - but a few
% also include a 4th field - height

varNames = {'lwrad_down','Pair'     ,'Qair'     ,'rain'     ,'swrad'   ,'Tair'     ,'Uwind'     ,'Vwind'};
varTimes = {'lrf_time'  ,'pair_time','qair_time','rain_time','srf_time','tair_time','wind_time','wind_time'};

longNames  = {                                  ...
    'Downward longwave radiation flux',     ...
    'Surface air pressure',                 ...
    'Surface air relative humidity'         ...
    'Rain fall rate'                        ...
    'net solar shortwave radiation flux',   ...
    'Surface air temperature',              ...
    'Surface u-wind component',             ...
    'Surface v-wind component'              ...
    };
 
unitNames = {'W m-2','millibar','percentage','kg m-2 s-1','W m-2','C','m/s','m/s'};

lat = nc_varget('latLon.nc','lat_rho');
lon = nc_varget('latLon.nc','lon_rho');

lon = lon(1,:);
lat = lat(:,1);


%% sdfsdf


for ii=1:length(varNames);
  
    timeVar  = char(varTimes(ii));
    nameVar  = char(varNames(ii));
    longName = char(longNames(ii));
    units    = char(unitNames(ii));
    
    [~,oldFile] = unix(['ls originals/*',nameVar,'*'])                 
    oldFile=oldFile(1:end-1)
    [~,newFile] = unix(['ls originals/*',nameVar,'* | cut -c 11-50'])
    newFile=newFile(1:end-1)
    
    time = nc_varget(oldFile,timeVar);
    var = nc_varget(oldFile,nameVar);
    [nt, ny, nx] = size(var);
    
    % lat is flipped in the original downloads for some reason
%     lat = flipud(lat);
%     for tt=1:nt
%         var(tt,:,:) = flipud(sq(var(tt,:,:)));
%     end;
    
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


dum = nc_varget('Qair_2016.11.nc','Qair');
dum(dum>100) = 100;
nc_varput('Qair_2016.11.nc','Qair',dum);



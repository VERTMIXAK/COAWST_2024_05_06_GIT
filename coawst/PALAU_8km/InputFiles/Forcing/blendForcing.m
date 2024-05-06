clear; close all

file1 = 'forcing_08548.nc';
file2 = 'forcing_08551.nc';
file3 = 'forcing_08554.nc';

% unix(['\rm forcing.nc']);
% ['ncrcat -O ',file1,' ',file2,' ',file3,' forcing.nc']
% unix(['ncrcat -O',file1,' ',file2,' ',file3,' forcing.nc']);

time1 = nc_varget(file1,'ocean_time');
time2 = nc_varget(file2,'ocean_time');
time3 = nc_varget(file3,'ocean_time');

myVar2D = {'EminusP','Pair','Tair','Uwind','Vwind','evaporation','latent','lwrad','rain','salt_sur','sensible','shflux','ssflux','swrad','temp_sur'    };

time = unique([time1' time2' time3']);
nc_varput('forcing.nc','ocean_time',time);

% unix(['ncks -/O -d ocean_time,0,',num2str(length(time)-1),' forcing.nc forcing.nc'])

myJ=10;
myI=10;

%% 2D variables

for nn=1:length(myVar2D)
    var1 = nc_varget(file1,char(myVar2D(nn)));
    var2 = nc_varget(file2,char(myVar2D(nn)));
    var3 = nc_varget(file3,char(myVar2D(nn)));
    
    [~,ny,nx] = size(var1);
    
%     fig(1);clf;
%     plot(time1,sq(var1(:,myJ,myI)),'b.')
%     hold on
%     plot(time2,sq(var2(:,myJ,myI)),'r.')
%     
   

    
    array12 = zeros(49,ny,nx);
    array23 = zeros(49,ny,nx);
    
    for ii=1:49
        frac1 = (50-ii)/50;
        frac2 =  ii/50;
        [ii,frac1,frac2,frac1+frac2];
        array12(ii,:,:) = frac1*var1(72+ii,:,:) + frac2*var2(ii,:,:);
        array23(ii,:,:) = frac1*var2(72+ii,:,:) + frac2*var3(ii,:,:);
    end
    
    varNew = zeros(265,ny,nx);
    varNew(1:72,:,:) = var1(1:72,:,:);
    varNew(73:121,:,:) = array12;
    varNew(122:144,:,:) = var2(50:72,:,:);
    varNew(145:193,:,:) = array23;
    varNew(194:265,:,:) = var3(50:121,:,:);
    
%     fig(2);clf;
%     plot(time1,sq(var1(:,myJ,myI)),'b.')
%     hold on
%     plot(time2,sq(var2(:,myJ,myI)),'r.')
%     plot(time(1:65),varNew(1:65,myJ,myI))
%     
    fig(3);clf;
    plot(time1,sq(var1(:,myJ,myI)),'b.')
    hold on
    plot(time2,sq(var2(:,myJ,myI)),'r.')
    plot(time3,sq(var3(:,myJ,myI)),'g.')
    plot(time,varNew(:,myJ,myI))
    title(char(myVar2D(nn)))
    
    nc_varput('forcing.nc',char(myVar2D(nn)),varNew);
    
    
end;

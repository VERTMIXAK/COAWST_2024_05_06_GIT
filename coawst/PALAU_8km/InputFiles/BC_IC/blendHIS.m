clear; close all

file1 = 'HIS_08548.nc';
file2 = 'HIS_08551.nc';
file3 = 'HIS_08554.nc';

% unix(['\rm HIS.nc']);
% ['ncrcat -O ',file1,' ',file2,' ',file3,' HIS.nc']
% unix(['ncrcat -O',file1,' ',file2,' ',file3,' HIS.nc']);

time1 = nc_varget(file1,'ocean_time');
time2 = nc_varget(file2,'ocean_time');
time3 = nc_varget(file3,'ocean_time');

myVar2D = {'zeta', 'ubar', 'vbar'    };
myVar3D = {'temp', 'salt', 'u',   'v'};

time = unique([time1' time2' time3']);
nc_varput('HIS.nc','ocean_time',time);

% unix(['ncks -/O -d ocean_time,0,',num2str(length(time)-1),' HIS.nc HIS.nc'])

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
   

    
    array12 = zeros(17,ny,nx);
    array23 = zeros(17,ny,nx);
    
    for ii=1:17
        frac1 = (18-ii)/18;
        frac2 =  ii/18;
        [ii,frac1,frac2,frac1+frac2];
        array12(ii,:,:) = frac1*var1(24+ii,:,:) + frac2*var2(ii,:,:);
        array23(ii,:,:) = frac1*var2(24+ii,:,:) + frac2*var3(ii,:,:);
    end
    
    varNew = zeros(89,ny,nx);
    varNew(1:24,:,:) = var1(1:24,:,:);
    varNew(25:41,:,:) = array12;
    varNew(42:48,:,:) = var2(18:24,:,:);
    varNew(49:65,:,:) = array23;
    varNew(66:89,:,:) = var3(18:41,:,:);
    
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
    
    nc_varput('HIS.nc',char(myVar2D(nn)),varNew);
    
    
end;




%% 3D variables

for nn=1:length(myVar3D)
    var1 = nc_varget(file1,char(myVar3D(nn)));
    var2 = nc_varget(file2,char(myVar3D(nn)));
    var3 = nc_varget(file3,char(myVar3D(nn)));
    
    [~,nz,ny,nx] = size(var1);
    
%     fig(1);clf;
%     plot(time1,sq(var1(:,myJ,myI)),'b.')
%     hold on
%     plot(time2,sq(var2(:,myJ,myI)),'r.')
%     
   

    
    array12 = zeros(17,nz,ny,nx);
    array23 = zeros(17,nz,ny,nx);
    
    for ii=1:17
        frac1 = (18-ii)/18;
        frac2 =  ii/18;
        [ii,frac1,frac2,frac1+frac2];
        array12(ii,:,:,:) = frac1*var1(24+ii,:,:,:) + frac2*var2(ii,:,:,:);
        array23(ii,:,:,:) = frac1*var2(24+ii,:,:,:) + frac2*var3(ii,:,:,:);
    end
    
    varNew = zeros(89,nz,ny,nx);
    varNew(1:24,:,:,:) = var1(1:24,:,:,:);
    varNew(25:41,:,:,:) = array12;
    varNew(42:48,:,:,:) = var2(18:24,:,:,:);
    varNew(49:65,:,:,:) = array23;
    varNew(66:89,:,:,:) = var3(18:41,:,:,:);
    
%     fig(2);clf;
%     plot(time1,sq(var1(:,myJ,myI)),'b.')
%     hold on
%     plot(time2,sq(var2(:,myJ,myI)),'r.')
%     plot(time(1:65),varNew(1:65,myJ,myI))
%     
    fig(3);clf;
    plot(time1,sq(var1(:,nz,myJ,myI)),'b.')
    hold on
    plot(time2,sq(var2(:,nz,myJ,myI)),'r.')
    plot(time3,sq(var3(:,nz,myJ,myI)),'g.')
    plot(time,varNew(:,nz,myJ,myI))
    title(char(myVar3D(nn)))
    
    nc_varput('HIS.nc',char(myVar3D(nn)),varNew);
    
    
end;



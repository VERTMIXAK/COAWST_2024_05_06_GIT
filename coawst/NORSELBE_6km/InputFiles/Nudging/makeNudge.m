gridFile = '../Gridpak/NORSELBE_6km.nc';
HISfile  = '../BC_IC/HIS.nc';
newFile  = 'Nudge_NORSELBE_6km.nc';

grd = roms_get_grid(gridFile,HISfile,0,1);

[ny,nx] = size(grd.mask_rho);
nz = length(grd.s_rho);

nc_create_empty(newFile,nc_64bit_offset_mode);

% Dimension section
nc_add_dimension(newFile,'s_rho'  ,nz);
nc_add_dimension(newFile,'eta_rho',ny);
nc_add_dimension(newFile,'xi_rho' ,nx);

% Variables section

dum.Name = 'M2_NudgeCoef';
dum.Nctype = 'double';
dum.Dimension = {'eta_rho','xi_rho'};
dum.Attribute = struct('Name',{'long_name','units','coordinates'},'Value',{'2D momentum inverse nudging coefficients','day-1','xi_rho eta_rho'});
nc_addvar(newFile,dum);

dum.Name = 'M3_NudgeCoef';
dum.Nctype = 'double';
dum.Dimension = {'s_rho','eta_rho','xi_rho'};
dum.Attribute = struct('Name',{'long_name','units','coordinates'},'Value',{'3D momentum inverse nudging coefficients','day-1','xi_rho eta_rho s_rho'});
nc_addvar(newFile,dum);

dum.Name = 'tracer_NudgeCoef';
dum.Nctype = 'double';
dum.Dimension = {'s_rho', 'eta_rho','xi_rho'};
dum.Attribute = struct('Name',{'long_name','units','coordinates'},'Value',{'generic tracer inverse nudging coefficients','day-1','xi_rho eta_rho s_rho'});
nc_addvar(newFile,dum);

dum.Name = 'temp_NudgeCoef';
dum.Nctype = 'double';
dum.Dimension = {'s_rho', 'eta_rho','xi_rho'};
dum.Attribute = struct('Name',{'long_name','units','coordinates'},'Value',{'temp inverse nudging coefficients','day-1','xi_rho eta_rho s_rho'});
nc_addvar(newFile,dum);

dum.Name = 'salt_NudgeCoef';
dum.Nctype = 'double';
dum.Dimension = {'s_rho', 'eta_rho','xi_rho'};
dum.Attribute = struct('Name',{'long_name','units','coordinates'},'Value',{'salt inverse nudging coefficients','day-1','xi_rho eta_rho s_rho'});
nc_addvar(newFile,dum);



%% Make a sigmoid IN DAYS^-1
% % deprecate
% 
% % x direction
% 
% a=1;
% myX = [1:30];
% LHS =  1 - (1./(1+exp(-a*(myX-10))))  + .001;
% fig(1);clf;
% plot(myX,LHS)
% fig((shift-1));clf;
% plot(myX,1./LHS)
% LHS(1);
% LHS(10)
% 
% myX = [nx-30:nx];
% RHS = 1 -  ( 1-1./(1+exp(-a*(myX-nx+9))) )  + .001;
% fig(2);clf;
% plot(myX,RHS)
% fig(shift);clf;
% plot(myX,1./RHS)
% RHS(end);
% RHS(end-9)
% 
% myX = [1:nx];
% sigX = 2 - ( 1./(1+exp(-a*(myX-10))) + 1-1./(1+exp(-a*(myX-nx+9))) )  + .001;
% fig(3);clf;
% plot(myX,sigX)
% fig(13);clf;
% plot(myX,1./sigX)
% 
% 
% 
% myY = [1:ny];
% sigY = 2 - ( 1./(1+exp(-a*(myY-10))) + 1-1./(1+exp(-a*(myY-ny+9))) )  + .001;
% fig(4);clf;
% plot(myY,sigY)
% fig(14);clf;
% plot(myY,1./sigY)
% 
% 
% dum = zeros(ny,nx);
% for ii=1:nx; for jj=1:ny
%     dum(jj,ii) = max(sigX(ii),sigY(jj));
% end;end
% 
% dum3D = zeros(nz,ny,nx);
% for kk=1:nz
%     dum3D(kk,:,:) = dum;
% end;
% 
% fig(20);clf;
% pcolor(dum);shading flat;colorbar
% 
% fig(21);clf
% contour(grd.h)
% hold on 
% contour(dum)
% 
% fig(22);clf
% contour(grd.h)
% hold on 
% contour(1./dum)




%% Make a sigmoid IN DAYS

% x direction

shift=6;

a=2;
myX = [1:30];
LHS = 1000*(1./(1+exp(-a*(myX-shift)))) + 1 ;
fig(1);clf;
plot(myX,LHS);title('days')
% fig((shift-1));clf;
% plot(myX,1./LHS)
LHS(1);
LHS(shift)

myX = [nx-30:nx];
RHS =  1000*( 1-1./(1+exp(-a*(myX-nx+ (shift-1) ))) )  + 1;
fig(2);clf;
plot(myX,RHS);title('days')
fig(shift);clf;
plot(myX,1./RHS);title('inverse days')
RHS(end);
RHS(end-(shift-1))

myX = [1:nx];
sigX = 1000*( 1./(1+exp(-a*(myX-shift))) + 1-1./(1+exp(-a*(myX-nx+(shift-1)))) ) -1000 +1;
fig(3);clf;
plot(myX,sigX);title('days')
fig(13);clf;
plot(myX,1./sigX);title('inverse days')



myY = [1:ny];
sigY = 1000*( 1./(1+exp(-a*(myY-shift))) + 1-1./(1+exp(-a*(myY-ny+(shift-1)))) )-1000  + 1;
fig(4);clf;
plot(myY,sigY);title('days')
fig(14);clf;
plot(myY,1./sigY);title('inverse days')


nudX = 1./sigX;
nudY = 1./sigY;


dum = zeros(ny,nx);
for ii=1:nx; for jj=1:ny
    dum(jj,ii) = max(nudX(ii),nudY(jj));
end;end

dum3D = zeros(nz,ny,nx);
for kk=1:nz
    dum3D(kk,:,:) = dum;
end;

fig(20);clf;
pcolor(dum);shading flat;colorbar

fig(21);clf
contour(grd.h)
hold on 
contour(dum)
title('inverse days')

fig(22);clf
contour(grd.h)
hold on 
contour(1./dum)
title('days')





%% fill in the fields


% 2D

nc_varput(newFile,'M2_NudgeCoef',dum);

% 3D

nc_varput(newFile,'M3_NudgeCoef',dum3D);
nc_varput(newFile,'tracer_NudgeCoef',dum3D);
nc_varput(newFile,'temp_NudgeCoef',dum3D);
nc_varput(newFile,'salt_NudgeCoef',dum3D);


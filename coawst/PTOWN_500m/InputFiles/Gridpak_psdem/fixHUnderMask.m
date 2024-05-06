file = 'PTOWN_500m.nc';

hraw = nc_varget(file,'hraw');
mask = nc_varget(file,'mask_rho');
[nraw,ny,nx] = size(hraw);

%%


fig(1);clf;pcolor(sq(hraw(end,:,:)));shading flat;colorbar

fig(2);clf;pcolor(mask);shading flat;colorbar

sq(hraw(2,:,:));hmin = min(ans(:))

for nn=2:nraw
    dum = sq(hraw(nn,:,:));
    fig(97);clf;pcolor(dum);shading flat;colorbar;caxis([0,50])
    dum = dum .* mask;
    
    fig(98);clf;pcolor(dum);shading flat;colorbar;caxis([0,50])
    dum(dum == 0) = hmin;
    fig(99);clf;pcolor(dum);shading flat;colorbar;caxis([0,50])
    hraw(nn,:,:) = dum;
end;

fig(11);clf;pcolor(sq(hraw(1,:,:)));shading flat;colorbar;caxis([0,5])
fig(12);clf;pcolor(sq(hraw(2,:,:)));shading flat;colorbar;caxis([0,5])

nc_varput(file,'hraw',hraw);


%% WET_DRY version

% wetDryFile = 'HC_100mME_wetDry.nc';
% unix(['cp ',file,' ',wetDryFile]);
% 
% h = h .* mask;
% h(h == 0) = -5;
% 
% fig(4);clf;pcolor(h);shading flat
% h(1,1)
% 
% 
% nc_varput(wetDryFile,'h',h);
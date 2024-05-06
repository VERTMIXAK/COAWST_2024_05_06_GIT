gridBrian = './fleat_outer_grid.nc';
gridPALAU_800m = '~/coawst/PALAU_800m/InputFiles/Gridpak/PALAU_800m.nc';

lonRhoBrian = nc_varget(gridBrian     ,'lon_rho');
lonRhoLocal = nc_varget(gridPALAU_800m,'lon_rho');

latRhoBrian = nc_varget(gridBrian     ,'lat_rho');
latRhoLocal = nc_varget(gridPALAU_800m,'lat_rho');

lonLL=lonRhoLocal(1,1)
lonLR=lonRhoLocal(1,end)
lonUL=lonRhoLocal(end,1)
lonUR=lonRhoLocal(end,end)

latLL=latRhoLocal(1,1)
latLR=latRhoLocal(1,end)
latUL=latRhoLocal(end,1)
latUR=latRhoLocal(end,end)

dum = sqrt( (lonRhoBrian - lonLL).^2 + (latRhoBrian - latLL).^2);
[min_num, min_idx] = min(dum(:));
[jLL,iLL] = ind2sub(size(dum),find(dum == min_num))

dum = sqrt( (lonRhoBrian - lonUR).^2 + (latRhoBrian - latUR).^2);
[min_num, min_idx] = min(dum(:));
[jUR,iUR] = ind2sub(size(dum),find(dum == min_num))

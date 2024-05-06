clear;
fileF = '../fLonLat.nc';
lon   = nc_varget(fileF,'lon_psi');
lat   = nc_varget(fileF,'lat_psi');

dirs = {'NORSELBE_2km_2020_245_mesoNoTides/',			...
	'NORSELBE_2km_2020_245_mesoNoTides_TSM2M3nudg/',           ...
	'NORSELBE_2km_2021_244_mesoNoTides/',           ...
	'NORSELBE_2km_2021_244_mesoNoTides_TSM2M3nudg/',           ...
	'NORSELBE_2km_2022_305_mesoNoTides/',           ...
	'NORSELBE_2km_2022_305_mesoNoTides_TSM2M3/',           ...
	'NORSELBE_2km_2023_305_mesoNoTides/',           	...
	'NORSELBE_2km_2023_305_mesoNoTides_TS_M2M3/'          
	}

aaa=5;

outDirs = {'2020_sep/',		           ...
	'2020_sep_nudg/',           ...
	'2021_sepOct/',          ...
	'2021_sepOct_nudg/',           ...
	'2022_novDec/',           ...
	'2022_novDec_nudg/',           ...
	'2023_nov/',           ...
	'2023_nov_nudg/'           
	}

for nn=1:length(outDirs)
    fileR = [dirs(nn),'rvortPlot/rvortOverF.nc'];
    rv  = nc_varget(fileR,'rvortOverF');
    [nt,ny,nx] = size(rv)
end;


% fileR = 'rvortOverF.nc';
% fileF = '../../fLonLat.nc';
% 
% lon   = nc_varget(fileF,'lon_psi');
% lat   = nc_varget(fileF,'lat_psi');
% 
% rv  = nc_varget(fileR,'rvortOverF');
% 
% [nt,ny,nx] = size(rv);
% 
% 
% % Make some plots
% 
% % fig(1);clf;
% % pcolor(lon,lat,sq(rv(end,:,:)));shading flat
% % caxis([-.5,.5]*1);colorbar;colormap(gray)
% 
% fig(2);clf;
% for tt=1:nt
%     pcolor(lon,lat,sq(rv(tt,:,:)));shading flat
% caxis([-.5,.5]*1);colorbar;colormap(gray)
% title([num2str(tt),'/',num2str(nt),'   day ',num2str(floor(tt/24)+1)])
% pause(.01)
% end;
%     

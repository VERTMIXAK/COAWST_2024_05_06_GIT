clear;
fileF = '../../fLonLat.nc';
lon   = nc_varget(fileF,'lon_psi');
lat   = nc_varget(fileF,'lat_psi');

% exptName = {'NORSELBE_2km_2020_245_mesoNoTides/',			...
% 	'NORSELBE_2km_2020_245_mesoNoTides_TSM2M3nudg/',           ...
% 	'NORSELBE_2km_2021_244_mesoNoTides/',           ...
% 	'NORSELBE_2km_2021_244_mesoNoTides_TSM2M3nudg/',           ...
% 	'NORSELBE_2km_2022_305_mesoNoTides/',           ...
% 	'NORSELBE_2km_2022_305_mesoNoTides_TSM2M3/',           ...
% 	'NORSELBE_2km_2023_305_mesoNoTides/',           	...
% 	'NORSELBE_2km_2023_305_mesoNoTides_TS_M2M3/'          
% 	};

% outDirs = {'2020-09-01/',		           ...
% 	'2020-09-01_nudg/',           ...
% 	'2021-09-01/',          ...
% 	'2021-09-01_nudg/',           ...
% 	'2022-11-01/',           ...
% 	'2022-11-01_nudg/',           ...
% 	'2023-11-01/',           ...
% 	'2023-11-01_nudg/'           
% 	};

[~,exptName] = unix('pwd | rev | cut -d "/" -f2 | rev')
exptName = exptName(1:end-1);

cUnix = 2208960000;

outDir = ['/import/VERTMIX/NORSELBE_2km/',exptName];


    exptName
    fileR ='rvortOverF.nc';

    % Make the destination directory if is doesn't already exist
    [outDir,exptName];
    if ~exist(outDir)
        'outDir does not exist'
        mkdir(outDir);
        mkdir([outDir,'/rvortPlots']);
    end;
     
    rv  = nc_varget(fileR,'rvortOverF');
    times = nc_varget(fileR,'ocean_time');
    [nt,ny,nx] = size(rv);
    for tt=1:24:nt
        
        tSnap = datestr( times(tt)/86400 + datenum(1900,1,1) );
        
        pcolor(lon,lat,sq(rv(tt,:,:)));shading flat
        caxis([-.5,.5]*1);colorbar;colormap(gray)
        title([exptName,'  rvort/f  ',tSnap],'Interpreter','none')
        xlabel(['deg E']);ylabel(['deg N'])
%         title([exptName,'  rvort/f   day ',num2str(floor(tt/24)+1)],'Interpreter','none')
        outName = sprintf('snap_%03d.png',floor(tt/24)+1)
%         ['rvortOverF_snapshot_day',num2str(floor(tt/24)+1),'.jpg']
        print([outDir,'/rvortPlots/',outName],'-dpng');
        aaa=5;

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

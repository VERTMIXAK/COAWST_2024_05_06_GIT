clear all;close all
tabwindow

tmp=load('../../InputFiles/cruiseData/freya_nors23_tbdGRIDDED.mat')
% tmp=load('../../../InputFiles/cruiseData/freya_nors23_tbdGRIDDED.mat')
Pi = tmp.freya(1).prsHALFMETER;
NT = length(tmp.freya);

for ii = 1:NT
    freya_hr.dnum0(ii)  = nanmean(tmp.freya(ii).tim);
    freya_hr.lon0(ii)   = nanmean(tmp.freya(ii).lonHALFMETER);
    freya_hr.lat0(ii)   = nanmean(tmp.freya(ii).latHALFMETER);
    freya_hr.T    (:,ii) = tmp.freya(ii).temHALFMETER;
    freya_hr.S    (:,ii) = tmp.freya(ii).salHALFMETER;
end
whos Pi dnum T;skip=10;
t0 = min(tmp.tim);t0 = max(tmp.tim);
freya_hr.Pi = Pi;clear Pi tmp tdx* t0* t1* ii skip dnum* lon0 lat0 NT D* S T P;
whos;

%%

gridFile = './util/NORSE1D_5km.nc';
HISFile  = './util/IC.nc';

% gridFile = '../util/NORSE1D_5km.nc';
% HISFile  = '../util/IC.nc';

grd = roms_get_grid(gridFile,HISFile,0,1);

% Choose the cast number

nn=1015;

% nn=1015

% Get the data for this cast
freya_hr.lon0(nn);
freya_hr.lat0(nn);
Tcruise = flipud(freya_hr.T(:,nn));
Scruise = flipud(freya_hr.S(:,nn));
zcruise = flipud(-freya_hr.Pi);

castDate = datestr(freya_hr.dnum0(nn),30)
castDate2 = cellstr(castDate);

hour = str2num(castDate(10:11))
min  = str2num(castDate(12:13))
sec  = str2num(castDate(14:15))

timeOrig = hour + min/60 + sec/3600
time = round(timeOrig)/24







% Write data to file
fileID = fopen('latlon.txt','w');
fprintf(fileID,'%5s %23.4f\n','lon',freya_hr.lon0(nn));
fprintf(fileID,'%5s %23.4f\n','lat',freya_hr.lat0(nn));
fprintf(fileID,'%c',castDate);
fprintf(fileID,'\n');
fprintf(fileID,'%20s %30.12f\n','timeOfDay',time);
fclose(fileID);





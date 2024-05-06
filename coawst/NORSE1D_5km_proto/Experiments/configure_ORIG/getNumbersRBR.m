clear all;close all
tabwindow

tmp=load('../../InputFiles/cruiseData/RBR.mat')

[nz,NT] = size(tmp.C.T)
Pi = tmp.C.z;

% for ii = 1:NT
    rbr_hr.dnum0 = tmp.C.dn;
    rbr_hr.lon0  = tmp.C.lon;
    rbr_hr.lat0  = tmp.C.lat;
    rbr_hr.T     = tmp.C.T;
    rbr_hr.S     = tmp.C.SP;
% end
whos Pi dnum T;skip=10;
% t0 = min(tmp.tim);t0 = max(tmp.tim);
rbr_hr.Pi = Pi;clear Pi tmp tdx* t0* t1* ii skip dnum* lon0 lat0 NT D* S T P;
whos;

%%

gridFile = './util/NORSE1D_5km.nc';
HISFile  = './util/IC.nc';

% gridFile = '../util/NORSE1D_5km.nc';
% HISFile  = '../util/IC.nc';

grd = roms_get_grid(gridFile,HISFile,0,1);

% Choose the cast number

nn=0200;

% nn=1015

% Get the data for this cast
rbr_hr.lon0(nn);
rbr_hr.lat0(nn);
Tcruise = flipud(rbr_hr.T(:,nn));
Scruise = flipud(rbr_hr.S(:,nn));
zcruise = flipud(-rbr_hr.Pi);

castDate = datestr(rbr_hr.dnum0(nn),30)
castDate2 = cellstr(castDate);

hour = str2num(castDate(10:11))
min  = str2num(castDate(12:13))
sec  = str2num(castDate(14:15))

timeOrig = hour + min/60 + sec/3600
time = round(timeOrig)/24







% Write data to file
fileID = fopen('latlon.txt','w');
fprintf(fileID,'%5s %23.4f\n','lon',rbr_hr.lon0(nn));
fprintf(fileID,'%5s %23.4f\n','lat',rbr_hr.lat0(nn));
fprintf(fileID,'%c',castDate);
fprintf(fileID,'\n');
fprintf(fileID,'%20s %30.12f\n','timeOfDay',time);
fclose(fileID);





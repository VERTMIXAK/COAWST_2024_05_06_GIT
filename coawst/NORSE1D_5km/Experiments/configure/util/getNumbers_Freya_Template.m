clear all;close all
tabwindow

tmp=load('../../InputFiles/cruiseData/freya_nors23_tbdGRIDDED.mat')
NT = length(tmp.freya);

for ii = 1:NT
    freya_hr.dnum0(ii)  = nanmean(tmp.freya(ii).tim);
    freya_hr.lon0(ii)   = nanmean(tmp.freya(ii).lonHALFMETER);
    freya_hr.lat0(ii)   = nanmean(tmp.freya(ii).latHALFMETER);
end


% Choose the cast number
nn=XXX;

% Get the data for this cast

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





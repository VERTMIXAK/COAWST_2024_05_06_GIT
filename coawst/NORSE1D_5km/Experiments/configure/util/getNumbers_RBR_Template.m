clear all;close all
tabwindow

tmp=load('../../InputFiles/cruiseData/RBR.mat')

rbr_hr.dnum0 = tmp.C.dn;    
rbr_hr.lon0  = tmp.C.lon;    
rbr_hr.lat0  = tmp.C.lat;
rbr_hr.T     = tmp.C.T;    
rbr_hr.S     = tmp.C.SP;


% Choose the cast number

nn=0205;

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





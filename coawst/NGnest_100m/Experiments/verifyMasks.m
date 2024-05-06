iniFile = '../InputFiles/Automate/BC_IC/ini_parent/myINI.nc';
hisFile = 'NGnest_100m_2023-10-29_mesoNoNesting_parent/netcdfOutput/ng_his_00001.nc';

maskUini = nc_varget(iniFile,'mask_u');
fig(1);pcolor(maskUini);shading flat;title('maskUini');

maskUhis = nc_varget(hisFile,'mask_u');
fig(2);pcolor(maskUhis);shading flat;title('maskUhis');
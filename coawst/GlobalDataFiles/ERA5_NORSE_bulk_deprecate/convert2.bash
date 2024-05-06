#!/bin/bash

source ~/.runPycnal

newDir=ERA5forcing

#\rm $newDir/*

oldDir=site1


newFile=ERA5_2022_swradNET.nc

ncks -v msdwswrf $oldDir/multi_2022.nc $newDir/$newFile
ncap2 -O -s 'time=double(time)' $newDir/$newFile $newDir/$newFile
python settime.py $newDir/$newFile
ncatted -O -a units,time,o,c,"days since 1900-01-01 00:00:00" $newDir/$newFile
ncrename -O -h -d time,srf_time $newDir/$newFile
ncrename -O -h -v time,srf_time $newDir/$newFile
ncrename -O -h -d latitude,lat $newDir/$newFile
ncrename -O -h -d longitude,lon $newDir/$newFile
ncrename -O -h -v latitude,lat $newDir/$newFile
ncrename -O -h -v longitude,lon $newDir/$newFile
ncrename -O -h -v msdwswrf,swrad $newDir/$newFile
ncatted -O -a units,swrad,o,c,"W m-2" $newDir/$newFile

exit

newFile=ERA5_2022_lwrad_down.nc

ncks -v msdwlwrf $oldDir/*.nc $newDir/$newFile
ncap2 -O -s 'time=double(time)' $newDir/$newFile $newDir/$newFile
python settime.py $newDir/$newFile
ncatted -O -a units,time,o,c,"days since 1900-01-01 00:00:00" $newDir/$newFile
ncrename -O -h -d time,lrf_time $newDir/$newFile
ncrename -O -h -v time,lrf_time $newDir/$newFile
ncrename -O -h -d latitude,lat $newDir/$newFile
ncrename -O -h -d longitude,lon $newDir/$newFile
ncrename -O -h -v latitude,lat $newDir/$newFile
ncrename -O -h -v longitude,lon $newDir/$newFile
ncrename -O -h -v msdwlwrf,lwrad_down $newDir/$newFile
ncatted -O -a units,lwrad_down,o,c,"W m-2" $newDir/$newFile






newFile=ERA5_2022_rain.nc

ncks -v tp $oldDir/*.nc $newDir/$newFile
ncap2 -O -s 'time=double(time)' $newDir/$newFile $newDir/$newFile
python settime.py $newDir/$newFile
ncatted -O -a units,time,o,c,"days since 1900-01-01 00:00:00" $newDir/$newFile
ncrename -O -h -d time,rain_time $newDir/$newFile
ncrename -O -h -v time,rain_time $newDir/$newFile
ncrename -O -h -d latitude,lat $newDir/$newFile
ncrename -O -h -d longitude,lon $newDir/$newFile
ncrename -O -h -v latitude,lat $newDir/$newFile
ncrename -O -h -v longitude,lon $newDir/$newFile
ncrename -O -h -v tp,rain $newDir/$newFile
ncatted -O -a units,rain,o,c,"kg m-2 s-1" $newDir/$newFile
python convertRain.py $newDir/$newFile


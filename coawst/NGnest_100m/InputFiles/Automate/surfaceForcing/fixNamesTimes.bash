#!/bin/bash

source ~/.runROMSintel

# The dates are specified in the dates.txt file

year=`head -1 ../dates.txt | cut -d '-' -f1`
echo $year

names=("Pair" "Qair" "Tair" "lwrad_down" "swrad_up" "swrad_down" "Uwind" "Vwind" )
times=("pair_time" "qair_time" "tair_time"  "lrf_time" "srf_time" "srf_time" "wind_time" "wind_time" )

#: <<'BLOCK'

for nn in `seq 0 7`
#for nn in `seq 0 0`
do
    name=${names[$nn]}
    time=${times[$nn]}

    echo ${names[$nn]} ${times[$nn]}

#    file="NAM_"$name"_"$year".nc_ORIG"
#    file00="NAM_"$name"_"$year".nc_ORIG00"
#    file18="NAM_"$name"_"$year".nc_ORIG18"
    file="NAM_"$name".nc_ORIG"
    file00="NAM_"$name".nc_ORIG00"
    file01="NAM_"$name".nc_ORIG01"
    file18="NAM_"$name".nc_ORIG18"

#    ncks -O -v $time,$name,lat,lon     $file $file
#
#    baseTime=`ncdump -h $file |grep "time:units" |rev | cut -d ' ' -f2 | rev | cut -d 'T' -f1`
#    baseDays=`grep $baseTime /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
#    echo "baseTime $baseTime    baseDays $baseDays"
#
#    ncatted -O -a units,$time,o,c,"days since 1900-01-01 00:00:00" $file
#
#    source ~/.runPycnal
#    python settime.py $file $time $baseDays
#    source ~/.runROMSintel

	ncrcat $file00 $file01 $file18 $file 

done

#BLOCK



source ~/.runPycnal
echo "about to do T"
#python Kelvin2Celsius.py                NAM_Tair_$year.nc_ORIG
#ncatted -O -a units,Tair,o,c,"C"        NAM_Tair_$year.nc_ORIG
#ncatted -O -a valid_range,Tair,d,,	NAM_Tair_$year.nc_ORIG
python Kelvin2Celsius.py     			NAM_Tair.nc_ORIG
ncatted -O -a units,Tair,o,c,"C"     	NAM_Tair.nc_ORIG
ncatted -O -a valid_range,Tair,d,,    	NAM_Tair.nc_ORIG


echo "done with T"
source ~/.runROMSintel


module purge
. /etc/profile.d/modules.sh  
module load matlab/R2013a

matlab -nodisplay -nosplash < newContainer.m
matlab -nodisplay -nosplash < newContainerRain.m

cp NAM_swrad_up.nc NAM_swradNet.nc
ncrename -v swrad_up,swrad NAM_swradNet.nc

matlab -nodisplay -nosplash < make_swrad_net.m


\rm *ORIG*

echo ''

#!/bin/bash

source ~/.runROMSintel

# The dates are specified in the dates.txt file

dum=`head dates.txt | cut -d ',' -f1`        
now=`date -d $dum "+%Y%m%d"`
echo "now     " $now
        
nowP1=`date -d "$dum +1 days" "+%Y%m%d"`
echo "nowPlus1" $nowP1

names=("Uwind"     "Vwind"     "lwrad_down" "lhflux"	  "Tair"      "swrad"    "Qair"      "sensible"      "latent"      "swrad_up"  "Pair"      "rain")
times=("wind_time" "wind_time" "lrf_time"   "lhflux_time" "tair_time" "srf_time" "qair_time" "sensible_time" "latent_time" "srf_time"  "pair_time" "rain_time")

source ~/.runPycnal
python Kelvin2Celsius.py                GFS_Tair*.nc_ORIG
ncatted -O -a units,Tair,o,c,"C"        GFS_Tair*.nc_ORIG
ncatted -O -a valid_range,Tair,d,,		GFS_Tair*.nc_ORIG
echo "done with T"
source ~/.runROMSintel


#for nn in `seq 0 4`
for nn in `seq 0 11`
#for nn in `seq 5 5`
do
 	echo "nn " $nn
	name=${names[$nn]}
    time=${times[$nn]}

    echo ${names[$nn]} ${times[$nn]}


	for file in `ls GFS_"$name"_2*.nc_ORIG`
	do
		echo "file $file"
		now=`echo $file | cut -d '.' -f1 | cut -d '_' -f3`	
		echo $now

#	    file="GFS_"$name"_"$now".nc_ORIG"
	    ncks -O -v $time,$name,lat,lon     $file $file
	
	    baseTime=`ncdump -h $file |grep "time:units" |rev | cut -d ' ' -f2 | rev | cut -d 'T' -f1`
	    baseDays=`grep $baseTime /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
	    echo "baseTime $baseTime    baseDays $baseDays"
	
	    ncatted -O -a units,$time,o,c,"days since 1900-01-01 00:00:00" $file

	    source ~/.runPycnal
	    python settime.py $file $time $baseDays
	    source ~/.runROMSintel

	done

done


module purge
. /etc/profile.d/modules.sh  
module load matlab/R2013a
matlab -nodisplay -nosplash < newContainer.m

#exit

#archiveDir='/import/VERTMIX/NORSE_extendedBB_2022-2023/GFS_surface_forcing/'
archiveDir='./data'

mv GFS_sensible*.nc     $archiveDir/sensible
mv GFS_latent*.nc     $archiveDir/latent

mv GFS_lhflux*.nc     	$archiveDir/lhflux
mv GFS_lwrad_down*.nc 	$archiveDir/lwrad_down
mv GFS_Qair*.nc       	$archiveDir/Qair
mv GFS_swrad_2*.nc   	$archiveDir/swrad
mv GFS_Tair*.nc       	$archiveDir/Tair
mv GFS_Uwind*.nc      	$archiveDir/Uwind
mv GFS_Vwind*.nc      	$archiveDir/Vwind
mv GFS_swrad_up_2*.nc   $archiveDir/swrad_up
mv GFS_Pair*.nc	 		$archiveDir/Pair
mv GFS_rain*.nc  		$archiveDir/rain

\rm *.nc_ORIG
cd $archiveDir
/bin/bash finishUp.bash



exit


#!!!!!!!!!! Double check typical size
sizeTarget="120K"

archiveDir='/import/VERTMIX/NORSE2023_SA/GFS_surface_forcing/'
for file in `ls G*.nc`
do
#	size=`\ls -lh $file | cut -c 31-34`
#	echo $size
#	if [[ "$size" == "$sizeTarget" ]]
#	then
#		echo "strings are equal"
		mv $file $archiveDir
#	else
#		echo "file size is wrong"
#	fi
done

#\rm out* GFS*ORIG *.tmp *.nc





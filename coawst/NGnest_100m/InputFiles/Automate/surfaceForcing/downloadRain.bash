#!/bin/bash

source ~/.runROMSintel

# The dates are specified in the dates.txt file

window=146
hours=( $(seq -w 000 3 $window))
nSnapshots=${#hours[@]}
echo "nSnapshots = $nSnapshots"

urlFile=url.txt

name="rain"
time="rain_time"
longName="Precipitation_rate_surface"

latMin=30
latMax=50
lonMin=-80
lonMax=-65

\rm out_*.nc GFS*

#while read line
#do

line=`cat ../dates.txt | head -1`
#echo $line

	year=`echo $line | cut -d '-' -f1`
	echo $year
	dum=`echo $line | cut -d ',' -f1`
	now=`date -d $dum "+%Y%m%d"`
	echo $now

    for ((ii=0;ii<$nSnapshots;ii+=1));
	do
		outFile="out_"$now"_${hours[$ii]}.nc"

		#part1="https://rda.ucar.edu/thredds/ncss/grid/files/g/ds084.1/$year/"
		part1="https://thredds.rda.ucar.edu/thredds/ncss/grid/files/g/ds084.1/$year/"

		part2="$now/gfs.0p25."
		part3=$now"00.f"
		part4="${hours[$ii]}.grib2?var=$longName&north=$latMax&west=$lonMin&east=$lonMax&south=$latMin&horizStride=1&time_start="
		datePlus=`date -d "$now + ${hours[$ii]} hours" "+%Y-%m-%dT%H:%M:%S"`
		part5=$datePlus"Z&time_end="
		part6=$datePlus"Z&timeStride=1&vertStride=1&accept=netcdf3&addLatLon=true"
		echo $part1$part2$part3$part4$part5$part6 > $urlFile

		echo $ii " of " $nSnapshots

		wget --no-check-certificate -O $outFile -i $urlFile

		if [ -s $outFile ];then
			timeVar=`ncdump -h $outFile | grep time | head -1 |   tr -d '\t' | cut -d ' ' -f1`
#			boundsVar=`ncdump -h $outFile | grep double | grep _ | cut -d '(' -f1 | rev | cut -d ' ' -f1 | rev`
#			echo "time_bounds variable " $boundsVar
#			echo "length" ${#boundsVar}

#			if [ ${#boundsVar} -gt 0 ];then
#				echo "found extra dimension"
#				ncks -O -x -v $boundsVar $outFile $outFile
#			fi


			echo "timeVar $timeVar"
			echo "time $time"
			echo "outFile $outFile"

   			ncrename -O -h -d $timeVar,$time   	$outFile
			ncrename -O -h -v $timeVar,$time 	$outFile
			ncrename -O -h -v $longName,$name	$outFile
			#ncks -O -v $time,$name,latitude,longitude $outFile $outFile

			ncks --mk_rec_dmn $time -O   $outFile $outFile
			echo "good download"

		else
			\rm $outFile
		fi


	done
#done < ../dates.txt

source ~/.runPycnal

outName="GFS_"$name".nc_ORIG"
echo "outName $outName"

ncrcat out*.nc						$outName
\rm out*.nc

ncrename -O -h -d latitude,lat   	$outName
ncrename -O -h -d longitude,lon  	$outName
ncrename -O -h -v latitude,lat   	$outName
ncrename -O -h -v longitude,lon   	$outName
ncks     -O -v $time,$name,lat,lon  $outName $outName


baseTime=`ncdump -h $outName |grep "time:units" |rev | cut -d ' ' -f2 | rev | cut -d 'T' -f1`
baseDays=`grep $baseTime /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
echo "baseTime $baseTime    baseDays $baseDays"

python settime00.py $outName $time $baseDays
ncatted -O -a units,$time,o,c,"days since 1900-01-01 00:00:00" $outName


#!/bin/bash

source ~/.runPycnal
# The dates are specified in the dates.txt file

window=23
hours=( $(seq -w 0 3 $window))
echo "hours" $hours
nSnapshots=${#hours[@]}
echo "nSnapshots = $nSnapshots"

urlFile=url.txt

year=`head -1 ../dates.txt | cut -d '-' -f1`
echo "year = " $year

#\rm NAM* out* url*


names=("Pair" "Qair" "Tair" "lwrad_down" "swrad_up" "swrad_down" "Uwind" "Vwind" "albedo" )
times=("pair_time" "qair_time" "tair_time" "lrf_time" "srf_time" "srf_time" "wind_time" "wind_time" )

longNames=names
longNames[0]="Pressure_surface"
longNames[1]="Specific_humidity_height_above_ground"
longNames[2]="Temperature_height_above_ground"
longNames[3]="Downward_Long-Wave_Radp_Flux_surface"
longNames[4]="Upward_Short-Wave_Radiation_Flux_surface"
longNames[5]="Downward_Short-Wave_Radiation_Flux_surface"
longNames[6]="u-component_of_wind_height_above_ground"
longNames[7]="v-component_of_wind_height_above_ground"
longNames[8]="Albedo_surface"
longNames[9]="Total_cloud_cover_entire_atmosphere_single_layer"

latMin=30
latMax=50
lonMin=-80
lonMax=-65


for nn in `seq 0 7`
#for nn in `seq 0 0`
do
    name=${names[$nn]}
    time=${times[$nn]}
    longName=${longNames[$nn]}

    echo ${names[$nn]} ${times[$nn]} ${longNames[$nn]}

    while read line
    do

        dum=`echo $line | cut -d ',' -f1`
        now=`date -d $dum "+%Y%m%d"`
		month=`echo $now | cut -c 1-6`
        echo $now $month

        for ((ii=0;ii<$nSnapshots;ii+=1));
        do
            outFile="out_"$now"_${hours[$ii]}.nc"

            part1="https://www.ncei.noaa.gov/thredds/ncss/model-nam218/$month/"
            part2="$now/nam_218_"
            part3=$now"_0000_0"${hours[$ii]}".grb2?"
            part4="var=$longName&north=$latMax&west=$lonMin&east=$lonMax&south=$latMin&disableProjSubset=on&horizStride=1&time_start="
            datePlus=`date -d "$now" +%Y-%m-%d`"T"${hours[$ii]}"%3A00%3A00"
            part5=$datePlus"Z&time_end="
            part6=$datePlus"Z&timeStride=1&vertCoord=&addLatLon=true"
            echo $part1$part2$part3$part4$part5$part6 > $urlFile
            echo $part1$part2$part3$part4$part5$part6 

			echo $ii " of " $nSnapshots

#: <<'BLOCK'
            wget --no-check-certificate -O $outFile -i $urlFile

            if [ -s $outFile ];then
                timeVar=`ncdump -h $outFile | grep time | head -1 |   tr -d '\t' | cut -d ' ' -f1`
                boundsVar=`ncdump -h $outFile | grep double | grep _ | cut -d '(' -f1 | rev | cut -d ' ' -f1 | rev`
                echo "time_bounds variable " $boundsVar
                echo "length" ${#boundsVar}

                if [ ${#boundsVar} -gt 0 ];then

                    echo "found extra dimension"
                    ncks -O -x -v $boundsVar $outFile $outFile
                fi    

                   ncrename -O -h -d $timeVar,$time               $outFile
                ncrename -O -h -v $timeVar,$time             $outFile
                ncrename -O -h -v $longName,$name            $outFile
#                ncks -O -v $time,$name,latitude,longitude     $outFile $outFile

                ncks    --mk_rec_dmn $time -O               $outFile $outFile
                echo "good download"

# new stuff
				ncks -O -v $time,$name,lat,lon     $outFile $outFile

			    baseTime=`ncdump -h $outFile |grep "time:units" |rev | cut -d ' ' -f2 | rev | cut -d 'T' -f1`	
			    baseDays=`grep $baseTime /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`
			    echo "baseTime $baseTime    baseDays $baseDays"

				ncatted -O -a units,$time,o,c,"days since 1900-01-01 00:00:00" $outFile
		
#			    source ~/.runPycnal
			    python settime00.py $outFile $time $baseDays
#			    source ~/.runROMSintel


            else
                \rm $outFile
            fi

#BLOCK
        done
    done < ../dates.txt

    outName="NAM_"$name".nc_ORIG00"

    ncrcat out*.nc                            $outName
    ncrename -O -h -d y,lat           	$outName
    ncrename -O -h -d x,lon          	$outName

    \rm out*.nc

done



#/bin/bash fixNamesTimes.bash



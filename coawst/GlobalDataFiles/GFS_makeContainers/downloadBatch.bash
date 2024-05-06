#!/bin/bash

source ~/.runROMSintel

now=`cat dates.txt | head -1 | cut -d ',' -f1 | sed  "s/-//g"`
echo "now $now"

urlFile=url.txt


names=("Uwind"     "Vwind"     "lwrad_down" "lhflux" 	  "Tair"      "swrad"    "Qair"      "swrad_up" "sensible"      "latent"      "Pair"      "rain")
times=("wind_time" "wind_time" "lrf_time"   "lhflux_time" "tair_time" "srf_time" "qair_time" "srf_time" "sensible_time" "latent_time" "pair_time" "rain_time")

longNames=names

longNames[0]="u-component_of_wind_height_above_ground"
longNames[1]="v-component_of_wind_height_above_ground"
longNames[2]="Downward_Long-Wave_Radp_Flux_surface_6_Hour_Average"
longNames[3]="Latent_heat_net_flux_surface_3_Hour_Average"
longNames[4]="Temperature_height_above_ground"
longNames[5]="Downward_Short-Wave_Radiation_Flux_surface_3_Hour_Average"
longNames[6]="Specific_humidity_height_above_ground"
longNames[7]="Upward_Short-Wave_Radiation_Flux_surface_3_Hour_Average"
longNames[8]="Sensible_heat_net_flux_surface_3_Hour_Average"
longNames[9]="Latent_heat_net_flux_surface_3_Hour_Average"
longNames[10]="Pressure_surface"
longNames[11]="Precipitation_rate_surface"

latMin=-85
latMax=85
lonMin=-179
lonMax=179


###### do $now 

\rm GFS* out* *tmp

for nn in `seq 0 11`
#for nn in `seq 5 5`
#for nn in `seq 8 9`
do
    NOW=$now
    year=`echo $NOW | cut -c 1-4`
    echo "year " $year

    name=${names[$nn]}
    time=${times[$nn]}
    longName=${longNames[$nn]}

    echo "name      " ${names[$nn]}
    echo "time      " ${times[$nn]}
    echo "long name " ${longNames[$nn]}

    for hour in `seq -w 000 3 23`
    do
        outFile="out_"$NOW"_$hour.nc"
        echo "outFile " $outFile

        part1="https://thredds.rda.ucar.edu/thredds/ncss/grid/files/g/ds084.1/$year/"
        part2="$NOW/gfs.0p25."
        part3=$NOW"00.f"
        part4="$hour.grib2?var=$longName&north=$latMax&west=$lonMin&east=$lonMax&south=$latMin&horizStride=1&time_start="

        datePlus=`date -u -d "$NOW + $hour hour" "+%Y-%m-%dT%H:%M:%S"`
		echo "datePlus $datePlus"

		echo "NOW  " $NOW
		echo "hour " $hour    "hourPlus " $hourPlus

        part5=$datePlus"Z&time_end="
        part6=$datePlus"Z&timeStride=1&vertStride=1&accept=netcdf3&addLatLon=true"

        echo $part1$part2$part3$part4$part5$part6 > $urlFile



        while [ ! -f $outFile ]
        do
            wget -O $outFile -i $urlFile
        done

        if [ -s $outFile ]
        then
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
#           ncks -O -v $time,$name,latitude,longitude     $outFile $outFile
            ncks    --mk_rec_dmn $time -O               $outFile $outFile
            echo "good download"
        else
            \rm $outFile
        fi


    done



    outName="GFS_"$name"_"$NOW".nc_ORIG"

    ncrcat -O out*.nc                     	 $outName
    ncrename -O -h -d latitude,lat           $outName
    ncrename -O -h -d longitude,lon          $outName
    ncrename -O -h -v latitude,lat           $outName  
    ncrename -O -h -v longitude,lon           $outName 

    \rm out*.nc


done


/bin/bash fixNamesTimes.bash



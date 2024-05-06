#!/bin/bash

source ~/.runROMSintel

now=`date -d "yesterday" +"%Y%m%d"`
echo "now $now"

urlFile=url.txt
\rm GFS* out* url*

#names=("Pair"      "Qair"      "Tair"      "rain"      "lwrad_down" "swrad"    "Uwind"     "Vwind"     "albedo"      "cloud")
#times=("pair_time" "qair_time" "tair_time" "rain_time" "lrf_time"   "srf_time" "wind_time" "wind_time" "albedo_time" "cloud_time")

names=("Uwind"     "Vwind"     "lwrad_down" "lhflux" 	  "shflux")
times=("wind_time" "wind_time" "lrf_time"   "lhflux_time"  "shflux_time")

longNames=names

longNames[0]="u-component_of_wind_height_above_ground"
longNames[1]="v-component_of_wind_height_above_ground"
longNames[2]="Downward_Long-Wave_Radp_Flux_surface_6_Hour_Average"
longNames[3]="Latent_heat_net_flux_surface_3_Hour_Average"
longNames[4]="Sensible heat net flux (3_Hour Average) @ Ground or water surface"

#longNames[0]="Pressure_surface"
#longNames[1]="Specific_humidity_height_above_ground"
#longNames[2]="Temperature_height_above_ground"
#longNames[3]="Precipitation_rate_surface"
#longNames[4]="Downward_Long-Wave_Radp_Flux_surface_6_Hour_Average"
#longNames[5]="Downward_Short-Wave_Radiation_Flux_surface_3_Hour_Average"
#longNames[6]="u-component_of_wind_height_above_ground"
#longNames[7]="v-component_of_wind_height_above_ground"
#longNames[8]="Albedo_surface_6_Hour_Average"
#longNames[9]="Total_cloud_cover_entire_atmosphere_3_Hour_Average"

latMin=65
latMax=72.5
lonMin=-20
lonMax=10


#: <<'COMMENTBLOCK'

###### do $now - 1 day

#for nn in `seq 0 9`
for nn in `seq 0 3`
#for nn in `seq 0 0`
do
	NOW=`date -d "$now - 1 day" +"%Y%m%d"`
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
		datePlus=`date -d "$NOW + $hour hours" "+%Y-%m-%dT%H:%M:%S"`            
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
#   		ncks -O -v $time,$name,latitude,longitude     $outFile $outFile
          	ncks    --mk_rec_dmn $time -O               $outFile $outFile                
			echo "good download"        
		else              
			\rm $outFile  
		fi

        
	done
	
	outName="GFS_"$name"_"$NOW".nc_ORIG"

    ncrcat -O out*.nc                            $outName
    ncrename -O -h -d latitude,lat           $outName
    ncrename -O -h -d longitude,lon          $outName
    ncrename -O -h -v latitude,lat           $outName
    ncrename -O -h -v longitude,lon           $outName
    \rm out*.nc

done 


/bin/bash fixNamesTimes.bash



# COMMENTBLOCK

###### do $now 

\rm GFS* out*

#for nn in `seq 0 9`
for nn in `seq 0 4`
#for nn in `seq 0 0`
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

    for hour in `seq -w 000 3 96`
    do
        outFile="out_"$NOW"_$hour.nc"
        echo "outFile " $outFile

        part1="https://thredds.rda.ucar.edu/thredds/ncss/grid/files/g/ds084.1/$year/"
        part2="$NOW/gfs.0p25."
        part3=$NOW"00.f"
        part4="$hour.grib2?var=$longName&north=$latMax&west=$lonMin&east=$lonMax&south=$latMin&horizStride=1&time_start="
        datePlus=`date -d "$NOW + $hour hours" "+%Y-%m-%dT%H:%M:%S"`
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



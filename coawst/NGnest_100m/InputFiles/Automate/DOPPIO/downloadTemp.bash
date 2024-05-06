#!/bin/bash

\rm doppio*.nc
start=`head -1 ../dates.txt`

part1='http://tds.marine.rutgers.edu/thredds/ncss/roms/doppio/2017_da/his/runs/History_RUN_'

part2='?var=mask_rho&var=zeta&var=salt&var=temp&var=ubar_eastward&var=vbar_northward&var=u_eastward&var=v_northward'
part2a='&var=mask_psi&var=mask_u&var=mask_v&var=ssflux&var=sustr&var=svstr&var=AKs&var=AKt&var=AKv'
part2b='&var=shflux&var=ssflux&var=sustr&var=svstr'

#part3='&north='$latMax'&west='$lonMin'&east='$lonMax'&south='$latMin'&disableProjSubset=on&horizStride=1&time_start='
part3='&disableLLSubset=on&disableProjSubset=on&horizStride=1&time_start='

part4='&time_end='
part5='&timeStride=1&vertCoord=&addLatLon=true&accept=netcdf'

for nn in `seq 0 7`
#for nn in `seq 0 0`
do
	date=`date -d "$start + $nn day" +"%Y-%m-%d"`
	echo $date
	outName="doppio_$date.nc"
	echo $outName
	
    file=$date'T00:00:00Z'
	timeStamp1=$date'T00%3A00%3A00Z'
    timeStamp2=$date'T23%3A00%3A00Z'

	site=$part1$file$part2$part3$timeStamp1$part4$timeStamp2$part5
	echo $site > urlVerify.txt
    while [ ! -f $outName ]
    do
		wget --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --auth-no-challenge=on --keep-session-cookies --content-disposition $site -O $outName
	done

exit

done


bash tidyUpTemp.bash



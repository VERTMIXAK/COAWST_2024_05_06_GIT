#!/bin/bash

\rm DOPPIO_split/doppio*.nc

for file in `ls DOPPIO_modified`
do
	echo $file
	myDate=`echo $file | cut -d '_' -f2 | cut -d '.' -f1`
	echo $myDate
	
	nt=`ncdump -h DOPPIO_modified/$file  | grep UNLIMITED | cut -d '(' -f2 | cut -d ' ' -f1`
	nt=`echo " $nt - 1 " |bc`
	echo $nt	

	for tt in `seq -w 00 $nt`
	do	
		outFile="doppio_"$myDate"_"$tt".nc"
		echo $outFile	
		ncks -d ocean_time,$tt DOPPIO_modified/$file DOPPIO_split/$outFile
	done

done

cp "DOPPIO_split/"`ls DOPPIO_split | head -1` BC_IC/ini_parent/mySource.nc

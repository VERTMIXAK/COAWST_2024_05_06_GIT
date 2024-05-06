#!/bin/bash

\rm split/HIS*.nc

#file=`ls HIS* | head -1`
file='HIS.nc'

#	echo $file
#	myDate=`echo $file | cut -d '_' -f2 | cut -d '.' -f1`
#	echo $myDate
	
	nt=`ncdump -h $file  | grep UNLIMITED | cut -d '(' -f2 | cut -d ' ' -f1`
	nt=`echo " $nt - 1 " |bc`
	echo $nt	


	for tt in `seq -w 00 $nt`
	do	
#		outFile="HIS_"$myDate"_"$tt".nc"
     	outFile="HIS_"$tt".nc"
		echo $outFile	
		ncks -d ocean_time,$tt $file split/$outFile
	done


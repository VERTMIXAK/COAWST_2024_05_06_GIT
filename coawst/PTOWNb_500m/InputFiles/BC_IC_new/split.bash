#!/bin/bash

\rm scheduleForDeletion/*.nc

for file in `ls ./HIS_*`
do
	echo $file
	
	root=`echo $file | rev | cut -d '.' -f2-10 | cut -d '/' -f1 | rev`
	echo $root

	for tt in `seq -w 00 23`
	do	
     	outFile=$root"_"$tt".nc"
		echo $outFile	
		ncks -d ocean_time,$tt $file scheduleForDeletion/$outFile
	done

done

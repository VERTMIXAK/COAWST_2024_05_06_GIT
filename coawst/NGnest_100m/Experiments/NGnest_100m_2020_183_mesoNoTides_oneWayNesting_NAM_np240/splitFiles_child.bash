# do HIS2 files first
for file in `ls netcdfOutput/*his2*.nc`
do
	echo $file
	rootNew=`echo $file | cut -d '_' -f4 | cut -d '.' -f1`
	echo $rootNew

	nt=`ncdump -h $file  |grep UNLIMITED | cut -d '(' -f2 | cut -d ' ' -f1`
	echo "nt " $nt	
	nt=` echo " $nt - 1 " | bc`
	echo "nt " $nt

	for ii in `seq -w 0 $nt`
	do
		echo $rootNew"_"$ii
		echo "netcdfOutput_split_child/HIS2_"$rootNew"_"$ii".nc"
		ncks -d ocean_time,$ii  $file "netcdfOutput_split_child/HIS2_"$rootNew"_"$ii".nc"
	done
done

# new do HIS files first
for file in `ls netcdfOutput/*his_*.nc`
do
    echo $file
    rootNew=`echo $file | cut -d '_' -f4 | cut -d '.' -f1`
    echo $rootNew

    nt=`ncdump -h $file  |grep UNLIMITED | cut -d '(' -f2 | cut -d ' ' -f1`
    echo "nt " $nt
    nt=` echo " $nt - 1 " | bc`
    echo "nt " $nt

    for ii in `seq -w 00 $nt`
    do
      	echo $rootNew"_"$ii
#	echo "netcdfOutput_split_child/HIS_"$rootNew"_"$ii".nc"
        ncks -d ocean_time,$ii  $file "netcdfOutput_split_child/HIS_"$rootNew"_"$ii".nc"
    done
done

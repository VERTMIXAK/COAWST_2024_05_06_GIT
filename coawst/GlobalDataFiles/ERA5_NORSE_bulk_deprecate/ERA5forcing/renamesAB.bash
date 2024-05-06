destDir='/import/VERTMIX/NORSE_extendedBB_2022-2023/ERA5_surface_forcing'

source ~/.runPycnal

for file in `ls *a.nc`
do
	echo $file
	root=`echo $file | rev | cut -c 5-30 | rev`
	echo $root
	newFile=`echo $root".nc"`
	ncrcat $root?.nc $newFile
	echo $newFile
	\rm $root?.nc

	ncap2 -O -s 'time=double(time)' 	$newFile	$newFile
	python settime.py $newFile
	ncatted -O -a units,time,o,c,"days since 1900-01-01 00:00:00" $newFile
	ncrename -O -h -d latitude,lat 		$newFile
	ncrename -O -h -d longitude,lon 	$newFile
	ncrename -O -h -v latitude,lat 		$newFile
	ncrename -O -h -v longitude,lon 	$newFile	
done


for file in `ls lw*`
do
    echo $file
	ncrename -O -h -d time,lrf_time			$file
    ncrename -O -h -v time,lrf_time     	$file
    ncrename -O -h -v msdwlwrf,lwrad_down 	$file
done

for file in `ls Pair*`
do
    echo $file
    ncrename -O -h -d time,pair_time     	$file
    ncrename -O -h -v time,pair_time     	$file
    ncrename -O -h -v sp,Pair   			$file
done

for file in `ls rain*`
do
    echo $file
    ncrename -O -h -d time,rain_time    $file
    ncrename -O -h -v time,rain_time    $file
    ncrename -O -h -v mtpr,rain         $file
done
			
for file in `ls sensi*`
do
    echo $file
    ncrename -O -h -d time,sensible_time    $file
    ncrename -O -h -v time,sensible_time    $file
    ncrename -O -h -v sshf,sensible         $file
done

for file in `ls Qrel*`
do
    echo $file
    ncrename -O -h -d time,qair_time     $file
    ncrename -O -h -v time,qair_time     $file
    ncrename -O -h -v r,Qair            $file
done

for file in `ls Qsp*`
do
    echo $file
    ncrename -O -h -d time,qair_time     $file
    ncrename -O -h -v time,qair_time     $file
    ncrename -O -h -v q,Qair   			$file
done

for file in `ls SST*`
do
    echo $file
    ncrename -O -h -d time,sst_time     $file
    ncrename -O -h -v time,sst_time     $file
    ncrename -O -h -v sst,SST	     	$file
    python convertT.py $file SST
    ncatted -a units,SST,o,c,'Celsius'         $file
done

for file in `ls swr*`
do
    echo $file
    ncrename -O -h -d time,srf_time     $file
    ncrename -O -h -v time,srf_time     $file
    ncrename -O -h -v msnswrf,swrad   	$file
done

for file in `ls Tair*`
do
    echo $file
    ncrename -O -h -d time,tair_time     		$file
    ncrename -O -h -v time,tair_time     		$file
    ncrename -O -h -v t2m,Tair     				$file
    python convertT.py $file Tair
    ncatted -a units,Tair,o,c,'Celsius'         $file
done

for file in `ls Uw*`
do
    echo $file
    ncrename -O -h -d time,wind_time     $file
    ncrename -O -h -v time,wind_time     $file
    ncrename -O -h -v u10,Uwind     	$file
done

for file in `ls Vw*`
do
    echo $file
    ncrename -O -h -d time,wind_time     $file
    ncrename -O -h -v time,wind_time     $file
    ncrename -O -h -v v10,Vwind     	$file
done

mv *.nc $destDir

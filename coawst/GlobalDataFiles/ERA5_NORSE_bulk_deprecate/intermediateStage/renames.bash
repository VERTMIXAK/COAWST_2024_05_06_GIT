source ~/.runPycnal

for file in `ls *.nc`
do
	echo $file
	ncap2 -O -s 'time=double(time)' 	$file	$file
	python settime.py $file
	ncatted -O -a units,time,o,c,"days since 1900-01-01 00:00:00" $file
	ncrename -O -h -d latitude,lat 		$file
	ncrename -O -h -d longitude,lon 	$file
	ncrename -O -h -v latitude,lat 		$file
	ncrename -O -h -v longitude,lon 	$file	
done

for file in `ls lw*`
do
	ncrename -O -h -d time,lrf_time			$file
    ncrename -O -h -v time,lrf_time     	$file
    ncrename -O -h -v msdwlwrf,lwrad_down 	$file
done

for file in `ls Pair*`
do
    ncrename -O -h -d time,pair_time     	$file
    ncrename -O -h -v time,pair_time     	$file
    ncrename -O -h -v sp,Pair   			$file
done
			
for file in `ls Qair*`
do
    ncrename -O -h -d time,qair_time     $file
    ncrename -O -h -v time,qair_time     $file
    ncrename -O -h -v r,Qair   			$file
done

for file in `ls rain*`
do
    ncrename -O -h -d time,rain_time 	$file
    ncrename -O -h -v time,rain_time   	$file
    ncrename -O -h -v mtpr,rain   		$file
done

for file in `ls swr*`
do
    ncrename -O -h -d time,srf_time     $file
    ncrename -O -h -v time,srf_time     $file
    ncrename -O -h -v msnswrf,swrad   	$file
done

for file in `ls Tair*`
do
    ncrename -O -h -d time,tair_time     $file
    ncrename -O -h -v time,tair_time     $file
    ncrename -O -h -v t2m,Tair     		$file
#	python convertT.py					 $file
done

for file in `ls Uw*`
do
    ncrename -O -h -d time,wind_time     $file
    ncrename -O -h -v time,wind_time     $file
    ncrename -O -h -v u10,Uwind     	$file
done

for file in `ls Vw*`
do
    ncrename -O -h -d time,wind_time     $file
    ncrename -O -h -v time,wind_time     $file
    ncrename -O -h -v v10,Vwind     	$file
done


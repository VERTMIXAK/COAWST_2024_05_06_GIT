destDir='/import/VERTMIX/NORSE_extendedBB_2022-2023/ERA5_surface_forcing'

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
	mv $file $file"_ORIG"
done

for file in `ls laten*`
do
	echo $file
    ncrename -O -h -d time,latent_time         					$file
    ncrename -O -h -v time,latent_time         					$file
    ncrename -O -h -v slhf,latent   							$file
	ncatted -a coordinates,latent,o,c,"lon lat latent_time"		$file 
done

for file in `ls lw*`
do
    echo $file
	ncrename -O -h -d time,lrf_time								$file
    ncrename -O -h -v time,lrf_time     						$file
    ncrename -O -h -v msdwlwrfcs,lwrad_down 					$file
    ncatted -a coordinates,lwrad_down,o,c,"lon lat lrf_time"  	$file 	
done

for file in `ls Pair*`
do
    echo $file
    ncrename -O -h -d time,pair_time                             $file
    ncrename -O -h -v time,pair_time                             $file
    ncrename -O -h -v sp,Pair                     $file
    ncatted -a coordinates,Pair,o,c,"lon lat pair_time"    $file
done

for file in `ls rain*`
do
    echo $file
    ncrename -O -h -d time,rain_time    						$file
    ncrename -O -h -v time,rain_time   		 					$file
    ncrename -O -h -v mtpr,rain         						$file
    ncatted -a coordinates,rain,o,c,"lon lat rain_time"     	$file 
done
			
for file in `ls sensi*`
do
    echo $file
    ncrename -O -h -d time,sensible_time   	 					$file
    ncrename -O -h -v time,sensible_time    					$file
    ncrename -O -h -v sshf,sensible        	 					$file
    ncatted -a coordinates,sensible,o,c,"lon lat sensible_time"	$file 
done

for file in `ls Qrel*`
do
    echo $file
    ncrename -O -h -d time,qair_time     						$file
    ncrename -O -h -v time,qair_time     						$file
    ncrename -O -h -v r,Qair            						$file
    ncatted -a coordinates,Qair,o,c,"lon lat qair_time"     	$file 
done

for file in `ls Qsp*`
do
    echo $file
    ncrename -O -h -d time,qair_time     						$file
    ncrename -O -h -v time,qair_time     						$file
    ncrename -O -h -v q,Qair   									$file
    ncatted -a coordinates,Qair,o,c,"lon lat qair_time"     	$file 
done

for file in `ls SST*`
do
    echo $file
    ncrename -O -h -d time,sst_time     						$file
    ncrename -O -h -v time,sst_time     						$file
    ncrename -O -h -v sst,SST     								$file
    python convertT.py 											$file SST
    ncatted -a units,SST,o,c,'Celsius'         					$file
    ncatted -a coordinates,SST,o,c,"lon lat sst_time"    	 	$file 
done

for file in `ls swr*`
do
    echo $file
    ncrename -O -h -d time,srf_time     						$file
    ncrename -O -h -v time,srf_time     						$file
    ncrename -O -h -v msnswrfcs,swrad   						$file
    ncatted -a coordinates,swrad,o,c,"lon lat srf_time"     	$file 
done

for file in `ls Tair*`
do
    echo $file
    ncrename -O -h -d time,tair_time     						$file
    ncrename -O -h -v time,tair_time     						$file
    ncrename -O -h -v t2m,Tair     								$file
	python convertT.py 											$file Tair
	ncatted -a units,Tair,o,c,'Celsius'							$file
    ncatted -a coordinates,Tair,o,c,"lon lat tair_time"     	$file 
done

for file in `ls Uw*`
do
    echo $file
    ncrename -O -h -d time,wind_time     						$file
    ncrename -O -h -v time,wind_time     						$file
    ncrename -O -h -v u10,Uwind     							$file
    ncatted -a coordinates,Uwind,o,c,"lon lat wind_time"     	$file 
done

for file in `ls Vw*`
do
    echo $file
    ncrename -O -h -d time,wind_time     						$file
    ncrename -O -h -v time,wind_time     						$file
    ncrename -O -h -v v10,Vwind     							$file
    ncatted -a coordinates,Vwind,o,c,"lon lat wind_time"     $file 
done

exit

mv *.nc $destDir

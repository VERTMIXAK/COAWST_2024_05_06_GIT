sourceDir='/import/VERTMIXFS/jgpender/roms-kate_svn/GlobalDataFiles'



region='NORSE'
year="2018"

latMin=50
latMax=70
#lonMin=-30
#lonMax=-20
lonMin=330
lonMax=340

#xmin=`echo "$lonMin * 3 / 2" | bc`
#xmax=`echo "$lonMax * 3 / 2" | bc`
xmin=`echo "$lonMin / .625" | bc`
xmax=`echo "$lonMax / .625" | bc`
ymin=`echo "( $latMin + 90 ) * 2" | bc`
ymax=`echo "( $latMax + 90 ) * 2" | bc`

echo $xmin
echo $xmax
echo $ymin
echo $ymax

myDir="MERRA_$region"
mkdir $myDir

for file in `ls $sourceDir/MERRA*$year.nc`
do
	echo $file

	shortName=`echo $file | rev | cut -d '/' -f1 | rev`
	echo $file  $shortName

	part1=`echo $shortName | cut -d '.' -f1`
	newName=`echo $part1"_"$region".nc"`

	echo "$myDir/$newName"

	ncks -d lon,$xmin,$xmax -d lat,$ymin,$ymax $file "$myDir/$newName"
done


echo "year "$year


ncatted -O -a units,albedo_time,o,c,"days since 1900-01-01 00:00:00"    $myDir'/MERRA_albedo'*$year*_NORSE.nc
ncatted -O -a units,tair_time,o,c,"days since 1900-01-01 00:00:00"		$myDir/MERRA_Tair*$year*_NORSE.nc
ncatted -O -a units,pair_time,o,c,"days since 1900-01-01 00:00:00"		$myDir/MERRA_Pair*$year*_NORSE.nc
ncatted -O -a units,qair_time,o,c,"days since 1900-01-01 00:00:00"		$myDir/MERRA_Qair*$year*_NORSE.nc
ncatted -O -a units,cloud_time,o,c,"days since 1900-01-01 00:00:00"     $myDir/MERRA_cloud*$year*_NORSE.nc
ncatted -O -a units,lrf_time,o,c,"days since 1900-01-01 00:00:00"		$myDir/MERRA_lwrad_down*$year*_NORSE.nc
ncatted -O -a units,rain_time,o,c,"days since 1900-01-01 00:00:00"		$myDir/MERRA_rain*$year*_NORSE.nc
ncatted -O -a units,srf_time,o,c,"days since 1900-01-01 00:00:00"		$myDir/MERRA_swrad*$year*_NORSE.nc
ncatted -O -a units,wind_time,o,c,"days since 1900-01-01 00:00:00"		$myDir/MERRA_Uwind*$year*_NORSE.nc
ncatted -O -a units,wind_time,o,c,"days since 1900-01-01 00:00:00"		$myDir/MERRA_Vwind*$year*_NORSE.nc


ncap2 -s 'tair_time=double(tair_time)'  $myDir/MERRA_Tair*$year*_NORSE.nc dum*_NORSE.nc		
mv dum*_NORSE.nc  $myDir/MERRA_Tair*$year*_NORSE.nc


ncap2 -s 'pair_time=double(pair_time)'		$myDir/MERRA_Pair*$year*_NORSE.nc  dum*_NORSE.nc
mv dum*_NORSE.nc  $myDir/MERRA_Pair*$year*_NORSE.nc

ncap2 -s 'qair_time=double(qair_time)'		$myDir/MERRA_Qair*$year*_NORSE.nc   dum*_NORSE.nc
mv dum*_NORSE.nc  $myDir/MERRA_Qair*$year*_NORSE.nc

ncap2 -s 'cloud_time=double(cloud_time)'     $myDir/MERRA_cloud*$year*_NORSE.nc  dum*_NORSE.nc
mv dum*_NORSE.nc  $myDir/MERRA_cloud*$year*_NORSE.nc

ncap2 -s 'albedo_time=double(albedo_time)' 	$myDir/MERRA_albedo*$year*_NORSE.nc  dum*_NORSE.nc
mv dum*_NORSE.nc  $myDir/MERRA_albedo*$year*_NORSE.nc

ncap2 -s 'lrf_time=double(lrf_time)'			$myDir/MERRA_lwrad_down*$year*_NORSE.nc  dum*_NORSE.nc
mv dum*_NORSE.nc  $myDir/MERRA_lwrad_down*$year*_NORSE.nc

ncap2 -s 'rain_time=double(rain_time)'		$myDir/MERRA_rain*$year*_NORSE.nc  dum*_NORSE.nc
mv dum*_NORSE.nc  $myDir/MERRA_rain*$year*_NORSE.nc

ncap2 -s 'srf_time=double(srf_time)'			$myDir/MERRA_swrad*$year*_NORSE.nc  dum*_NORSE.nc
mv dum*_NORSE.nc  $myDir/MERRA_swrad*$year*_NORSE.nc

ncap2 -s 'wind_time=double(wind_time)'		$myDir/MERRA_Uwind*$year*_NORSE.nc  dum*_NORSE.nc
mv dum*_NORSE.nc  $myDir/MERRA_Uwind*$year*_NORSE.nc

ncap2 -s 'wind_time=double(wind_time)'		$myDir/MERRA_Vwind*$year*_NORSE.nc  dum*_NORSE.nc
mv dum*_NORSE.nc  $myDir/MERRA_Vwind*$year*_NORSE.nc

#exit

source ~/.runPycnal


python settime_MERRA.py													$myDir/MERRA_Tair*$year*_NORSE.nc 			tair_time
python settime_MERRA.py                                                 $myDir/MERRA_Pair*$year*_NORSE.nc      	pair_time
python settime_MERRA.py                                                	$myDir/MERRA_Qair*$year*_NORSE.nc      	qair_time
python settime_MERRA.py                                              	$myDir/MERRA_cloud*$year*_NORSE.nc    		cloud_time
python settime_MERRA.py                                               	$myDir/MERRA_albedo*$year*_NORSE.nc    	albedo_time
python settime_MERRA.py                                                 $myDir/MERRA_lwrad_down*$year*_NORSE.nc	lrf_time
python settime_MERRA.py                                              	$myDir/MERRA_rain*$year*_NORSE.nc    		rain_time
python settime_MERRA.py                                               	$myDir/MERRA_swrad*$year*_NORSE.nc    		srf_time
python settime_MERRA.py                                               	$myDir/MERRA_Uwind*$year*_NORSE.nc    		wind_time
python settime_MERRA.py                                              	$myDir/MERRA_Vwind*$year*_NORSE.nc    		wind_time


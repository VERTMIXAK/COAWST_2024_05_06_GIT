kmInDeg=111.7

lon0=-6.2752
lat0=70.4335

lat0Rad=`echo " $lat0 * 3.1415926535 / 180. " | bc -l`
echo "lat0 in radians "$lat0Rad

scaleFactor=`echo " c( $lat0Rad ) " | bc -l`
echo "scaleFactor" $scaleFactor

# NOTE: we are using
#	Lm=5   , Mm=5
# and a 5km grid interval

deltaLat=`echo " 12.5 / $kmInDeg " | bc -l`
echo "a"
deltaLon=`echo " 12.5 / $kmInDeg / c($lat0Rad) " | bc -l`
echo "b"

echo "deltaLat " $deltaLat
echo "deltaLon " $deltaLon

latMin=`echo " $lat0 - $deltaLat " | bc -l`
latMax=`echo " $lat0 + $deltaLat " | bc -l`

lonMin=`echo " $lon0 - $deltaLon " | bc -l`
lonMax=`echo " $lon0 + $deltaLon " | bc -l`

echo $latMax $lonMin >  coast.in
echo $latMin $lonMin >> coast.in 
echo $latMin $lonMax >> coast.in
echo $latMax `echo " $lonMax + .00001 " | bc -l ` >> coast.in

source loadModules.txt
coast <coast.in

# square up the domain
tail -4 fort.60 | tr -s ' ' | tr ' ' ',' > fort.temp
sed -i "s/^,// " fort.temp
sed -i "s/,$// " fort.temp
python squareUpFort.py
echo "4" > fort.60
cat fort.temp >> fort.60

# resume
./fort2sq.bash
grid < sqgrid.in
tolat

source ~/.runPycnal
python hack.py NORSE1D_5km.nc
source loadModules.txt
sphere


mv NORSE1D_5km.nc NORSE1D_5km.nc_temporary


module purge
. /etc/profile.d/modules.sh
module load matlab/R2013a
matlab -nodisplay -nosplash < xferFields.m > log

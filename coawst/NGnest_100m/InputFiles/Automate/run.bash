date=`cat dates.txt | head -1`
pathDir='/import/c1/VERTMIX/jgpender/coawst/NGnest_100m/Experiments'
exptDir=$pathDir'/NGnest_100m_'$date'_mesoNoNesting_parent'
echo $exptDir

datePREV=`date -d "$date - 1 day" +"%Y-%m-%d"`
exptDirPREV=$pathDir'/NGnest_100m_'$datePREV'_mesoNoNesting_parent'
echo $exptDirPREV



\cp -R $pathDir/*template $exptDir

cp surfaceForcing/GFS*.nc        	$exptDir/Forcing
cp surfaceForcing/NAM*.nc 			$exptDir/Forcing
cp BC_IC/myBDRY.nc 					$exptDir/Forcing
cp BC_IC/ini_parent/myINI.nc 		$exptDir/Forcing/myINI.nc_ORIG
cp Fresh_water/Runoff/myRunoff.nc	$exptDir/Forcing


prevSnapshot=`ls $exptDirPREV/netcdfOutput/*his* | head -2 | tail -1`
echo $prevSnapshot

cd $exptDir/Forcing
ncks -d ocean_time,0 $prevSnapshot myINI.nc_prev


module purge
. /etc/profile.d/modules.sh
module load matlab/R2013a
matlab -nodisplay -nosplash < scarfVars.m

cd ..
source ~/.runROMSintel
sbatch *sbat
echo ' '

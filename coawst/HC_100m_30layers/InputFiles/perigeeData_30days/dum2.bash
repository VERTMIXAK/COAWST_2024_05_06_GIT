#!/bin/bash

#if [ -f "scpDone.txt" ]
#then
	echo "begin tidyUp.bash"

	source /import/home/jgpender/.runROMSintel

#	\cp -f *.nc backup/
#	\cp scpDone.txt backup

#	Do the experiment name up front to make sure the timing's right

	exptDate=`cat scpDone.txt`
	exptName=HC_100m_$exptDate

	baseDir="/import/c1/VERTMIX/jgpender/coawst/HC_100m_30layers/"
#	cp -R $baseDir/Experiments/HC_100m_template $baseDir/Experiments/$exptName





# there are 14 files but the counting begins at zero
    
#	nMax=13 
#	fileList=( "HIS1.nc"    "HIS2.nc"    "HIS3.nc"    "HIS4.nc"    "HIS5.nc"    "rivers.nc"  "lwrad_down.nc" "Pair.nc"   "Qair.nc"   "rain.nc"   "swrad.nc" "Tair.nc"    "Uwind.nc"  "Vwind.nc" )
#	varList=(  "dum"        "dum"        "dum"        "dum"        "dum"        "dum"        "lwrad_down"    "Pair"      "Qair"      "rain"      "swrad"    "Tair"       "Uwind"     "Vwind" )
#	timeList=( "ocean_time" "ocean_time" "ocean_time" "ocean_time" "ocean_time" "river_time" "lrf_time"      "pair_time" "qair_time" "rain_time" "srf_time" "tair_time"  "wind_time" "wind_time")

    nMax=8
    fileList=( "rivers.nc"  "lwrad_down.nc" "Pair.nc"   "Qair.nc"   "rain.nc"   "swrad.nc" "Tair.nc"    "Uwind.nc"  "Vwind.nc" )
    varList=(  "dum"        "lwrad_down"    "Pair"      "Qair"      "rain"      "swrad"    "Tair"       "Uwind"     "Vwind" )
    timeList=( "river_time" "lrf_time"      "pair_time" "qair_time" "rain_time" "srf_time" "tair_time"  "wind_time" "wind_time")


#   The surface forcing files do need the lat/lon fields, so add them now


    cd ../perigeeData_30days

    for ii in `seq 1 $nMax`
    do
        echo ${fileList[$ii] } ${timeList[$ii]}
        ncrename -O -d eta_rho,lat -d xi_rho,lon ${fileList[$ii]}
        ncatted -O -a  coordinates,${varList[$ii]},a,c,"lon lat" ${fileList[$ii]}
    done

    matlab -nodisplay -nosplash < addLatLon.m

    echo " "
    echo "done with all the file creation"


exit

#	generate the IC/BC files now

	source /import/home/jgpender/.runPycnal

	cd $baseDir/InputFiles/BC_IC_HC_30days/ini_wetDry
	echo "should be in IC directory" `pwd`
	\rm *.nc
	ls -l

	ncks -O -d ocean_time,23 $baseDir/InputFiles/perigeeData_30days/HIS_2024.03.08.nc HISstart.nc
	python make_weight_files.py
	python ini.py
	echo "should see IC file"
	ls -l
#	mv HISstart_*.nc 								$baseDir/Experiments/$exptName/forcing/HC_ic.nc



	cd $baseDir/InputFiles/BC_IC_HC_30days
	echo "should be in BC directory" `pwd`
	\rm *.nc
	
	echo "start BC"
	bash bry.bat


#	wait
#	echo "should see BC files"
#	ls -l
#	echo "ncrcat BC files and move to expt forcing directory"
#	ncrcat -O HIS*bdry.nc 				HC_bdry.nc
#	mv HC_bdry.nc		$baseDir/Experiments/$exptName/forcing/

	echo "end BC"

exit


#	Move files

	echo "copy remaining forcing files to expt forcing directory"
	cp ../perigeeData_30days/*.nc 													$baseDir/Experiments/$exptName/forcing
	cp ../Runoff/rivers.nc										$baseDir/Experiments/$exptName/forcing
	\rm ../perigeeData_30days/scpDone.txt										


#	Run ROMS
	cd $baseDir/Experiments/$exptName

	mv HC_template.sbat "HC_$exptDate.sbat"

	source /import/home/jgpender/.runROMSintel
	sbatch *sbat
#	sbatch --reservation=vertmix -N 6  *sbat





#fi

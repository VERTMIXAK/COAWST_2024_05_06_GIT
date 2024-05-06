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
echo $exptName




	cp -R $baseDir/Experiments/HC_100m_template $baseDir/Experiments/$exptName



#	Move files

	echo "copy remaining forcing files to expt forcing directory"
	cp ../perigeeData/*.nc 													$baseDir/Experiments/$exptName/forcing
	cp ../Runoff/rivers.nc										$baseDir/Experiments/$exptName/forcing
	\rm ../perigeeData/scpDone.txt										


#	Run ROMS
	cd $baseDir/Experiments/$exptName

	mv HC_template.sbat "HC_$exptDate.sbat"

	source /import/home/jgpender/.runROMSintel
	sbatch *sbat
#	sbatch --reservation=vertmix -N 6  *sbat





fi

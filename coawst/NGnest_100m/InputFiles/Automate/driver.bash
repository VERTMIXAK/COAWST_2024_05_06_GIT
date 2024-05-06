#!/bin/bash
source ~/.runROMSintel
homeDir=`pwd`

# set up the dates.txt file
forecastSite="http://tds.marine.rutgers.edu/thredds/catalog/roms/doppio/2017_da/his/runs/catalog.html"

wget --no-check-certificate  $forecastSite -O dum.html

date=`grep History_RUN dum.html | head -1 | cut -c 72-81`

####################
date
date=`date -d "$date - 7 day" +"%Y-%m-%d"`

echo $date > dates.txt

echo `date -d "$date +1 day" +"%Y-%m-%d"` >> dates.txt
echo `date -d "$date +2 day" +"%Y-%m-%d"` >> dates.txt
echo `date -d "$date +3 day" +"%Y-%m-%d"` >> dates.txt


# run surface forcing downloads in background
cd ./surfaceForcing
/bin/bash master.bash 	& 
echo "started surface forcing in background" 	> $homeDir/log
cd ..


# download DOPPIO data
cd ./DOPPIO
echo "starting DOPPIO downloads " 							>> $homeDir/log
/bin/bash download.bash    


# eliminate excess of NaNs in Doppio files, plus subset in x/y
cd $homeDir
echo "starting fixNaNs.m"									>> $homeDir/log
module purge
module load matlab/R2013a    
matlab -nodisplay -nosplash < fixNaNs.m


# split the DOPPIO data out, 1 file per snapshot
cd $homeDir
echo "splitting reduced DOPPIO files"						>> $homeDir/log
/bin/bash split.bash
firstFile=`ls DOPPIO_split | head -1`						>> $homeDir/log
cp DOPPIO_split/$firstFile BC_IC/ini_parent/mySource.nc



# create the INI file
source /import/home/jgpender/.runPycnal
cd $homeDir/BC_IC/ini_parent
\rm myINI.nc
echo "starting INI build"									>> $homeDir/log
python ini.py
mv mySource_NGnest_100m_parent.nc myINI.nc
echo "should see new INI file"								>> $homeDir/log
echo `ls -l myINI.nc`												>> $homeDir/log
module purge
module load matlab/R2013a
matlab -nodisplay -nosplash < fixZetaNaNsinDOPPIO.m
source /import/home/jgpender/.runPycnal




# create the BDRY file
cd ..
\rm myBDRY.nc doppio*.nc
echo "starting BDRY build"									>> $homeDir/log
python bry0.py
echo `ls -s`														>> $homeDir/log
ncrcat doppio*_bdry.nc myBDRY.nc
echo "should see BDRY file"									>> $homeDir/log

cd $homeDir
	


# create the Runoff file for freshwater
cd Fresh_water/riverData
echo "starting freshwater downloads"						>> $homeDir/log
/bin/bash getData.bash
cd ../Runoff
echo "building Runoff file"									>> $homeDir/log		
/bin/bash run_regrid_2.bash

echo "make new experiment directory, copy forcing files, run"  >> log

# make sure the surface forcing downloads are over
cd $homeDir
while [ ! -f ./surfaceForcing/NAM_swradNet.nc ]
do
	sleep 10
done


# create new expt directory, copy ROMS input files to new dir, then run ROMS
/bin/bash run.bash

echo ' '

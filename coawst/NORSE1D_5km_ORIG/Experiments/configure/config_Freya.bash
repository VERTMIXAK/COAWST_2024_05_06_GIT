#!/bin/bash
source ~/.runROMSintel

myHome=`pwd`
echo $myHome

nLines=`wc -l input_Freya.txt | cut -d ' ' -f1`
echo $nLines





# Choose the cast number

counter=1

for counter in `seq 1 $nLines`
do
	echo " "
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " "

echo " "
echo " !!!  begin iteration $counter"
echo " "

	line=`head -$counter input_Freya.txt | tail -1`
	echo $line

	source=`echo $line | cut -d ',' -f1`
         n=`echo $line | cut -d ',' -f2`
   forcing=`echo $line | cut -d ',' -f3`
    mixing=`echo $line | cut -d ',' -f4`
	  Kmin=`echo $line | cut -d ',' -f5`   	# for GLS mixing
		
	if [ $forcing = 'deadStill' ];
	then
		mode='deadStill'
		forcingName='deadStill'
	else
		mode='mesoNoTides'
		if [ $forcing = 'GFS' ];
		then
			forcingName='GFS______'
		fi
        if [ $forcing = 'ERA5' ];
        then
            forcingName='ERA5_____'
        fi
	fi

	echo $source','$n','$forcing','$mixing','$mode','$Kmin


#	echo $n
	n=`seq -w $n 2000 | head -1`
#	echo $n


\rm getNumbers_Freya.m
perl -pe "s/XXX/$n/" util/getNumbersTemplate.m > getNumbers_Freya.m


module purge
. /etc/profile.d/modules.sh
module load matlab/R2013a
matlab -nodisplay -nosplash < getNumbers_Freya.m > log



lon=`head -1 latlon.txt | rev | cut -d ' ' -f1 |rev`
lat=`head -2 latlon.txt | tail -1 | rev | cut -d ' ' -f1 |rev`

echo "lat " $lat
echo "lon " $lon





myDate=`head -3 latlon.txt | tail -1 | cut -c 1-8`
myDate=`date -d $myDate +"%Y-%m-%d"`

timeOfDay=`tail -1 latlon.txt | tr -s ' ' | tr ' ' ',' | cut -d ',' -f3`
echo "time of day "$timeOfDay


echo "date "$myDate

dayN=`grep $myDate /import/home/jgpender/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`

echo "day number" $dayN

dStart=`echo "scale=15; $dayN + $timeOfDay " | bc -l`

echo "dStart " $dStart






if [ $mixing = 'GLS' ]
then
	echo "GLS mixing"
	dirName="NORSE1D_5km_"$source"Cast_"$n"__"$forcingName"__"$mixing"_Kmin_"$Kmin
#	dirNameA="NORSE1D_5km__"$source"Cast_"$n"__"$myDate"_"$myHour":"$myMin":"$mySec"__"$lon"E__"$lat"N"
#    dirNameB="NORSE1D_5km_"$mode"__"$source"Cast_"$n"__"$forcing"_"$mixing"__Kmin_"$Kmin
else
	echo "LMD mixing"
	dirName="NORSE1D_5km_"$source"Cast_"$n"__"$forcingName"__"$mixing
#    dirNameA="NORSE1D_5km__"$source"Cast_"$n"__"$myDate"_"$myHour":"$myMin":"$mySec"__"$lon"E__"$lat"N"
#    dirNameB="NORSE1D_5km_"$mode"__"$source"Cast_"$n"__"$forcing"_"$mixing	
fi

#echo "dirNameA = " $dirNameA
#echo "dirNameB = " $dirNameB
#dirName=$dirNameA'/'$dirNameB

#dirName="NORSE1D_5km_"$source"Cast_"$n"__"$forcing"_"$mixing
echo $dirName


mkdir         ../$dirName


#############

# Make a new grid file

echo " "
echo " !!!  make a new grid file"
echo " "

cd ../../InputFiles/Gridpak_scripted


\rm NORSE1D_5km.nc
perl -pe "s/XXX/$lon/" 		hackGrid.bash_template 	> dum
perl -pe "s/YYY/$lat/"      dum						> hackGrid.bash
bash hackGrid.bash


################

# Make a new IC file

echo " "
echo " !!!  make a new IC file"
echo " "

cd ../B*/ini*
\rm -r __* remap*.nc
#perl -pe "s/XXX/$dStart/"      makeGeneric.m_template > makeGeneric.m

source ~/.runPycnal
python make_remap* > log
python make_ic*    > log
mv source_* IC.nc

module purge
. /etc/profile.d/modules.sh
module load matlab/R2013a
matlab -nodisplay -nosplash < addStretching.m > log

mv IC.nc /import/c1/VERTMIX/jgpender/coawst/NORSE1D_5km/Experiments/configure



################

# move grid file to working directory


cd ../../Gridpak_scripted
mv NORSE1D_5km.nc /import/c1/VERTMIX/jgpender/coawst/NORSE1D_5km/Experiments/configure/


cd /import/c1/VERTMIX/jgpender/coawst/NORSE1D_5km/Experiments/configure



###########

# Update all the fields for zero motion and new S/T profile

echo " "
echo " !!!  update the IC file profile"
echo " "

perl -pe "s/XXX/$n/" util/customizeST_template.m 	> dum
perl -pe "s/YYY/$dStart/" dum 						> customizeST_Freya.m

module purge
. /etc/profile.d/modules.sh
module load matlab/R2013a
matlab -nodisplay -nosplash < customizeST_Freya.m > log



#################

# subset the surface forcing files and make them laterally uniform

    
if [ $forcing = 'deadStill' ];    
then    
	echo " "
	echo " !!!  no forcing files for deadStill experiment"
	echo " "
else
	mode='mesoNoTides'    


echo " "
echo " !!!  make the forcing files"
echo " "

cd ../../InputFiles/Forcing
pwd

echo "forcing template file: " subsetForcing_template.m_$forcing
ls -l subsetForcing_template.m_$forcing

echo "lat = $lat     lon = $lon"

/usr/bin/perl -pe "s/XXX/$lon/"      subsetForcing_template.m_$forcing	> dum
/usr/bin/perl -pe "s/YYY/$lat/"      dum                     			> subsetForcing.m


matlab -nodisplay -nosplash < subsetForcing.m > log

cd -

fi




############

# Move everything to a new experiment directory

echo " "
echo " !!!  create the exptDir and move stuff into it"
echo " "

# dirName now constructed above
#dirName="NORSE1D_5km__cast_"$n"__"$myDate"_"$myTimeGMT"__"$lon"E__"$lat"N__"$mode"_"$mixing
echo ' '
echo 'experiment directory:'
echo $dirName

oceanName="ocean_niskine1d_2km_"$mode".in_"$forcing
#oceanName="ocean_niskine1d_2km_"$mode".in"
#echo "oceanName" $oceanName

coawstName="coawstM_"$mode"_"$mixing
#echo "coawstName "$coawstName



#mkdir 																												../$dirName
mkdir               																								../$dirName/netcdfOutput

perl -pe "s/YYY/$dStart/" util/$oceanName  | perl -pe "s/ZZZ/$Kmin/"      										> ../$dirName/$oceanName

cp util/$coawstName																									../$dirName
mv IC.nc 																											../$dirName
mv NORSE*.nc																										../$dirName
cp -r ../../InputFiles/Forcing																						../$dirName


echo "mpirun -np 1 coawstM* ocean* > log; bash /import/home/jgpender/addl_Scripts/timeROMS/getRunTime.bash >> log"  > ../$dirName/run
chmod gou+x                                     																	../$dirName/run


# run the experiment
cd ../$dirName

echo " "
echo " !!!  run the job"
echo " "

source ~/.runROMSintel
./run &


counter=$((counter+1))
echo "new value of the counter is $counter"

cd $myHome


done 



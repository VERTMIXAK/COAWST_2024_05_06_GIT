#!/bin/bash
source ~/.runROMSintel

myHome=`pwd`
echo $myHome

nLines=`wc -l input.txt | cut -d ' ' -f1`
echo $nLines





# Choose the cast number and write lat/lon and time to file

counter=1



for counter in `seq 1 $nLines`
do

	echo " "
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " "

	echo " "
	echo " !!!  begin iteration $counter"
	echo " "

	line=`head -$counter input.txt | tail -1`
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


	\rm getNumbers.m

	if   [ $source = 'Freya' ];then
		echo "Freya cast source data"
		perl -pe "s/XXX/$n/" util/getNumbers_Freya_Template.m > getNumbers.m
	elif [ $source = 'RBR' ];then
	    echo "RBR cast source data"
		perl -pe "s/XXX/$n/" util/getNumbers_RBR_Template.m > getNumbers.m
	fi



	module purge
	. /etc/profile.d/modules.sh
	module load matlab/R2013a
	matlab -nodisplay -nosplash < getNumbers.m > log




	# slurp up data from the latlon.txt file

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





	# construct the name of the experiment directory
	if [ $mixing = 'GLS' ]
	then
		echo "GLS mixing"
		dirName="NORSE1D_5km_"$source"Cast_"$n"__"$forcingName"__"$mixing"_Kmin_"$Kmin
	else
		echo "LMD mixing"
		dirName="NORSE1D_5km_"$source"Cast_"$n"__"$forcingName"__"$mixing
	fi

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

	mv IC.nc $myHome



################

	# move grid file to working directory

	cd ../../Gridpak_scripted
	mv NORSE1D_5km.nc $myHome

	cd $myHome





###########

# Update all the fields for zero motion and new S/T profile

	echo " "
	echo " !!!  update the IC file profile"
	echo " "


    if   [ $source = 'Freya' ];then
        echo "Freya S/T source data"
		perl -pe "s/XXX/$n/" util/customizeST_Freya_Template.m    > dum
    elif [ $source = 'RBR' ];then
        echo "RBR ST source data"
		perl -pe "s/XXX/$n/" util/customizeST_RBR_Template.m    > dum
    fi

	perl -pe "s/YYY/$dStart/" dum 						> customizeST.m



module purge
. /etc/profile.d/modules.sh
module load matlab/R2013a
matlab -nodisplay -nosplash < customizeST.m > log





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




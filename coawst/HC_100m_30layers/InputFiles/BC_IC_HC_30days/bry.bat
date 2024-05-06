source ~/.runROMSintel

for sourceFile in `ls ../perigeeData_30days/HIS*.nc`
do
	echo $sourceFile
	file=`echo $sourceFile | rev | cut -d '/' -f1 | rev`
	myDate=`echo $file | cut -d '_' -f2 | cut -d '.' -f1-3`
	echo $file $myDate
	bryFile="bry_"$myDate".py"
	
	cp bry_template.py $bryFile
	sed -i "s/XXXX/$file/" 	$bryFile			

    cp bry_template.sbat "bry_"$myDate".sbat"
    sed -i "s/XXXX/$bryFile/"  "bry_"$myDate".sbat"

	sbatch "bry_"$myDate".sbat"


done

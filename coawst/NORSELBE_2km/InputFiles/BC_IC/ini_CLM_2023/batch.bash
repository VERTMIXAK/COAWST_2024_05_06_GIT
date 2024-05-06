source ~/.runPycnal

dataDir='/import/c1/VERTMIX/jgpender/ROMS/CMEMS_CLI/NORSE_ICBC_2021-2023/data'
year="2023"

python make_remap_weights_file.py

\rm CMEMS_*.nc

for file in `ls $dataDir/*$year*`
do
	echo $file
#	myDate=`echo $file | rev | cut -d '/' -f1 | rev | cut -d '_' -f2-5 | cut -d '.' -f1`
#	echo $myDate

	sed  "s|XXXX|$file|" make_ic_file_template.py > make_ic_file.py
	python make_ic_file.py

done

source ~/.runROMSintel

ncrcat -O CMEMS* CLM_NORSELBE_2km.nc


\rm CMEMS*
bash splitCLM.bash


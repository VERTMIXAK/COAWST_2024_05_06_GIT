source ~/.runPycnal

#\rm CMEMS_*.nc remap*.nc

#python make_remap_weights_file.py

for file in `ls -1 CMEMS_2023-06-??.nc*`
do
	echo $file
	sed  "s/XXXX/$file/" make_ic_file_template.py > make_ic_file.py
	

	python make_ic_file.py

done

exit

source ~/.runROMSintel

ncrcat -O CMEMS* CLM_PALAU_8km.nc

exit

\rm HIS*

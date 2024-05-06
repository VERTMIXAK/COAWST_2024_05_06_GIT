for file in `ls scheduleForDeletion`
do
	source ~/.runROMSintel
#	echo "data/$file"
	dateStamp=`echo $file | cut -d '_' -f2 `
	dayN=`grep $dateStamp ~/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`

	echo $file $dateStamp '   ' $dayN

	source ~/.runPycnal
	python settimeFix.py scheduleForDeletion/$file $dayN

done


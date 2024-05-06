while read date
do
	echo $date > dates.txt
	bash downloadBatch.bash
done < dates.bat

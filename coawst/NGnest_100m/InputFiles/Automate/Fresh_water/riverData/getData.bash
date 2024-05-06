#!/bin/bash

# ask for a distant end date and you will get the most recent data without triggering an error

#names=("Hunt"     "Moshassuck" "Woonasquatucket" "Blackstone" "TenMile"  "Pawtuxet" "Taunton")
#sites=("01117000" "01114000"   "01114500"        "01113895"   "01109403" "01116500" "01108000")

names=("Moshassuck" "Woonasquatucket" "Blackstone" "TenMile"  "Pawtuxet" "Taunton"  "Hunt"     )
sites=("01114000"   "01114500"        "01113895"   "01109403" "01116500" "01108000" "01117000")


start=`head -1 ../../dates.txt`
start=`date -d "$start -2 day" +"%Y-%m-%d"`
end=`date -d "$start + 10 day" +"%Y-%m-%d"`

echo $start
echo $end
echo ' '

#: <<'END'

part1="https://waterdata.usgs.gov/nwis/dv?b_00060=on&format=rdb&site_no="
part2="&legacy=&referred_module=sw&period=&begin_date="
part3="&end_date="

for nn in `seq 0 6`
do
    name=${names[$nn]}
    site=${sites[$nn]}
	echo $site $name

	url="$part1$site$part2$start$part3$end"
	wget -O download.txt $url
	grep USGS download.txt | grep -v '#' > dum.txt

	{
	while read line
	do
#   echo $line
	    dumDate=`echo $line | cut -d ' ' -f3`
		dumDate=`grep $dumDate /import/home/jgpender/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f2`.5
	    dumFlow=`echo $line | cut -d ' ' -f4`
	    echo $dumDate $dumFlow
	done < dum.txt
	
	# duplicate the last few lines to push the discharge data into the future
	for ii in `seq 1 5`
	do
		dumDate=` echo " $dumDate + 1 " | bc `
		echo $dumDate $dumFlow 
	done

	} > "$name.txt"
done

\rm download.txt dum.txt

#END

# Consolidate Moshassuck, Woonasquatucket, Blackstone and Ten Mile to get the Providence River

{
ii=0
while read line
do
    ii=`echo " $ii + 1 " | bc `
    date=`echo $line | cut -d ' ' -f1`

    var1=`echo $line                 | cut -d ' ' -f2`
    var2=`head -$ii ${names[1]}.txt | tail -1 | cut -d ' ' -f2`
    var3=`head -$ii ${names[2]}.txt | tail -1 | cut -d ' ' -f2`
    var4=`head -$ii ${names[3]}.txt | tail -1 | cut -d ' ' -f2`



    sum=`echo " $var1 + $var2 + $var3 + $var4" |bc`
#    echo $ii $date $var1 $var2 $var3 $var4 $sum
    echo $date $sum
done < ${names[0]}.txt
} > Providence.txt


module purge
. /etc/profile.d/modules.sh
module load matlab/R2013a

matlab -nodisplay -nosplash < makeRunoff.m

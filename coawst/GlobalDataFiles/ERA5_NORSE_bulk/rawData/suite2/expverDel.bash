for file in `ls suit*`
do
	ncks    --mk_rec_dmn time  -O   $file $file
	ncpdq -U -O						$file $file 			
done

exit

orig=adaptor.mars.internal-1703666704.0644042-13123-15-82f4b1ae-6483-44fd-abf4-b245b4f3cafa.nc

ncks -O -d time,0,719 		$orig dum1.nc
ncks -O -d time,720,2183	$orig dum2.nc

ncks -O -d expver,0 		dum1.nc dum1.nc
ncks -O -d expver,1         dum2.nc dum2.nc   

ncwa -O -a expver 			dum1.nc dum1.nc
ncwa -O -a expver           dum2.nc dum2.nc

ncks -O -x -v expver		dum1.nc part1.nc
ncks -O -x -v expver        dum2.nc part2.nc


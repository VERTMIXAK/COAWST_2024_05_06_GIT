for file in `ls suit*`
do
	ncks    --mk_rec_dmn time  -O   $file $file
	ncpdq -U -O						$file $file 			
done



exit

orig=adaptor.mars.internal-1703666050.776875-26408-16-9de0e027-7acb-42f7-895f-729b2bb8261f.nc

ncks -O -d expver,1 		$orig $orig


ncwa -O -a expver 			 $orig $orig

ncks -O -x -v expver		$orig $orig


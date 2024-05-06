for file in `ls suit*`
do
	ncks    --mk_rec_dmn time  -O   $file $file
	ncpdq -U -O						$file $file 			
done

ncwa -O -a expver            *c1.nc *c1.nc
ncks -O -x -v expver        *c1.nc *c1.nc

ncwa -O -a expver 			 *c2.nc *c2.nc
ncks -O -x -v expver	 	*c2.nc *c2.nc


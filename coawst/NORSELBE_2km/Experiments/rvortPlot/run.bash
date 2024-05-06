\rm *.nc

ncrcat -O -v rvort_sur ../netcdfOutput/no*his2* rvort.nc
cp rvort.nc rvortOverF.nc
ncrename -O -h -v rvort_sur,rvortOverF		rvortOverF.nc      
ncap2 -O -s 'rvortOverF=double(rvortOverF)' rvortOverF.nc rvortOverF.nc 


module purge
module load matlab/R2013a
matlab -nodisplay -nosplash < makeRoverF.m
matlab  -nosplash < newPlot.m

#!/bin/bash

source ~/.runPycnal
year=2016

python regrid_runoff.py NGnest_100m_parent -z --regional_domain -f /import/AKWATERS/kshedstrom/JRA55-flooded/runoff_JRA55-do-1-4-0_${year}.nc USGS_runoff_${year}.nc_template > log

exit


python add_rivers.py JRA-1.4_NG_rivers_${year}.nc
python make_river_clim.py NG_runoff_${year}.nc JRA-1.4_NG_rivers_${year}.nc
## Squeezing JRA is dangerous - different number of rivers when you change years.
##python squeeze_rivers.py JRA-1.4_NG_rivers_${year}.nc squeeze.nc
##mv squeeze.nc JRA-1.4_NG_rivers_${year}.nc
echo "start temp"
python add_temp.py JRA-1.4_NG_rivers_${year}.nc
echo "end temp"
python set_vshape.py JRA-1.4_NG_rivers_${year}.nc


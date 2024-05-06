#!/bin/bash

source ~/.runPycnal

fileSource='../riverData_2020_parent/USGS_runoff_2020.nc'
fileForRoms='USGS_NGnest_100m_parent_rivers_2020.nc'


python add_rivers.py 																$fileForRoms
python make_river_clim.py 							$fileSource 					$fileForRoms

echo "start temp"
python add_temp_3D.py 																	$fileForRoms
echo "end temp"
python set_vshape.py 																$fileForRoms


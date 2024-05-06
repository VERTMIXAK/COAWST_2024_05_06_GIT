#!/bin/bash

source ~/.runPycnal

fileSource='../riverData/USGS_runoff.nc'
fileForRoms='myRunoff.nc'


python add_rivers.py 																$fileForRoms
python make_river_clim.py 							$fileSource 					$fileForRoms

echo "start temp"
python add_temp_3D.py 																	$fileForRoms
echo "end temp"
python set_vshape.py 																$fileForRoms


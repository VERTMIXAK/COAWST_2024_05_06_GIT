ncatted -O -a units,ocean_time,o,c,"days since 1900-01-01 00:00:00" forcing.nc

source ~/.runPycnal
python settime.py forcing.nc

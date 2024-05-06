module purge
. /etc/profile.d/modules.sh
module load matlab/R2013a
matlab -nodisplay -nosplash < newContainer.m

source ~/.runROMSintel

ncatted -O -a units,lrf_time,o,c,"days since 1900-01-01 00:00:00" lwrad_down* lwrad_down*
ncatted -O -a units,pair_time,o,c,"days since 1900-01-01 00:00:00" P* P*
ncatted -O -a units,qair_time,o,c,"days since 1900-01-01 00:00:00" Qair* Qair*
ncatted -O -a units,rain_time,o,c,"days since 1900-01-01 00:00:00" rain* rain*
ncatted -O -a units,srf_time,o,c,"days since 1900-01-01 00:00:00"  swrad* swrad*
ncatted -O -a units,tair_time,o,c,"days since 1900-01-01 00:00:00" Tair* Tair*
ncatted -O -a units,wind_time,o,c,"days since 1900-01-01 00:00:00" Uwin* Uwin*
ncatted -O -a units,wind_time,o,c,"days since 1900-01-01 00:00:00" Vwin* Vwin*

source ~/.runPycnal
python settime.py lwrad* lrf_time
python settime.py Pair*  pair_time
python settime.py Qair*  qair_time
python settime.py rain*  rain_time
python settime.py swra*  srf_time
python settime.py Tair*  tair_time
python settime.py Uwin*  wind_time
python settime.py Vwin*  wind_time



ncks -v msdwlwrf multi_2022.nc ../ERA5forcing/lwrad_down_2022.nc
ncks -v msdwlwrf multi_2023.nc ../ERA5forcing/lwrad_down_2023.nc

ncks -v msnswrf multi_2022.nc ../ERA5forcing/swrad_net_2022.nc
ncks -v msnswrf multi_2023.nc ../ERA5forcing/swrad_net_2023.nc

ncks -v mtpr multi_2022.nc ../ERA5forcing/rain_2022.nc
ncks -v mtpr multi_2023.nc ../ERA5forcing/rain_2023.nc

ncks -v sp multi_2022.nc ../ERA5forcing/Pair_2022.nc
ncks -v sp multi_2023.nc ../ERA5forcing/Pair_2023.nc

ncks -v t2m multi_2022.nc ../ERA5forcing/Tair_2022.nc
ncks -v t2m multi_2023.nc ../ERA5forcing/Tair_2023.nc

ncks -v u10 multi_2022.nc ../ERA5forcing/Uwind_2022.nc
ncks -v u10 multi_2023.nc ../ERA5forcing/Uwind_2023.nc

ncks -v v10 multi_2022.nc ../ERA5forcing/Vwind_2022.nc
ncks -v v10 multi_2023.nc ../ERA5forcing/Vwind_2023.nc

ncks -v r single_2022.nc ../ERA5forcing/Qair_2022.nc
ncks -v r single_2023.nc ../ERA5forcing/Qair_2023.nc

cd ../ERA5forcing
bash renames.bash



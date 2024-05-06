ncrcat  latent/* 		GFS_latent_2022.nc
ncrcat  lhflux/* 		GFS_lhflux_2022.nc
ncrcat  lwrad_down/* 	GFS_lwrad_down_2022.nc
ncrcat  Pair/*			GFS_Pair_2022.nc
ncrcat  Qair/*			GFS_Qair_2022.nc
ncrcat  rain/*			GFS_rain_2022.nc
ncrcat  sensible/*		GFS_sensible_2022.nc
ncrcat  swrad/*			GFS_swrad_2022.nc
ncrcat  swrad_up/*		GFS_swrad_up_2022.nc
ncrcat	Tair/*			GFS_Tair_2022.nc
ncrcat  Uwind/*			GFS_Uwind_2022.nc
ncrcat  Vwind/*			GFS_Vwind_2022.nc

cp GFS_swrad_2022.nc GFS_swrad_net_2022.nc

source ~/.runPycnal
python makeSWradNet.py GFS_swrad_2022.nc GFS_swrad_up_2022.nc GFS_swrad_net_2022.nc 


python fixLon.py		GFS_latent*.nc
python fixLon.py        GFS_lhflux*.nc
python fixLon.py        GFS_lwrad*.nc
python fixLon.py        GFS_Pair*.nc
python fixLon.py        GFS_Qair*.nc
python fixLon.py        GFS_rain*.nc
python fixLon.py        GFS_sensi*.nc
python fixLon.py        GFS_swrad_2*.nc
python fixLon.py        GFS_swrad_up*.nc
python fixLon.py        GFS_swrad_n*.nc
python fixLon.py        GFS_Tair*.nc
python fixLon.py        GFS_Uwind*.nc
python fixLon.py        GFS_Vwind*.nc

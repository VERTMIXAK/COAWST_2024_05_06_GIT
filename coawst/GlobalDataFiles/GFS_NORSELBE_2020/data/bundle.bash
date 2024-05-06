ncrcat  latent/* 		GFS_latent_2020.nc
ncrcat  lhflux/* 		GFS_lhflux_2020.nc
ncrcat  lwrad_down/* 	GFS_lwrad_down_2020.nc
ncrcat  Pair/*			GFS_Pair_2020.nc
ncrcat  Qair/*			GFS_Qair_2020.nc
ncrcat  rain/*			GFS_rain_2020.nc
ncrcat  sensible/*		GFS_sensible_2020.nc
ncrcat  swrad/*			GFS_swrad_2020.nc
ncrcat  swrad_up/*		GFS_swrad_up_2020.nc
ncrcat	Tair/*			GFS_Tair_2020.nc
ncrcat  Uwind/*			GFS_Uwind_2020.nc
ncrcat  Vwind/*			GFS_Vwind_2020.nc

cp GFS_swrad_2020.nc GFS_swrad_net_2020.nc

source ~/.runPycnal
python makeSWradNet.py GFS_swrad_2020.nc GFS_swrad_up_2020.nc GFS_swrad_net_2020.nc 


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

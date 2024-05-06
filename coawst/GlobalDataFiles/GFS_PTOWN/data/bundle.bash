ncrcat  latent/* 		GFS_latent_2016.nc
ncrcat  lhflux/* 		GFS_lhflux_2016.nc
ncrcat  lwrad_down/* 	GFS_lwrad_down_2016.nc
ncrcat  Pair/*			GFS_Pair_2016.nc
ncrcat  Qair/*			GFS_Qair_2016.nc
ncrcat  rain/*			GFS_rain_2016.nc
ncrcat  sensible/*		GFS_sensible_2016.nc
ncrcat  swrad/*			GFS_swrad_2016.nc
ncrcat  swrad_up/*		GFS_swrad_up_2016.nc
ncrcat	Tair/*			GFS_Tair_2016.nc
ncrcat  Uwind/*			GFS_Uwind_2016.nc
ncrcat  Vwind/*			GFS_Vwind_2016.nc

cp GFS_swrad_2016.nc GFS_swrad_net_2016.nc

source ~/.runPycnal
python makeSWradNet.py GFS_swrad_2016.nc GFS_swrad_up_2016.nc GFS_swrad_net_2016.nc 


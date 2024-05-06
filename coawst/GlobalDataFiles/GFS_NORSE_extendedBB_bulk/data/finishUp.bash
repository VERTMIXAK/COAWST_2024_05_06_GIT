ncrcat latent/GFS_latent_2023*	 		GFS_latent_2023.nc
ncrcat lhflux/GFS_lhflux_2023* 			GFS_lhflux_2023.nc
ncrcat lwrad_down/GFS_lwrad_down_2023* 	GFS_lwrad_down_2023.nc
ncrcat Pair/GFS_Pair_2023* 				GFS_Pair_2023.nc
ncrcat Qair/GFS_Qair_2023* 				GFS_Qair_2023.nc
ncrcat rain/GFS_rain_2023* 				GFS_rain_2023.nc
ncrcat sensible/GFS_sensible_2023* 		GFS_sensible_2023.nc
ncrcat swrad/GFS_swrad_2023* 			GFS_swrad_down_2023.nc
ncrcat swrad_up/GFS_swrad_up_2023* 		GFS_swrad_up_2023.nc
ncrcat Tair/GFS_Tair_2023* 				GFS_Tair_2023.nc
ncrcat Uwind/GFS_Uwind_2023* 			GFS_Uwind_2023.nc
ncrcat Vwind/GFS_Vwind_2023* 			GFS_Vwind_2023.nc

module purge
. /etc/profile.d/modules.sh
module load matlab/R2013a
matlab -nodisplay -nosplash < makeSWradNet.m
matlab -nodisplay -nosplash < lonPosToNeg.m  

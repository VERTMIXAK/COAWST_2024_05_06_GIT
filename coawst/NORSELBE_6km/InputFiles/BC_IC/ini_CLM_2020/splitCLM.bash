ncks -O -v ubar,vbar	 		CLM_NORSELBE_6km.nc 		clm_UBAR_VBAR_NORSELBE_6km.nc
ncks -O -v u,v     				CLM_NORSELBE_6km.nc    		clm_U_V_NORSELBE_6km.nc
ncks -O -v temp					CLM_NORSELBE_6km.nc      	clm_TEMP_NORSELBE_6km.nc
ncks -O -v salt   				CLM_NORSELBE_6km.nc			clm_SALT_NORSELBE_6km.nc


ncrename -O -d ocean_time,temp_time -v ocean_time,temp_time    	clm_TEMP_NORSELBE_6km.nc
ncrename -O -d ocean_time,salt_time -v ocean_time,salt_time   	clm_SALT_NORSELBE_6km.nc
ncrename -O -d ocean_time,v2d_time  -v ocean_time,v2d_time     	clm_UBAR_VBAR_NORSELBE_6km.nc
ncrename -O -d ocean_time,v3d_time  -v ocean_time,v3d_time     	clm_U_V_NORSELBE_6km.nc


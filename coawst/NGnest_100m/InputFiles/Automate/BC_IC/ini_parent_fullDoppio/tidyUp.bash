#source ~/.runPycnal

xiRHOmin=100
xiRHOmax=140
etaRHOmin=65
etaRHOmax=105

xiMinus1=139
etaMinus1=104

\rm ../DOPPIO_modified/doppio*

for file in `ls doppio*.nc`
do
	\rm uv.nc others.nc

	echo $file

	ncks -O -v u_eastward,v_northward,ubar_eastward,vbar_northward		$file uv.nc
	ncks -O -x -v u_eastward,v_northward,ubar_eastward,vbar_northward 	$file others.nc

	ncrename -O -h -d time1,ocean_time   uv.nc
	ncrename -O -h -v time1,ocean_time   uv.nc

    ncrename -O -h -d time,ocean_time   others.nc
    ncrename -O -h -v time,ocean_time   others.nc

	ncatted -O -a units,ocean_time,o,c,"days since 1900-01-01 00:00:00" uv.nc
    ncatted -O -a units,ocean_time,o,c,"days since 1900-01-01 00:00:00" others.nc

	ncks -O -x -v time1 others.nc others.nc

	ncks -A uv.nc others.nc

	source ~/.runPycnal
	python settime.py others.nc
	source ~/.runROMSintel

	ncks --mk_rec_dmn ocean_time -O others.nc others.nc

	mv others.nc mySource.nc

#	dumDate=`echo $file | cut -d '_' -f2 | cut -d '.' -f1`
#	for ii in `seq -w 0 23`
#	do
#		newFile="doppio_"$dumDate"_"$ii".nc"
#		ncks -d ocean_time,$ii reduced.nc -O ../DOPPIO_modified/$newFile
#	done



done

\rm uv.nc others.nc


exit

# resize DOPPIO grid file. This only needs to be done once

ncks 	-d xi_rho,$xiRHOmin,$xiRHOmax -d eta_rho,$etaRHOmin,$etaRHOmax 			\
	-d xi_psi,$xiRHOmin,$xiMinus1 -d eta_psi,$etaRHOmin,$etaMinus1  			\
	-d xi_u,$xiRHOmin,$xiMinus1 -d eta_u,$etaRHOmin,$etaRHOmax  				\
	-d xi_v,$xiRHOmin,$xiRHOmax -d eta_v,$etaRHOmin,$etaMinus1  				\
	/import/c1/VERTMIX/jgpender/ROMS/DOPPIO/DOPPIO_2020/grid_DOPPIO.nc -O ../grid_DOPPIO_reduced.nc

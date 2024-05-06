#!/bin/bash

dirDOPPIO='/import/c1/VERTMIX/jgpender/ROMS/DOPPIO/DOPPIO_2020/data_DOPPIO_ORIG/'
#
#ncks -d xi_psi,117,133 -d xi_rho,117,133 -d xi_u,117,133 -d xi_v,117,133 -d eta_psi,63,89 -d eta_rho,63,89 -d eta_u,63,89 -d eta_v,63,89 $dirDOPPIO/../grid_DOPPIO.nc grid_DOPPIO.nc
#exit



for file in `ls $dirDOPPIO/DOPPIO_2020-07-2* $dirDOPPIO/DOPPIO_2020-07-3*`
do
	echo $file
	newName=`echo $file | rev | cut -d '/' -f1 | rev`
	echo $newName
	ncks -d xi_psi,117,133 -d xi_rho,117,133 -d xi_u,117,133 -d xi_v,117,133 -d eta_psi,63,89 -d eta_rho,63,89 -d eta_u,63,89 -d eta_v,63,89   $file $newName 

done



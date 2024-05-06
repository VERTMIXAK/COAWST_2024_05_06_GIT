ncrename -O -d eta_rho,lat -d xi_rho,lon 				lwrad_down.nc         
ncatted -O -a  coordinates,lwrad_down,a,c,"lon lat" 	lwrad_down.nc

ncrename -O -d eta_rho,lat -d xi_rho,lon                Pair.nc
ncatted -O -a  coordinates,pair,a,c,"lon lat"     		Pair.nc

ncrename -O -d eta_rho,lat -d xi_rho,lon                Qair.nc
ncatted -O -a  coordinates,qair,a,c,"lon lat"           Qair.nc

ncrename -O -d eta_rho,lat -d xi_rho,lon                rain.nc
ncatted -O -a  coordinates,rain,a,c,"lon lat"           rain.nc

ncrename -O -d eta_rho,lat -d xi_rho,lon                swrad.nc
ncatted -O -a  coordinates,swrad,a,c,"lon lat"          swrad.nc

ncrename -O -d eta_rho,lat -d xi_rho,lon                Tair.nc
ncatted -O -a  coordinates,tair,a,c,"lon lat"           Tair.nc

ncrename -O -d eta_rho,lat -d xi_rho,lon                Uwind.nc
ncatted -O -a  coordinates,Uwind,a,c,"lon lat"          Uwind.nc

ncrename -O -d eta_rho,lat -d xi_rho,lon                Vwind.nc
ncatted -O -a  coordinates,Vwind,a,c,"lon lat"          Vwind.nc


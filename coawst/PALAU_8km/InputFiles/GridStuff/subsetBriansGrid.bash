ncks -d xi_rho,207,281 -d eta_rho,44,112			\
	 -d xi_psi,207,280 -d eta_psi,44,111            \
     -d xi_u,207,280   -d eta_u,44,112            	\
     -d xi_v,207,281   -d eta_v,44,111            	\
	 -O fleat_outer_grid.nc PALAU_8km.nc


ncks    -d xi_rho,200,285 -d eta_rho,40,115             \
        -d xi_psi,200,284 -d eta_psi,40,114             \
        -d xi_u,200,284   -d eta_u,40,115               \
        -d xi_v,200,285   -d eta_v,40,114               \
		 -O fleat_outer_grid.nc  fleat_outer_grid_subset.nc

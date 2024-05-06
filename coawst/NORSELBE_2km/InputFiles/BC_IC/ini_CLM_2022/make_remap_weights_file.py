import matplotlib
matplotlib.use('Agg')
import pycnal
import pycnal_toolbox

# load the grid

# This points to the grid file in my HYCOM directory
srcgrd = pycnal_toolbox.Grid_HYCOM.get_nc_Grid_HYCOM('/import/c1/VERTMIX/jgpender/ROMS/CMEMS_CLI/NORSE_ICBC_2021-2023/NORSE_grid.nc')

# This points to the relevant section of ~/Pycnal/gridid.txt
dstgrd = pycnal.grid.get_ROMS_grid('NORSELBE_2km')

# make remap grid file for scrip
pycnal_toolbox.Grid_HYCOM.make_remap_grid_file(srcgrd)
pycnal.remapping.make_remap_grid_file(dstgrd, Cpos='rho')
pycnal.remapping.make_remap_grid_file(dstgrd, Cpos='u')
pycnal.remapping.make_remap_grid_file(dstgrd, Cpos='v')

# compute remap weights
# input namelist variables for bilinear remapping at rho points

# apparently this NEP thing doesn't do anything
grid1_file = 'remap_grid_GLBa0.08_NEP_t.nc'
#grid1_file = 'remap_grid_GLBa0.08_t.nc'

grid2_file = 'remap_grid_NORSELBE_2km_rho.nc'
interp_file1 = 'remap_weights_GLBa0.08_to_NORSELBE_2km_bilinear_t_to_rho.nc'
interp_file2 = 'remap_weights_NORSELBE_2km_to_GLBa0.08_bilinear_rho_to_t.nc'
map1_name = 'GLBa0.08 to NORSELBE_2km Bilinear Mapping'
map2_name = 'NORSELBE_2km to GLBa0.08 Bilinear Mapping'
num_maps = 1
map_method = 'bilinear'

print('about to start compute_remap_weights')

pycnal.remapping.compute_remap_weights(grid1_file, grid2_file, \
              interp_file1, interp_file2, map1_name, \
              map2_name, num_maps, map_method)


print('done with compute_remap_weights')

# compute remap weights
# input namelist variables for bilinear remapping at rho points
grid1_file = 'remap_grid_GLBa0.08_NEP_t.nc'
#grid1_file = 'remap_grid_GLBa0.08_t.nc'

grid2_file = 'remap_grid_NORSELBE_2km_u.nc'
interp_file1 = 'remap_weights_GLBa0.08_to_NORSELBE_2km_bilinear_t_to_u.nc'
interp_file2 = 'remap_weights_NORSELBE_2km_to_GLBa0.08_bilinear_u_to_t.nc'
map1_name = 'GLBa0.08 to NORSELBE_2km Bilinear Mapping'
map2_name = 'NORSELBE_2km to GLBa0.08 Bilinear Mapping'
num_maps = 1
map_method = 'bilinear'

pycnal.remapping.compute_remap_weights(grid1_file, grid2_file, \
              interp_file1, interp_file2, map1_name, \
              map2_name, num_maps, map_method)


# compute remap weights
# input namelist variables for bilinear remapping at rho points
grid1_file = 'remap_grid_GLBa0.08_NEP_t.nc'
#grid1_file = 'remap_grid_GLBa0.08_t.nc'

grid2_file = 'remap_grid_NORSELBE_2km_v.nc'
interp_file1 = 'remap_weights_GLBa0.08_to_NORSELBE_2km_bilinear_t_to_v.nc'
interp_file2 = 'remap_weights_NORSELBE_2km_to_GLBa0.08_bilinear_v_to_t.nc'
map1_name = 'GLBa0.08 to NORSELBE_2km Bilinear Mapping'
map2_name = 'NORSELBE_2km to GLBa0.08 Bilinear Mapping'
num_maps = 1
map_method = 'bilinear'

pycnal.remapping.compute_remap_weights(grid1_file, grid2_file, \
              interp_file1, interp_file2, map1_name, \
              map2_name, num_maps, map_method)

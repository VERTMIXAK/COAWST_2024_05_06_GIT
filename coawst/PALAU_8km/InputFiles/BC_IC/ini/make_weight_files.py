import pycnal

print('about to start')
srcgrd = pycnal.grid.get_ROMS_grid('PALAU_BrianSubset')
print('srcgrd ',srcgrd)
dstgrd = pycnal.grid.get_ROMS_grid('PALAU_8km')
print('dstgrd ',dstgrd)

pycnal.remapping.make_remap_grid_file(srcgrd)
pycnal.remapping.make_remap_grid_file(srcgrd,Cpos='u')
pycnal.remapping.make_remap_grid_file(srcgrd,Cpos='v')

pycnal.remapping.make_remap_grid_file(dstgrd)
pycnal.remapping.make_remap_grid_file(dstgrd,Cpos='u')
pycnal.remapping.make_remap_grid_file(dstgrd,Cpos='v')


type = ['rho','u','v']

for typ in type:
        grid1_file = 'remap_grid_PALAU_BrianSubset_'+str(typ)+'.nc'
        grid2_file = 'remap_grid_PALAU_8km_'+str(typ)+'.nc'
        interp_file1 = 'remap_weights_PALAU_BrianSubset_to_PALAU_8km_bilinear_'+str(typ)+'_to_'+str(typ)+'.nc'
        interp_file2 = 'remap_weights_PALAU_8km_to_PALAU_BrianSubset_bilinear_'+str(typ)+'_to_'+str(typ)+'.nc'
        map1_name = 'PALAU_BrianSubset to PALAU_8km Bilinear Mapping'
        map2_name = 'PALAU_8km to PALAU_BrianSubset Bilinear Mapping'
        num_maps = 1
        map_method = 'bilinear'
            
        print("Making "+str(interp_file1)+"...")
            
        pycnal.remapping.compute_remap_weights(grid1_file,grid2_file,\
                         interp_file1,interp_file2,map1_name,\
                         map2_name,num_maps,map_method)


import pycnal
import pycnal_toolbox

src_varname = ['zeta','temp','salt','u','v','ubar','vbar']

# Change src_filename to your directory for the files containing variable data
src_filename = '../ini_183_b/DOPPIO_2020_183_ic_NGnest_triple_b.nc'
wts_file = "./remap_weights_NGnest_triple_b_to_NGnest_triple_c_bilinear_*"
src_grd = pycnal.grid.get_ROMS_grid('NGnest_triple_b')
dst_grd = pycnal.grid.get_ROMS_grid('NGnest_triple_c')
# Outfile is a parameter to allow you to place these created remap files in a different
# directory than the one that is default which is where the file came from.

print(' ')
print('in ini script')
print(' ')

dst_var = pycnal_toolbox.remapping(src_varname, src_filename,\
                                   wts_file,src_grd,dst_grd,rotate_uv=False)

print('done with ini')

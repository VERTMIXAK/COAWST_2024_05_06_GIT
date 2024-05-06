source ~/.runPycnal

year=2020

python add_rivers.py  NGnest_100m_child_runoff_${year}.nc
python make_river_clim.py ../riverData_2020/_${year}.nc USGS_NG_rivers_${year}.nc
#python add_temp.py  NGnest_100m_child_runoff_${year}.nc


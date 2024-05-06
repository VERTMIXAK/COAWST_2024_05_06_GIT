year=`ls suite1/*.nc | head -1 | rev | cut -d '.' -f2 | cut -d '_' -f1 | rev | cut -c 1-4`

#: <<'END'

echo "Uwind"
ncks -v u10 "suite1/suite1_"$year"a.nc" ../ERA5forcing/Uwind_$year"a.nc"

echo "Vwind"
ncks -v v10 "suite1/suite1_"$year"a.nc" ../ERA5forcing/Vwind_$year"a.nc"

echo "Tair"
ncks -v t2m "suite1/suite1_"$year"a.nc" ../ERA5forcing/Tair_$year"a.nc"

echo "lwrad_down"
ncks -v msdwlwrf "suite1/suite1_"$year"a.nc" ../ERA5forcing/lwrad_down_$year"a.nc"

echo "swrad_net"
ncks -v msnswrf "suite1/suite1_"$year"a.nc" ../ERA5forcing/swrad_net_$year"a.nc"

echo "rain"
ncks -v mtpr "suite1/suite1_"$year"a.nc" ../ERA5forcing/rain_$year"a.nc"

echo "SST"
ncks -v sst "suite1/suite1_"$year"a.nc" ../ERA5forcing/SST_$year"a.nc"

echo "latent"
ncks -v slhf "suite1/suite1_"$year"a.nc" ../ERA5forcing/latent_$year"a.nc"

echo "Pair"
ncks -v sp "suite1/suite1_"$year"a.nc" ../ERA5forcing/Pair_$year"a.nc"

echo "sensible"
ncks -v sshf "suite1/suite1_"$year"a.nc" ../ERA5forcing/sensible_$year"a.nc"


#END

echo "Uwind"
ncks -O -v u10 "suite1/suite1_"$year"b.nc" 		dum.nc
ncks -O -d expver,0 						dum.nc dum.nc
ncwa -O -a expver 			 				dum.nc dum.nc
ncks -O -x -v expver						dum.nc dum.nc
mv dum.nc ../ERA5forcing/Uwind_$year"b.nc"


echo "Vwind"
ncks -O -v v10 "suite1/suite1_"$year"b.nc"          dum.nc
ncks -O -d expver,0                         dum.nc dum.nc
ncwa -O -a expver                           dum.nc dum.nc
ncks -O -x -v expver                        dum.nc dum.nc   
mv dum.nc ../ERA5forcing/Vwind_$year"b.nc"

echo "Tair"
ncks -O -v t2m "suite1/suite1_"$year"b.nc"         dum.nc
ncks -O -d expver,0                         dum.nc dum.nc
ncwa -O -a expver                           dum.nc dum.nc
ncks -O -x -v expver                        dum.nc dum.nc   
mv dum.nc  ../ERA5forcing/Tair_$year"b.nc"

echo "lwrad_down"
ncks -O -v msdwlwrf "suite1/suite1_"$year"b.nc"         dum.nc
ncks -O -d expver,0                         dum.nc dum.nc
ncwa -O -a expver                           dum.nc dum.nc
ncks -O -x -v expver                        dum.nc dum.nc   
mv dum.nc  ../ERA5forcing/lwrad_down_$year"b.nc"

echo "swrad_net"
ncks -O -v msnswrf "suite1/suite1_"$year"b.nc"         dum.nc
ncks -O -d expver,0                         dum.nc dum.nc
ncwa -O -a expver                           dum.nc dum.nc
ncks -O -x -v expver                        dum.nc dum.nc   
mv dum.nc  ../ERA5forcing/swrad_net_$year"b.nc"

echo "rain"
ncks -O -v mtpr "suite1/suite1_"$year"b.nc"          dum.nc
ncks -O -d expver,0                         dum.nc dum.nc
ncwa -O -a expver                           dum.nc dum.nc
ncks -O -x -v expver                        dum.nc dum.nc   
mv dum.nc ../ERA5forcing/rain_$year"b.nc"

echo "SST"
ncks -O -v sst "suite1/suite1_"$year"b.nc"          dum.nc
ncks -O -d expver,0                         dum.nc dum.nc
ncwa -O -a expver                           dum.nc dum.nc
ncks -O -x -v expver                        dum.nc dum.nc   
mv dum.nc ../ERA5forcing/SST_$year"b.nc"

echo "latent"
ncks -O -v slhf "suite1/suite1_"$year"b.nc"          dum.nc
ncks -O -d expver,0                         dum.nc dum.nc
ncwa -O -a expver                           dum.nc dum.nc
ncks -O -x -v expver                        dum.nc dum.nc   
mv dum.nc ../ERA5forcing/latent_$year"b.nc"

echo "Pair"
ncks -O -v sp "suite1/suite1_"$year"b.nc"          dum.nc
ncks -O -d expver,0                         dum.nc dum.nc
ncwa -O -a expver                           dum.nc dum.nc
ncks -O -x -v expver                        dum.nc dum.nc   
mv dum.nc ../ERA5forcing/Pair_$year"b.nc"

echo "sensible"
ncks -O -v sshf "suite1/suite1_"$year"b.nc"         dum.nc
ncks -O -d expver,0                         dum.nc dum.nc
ncwa -O -a expver                           dum.nc dum.nc
ncks -O -x -v expver                        dum.nc dum.nc   
mv dum.nc  ../ERA5forcing/sensible_$year"b.nc"


exit

cd ../ERA5forcing
bash renames.bash



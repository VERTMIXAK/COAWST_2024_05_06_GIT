year=`ls suite1/*.nc | head -1 | rev | cut -d '.' -f2 | cut -d '_' -f1 | rev`

echo "year " $year

echo "Uwind"
ncks -v u10 "suite1/suite1_"$year".nc" ../ERA5forcing/Uwind_$year".nc"

echo "Vwind"
ncks -v v10 "suite1/suite1_"$year".nc" ../ERA5forcing/Vwind_$year".nc"

echo "Tair"
ncks -v t2m "suite1/suite1_"$year".nc" ../ERA5forcing/Tair_$year".nc"

echo "lwrad_down"
ncks -v msdwlwrfcs "suite1/suite1_"$year".nc" ../ERA5forcing/lwrad_down_$year".nc"

echo "swrad_net"
ncks -v msnswrfcs "suite1/suite1_"$year".nc" ../ERA5forcing/swrad_net_$year".nc"

echo "rain"
ncks -v mtpr "suite1/suite1_"$year".nc" ../ERA5forcing/rain_$year".nc"

echo "SST"
ncks -v sst "suite1/suite1_"$year".nc" ../ERA5forcing/SST_$year".nc"

echo "latent"
ncks -v slhf "suite1/suite1_"$year".nc" ../ERA5forcing/latent_$year".nc"

echo "Pair"
ncks -v sp "suite1/suite1_"$year".nc" ../ERA5forcing/Pair_$year".nc"

echo "sensible"
ncks -v sshf "suite1/suite1_"$year".nc" ../ERA5forcing/sensible_$year".nc"

exit

cd ../ERA5forcing
bash renames.bash



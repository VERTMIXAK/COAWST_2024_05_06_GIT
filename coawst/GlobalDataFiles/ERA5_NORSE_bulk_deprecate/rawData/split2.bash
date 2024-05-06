year=`ls suite2/*.nc | head -1 | rev | cut -d '.' -f2 | cut -d '_' -f1 | rev`

echo "Qrel"
ncks -v r "suite2/suite2_"$year".nc" ../ERA5forcing/Qrel_$year".nc"

echo "Qspec"
ncks -v q "suite2/suite2_"$year".nc" ../ERA5forcing/Qspec_$year".nc"




#ncks -v r multi2_2022.nc ../ERA5forcing/Qrel_2022.nc
#ncks -v r multi2_2023.nc ../ERA5forcing/Qrel_2023.nc
#ncks -v r multi2_2023_b.nc ../ERA5forcing/Qrel_2023_b.nc
#
#ncks -v q multi2_2022.nc ../ERA5forcing/Qspec_2022.nc
#ncks -v q multi2_2023.nc ../ERA5forcing/Qspec_2023.nc
#ncks -v q multi2_2023_b.nc ../ERA5forcing/Qspec_2023_b.nc

exit

cd ../ERA5forcing
bash renames2.bash



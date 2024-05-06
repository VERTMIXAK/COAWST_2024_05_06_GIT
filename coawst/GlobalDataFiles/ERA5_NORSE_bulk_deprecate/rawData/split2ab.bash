year=`ls suite1/*.nc | head -1 | rev | cut -d '.' -f2 | cut -d '_' -f1 | rev | cut -c 1-4`

echo "Qrel"
ncks -v r "suite2/suite2_"$year"_a.nc" ../ERA5forcing/Qrel_$year"a.nc"

echo "Qspec"
ncks -v q "suite2/suite2_"$year"_a.nc" ../ERA5forcing/Qspec_$year"a.nc"


echo "Qrel"
ncks -v r "suite2/suite2_"$year"_b.nc" ../ERA5forcing/Qrel_$year"b.nc"

echo "Qspec"
ncks -v q "suite2/suite2_"$year"_b.nc" ../ERA5forcing/Qspec_$year"b.nc"





exit

cd ../ERA5forcing
bash renames2.bash



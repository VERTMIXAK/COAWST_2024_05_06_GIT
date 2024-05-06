exptCode='NORSE1D_5km_n42'
echo $exptCode

nStart=`grep -n $exptCode ~/Python/gridid.txt | head -1 | cut -d ':' -f1`
#echo $nStart

nEnd=`echo " $nStart + 9 " | bc`
#echo $nEnd

head -$nEnd ~/Python/gridid.txt | tail -11 > gridid.txt

vTrans=`grep Vtrans gridid.txt | cut -d '=' -f2 | cut -d ' ' -f2`
echo $vTrans 

\rm -r __* remap*.nc

source ~/.runPycnal
python make_remap_weights_file.py
python make_ic_file.py

source ~/.runROMSintel

mv source_*.nc IC.nc

module purge
. /etc/profile.d/modules.sh
module load matlab/R2013a
matlab -nodisplay -nosplash < addStretching.m > log

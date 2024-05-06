for file in `ls adaptor*`
do
	echo $file
	ncks    --mk_rec_dmn time  -O  $file  $file
done

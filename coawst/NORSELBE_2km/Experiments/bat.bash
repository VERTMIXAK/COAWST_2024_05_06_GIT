for dir in `ls | grep NOR`
do	
	echo $dir
	\rm -r $dir/rvortPlot
	cp -r rvortPlot $dir
	cd $dir/rvortPlot
	bash run.bash

	cd ..
	\rm -r rvortPlot
	cd ..
done


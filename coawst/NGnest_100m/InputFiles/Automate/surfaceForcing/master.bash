#!/bin/bash
source ~/.runROMSintel

\rm *.nc*  url*

/bin/bash downloadRain.bash
/bin/bash download00.bash
/bin/bash download01.bash
/bin/bash download18.bash

#exit

/bin/bash fixNamesTimes.bash

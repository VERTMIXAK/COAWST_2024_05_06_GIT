#!/bin/bash


DEST=/import/VERTMIXFS/jgpender/COAWST_2021_06_26/

SRC=/import/c1/VERTMIX/jgpender/coawst/

local=PALAU_800m

rsync  -P -v -r -a --rsh="/usr/bin/rsh" 			\
	--rsync-path=/usr/local/bin/rsync $SRC$local $DEST  > myRsync.log


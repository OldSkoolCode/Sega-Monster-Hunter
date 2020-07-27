

	snasm68k /g /o l+,v+ /k /l /w %1.s,%1.obj
	snlink /m /o 0 /x $200 @%1.lnk,%1.cpe,%1.sym


#!/bin/sh

# You must place file "COPYING" in same folder of this script.


zenity --text-info="Olá" \
       --title="License" \
       --text="OLá bom dia" \
       --checkbox="I read and accept the terms."

case $? in
    0)
        echo "Start installation!"
	# next step
	;;
    1)
        echo "Stop installation!"
	;;
    -1)
        echo "An unexpected error has occurred."
	;;
esac

#!/bin/bash
#===============================================================================
#
#          FILE:  monitor.sh
# 
#         USAGE:  ./monitor.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Kiril Aleksandrov (), kiril.aleksandrov.89@gmail.com
#       COMPANY:  Open Source Corporation
#       VERSION:  1.0
#       CREATED:  02/12/2012 11:19:07 AM EET
#      REVISION:  ---
#===============================================================================

#!/bin/bash

STATUS=`xset -q | grep "Monitor is" | awk '{print $3}'`

if [ "${STATUS}" = "On" ]
then
	xset dpms force off
else
	xset dpms force on
fi
exit 0

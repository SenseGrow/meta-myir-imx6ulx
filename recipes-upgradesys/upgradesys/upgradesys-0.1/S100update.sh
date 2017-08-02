#!/bin/sh
### BEGIN INIT INFO
# Provides: banner
# Required-Start:
# Required-Stop:
# Default-Start:     S
# Default-Stop:
### END INIT INFO

echo "System update start ..."
if grep "update_emmc" /proc/cmdline > /dev/null;then
	flash_emmc.sh &
else
        echo "Normal boot"                                    
        exit 0                                                
fi

if grep "update_nand" /proc/cmdline > /dev/null;then                 
	flash_nand.sh
else                                            
        echo "Normal boot"                                    
        exit 0                                                
fi

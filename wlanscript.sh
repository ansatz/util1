#!/bin/bash

#gobind singh

#last modified 	2014-05-15 22:33

#connect wlan0 to wifi

##function wlanoffx()
##{
##    #alias wlanoff='nmcli dev disconnect iface wlan0'
##	#doesnt seem to work, reconnects later
##    nmcli dev disconnect iface wlan0
##	nmcli nm sleep=True #enable=False
##
##	#  check root
##	if [ "$(id -u)" != "0" ]
##	then
##		echo
##		#sudo "${1}" && exit 0
##		sudo -p && exit 0
##
##	#print current ap
##	nmcli -f GENERAL,WIFI-PROPERTIES dev list iface wlan0  
##	
##	#shutdown with iconfig
##    ifconfig wlan0 down #sudo
##    dhclient -x
##	#print after
##	nmcli -f GENERAL,WIFI-PROPERTIES dev list iface wlan0  
##}

#function wlanoff()
#{
#    #alias wlanoff='nmcli dev disconnect iface wlan0'
#    nmcli dev disconnect iface wlan0
#    ifconfig wlan0 down
#    dhclient -x
#}


function wlanons
{
	nmcli nm enable true
	#  list access points to wlan0
	if [[ $# -eq 0 ]]  
    then
		#-f fields
        nmcli -f 'SIGNAL','SSID','SECURITY' dev wifi list iface wlan0
		exit 0	
	fi

	#  check root
	if [ "$(id -u)" != "0" ]
	then
		echo
		#sudo "${1}" && exit 0
		sudo -p && exit 0
	
	#nmcli connect  
	else
    	NOW=$(date +%m-%d-%Y) 
        printf " " $NOW" \n access point_"$1" "
        echo $(nmcli dev wifi connect $1 iface wlan0 --private)
        echo $(dhclient wlan0)
		conkeror
    
	fi
}

#call args verbatim

$@

#TODO pw secrets 

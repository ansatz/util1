#!/bin/bash
function wlanoffs()
{
    #alias wlanoff='nmcli dev disconnect iface wlan0'
    ifconfig wlan0 down
    nmcli dev disconnect iface wlan0
    dhclient -x
}

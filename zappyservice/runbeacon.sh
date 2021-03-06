#!/bin/bash

ipaddr=""
#echo $ipaddr
while [[ $ipaddr == "" ]] ; do
    sleep 1
    ipaddr="$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"
    #echo $ipaddr
done
echo "ip is $ipaddr"
pushd python

echo display ip
python3 display.py $ipaddr


echo bt beacon ip
sudo hciconfig hci0 up
sudo hciconfig hci0 leadv 3
cmd=$(python3 beacon.py $ipaddr) 
echo "running command: $cmd"
sudo $cmd
popd

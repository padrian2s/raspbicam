#!/bin/bash

rectime=$((60000*1))

while true; do

H=$(date +%H)
echo $H $(date)
if (( 6 >= 10#$H && 10#$H < 174)); then
 echo rectime=$rectime - $(date) >> /home/pi/picam/working
 filename=$(date -u +"%d%m%Y_%H%M")
 mkdir /home/pi/picam/jpg/"$filename"
 mkdir /home/pi/picam/tmp/"$filename"
 /usr/bin/raspistill -n -t $rectime -tl 6000 -o /home/pi/picam/tmp/$filename/a%d.jpg
 mv /home/pi/picam/tmp/$filename/* /home/pi/picam/jpg/$filename/
else
 echo sleep mod 1m
 sleep 1m

fi



done

#!/bin/bash

rectime=$((60000*1))

while true; do

H=$(date +%H)
echo $H $(date)
if (( 6 <= 10#$H && 10#$H < 174)); then
 echo rectime=$rectime - $(date) >> /home/pi/picam/working
 filename=$(date -u +"%d%m%Y_%H%M")
 mkdir /home/pi/picam/jpg/"$filename"
 /usr/bin/raspistill -n -t $rectime -tl 6000 -o /home/pi/picam/jpg/$filename/a%d.jpg
 ls -tr -d -1 /home/pi/picam/jpg/$filename/*.jpg > /home/pi/picam/jpg/$filename/a"$filename".txt
 echo $(date) >> /home/pi/picam/menc
 mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4:aspect=16/9:vbitrate=8000000 -vf scale=1920:1080 -o tlcam"$filename".avi -mf type=jpeg:fps=24 mf://@/home/pi/picam/a"$filename".txt
 echo $(date) >> /home/pi/picam/menc
 python /home/pi/picam/youtube/upload_video.py --file=/home/pi/picam/tlcam"$filename".avi --title="Video Title $(date)"  --noauth_local_webserver
 rm jpg/*.jpg
else

 sleep 1m

fi



done

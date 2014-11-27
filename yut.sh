#!/bin/bash

#exit
jpg="jpg"

while true; do
 
 for D in `find /home/pi/picam/mpg/*.avi -type f 2>/dev/null`
 do
    
     sz=$(ls -1 $D 2>/dev/null | wc -l)
     echo $D ----- $sz
     if ((10#$sz >= 1)); then
 	echo "I have something to upload..."
	echo $(date)
	python /home/pi/picam/youtube/upload_video.py --file=$D --title="Video Title $(date)"  --noauth_local_webserver
	rm $D 2>/dev/null
	echo $(date)
 	break
     fi
 done
 echo "Sleep..."
 sleep 10s
done
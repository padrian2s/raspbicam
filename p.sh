#!/bin/bash

#exit
jpg="jpg"

while true; do
 
 echo $((60000*60))
 filename=$(date -u +"%d%m%Y_%H%M")

 echo Current filename:"$filename"a
 echo "-----------------------------------"
 

 for D in `find /home/pi/picam/jpg/* -type d 2>/dev/null`
 do
     sz=$(ls -1 $D/*.jpg 2>/dev/null| wc -l)
     targetDir=$(readlink -f $D)
     targetLDir="`cd $D; pwd`"
     targetDD=${targetLDir##*/}
     echo Total files "$sz" - $D - path $targetDD
    
     if ((10#$sz >= 2)); then
 	echo "I have work to do"

	for T in `ls $D/*.jpg`
	do
	 TMM=`ls -ll $T | awk '{print $6 $8}'`
	 fn=`ls $T`
	 echo convert -pointsize 40 -fill green -draw \'text 20,40 \"$TMM\"\' $fn $fn
	 #echo eeeeeeeeeeeeeeee `ls $T`
	done
	

 	ls -tr -d -1 "$D"/*.jpg > "$D"/a.txt
 	mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4:aspect=16/9:vbitrate=8000000 -vf scale=1920:1080 -o /home/pi/picam/mpg/tlcam"$filename".avi -mf type=jpeg:fps=24 mf://@$D/a.txt
	rm $D/*.jpg 2>/dev/null
 	break
      else
          
      if test "$targetDD" == $jpg; then
	 echo ".!#@" $targetDD
	else
	 echo "          do be deleted $targetDD"
	 rm -R $D
       fi
	
      echo ""
     fi
 done
 echo "Sleep..."
 sleep 3s
done
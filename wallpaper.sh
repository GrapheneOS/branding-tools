#!/bin/bash
#author r0tt0r aka q for GrapheneOS
#imagemagick & pngcrush required
#Pixel     1080x1920
#Pixel 3   1080x2160
#Pixel 3a  1080x2220
#Pixel3axl 1080x2160
#Pixel 4   1080x2280
#Pixel 4a  1080x2340 

set -o errexit

c=convert
resW="1080"
resH="1920 2160 2220 2160 2280 2340"
com="-composite"
bk="bg_"
logo=https://raw.githubusercontent.com/GrapheneOS/branding_extra/master/simple.svg
#logo=vector.svg
fin=final.png
gra="-gravity center -geometry +0+100"

for res in $resH;do
    $c -size $resW'x'$res xc:black $res.png && $c $logo -channel RGB -negate $fin && $c $res.png $fin $gra $com -quality 100 $resW\x$res.png
    pngcrush -ow -s $resW\x$res.png
    echo "$resW"'x'"$res.png generation successfull"
    rm $res.png $fin
done
exit





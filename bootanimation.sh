#!/bin/bash
#author r0tt0r aka q for GrapheneOS
#imagemagick ,pngcrush, zip, unzip, rm and curl required
#make sure no folder partX is existing from where the script is run. it would get overwritten/removed after packing bootanimation.zip --> rm will delete following after bootanimation is created: part0/ part1/ part2/ desc.txt os_cb.ttf font.zip font.png bg.png final.png circle.png
#change value resH accordingly to the device resolution
#Pixel     1080x1920
#Pixel 3   1080x2160
#Pixel 3a  1080x2220
#Pixel3axl 1080x2160
#Pixel 4   1080x2280
#Pixel 4a  1080x2340 

set -o errexit

c=convert
resW="1080"
resH="1920"
com="-composite"
bk="bg_"
logo=https://raw.githubusercontent.com/GrapheneOS/branding_extra/master/simple.svg
bg=bg.png
#logo=simple.svg
fin=final.png
gra="-gravity center -geometry +"
locx='0'
locy='-80'
p=part0.png
q="-quality 100"
cir=circle.png
font=https://www.opensans.com/download/open-sans-condensed.zip
fn=font.png

$c -size 40x40 xc:none -fill white -draw "circle 20,20 10,4" -gamma 2.2 -antialias $cir
$c -size 200x200 xc:none $bg
$c $bg $cir $gra''$locx+$locy $com $q $p
locy='76'
$c $p $cir $gra''$locx+$locy $com $q $p
locx='-67'
locy='-41'
$c $p $cir $gra''$locx+$locy $com $q $p
locy='37'
$c $p $cir $gra''$locx+$locy $com $q $p
locx='67'
locy='-41'
$c $p $cir $gra''$locx+$locy $com $q $p
locy='37'
$c $p $cir $gra''$locx+$locy $com $q $p

mkdir -p part0
locx='0'
locy='100'
for((i=1;i<=360;i++))
do
    $c -size $resW'x'$resH xc:black $bg && $c $p -distort ScaleRotateTranslate $i $fin && $c $bg $fin $gra''$locx+$locy $com $q part0\/$i.png
    pngcrush -ow -s part0\/$i.png
done
rm $bg $fin $cir
ls -1prt part0/| grep -v "/$" | cat -n | while read n f; do mv -n part0/"${f}" part0/"$(printf "%04d" $n).${f#*.}"; done

mkdir -p part1
locx='0'
locy='100'
locyy='98'
for((i=1;i<=259;i++))
do
    $c -size $resW'x'$resH xc:black $bg && $c $p $fin && $c $bg $fin $gra''$locx+$locy $com $q part1\/$i.png
    $c $logo -channel RGB -negate -scale $i'x'$i $fin && $c $fin -alpha copy $fin && $c part1\/$i.png $fin $gra''$locx+$locyy $com $q part1\/$i.png
    pngcrush -ow -s part1\/$i.png
done
ls -1prt part1/| grep -v "/$" | cat -n | while read n f; do mv -n part1/"${f}" part1/"$(printf "%04d" $n).${f#*.}"; done

curl -sS $font > font.zip && unzip -qq -j "font.zip" "OpenSans-CondBold.ttf" && mv "OpenSans-CondBold.ttf" "os_cb.ttf"
mkdir -p part2
i='1'
locx='0'
locy='100'
locyy='98'
$c -size $resW'x'$resH xc:black $bg && $c $p $fin && $c $bg $fin $gra''$locx+$locy $com $q part2\/$i.png
$c $logo -channel RGB -negate -scale 259x259 $fin && $c $fin -alpha copy $fin && $c part2\/$i.png $fin $gra''$locx+$locyy $com $q part2\/$i.png
for((i=2;i<=347;i++))
do
    locyy='-100'
    $c -size $i'x'100 -background none -fill white -font os_cb.ttf -pointsize 72 label:GrapheneOS $fn
    $c part2\/1.png $fn $gra''$locx+$locyy $com $q part2\/$i.png
    pngcrush -ow -s part2\/$i.png
done
ls -1prt part2/| grep -v "/$" | cat -n | while read n f; do mv -n part2/"${f}" part2/"$(printf "%04d" $n).${f#*.}"; done
rm $fin $bg $p $fn
echo -e "1080 $resH 60\np 0 1 part0\nc 1 0 part1\nc 0 1 part2" > desc.txt
zip -0qry -i \desc.txt \*.png @ bootanimation.zip desc.txt part*
rm -R part0/ part1/ part2/
rm desc.txt os_cb.ttf font.zip
exit

#!/bin/ksh
for i in *
do
echo $i
../x_sedifyMenu.ksh $i >$i.menu
done

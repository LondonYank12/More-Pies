#!/bin/ksh
for i in *
do
echo $i
cp $i/*menu X_MENUS
done

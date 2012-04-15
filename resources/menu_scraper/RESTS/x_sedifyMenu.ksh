#!/bin/ksh
for i in $1
do
cat $i | grep -v "^*" | tr -s " " | sed 's/\\t//g;s/\\n/\n/g' | sed 's/^[ \t]*//;s/[ \t]*$//' | sed '/^$/d' | sed '/^.*View all.*$/d;/^.$/d' >$i.menu
done

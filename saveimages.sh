#!/bin/sh

echo start export docker images
idx=0
rm -rf ./tmp
mkdir ./tmp

for out in $(docker images --format "{{.Repository}}")
do
   echo export docker image $out
   name=./tmp/$(echo $out|sed 's/[/.-]//g')$idx.tar
   idx=$(($idx+1))
   echo $name
   docker save -o $name $out
done

echo start gzip images
gzip -rc tmp > images.gz
echo end

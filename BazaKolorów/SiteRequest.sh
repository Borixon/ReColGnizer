#!/bin/bash
name=$1
link=$2
maxIndex=$3

if [[ -z $link || -z $link ]] ; then
	echo "No arguments"
	exit -1
fi

if [[ -z $maxIndex ]] ; then
	curl "$link" -o "${name}.txt"
else 
	count=1
	while [ $count -le $maxIndex ]
	do
		curl "$link$count" -o "${name}_${count}.txt"
		((count=count+1))
	done		
fi



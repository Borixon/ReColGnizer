#!/bin/bash
file=$(<${1}.txt)
sub='<img src="images/clearpixel.gif" style='
declare -a array
IFS='
'
count=0
for line in $file
do
	if [[ "$line" =~ .*"$sub".* ]]; then 
		rgb=$(echo $line | sed 's/.*background-color://' | sed 's/["].*$//') 
		name=$(echo $line | sed 's/.*name=//'  | sed 's/ id=.*$//')
		alt=$(echo $line | sed 's/.*alt=//'  | sed 's/ content=.*$//')
		
		r=$(echo $rgb | sed 's/.*rgb(//' | sed 's/[,].*$//') 
		g=$(echo $rgb | sed 's/^[^,]*,//g' | sed 's/[,].*$//') 
		b=$(echo $rgb | sed 's/.*rgb(.*[0-9],//' | sed 's/[)].*$//') 

		jsonObject="{\"value\":$name, \"alt\":$alt, \"r\":$r, \"g\":$g, \"b\":$b},"
		
		array[${#array[@]}]=${jsonObject}
		((count=count+1)) 
	fi  
done 

array[((0))]=$(echo ${array[((0))]} | sed 's/^/[/')
array[((count-1))]=$(echo ${array[((count-1))]} | sed 's/.$/]/')

printf "%s\n" "${array[@]}" > ${1}.json

cat ${1}.json 

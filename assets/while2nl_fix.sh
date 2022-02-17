#!/bin/bash
#Description: Use the loop (while) to simulate "nl" command.
#Write by 350 (weilin.jang@gmail.com)
#Version: v1.00

read -p "Please enter File-Name:" varFileName
[ ! -f $varFileName ] && { echo "$varFileName file not found"; exit 99; }

noLine=1

while read txtLine
do
	echo -e "\t $noLine $txtLine"
	let noLine=$noLine+1
done < $varFileName

exit 0

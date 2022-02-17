#!/bin/bash

usage() { echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; exit 1; }

while getopts "hs:p::" o; 
do
	
	echo "o = ${o}"
	
    case "${o}" in
	
        s)
            s=${OPTARG}
			
			echo "this is -s option. OPTARG=[${OPTARG}] OPTIND=[${OPTIND}]"
			
            ;;
        p)
            p=${OPTARG}
			
			echo "this is -p option. OPTARG=[${OPTARG}] OPTIND=[${OPTIND}]"
			
            ;;
        *)
            echo "this is * option. OPTARG=[${OPTARG}] OPTIND=[${OPTIND}]"
			
			usage
            ;;
    esac
done
shift $((OPTIND-1))

#if [ -z "${s}" ] || [ -z "${p}" ]; then
#    usage
#fi

echo "remaining parameters=[$*]"
 
echo "\$1 = $1"
echo "\$2 = $2"

echo "s = ${s}"
echo "p = ${p}"
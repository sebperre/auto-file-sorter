#!/bin/bash

if [ $# -lt 2 ] || [ $# -gt 4 ]; then
	echo "Error: Missing or Too Many Arguments; Check Documentation"
	exit 1
fi

TRANSFER="mv"
VERBOSE=":"
FORCE="0"

# flags must go first before parameters
# v means verbose; Show what file is being transferred
# c means copy; copy the files instead of moving them
# f means force; overwrite files that have the same name without asking
while getopts 'vcf' OPTION; do
        case "$OPTION" in
                v)
                        VERBOSE="echo"
                        echo "verbose on"
                        ;;
                c)
                        TRANSFER="cp"
                        echo "copy on"
                        ;;
		f)
			FORCE="1"
			echo "force on"
			;;
        esac
done

shift "$((OPTIND - 1))"

sort_dir=$1
output_dir=$2

if [ ! -d $output_dir ]; then
	echo "Error: Invalid Output Directory"
	exit 1
fi

if [ ! -d $sort_dir ]; then
	echo "Error: Invalid Sorting Directory"
	exit 1
fi

shift "$((OPTIND - 1))"

main_folder="Sorted Files"

if [ ! -d "${output_dir}/${main_folder}" ]; then
	mkdir "${output_dir}/${main_folder}"
fi


item_num=$(ls $sort_dir -p | wc -l)
count=1

#ls $sort_dir -p | grep -v / | while read -r line;
for line in $(ls "$sort_dir" -p | grep -v /);
	do 
		ext=$(echo $line | rev | cut -d '.' -f 1 | rev)
		if [ ! -d "${output_dir}/${main_folder}/${ext}" ]; then
			mkdir "${output_dir}/${main_folder}/${ext}" 
		fi		
		if [ $FORCE -eq "0" ] && [ -f "${output_dir}/${main_folder}/${ext}/${line}" ]; then
			choice=""
			while true;
			do
				echo "Would you like to overwrite ${line} [y/n]"
				read choice < /dev/tty
				if [ "$choice" = "y" ] || [ "$choice" = "n" ]; then
					break	
				fi
			done
			if [ "$choice" = "n" ]; then
				continue
			fi
		fi
		$TRANSFER "${sort_dir}/${line}" "${output_dir}/${main_folder}/${ext}"
		$VERBOSE "ITEM ${line} TRANSFERRED [${count}/${item_num}]"
		((count++))
	done

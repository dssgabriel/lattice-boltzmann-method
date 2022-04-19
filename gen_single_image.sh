#!/bin/bash

#check args
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
	echo "Usage : $0 {input.raw} {output.png} {image_id}" 1>&2
	exit 1
fi

#get values
INPUT_FILE=$1
OUTPUT_FILE=$2
IMG_ID=$3

#gen gnuplot command
gen_gnuplot_command()
{
	echo "set pm3d map"
	echo "set palette defined ( 0 '#000090', 1 '#000fff',2 '#0090ff',3 '#0fffee', 4 '#90ff70', 5 '#ffee00', 6 '#ff7000', 7 '#ee0000', 8 '#7f0000')"
	echo "set cbr [0:0.14]"
	echo "set terminal png size 1700,300"
	echo "set output '${OUTPUT_FILE}'"
	echo "splot \"< ./display --gnuplot ${INPUT_FILE} ${IMG_ID} \" u 1:2:4"
}

#call if

gen_gnuplot_command | gnuplot


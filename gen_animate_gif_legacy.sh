#!/bin/bash

#check args
if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage : $0 {input.raw} {output.gif}" 1>&2
	exit 1
fi

#get values
INPUT_FILE=$1
OUTPUT_FILE=$2

#get info
FRAMES=$(./display --info $INPUT_FILE 0 | grep frames | sed -e 's/frames=//g')

mkdir -p GIF_TMP

#gen gnuplot command
gen_gnuplot_command() {
	ID=$1
	echo "set pm3d map"
	echo "set palette defined ( 0 '#000090', 1 '#000fff',2 '#0090ff',3 '#0fffee', 4 '#90ff70', 5 '#ffee00', 6 '#ff7000', 7 '#ee0000', 8 '#7f0000')"
	echo "set cbr [0:0.14]"
	echo "set terminal png size 1700,300"
	printf "set output './GIF_TMP/%04d.png'\n" $ID
	echo "splot \"< ./display --gnuplot $INPUT_FILE $ID \" u 1:2:4"
}

#call if

for tmp in $(seq 0 1 $FRAMES); do
	echo "Image $tmp"
	gen_gnuplot_command $tmp | gnuplot
done

convert ./GIF_TMP/*.png $2
